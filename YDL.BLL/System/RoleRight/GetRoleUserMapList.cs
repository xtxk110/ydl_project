using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户角色关系列表,根据角色ID
    /// </summary>
    class GetRoleUserMapList_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitRoleUserMap>>(request);
            var obj = req.Filter;
            var card_name = obj.CardName;

            //var sqlStr = @"SELECT b.CardName,b.PetName,b.Mobile,a.RoleId,a.UserId FROM LimitRoleUserMap AS a LEFT JOIN UserAccount AS b ON a.UserId=b.Id Where a.RoleId=@roleid AND b.CardName like %@cardanme%";
            var cmd = CommandHelper.CreateProcedure<LimitRoleUserMap>(FetchType.Fetch, "sp_GetRoleUserMapListByRole");
            cmd.Params.Add("@roleid", obj.RoleId);
            cmd.Params.Add("@cardanme", card_name);
            cmd.CreateParamPager(obj);
            var response = DbContext.GetInstance().Execute(cmd);
            foreach(var item in response.Entities)
            {
                (item as LimitRoleUserMap).CardName = Regex.Replace((item as LimitRoleUserMap).CardName, @"\s", "");
            }
            response.SetRowCount();
            return response;
        }
    }
}
