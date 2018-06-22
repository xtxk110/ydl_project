using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 用户角色匹配增加(从角色添加用户或从用记选择角色)
    /// </summary>
    class SaveRoleUserMap_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitRole>>(request);
            var obj = req.FirstEntity();
            List<EntityBase> entites = new List<EntityBase>();
            if ((string.IsNullOrEmpty(obj.UserId) && !string.IsNullOrEmpty(obj.Id)))//从角色添加用户
            {
                foreach (var item in obj.MapList)
                {
                    if (!LimitHelper.IsChecked(item.UserId, item.RoleId))
                    {
                        item.SetNewEntity();
                        entites.Add(item);
                    }
                }

            }
            else//从用户添加角色
            {
                string delSql = @"DELETE FROM LimitRoleUserMap WHERE UserId=@Userid";
                var cmd2 = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Execute, delSql);
                cmd2.Params.Add("@Userid", obj.UserId);
                DbContext.GetInstance().Execute(cmd2);
                foreach (var item in obj.MapList)
                {
                    item.SetNewEntity();
                    entites.Add(item);
                }
            }
            //保存用户角色关系
            var cmd = CommandHelper.CreateSave(entites);
            var response = DbContext.GetInstance().Execute(cmd);
            if (response.IsSuccess)
            {//角色更改,剔除相应的在线用户
                if ((string.IsNullOrEmpty(obj.UserId) && !string.IsNullOrEmpty(obj.Id)))//从角色添加用户
                {
                    foreach(LimitRoleUserMap item in entites)
                    {
                        var result = LimitHelper.DeleteOnlieUser(item.UserId);
                    }
                }
                else//从用户添加角色
                {
                    var result = LimitHelper.DeleteOnlieUser(obj.UserId);
                }
            }
            return response;
        }
    }
}
