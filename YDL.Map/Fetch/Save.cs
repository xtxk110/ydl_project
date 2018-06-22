using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using YDL.Core;
using YDL.Utility;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace YDL.Map
{
    internal class Save : FetchBase
    {
        public override Response Execute(Command wrapper)
        {
            var result = new Response() { IsSuccess = true, OutParams = new List<OutParam>() };
            if (wrapper.Entities.IsNotNullOrEmpty())
            {
                TryRemoveUnchanged(wrapper);

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
                        if (wrapper.PreCommands.IsNotNullOrEmpty())
                        {
                            TryExcuteCommands(db, wrapper.PreCommands, result, conn, tran);
                            if (!string.IsNullOrEmpty(result.Message))
                            {
                                //执行错误则回滚
                                tran.Rollback();
                            }
                        }
                        if (result.IsSuccess)
                        {
                            result.RowCount = TrySaveData(db, wrapper, conn, tran);
                            if (result.RowCount > 0)
                            {
                                TryExcuteCommands(db, wrapper.AfterCommands, result, conn, tran);
                                if (string.IsNullOrEmpty(result.Message))
                                {
                                    tran.Commit();
                                }
                                else
                                {
                                    tran.Rollback();
                                }
                            }
                            else
                            {
                                tran.Rollback();
                                result.IsSuccess = false;
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

        private static void TryRemoveUnchanged(Command wrapper)
        {
            List<EntityBase> tempList = new List<EntityBase>();
            wrapper.Entities.ForEach(p =>
            {
                if (p.RowState == RowState.Unchanged)
                {
                    tempList.Add(p);
                }
            });

            if (tempList.IsNotNullOrEmpty())
            {
                tempList.ForEach(p => wrapper.Entities.Remove(p));
            }
        }

        private int TrySaveData(Database db, Command wrapper, DbConnection conn, DbTransaction tran)
        {
            if (wrapper.Entities.IsNotNullOrEmpty())
            {
                wrapper.Entities = wrapper.Entities;
                return UpdateNonDynamic(db, tran, wrapper);
            }
            return 0;
        }

        private static void TryExcuteCommands(Database db, List<Command> cmdList, Response result, DbConnection conn, DbTransaction tran)
        {
            if (cmdList.IsNotNullOrEmpty())
            {
                foreach (var proc in cmdList)
                {
                    var cmd = CommandConvert.ToSelectCommand(db, conn, tran, proc.CmdType, proc.Text, proc.Params);
                    var message = cmd.GetProcMsgParam();
                    cmd.ExecuteNonQuery();
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

        private int UpdateNonDynamic(Database db, DbTransaction tran, Command wrapper)
        {
            var tempType = wrapper.Entities.First().GetType();
            var tempList = new List<object>();
            int count = 0;
            foreach (var data in wrapper.Entities)
            {
                if (data.GetType() == tempType)
                {
                    tempList.Add(data);
                }
                else
                {
                    count += ToDb(db, tran, tempList, wrapper);

                    tempList.Clear();
                    tempType = data.GetType();
                    tempList.Add(data);
                }
            }
            count += ToDb(db, tran, tempList, wrapper);
            return count;
        }

        private int ToDb(Database db, DbTransaction tran, IEnumerable<object> list, Command wrapper)
        {
            int result = 0;
            if (list.IsNotNullOrEmpty())
            {
                var type = list.First().GetType();
                var builder = new CommandBuilder { Type = type, Db = db, CmdWrapper = wrapper };
                var insertCommand = builder.Get(new InsertCommand());
                var updateCommand = builder.Get(new UpdateCommand());
                var deleteCommand = builder.Get(new DeleteCommand());
                DataSet ds = new DataSet();
                ds.Tables.Add(MapConverter.ToDataTable(list));
                result = db.UpdateDataSet(ds, ds.Tables[0].TableName, insertCommand, updateCommand, deleteCommand, tran);
            }
            return result;
        }
    }
}
