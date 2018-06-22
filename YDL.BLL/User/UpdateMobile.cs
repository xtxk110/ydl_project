using System;
using System.Collections.Generic;
using System.Linq;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 修改手机号 done
    /// </summary>
    public class UpdateMobile : IService
    {
       
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            if (user.Id.IsNullOrEmpty() || user.Mobile.IsNullOrEmpty() || user.ValCode.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入手机号和验证码。");
            }

            var valCode = SystemHelper.GetValCode(user.Mobile);
            if (valCode == null || user.ValCode != valCode.Code)
            {
                return ResultHelper.Fail("验证码错误。");
            }

            //判断手机号是否存在
            var userOther = getUserByMobile(user.Id, user.Mobile);
            if (userOther != null)
            {
                return ResultHelper.Fail("此手机号已经和昵称为: "+userOther.PetName +" 的绑定, 请先解绑");
            }

            var cmd = CommandHelper.CreateText(FetchType.Execute, "UPDATE UserAccount SET Mobile=@mobile WHERE Id=@id");
            cmd.CreateParamId(user.Id);
            cmd.Params.Add("@mobile", user.Mobile);

            return DbContext.GetInstance().Execute(cmd);
        }

        /// <summary>
        /// 除自己外,看手机号是否已存在
        /// </summary>
        /// <returns></returns>
        public User getUserByMobile(string userId, string mobile)
        {
            var cmd = CommandHelper.CreateText<User>(text: "SELECT * FROM UserAccount " +
                "WHERE Mobile=@Mobile AND Id!=@Id");
            cmd.Params.Add(CommandHelper.CreateParam("@Mobile", mobile));
            cmd.Params.Add(CommandHelper.CreateParam("@Id", userId));

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault();
            if (obj == null)
                return null;
            return obj as User;
        }

    }

}
