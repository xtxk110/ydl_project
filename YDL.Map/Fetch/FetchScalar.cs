using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using System.Data;
using System.Data.Common;
using YDL.Core;
using YDL.Utility;


namespace YDL.Map
{
    internal class FetchScalar : FetchBase
    {
        public override Response Execute(Command wrapper)
        {
            var result = new Response() { IsSuccess = true, OutParams = new List<OutParam>() };
            var db = CreateDatabase();
            using (var conn = db.CreateConnection())
            {
                try
                {
                    if (conn.State != ConnectionState.Open)
                    {
                        conn.Open();
                    }
                    /*
                    if (wrapper.AfterCommands.IsNotNullOrEmpty())
                    {
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
                            }
                        }
                        catch (Exception ex)
                        {
                            tran.Rollback();

                            result.IsSuccess = false;
                            result.Message = ex.Message;
                        }

                    }*/
                    if (result.IsSuccess)
                    {
                        var cmd = CommandConvert.ToSelectCommand(db, conn, null, wrapper.CmdType, wrapper.Text, wrapper.Params);
                        result.Tag = cmd.ExecuteScalar();
                        Tool.SetListOutParam(cmd, result.OutParams);
                    }
                    conn.Close();
                }
                catch (Exception ex)
                {
                    result.IsSuccess = false;
                    result.Message = ex.Message;
                }
            }
            return result;
        }

        private static void TryExcuteCommands(Database db, Command wrapper, Response result, DbConnection conn, DbTransaction tran)
        {
            foreach (var proc in wrapper.AfterCommands)
            {
                var cmd = CommandConvert.ToSelectCommand(db, conn, tran, proc.CmdType, proc.Text, proc.Params);
                var message = cmd.GetProcMsgParam();
                result.RowCount = cmd.ExecuteNonQuery();
                if (message != null && !string.IsNullOrEmpty(message.Value as string))
                {
                    result.Message = message.Value as string;
                    result.IsSuccess = false;
                    break;
                }
            }
        }
    }
}
