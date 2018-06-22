using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class Fetch : FetchBase
    {
        public override Response Execute(Command wrapper)
        {
            var result = new Response() { IsSuccess = true, Entities = new List<EntityBase>(), OutParams = new List<OutParam>() };
            var db = CreateDatabase();
            using (var conn = db.CreateConnection())
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
                TryExcuteCommands(db, wrapper.PreCommands, result, conn);
                if (result.IsSuccess)
                {
                    var dataSet = GetListData(db, wrapper, result, conn, null);
                    ConvertData(wrapper, result, dataSet);
                }

                conn.Close();
            }
            return result;
        }

        private static void TryExcuteCommands(Database db, List<Command> cmdList, Response result, DbConnection conn)
        {
            if (cmdList.IsNotNullOrEmpty())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    ExcuteCommands(db, cmdList, result, conn, tran);
                    if (string.IsNullOrEmpty(result.Message))
                    {
                        tran.Commit();
                    }
                    else
                    {
                        tran.Rollback();
                    }
                }
                catch (Exception ex)
                {
                    tran.Rollback();

                    result.IsSuccess = false;
                    result.Message = ex.Message;
                }
            }
        }

        private static void ExcuteCommands(Database db, List<Command> cmdList, Response result, DbConnection conn, DbTransaction tran)
        {
            foreach (var proc in cmdList)
            {
                var cmdProc = CommandConvert.ToSelectCommand(db, conn, tran, proc.CmdType, proc.Text, proc.Params);
                var message = cmdProc.GetProcMsgParam();
                cmdProc.ExecuteNonQuery();
                if (message != null && !string.IsNullOrEmpty(message.Value as string))
                {
                    result.Message = message.Value as string;
                    result.IsSuccess = false;
                    break;
                }
            }
        }

        private static DataSet GetListData(Database db, Command wrapper, Response result, DbConnection conn, DbTransaction tran)
        {
            DbCommand cmd = CommandConvert.ToSelectCommand(db, conn, tran, wrapper.CmdType, wrapper.Text, wrapper.Params);
            if (cmd.CommandType == CommandType.StoredProcedure && (cmd.CommandText == Tool.Proc_PageData || cmd.CommandText.EndsWith(Tool.ProcPage_Suffix)))
            {
                db.AddOutParameter(cmd, Tool.Proc_Param_Count, DbType.Int32, 4);
            }

            var ds = db.ExecuteDataSet(cmd);
            if (cmd.Parameters.Contains(Tool.Proc_Param_Count))
            {
                result.Tag = cmd.Parameters[Tool.Proc_Param_Count].Value;
            }
            Tool.SetListOutParam(cmd, result.OutParams);
            return ds;
        }

        private static void ConvertData(Command wrapper, Response result, DataSet ds)
        {
            if (ds.Tables.Count > 0)
            {
                var listName = wrapper.EntityType.Split(Tool.Chr_Semicolon).ToList();
                foreach (DataTable table in ds.Tables)
                {
                    if (table.Rows.Count > 0)
                    {
                        var type = Type.GetType(TryGetEntityAQName(listName, table));
                        table.ToList(type, result.Entities);
                    }
                }
            }
        }

        private static string TryGetEntityAQName(List<string> listName, DataTable table)
        {
            string name = null;
            if (table.Columns.Contains(Tool.EntityFullName))
            {
                string temp = table.Rows[0][Tool.EntityFullName] as string;
                if (!string.IsNullOrEmpty(temp))
                {
                    name = listName.FirstOrDefault(p => p.StartsWith(temp));
                }
            }

            if (string.IsNullOrEmpty(name))
            {
                name = listName.FirstOrDefault();
            }
            return name;
        }
    }
}
