using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;


namespace YDL.BLL
{
    /// <summary>
    /// 新增删除更新用户角色
    /// </summary>
    class SaveRole_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitRole>>(request);
            var obj = req.FirstEntity();
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            Response response = null;
            //string sqlStr = @"INSERT INTO [LimitRole] ([Name], [IsDefault]) VALUES (@name, @default)";
            if (obj.RowState == RowState.Added)
            {
                obj.SetNewEntity();
                obj.IsDefault = false;
                var cmd = CommandHelper.CreateSave(entites);
                response = DbContext.GetInstance().Execute(cmd);
            }
            else //删除\更新
            {
                string sqlStr = @"SELECT * FROM LimitRole Where Id=@id AND IsDefault=0";
                var cmd1 = CommandHelper.CreateText<LimitRole>(FetchType.Fetch, sqlStr);
                cmd1.Params.Add("@id", obj.Id);
                var existResult = DbContext.GetInstance().Execute(cmd1);
                var existObj = existResult.FirstEntity<LimitRole>();
                if (existObj != null)
                {
                    var cmd = CommandHelper.CreateSave(entites);
                    response = DbContext.GetInstance().Execute(cmd);
                    if (RowState.Deleted == obj.RowState)//删除角色时,删除角色用户表中的相应数据
                    {
                        if (response.IsSuccess)
                        {
                            string delSql = @"DELETE FROM LimitRoleUserMap WHERE RoleId=@id";
                            var cmd2 = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Execute, delSql);
                            cmd2.Params.Add("@id", obj.Id);
                            response = DbContext.GetInstance().Execute(cmd2);
                        }
                    }
                }
                else
                {
                    response = ResultHelper.Fail("默认用户不能操作");
                }
            }           
            return response;
        }
    }
}
