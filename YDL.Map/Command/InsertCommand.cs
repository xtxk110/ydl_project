using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class InsertCommand : ICommandCreator
    {
        private static readonly string SQL_INSERT_PART1 = " INSERT INTO  {0} (";
        private static readonly string SQL_INSERT_PART2 = "  VALUES (";
        private static readonly string RIGHT_BRACKET = ") ";
        private static readonly string SQL_NULL = "SELECT";

        public DbCommand Get(Type type, Database db, Command cmdWrapper)
        {
            var map = MapConverter.GetPropertyData(type);
            var properties = map.Fields.Where(p => p.Field.IsNotNullOrEmpty() && p.IsUpdate).ToList();
            if (properties != null && properties.Count > 0)
            {
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

                if (map.InsertSP.IsNotNullOrEmpty())
                {
                    cmd = db.GetStoredProcCommand(map.InsertSP);
                    SetUpdateFieldsForSP(properties, db, cmd);
                }
                else
                {
                    cmd = db.GetSqlStringCommand(SQL_NULL);
                    cmd.CommandText = null;

                    var fields = new StringBuilder();
                    fields.Append(string.Format(SQL_INSERT_PART1, map.Table));

                    var values = new StringBuilder();
                    values.Append(SQL_INSERT_PART2);

                    SetUpdateFields(properties, db, cmd, fields, values);
                    fields.Append(RIGHT_BRACKET);
                    values.Append(RIGHT_BRACKET);
                    cmd.CommandText = fields.ToString() + values.ToString();
                }
                return cmd;
            }
            return null;
        }

        private static void SetUpdateFields(List<FieldInfo> properties, Database db, DbCommand cmd, StringBuilder fields, StringBuilder values)
        {
            int count = 1;
            foreach (var pt in properties)
            {
                if (count > 1)
                {
                    fields.Append(Tool.Chr_Comma);
                    values.Append(Tool.Chr_Comma);
                }
                fields.Append(pt.Field);
                values.Append(Tool.Str_Alpha).Append(pt.Field);
                db.AddInParameter(cmd, Tool.Str_Alpha + pt.Field, pt.DataType.ToEnum<DbType>(), pt.Field, DataRowVersion.Current);
                count++;
            }
        }

        private static void SetUpdateFieldsForSP(List<FieldInfo> properties, Database db, DbCommand cmd)
        {
            foreach (var pt in properties)
            {
                db.AddInParameter(cmd, Tool.Str_Alpha + pt.Field, pt.DataType.ToEnum<DbType>(), pt.Field, DataRowVersion.Current);
            }
        }
    }
}
