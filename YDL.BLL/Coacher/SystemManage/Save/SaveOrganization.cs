using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 保存机构
    /// </summary>
    public class SaveOrganization : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachOrganization>>(request);
            var obj = req.FirstEntity();
            if (IsExistOrganization(obj))
            {
                return ResultHelper.Fail("已存在此名称的机构, 请换个新名称再添加");
            }
            if (IsManagerOtherOrganization(obj))
            {
                return ResultHelper.Fail("管理员已管理其他的机构, 请换个管理员");
            }
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {

                if (string.IsNullOrEmpty(obj.OrgType))
                {
                    obj.OrgType = CoachDic.Type_General;//给机构赋默认值
                }
                obj.TrySetNewEntity();
            }

            //处理头像
            obj.ModifyHeadIcon();
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return result;

        }

        public bool IsManagerOtherOrganization(CoachOrganization obj)
        {
            string sql = "";
            sql = @"
SELECT * 
FROM dbo.CoachOrganization 
WHERE ManagerId =@ManagerId
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id";
            }

            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@ManagerId", obj.ManagerId);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }


        public bool IsExistOrganization(CoachOrganization obj)
        {
            string sql = "";
            sql = @"
SELECT * 
FROM dbo.CoachOrganization 
WHERE Name =@Name
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id";
            }

            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@Name", obj.Name);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

    }
}
