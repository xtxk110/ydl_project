using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Data.Common;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class UpdateCommand : ICommandCreator
    {
        private static readonly string SQL_UPDATE_PART1 = " UPDATE {0} SET ";
        private static readonly string SQL_UPDATE_PART2 = " WHERE {0}=@{0} ";
        private static readonly string FIELD_PREFIX = "=@";
        private static readonly string SQL_NULL = "SELECT";
        private static readonly string PK_ID = "Id";

        public DbCommand Get(Type type, Database db, Command cmdWrapper)
        {
            var map = MapConverter.GetPropertyData(type);
            List<FieldInfo> fieldList = GetFieldList(type, cmdWrapper, map);
            DbCommand cmd = null;

            if (cmdWrapper.Procedures.IsNotNullOrEmpty())
            {
                var table = cmdWrapper.Procedures.FirstOrDefault(p => p.Table == map.Table);
                if (table != null)
                {
                    map.InsertSP = table.InsertSP;
                    map.UpdateSP = table.UpdateSP;
                    map.DeleteSP = table.DeleteSP;
                }
            }

            if (map.UpdateSP.IsNotNullOrEmpty())
            {
                cmd = db.GetStoredProcCommand(map.UpdateSP);
                SetUpdateFieldsForSP(fieldList, db, cmd);
            }
            else
            {
                cmd = db.GetSqlStringCommand(SQL_NULL);
                cmd.CommandText = null;

                if (fieldList.IsNotNullOrEmpty())
                {
                    var updateSql = new StringBuilder();
                    updateSql.Append(string.Format(SQL_UPDATE_PART1, map.Table));

                    SetUpdateFields(fieldList, updateSql, db, cmd);
                    string whereText = string.Format(SQL_UPDATE_PART2, PK_ID);
                    //数据版本管理
                    if (map.IsRowVersion)
                    {
                        whereText += string.Format(" AND {0}=@{0} ", Constant.FieldName_RowVersion);
                        db.AddInParameter(cmd, Tool.Str_Alpha + Constant.FieldName_RowVersion, DbType.Int32, Constant.FieldName_RowVersion, DataRowVersion.Current);
                    }
                    cmd.CommandText = updateSql.ToString() + whereText;
                    AddPkParameter(fieldList, db, cmd);
                }
            }

            return cmd;
        }

        private static List<FieldInfo> GetFieldList(Type type, Command cmdWrapper, TableInfo map)
        {
            List<FieldInfo> fieldList = null;
            if (cmdWrapper.OnlyFields.IsNotNullOrEmpty())
            {
                var tempFields = cmdWrapper.OnlyFields.FirstOrDefault(p => p.Table == type.Name);
                if (tempFields != null)
                {
                    fieldList = map.Fields.Where(p => p.IsUpdate && !p.OnlyInsert && tempFields.Fields.ContainValue(p.Field)).ToList();
                }
            }
            else if (cmdWrapper.NotFields.IsNotNullOrEmpty())
            {
                var tempFields = cmdWrapper.OnlyFields.FirstOrDefault(p => p.Table == type.Name);
                if (tempFields != null)
                {
                    fieldList = map.Fields.Where(p => p.IsUpdate && !p.OnlyInsert && !tempFields.Fields.ContainValue(p.Field)).ToList();
                }
            }
            else
            {
                fieldList = map.Fields.Where(p => !string.IsNullOrEmpty(p.Field) && p.IsUpdate && !p.OnlyInsert).ToList();
            }
            return fieldList;
        }

        private static void SetUpdateFields(List<FieldInfo> fieldList, StringBuilder updateSql, Database db, DbCommand cmd)
        {
            int count = 1;
            foreach (var pt in fieldList)
            {
                if (count > 1)
                {
                    updateSql.Append(Tool.Str_Comma);
                }
                updateSql.Append(pt.Field)
                    .Append(FIELD_PREFIX)
                    .Append(pt.Field);
                count++;

                db.AddInParameter(cmd, Tool.Str_Alpha + pt.Field, pt.DataType.ToEnum<DbType>(), pt.Field, DataRowVersion.Current);
            }
        }

        private static void SetUpdateFieldsForSP(List<FieldInfo> fieldList, Database db, DbCommand cmd)
        {
            foreach (var pt in fieldList)
            {
                db.AddInParameter(cmd, Tool.Str_Alpha + pt.Field, pt.DataType.ToEnum<DbType>(), pt.Field, DataRowVersion.Current);
            }

            AddPkParameter(fieldList, db, cmd);
        }

        private static void AddPkParameter(List<FieldInfo> fieldList, Database db, DbCommand cmd)
        {
            var pkField = fieldList.FirstOrDefault(p => p.Field == PK_ID);
            if (pkField == null)
            {
                db.AddInParameter(cmd, Tool.Str_Alpha + PK_ID, DbType.String, PK_ID, DataRowVersion.Current);
            }
        }
    }
}
