using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户角色关系列表,根据用户ID
    /// </summary>
    public class GetRoleUserMapListByUserId_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitRole>>(request);
            var obj = req.Filter;

            var sqlStr = @"SELECT b.Id,b.Name,b.IsDefault FROM LimitRole AS b ";
            var cmd = CommandHelper.CreateText<LimitRole>(FetchType.Fetch, sqlStr);
            //cmd.Params.Add("@userid", obj.UserId);
            var response = DbContext.GetInstance().Execute(cmd);
            if (response.Entities != null)
            {
                foreach(LimitRole item in response.Entities)
                {
                    if (LimitHelper.IsChecked(obj.UserId, item.Id))
                        item.IsChecked = true;
                    else
                        item.IsChecked = false;
                }
            }
            
            return response;
        }
        
    }
}
