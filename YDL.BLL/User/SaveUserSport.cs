using System;
using System.Linq;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存用户运动爱好 done
    /// </summary>
    public class SaveUserSport : IServiceBase
    {
        /// <summary>
        /// 保存用户运动爱好
        /// </summary>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserSport>>(request);
            var obj = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveUserSport");
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@UserId", obj.UserId.GetId());
            cmd.Params.Add("@SportId", obj.SportId.GetId());
            cmd.Params.Add("@IsActive", obj.IsActive,DataType.Boolean);
            cmd.Params.Add("@ProType", obj.ProType);
            cmd.Params.Add("@GripOption", obj.GripOption);
            cmd.Params.Add("@Score", obj.Score, DataType.Int32);
            cmd.Params.Add("@Editor", currentUser.Id);
            cmd.CreateParamActionCode(obj.RowState);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
