using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using System.Data.Common;
using YDL.Core;
using YDL.Utility;

namespace YDL.Map
{
    internal class FetchSelf : FetchBase
    {
        public override Response Execute(Command wrapper)
        {
            var result = new Response() { IsSuccess = true, Entities = new List<EntityBase>() };
            try
            {
                var db = CreateDatabase();
                using (var conn = db.CreateConnection())
                {
                    if (conn.State != ConnectionState.Open)
                    {
                        conn.Open();
                    }

                    var cmd = CommandConvert.ToSelectSelfCommand(db, conn, null, wrapper.Text, wrapper.Params, Type.GetType(wrapper.EntityType), wrapper);
                    var ds = db.ExecuteDataSet(cmd);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        result.Entities = new List<EntityBase>();
                        MapConverter.ToList(ds.Tables[0], Type.GetType(wrapper.EntityType), result.Entities);
                    }
                    conn.Close();
                }

            }
            catch (Exception ex)
            {
                result.IsSuccess = false;
                result.Message = ex.Message;
            }
            return result;
        }
    }
}
