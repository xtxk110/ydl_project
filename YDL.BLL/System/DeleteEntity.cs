using System;
using System.Text;
using System.Linq;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 删除数据(done)
    /// </summary>
    public class DeleteEntity : IServiceBase
    {
        private static readonly string sql = " DELETE FROM {0} WHERE {1} IN (SELECT * FROM dbo.fn_Split('{2}')) ";

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">EntityPair</param>
        /// <returns>EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<EntityPair>>(request);
            var sb = new StringBuilder();
            foreach (var obj in req.Entities)
            {
                if (sb.Length > 0)
                {
                    sb.Append(Constant.Str_Semicolon);
                }
                sb.Append(string.Format(sql, obj.Table, obj.Field, obj.Values));
            }
            var cmd = CommandHelper.CreateText(FetchType.Execute, sb.ToString());

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
