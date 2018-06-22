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
    /// 用户签到
    /// </summary>
    public class SaveUserSign : IService
    {
        /// <summary>
        /// 场馆签到
        /// </summary>
        /// <param name="request">实体UserSign</param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserSign>>(request);

            var obj = req.Entities.FirstOrDefault();
            obj.MasterType = obj.MasterType.GetId();
            obj.MasterId = obj.MasterId.GetId();
            obj.CreatorId = obj.CreatorId.GetId();
            obj.TrySetNewEntity();
            
            string errorMsg = ValidateUserSign(obj);
            if (errorMsg.IsNotNullOrEmpty())
            {
                return ResultHelper.Fail(errorMsg);
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }

        private static string ValidateUserSign(UserSign obj)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_ValidateUserSign");
            cmd.Params.Add("@userId", obj.CreatorId);
            cmd.Params.Add("@masterId", obj.MasterId);
            cmd.Params.Add("@signDate", obj.CreateDate.ToDbString());
            var result = DbContext.GetInstance().Execute(cmd);
            return (string)result.Tag ;
        }
    }

}
