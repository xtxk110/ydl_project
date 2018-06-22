using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    public static class MapConverter
    {
        internal static TableInfo GetPropertyData(Type type)
        {
            IMap pt = new MapType();

            return pt.Get(type);
        }

        internal static void ToList(this DataTable dataTable, Type type, List<EntityBase> result)
        {
            if (dataTable != null)
            {
                var ptList = GetPropertyData(type).Fields;
                foreach (DataRow dr in dataTable.Rows)
                {
                    var entity = Activator.CreateInstance(type) as EntityBase;
                    entity.RowState = RowState.Unchanged;

                    foreach (var pt in ptList)
                    {
                        if (dataTable.Columns.IndexOf(pt.Field) != -1 && pt.Property.CanWrite && !DBNull.Value.Equals(dr[pt.Field]))
                        {
                            if (pt.DataType == DataType.DateTime.ToString())
                            {
                                pt.Property.SetValue(entity, ((DateTime)dr[pt.Field]), null);
                            }
                            else
                            {
                                pt.Property.SetValue(entity, dr[pt.Field], null);
                            }
                        }
                    }
                    result.Add(entity);
                }
            }
        }

        internal static DataTable ToDataTable(this IEnumerable<object> list)
        {
            if (list.IsNotNullOrEmpty())
            {
                var dt = ConvertDataTable(list);
                dt.AcceptChanges();
                SetRowState(dt);
                return dt;
            }
            return null;
        }

        public static List<FieldAttribute> GetFieldAttributes(Type type)
        {
            var result = new List<FieldAttribute>();
            foreach (var pt in type.GetProperties())
            {
                var fieldAtt = Attribute.GetCustomAttribute(pt, typeof(FieldAttribute)) as FieldAttribute;
                if (fieldAtt != null)
                {
                    result.Add(fieldAtt);
                }
            }
            return result;
        }


        private static void SetRowState(DataTable dt)
        {
            foreach (DataRow dr in dt.Rows)
            {
                var rowState = dr.RowError.ToEnum<RowState>();
                switch (rowState)
                {
                    case RowState.Added:
                        dr.SetAdded();
                        break;

                    case RowState.Modified:
                        dr.SetModified();
                        break;

                    case RowState.Deleted:
                        dr.Delete();
                        break;

                    default:
                        break;
                }
                dr.RowError = null;
            }
        }

        private static DataTable ConvertDataTable(IEnumerable<object> list)
        {
            var type = list.First().GetType();
            var ptState = type.GetProperty(Tool.Field_RowState);
            var dt = new DataTable();
            var ptList = GetPropertyData(type).Fields;
            //var ptList = temps.Where(p => p.IsUpdate).ToList();
            bool isIdentity = false;

            foreach (var pt in ptList)
            {
                dt.Columns.Add(pt.Field, pt.Property.PropertyType.IsGenericType ? pt.Property.PropertyType.GetGenericArguments()[0] : pt.Property.PropertyType);
            }

            foreach (var entity in list)
            {
                var temp = entity as EntityBase;
                if ((!isIdentity || isIdentity && (temp.RowState == RowState.Modified || temp.RowState == RowState.Deleted)) && string.IsNullOrEmpty(temp.Id))
                {
                    throw new Exception("出错：对象的主键属性值为null");
                }
                else if (RowState.Unchanged != temp.RowState)
                {
                    var dr = dt.NewRow();
                    dr.RowError = temp.RowState.ToString();
                    foreach (var pt in ptList)
                    {
                        SetFieldValue(entity, dr, pt);
                    }
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }

        private static void SetFieldValue(object entity, DataRow dr, FieldInfo pt)
        {
            object value = pt.Property.GetValue(entity, null);
            if (value != null)
            {
                dr[pt.Field] = pt.IsLink ? value.ToString().GetId() : value;
            }
            else
            {
                dr[pt.Field] = DBNull.Value;
            }
        }

    }

}
