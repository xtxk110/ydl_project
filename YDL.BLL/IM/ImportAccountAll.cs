using System.Linq;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using RestSharp;
using System;
using YDL.Utility;
using System.Threading.Tasks;
using System.Threading;

namespace YDL.BLL
{
    /// <summary>
    /// 账号批量导入(如果没有就创建, 有就修改原有账号信息)
    /// </summary>
    public class ImportAccountAll : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<AccountImport>(request);

            var sql = @"
 SELECT TOP 100 * FROM dbo.UserAccount   ORDER BY CreateDate DESC
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);

            Response rsp = new Response();

            var logger = LoggerHelper.GetOperateLog();
            foreach (var item in result.Entities)
            {
                var user = item as User;
                rsp = IMHelper.Instance.ImportAccount(user);
                if (rsp.IsSuccess == false)
                {

                    logger.Error("导入失败 ,账号: " + user.Code + "  " + rsp.Message);
                    return rsp;
                }
                logger.Debug("导入成功, 账号: " + user.Code);
                Thread.Sleep(10);
            }

            return rsp;

        }
    }
}
