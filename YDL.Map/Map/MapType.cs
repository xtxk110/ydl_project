using System;
using System.Collections.Generic;
using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class MapType : IMap
    {
        public TableInfo Get(Type type)
        {
            TableInfo result = new TableInfo();
            var table = Attribute.GetCustomAttribute(type, typeof(TableAttribute)) as TableAttribute;
            if (table != null)
            {
                result.Table = table.Name.IsNotNullOrEmpty() ? table.Name : type.Name;
                result.InsertSP = table.InsertSP;
                result.UpdateSP = table.UpdateSP;
                result.DeleteSP = table.DeleteSP;
                result.IsRowVersion = table.IsRowVersion;
            }
            else
            {
                throw new Exception(string.Format("实体{0}没有定义Table特性", type.Name));
            }

            foreach (var pt in type.GetProperties())
            {
                var fieldAtt = Attribute.GetCustomAttribute(pt, typeof(FieldAttribute)) as FieldAttribute;
                if (fieldAtt != null)
                {
                    var obj = new FieldInfo()
                    {
                        Property = pt,
                        Field = fieldAtt.Name.IsNotNullOrEmpty() ? fieldAtt.Name : pt.Name,
                        DataType = fieldAtt.DataType.ToString(),
                        Name = pt.Name,
                        IsKey = fieldAtt.IsKey,
                        IsLink = fieldAtt.IsLink,
                        IsUpdate = fieldAtt.IsUpdate,
                        OnlyInsert = fieldAtt.OnlyInsert
                    };
                    result.Fields.Add(obj);
                }
            }
            return result;
        }
    }
}
