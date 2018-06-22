using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 保存当前角色权限
    /// </summary>
    public class SaveLimit_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Limit>>(request);
            var objList = req.Entities;
            int type = 0;//权限动作类型  1操作,2查看,3特殊
            string roleid = string.Empty;
            if (objList.Count > 0)
            {
                Limit limit = objList[0];
                type = limit.Type;
                roleid = limit.RoleId;
                if (limit.RoleId.Equals("000002")) //假如是默认角色,不能更改权限 || limit.RoleId.Equals("000001")
                {
                    return ResultHelper.Fail("默认角色不能修改权限");
                }
            }
            else
            {
                return ResultHelper.Fail("权限数据为空");
            }
            DeleteLimitByRole(roleid, type);//删除对应角色及动作的权限
            foreach (Limit item in objList)
            {
                item.SetNewEntity();
                //Limit limit = GetOwnLimit(item.RoleId, item.LimitName);
                //if (limit == null)
                //{
                //    item.SetNewEntity();
                //}
                //else
                //{
                //    item.Id = limit.Id;
                //    item.RowState = RowState.Modified;
                //    item.SetCreateDate();
                //}
            }
            List<EntityBase> entity = new List<EntityBase>(objList);
            var cmd = CommandHelper.CreateSave(entity);
            var response = DbContext.GetInstance().Execute(cmd);
            if (response.IsSuccess)
            {
                var list = LimitHelper.GetRoleUserMap(roleid);//获取对应角色的用户
                foreach(var item in list)
                {
                    LimitHelper.DeleteOnlieUser(item.UserId);//剔掉线
                }
            }
            return response;
        }
        private Limit GetOwnLimit(string roleid,string limitName)
        {
            string sqlStr = @"SELECT * FROM Limit WHERE RoleId=@roleid AND LimitName=@limitname";
            var cmd = CommandHelper.CreateText<Limit>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@roleid", roleid);
            cmd.Params.Add("@limitname", limitName);
            var response = DbContext.GetInstance().Execute(cmd);
            if (response.Entities != null&&response.Entities.Count>0)
                return response.Entities[0] as Limit;
            else
                return null;
        }
        /// <summary>
        /// 删除对应角色及动作的权限
        /// </summary>
        /// <param name="roleid"></param>
        /// <param name="type">动作类型</param>
        /// 
        /// <returns></returns>
        private bool DeleteLimitByRole(string roleid,int type)
        {//DELETE FROM Limit WHERE RoleId=''
            bool flag = false;
            string sqlStr = @"DELETE FROM Limit WHERE RoleId=@roleid AND Type=@type";
            var cmd = CommandHelper.CreateText<Limit>(FetchType.Execute, sqlStr);
            cmd.Params.Add("@roleid", roleid);
            cmd.Params.Add("@type", type);
            var response = DbContext.GetInstance().Execute(cmd);
            if (response.IsSuccess)
                flag = true;

            return flag;
        }
    }
}
