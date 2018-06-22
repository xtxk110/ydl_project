using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

namespace YDL.Map
{
    internal class SelfCommand : ICommandCreator
    {
        private static readonly string SQL_SELECT = " SELECT * FROM {0} ";

        public DbCommand Get(Type type, Database db, Command cmdWrapper)
        {
            DbCommand cmd = null;
            var map = MapConverter.GetPropertyData(type);
            var key = map.Fields.FirstOrDefault(p => p.IsKey);
            if (key != null)
            {
                var sb = new StringBuilder();
                foreach (var field in map.Fields)
                {
                    if (field.IsUpdate)
                    {
                        if (sb.Length > 0)
                        {
                            sb.Append(Tool.Str_Comma);
                        }
                        sb.Append(field.Field);
                    }
                }
                if (sb.Length > 0)
                {
                    cmd = db.GetSqlStringCommand(string.Format(SQL_SELECT, map.Table));
                }
            }
            return cmd;
        }
    }
}
