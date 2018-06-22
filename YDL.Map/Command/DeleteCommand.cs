using System;
using System.Data;
using System.Data.Common;
using System.Linq;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class DeleteCommand : ICommandCreator
    {
        private static readonly string SQL_DELETE = " DELETE FROM {0} WHERE {1}=@{1} ";
        private static readonly string PK_ID = "Id";

        public DbCommand Get(Type type, Database db, Command cmdWrapper)
        {
            var map = MapConverter.GetPropertyData(type);
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

            if (map.DeleteSP.IsNotNullOrEmpty())
            {
                cmd = db.GetStoredProcCommand(map.DeleteSP);
            }
            else
            {
                cmd = db.GetSqlStringCommand(string.Format(SQL_DELETE, map.Table, PK_ID));
                //数据版本管理
                if (map.IsRowVersion)
                {
                    cmd.CommandText += string.Format(" AND {0}=@{0} ", Constant.FieldName_RowVersion);
                    db.AddInParameter(cmd, Tool.Str_Alpha + Constant.FieldName_RowVersion, DbType.Int32, Constant.FieldName_RowVersion, DataRowVersion.Current);
                }
            }
            db.AddInParameter(cmd, Tool.Str_Alpha + PK_ID, DbType.String, PK_ID, DataRowVersion.Current);

            return cmd;
        }
    }
}
