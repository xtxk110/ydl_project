using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using YDL.Core;
using YDL.Utility;


namespace YDL.Map
{
    internal class FetchExecute : FetchBase
    {
        public override Response Execute(Command wrapper)
        {
            var result = new Response() { IsSuccess = true, OutParams = new List<OutParam>() };
            if (wrapper != null)
            {
                if (wrapper.AfterCommands == null)
                {
                    wrapper.AfterCommands = new List<Command>();
                }
                if (!string.IsNullOrEmpty(wrapper.Text))
                {
                    var cmd = Command.CreateInstance();
                    cmd.CmdType = wrapper.CmdType;
                    cmd.Params = wrapper.Params;
                    cmd.Text = wrapper.Text;
                    wrapper.AfterCommands.Insert(0, cmd);
                }
                var db = CreateDatabase();
                using (var conn = db.CreateConnection())
                {
                    if (conn.State != ConnectionState.Open)
                    {
                        conn.Open();
                    }
                    var tran = conn.BeginTransaction();
                    try
                    {
                        TryExcuteCommands(db, wrapper, result, conn, tran);
                        if (string.IsNullOrEmpty(result.Message))
                        {
                            tran.Commit();
                        }
                        else
                        {
                            tran.Rollback();

                            result.IsSuccess = false;
                            if (result.Message.IsNullOrEmpty())
                            {
                                result.Message = "数据可能已经发生改变！";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();

                        result.IsSuccess = false;
                        result.Message = ex.Message;
                    }
                    conn.Close();
                }
            }
            return result;
        }

        private static void TryExcuteCommands(Database db, Command wrapper, Response result, DbConnection conn, DbTransaction tran)
        {
            if (wrapper.AfterCommands != null && wrapper.AfterCommands.Count > 0)
            {
                foreach (var proc in wrapper.AfterCommands)
                {
                    var cmd = CommandConvert.ToSelectCommand(db, conn, tran, proc.CmdType, proc.Text, proc.Params);
                    var message = cmd.GetProcMsgParam();
                    result.RowCount += cmd.ExecuteNonQuery();
                    if (message != null && !string.IsNullOrEmpty(message.Value as string))
                    {
                        result.Message = message.Value as string;
                        result.IsSuccess = false;
                        break;
                    }
                    Tool.SetListOutParam(cmd, result.OutParams);
                }
            }
        }
    }
}
