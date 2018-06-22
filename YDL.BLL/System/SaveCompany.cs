using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存公司单位
    /// </summary>
    public class SaveCompany : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Company>>(request);
            var obj = req.Entities.FirstOrDefault();
            if (obj.Name.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入名称。");
            }
            if (obj.CreatorId.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请设置创建人。");
            }
            //验证名称重复性
            obj.TrySetNewEntity();
            if (HasExist(obj))
            {
                return ResultHelper.Fail(string.Format("【{0}】已经存在。", obj.Name));
            }
            obj.CreatorId = obj.CreatorId.GetId();
            obj.AdminId = obj.AdminId.GetId();

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }

        private static bool HasExist(Company obj)
        {
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Scalar, text: "SELECT COUNT(*) FROM Company WHERE Name=@Name AND Id!=@Id");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", obj.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@Id", obj.Id));
            var result = DbContext.GetInstance().Execute(cmd);
            return (int)result.Tag > 0;
        }
    }

}
