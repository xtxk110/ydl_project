using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    public class CommandConvert
    {
        public static DbCommand ToSelectSelfCommand(Database db, DbConnection conn, DbTransaction tran, string conditionText, List<DbParam> listParameter, Type type, Command wrapper)
        {
            var builder = new CommandBuilder { Type = type, Db = db, CmdWrapper = wrapper };
            var cmd = builder.Get(new SelfCommand());
            cmd.CommandText += conditionText.IsNotNullOrEmpty() ? " WHERE " + conditionText : ToWhereText(listParameter);
            if (listParameter != null)
            {
                foreach (var param in listParameter)
                {
                    ToDbParameter(db, cmd, param);
                }
            }

            return cmd;
        }

        public static DbCommand ToSelectCommand(Database db, DbConnection conn, DbTransaction tran, CommandType commandType, string commandText, List<DbParam> listParameter)
        {
            DbCommand cmd = null;
            if (commandType == CommandType.Text)
            {
                cmd = db.GetSqlStringCommand(commandText);
            }
            else
            {
                cmd = db.GetStoredProcCommand(commandText);
            }
            cmd.Connection = conn;
            cmd.TryAttachTran(tran);
            if (listParameter != null)
            {
                foreach (var param in listParameter)
                {
                    ToDbParameter(db, cmd, param);
                }
            }
            return cmd;
        }

        public static List<DbParameter> ToDbParameters(Database db, DbCommand cmd, List<DbParam> listParameter)
        {
            var list = new List<DbParameter>();
            if (listParameter != null)
            {
                foreach (var temp in listParameter)
                {
                    ToDbParameter(db, cmd, temp);
                }
            }
            return list;
        }

        public static void ToDbParameter(Database db, DbCommand cmd, DbParam parameter)
        {
            if (parameter != null)
            {
                var type = parameter.Direction.ToString().ToEnum<ParameterDirection>();
                if (type == ParameterDirection.Input)
                {
                    db.AddInParameter(cmd, parameter.Name, parameter.Type.ToString().ToEnum<DbType>(), parameter.Value == null ? System.DBNull.Value : parameter.Value);
                }
                else
                {
                    db.AddOutParameter(cmd, parameter.Name, parameter.Type.ToString().ToEnum<DbType>(), parameter.Size > 0 ? parameter.Size : 4);
                }
            }
        }

        public static DbParam ToOutParam(DbParameter parameter)
        {
            return parameter != null ? new DbParam() { Name = parameter.ParameterName, Value = parameter.Value == System.DBNull.Value ? null : parameter.Value } : null;
        }

        public static string ToWhereText(List<DbParam> listParameter)
        {
            if (listParameter != null && listParameter.Count > 0)
            {
                var sb = new StringBuilder();
                sb.Append(" WHERE ");
                int count = 1;
                foreach (var sp in listParameter)
                {
                    if (count > 1)
                    {
                        sb.Append(" AND ");
                    }
                    sb.Append(sp.Name.Replace("@", string.Empty));
                    sb.Append("=");
                    sb.Append(sp.Name);
                    count++;
                }

                return sb.ToString();
            }

            return string.Empty;
        }
    }
}
