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
    /// 修改技术类别
    /// </summary>
    public class UpdateCategoryOfTechnology : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<SysDic>>(request);
            var obj = req.FirstEntity();
            if (CoachHelper.Instance.IsExistCategory(obj))
            {
                return ResultHelper.Fail("已存在此技术类别名称, 请重新输入一个新的名称");
            }

            var sql = @"UPDATE dbo.SysDic SET Name=@Name WHERE Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Name", obj.Name);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }




    }
}
