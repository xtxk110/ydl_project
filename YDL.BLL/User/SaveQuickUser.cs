using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using NLog;

namespace YDL.BLL
{
    /// <summary>
    /// 注册用户 done
    /// </summary>
    public class SaveQuickUser : IService
    {

        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();
            user.WeiXinUnionId = "";
            if (user.Mobile.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入手机。");
            }

            //先检查手机号是否已注册
            User userdb = UserHelper.GetUserByMobile(user.Mobile);
            if (userdb != null)
            {
                return ResultHelper.Fail("手机号已注册, 不能再注册");
            }

            //最后注册
            return RegisterUser(user);
        }

        public Response RegisterUser(User user)
        {
            Logger logger = LoggerHelper.GetOperateLog();
            //验证注册必要信息
            if (user.CityId.IsNullOrEmpty())
            {
                user.CityId = "75";
                //return ResultHelper.Fail("城市不能为空");
            }

            if (user.PetName.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入昵称。");
            }

            user.Id = Ext.NewId();
            if (user.CardName.IsNullOrEmpty())
            {
                user.CardName = user.PetName;
            }
            user.PetName = user.PetName.Trim();
            user.CardName = user.CardName.Trim();
            user.ModifyHeadIcon();
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveQuickUser");
            cmd.Params.Add("@userId", user.Id);
            cmd.Params.Add("@sex", user.Sex.GetId());
            cmd.Params.Add("@petName", user.PetName);
            cmd.Params.Add("@cardName", user.CardName);
            cmd.Params.Add("@mobile", user.Mobile);
            cmd.Params.Add("@cityId", user.CityId);
            cmd.Params.Add("@password", user.Password);
            cmd.Params.Add("@headUrl", user.HeadUrl);
            cmd.Params.Add("@lat", user.Lat, DataType.Double);
            cmd.Params.Add("@lng", user.Lng, DataType.Double);
            cmd.Params.Add("@userCode", null, DataType.String, ParamDirection.Output, 50);
            cmd.Params.Add("@address", user.Address);
            cmd.Params.Add("@WeiXinUnionId", user.WeiXinUnionId);
            cmd.Params.Add("@QQOpenId", user.QQOpenId);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            var userCodeParam = result.OutParams.FirstOrDefault(p => p.Name == "@userCode");
            if (userCodeParam != null)
            {
                user.Code = userCodeParam.value.ToString();
            }

            //尝试加入可能数据库不存在的城市
            if (user.CityId.IsNotNullOrEmpty() && user.CityName.IsNotNullOrEmpty())
            {
                Globals.SaveCity(user.CityId, user.CityName);
            }

            //建立IM账户
            if (result.IsSuccess == true)
            {
                result = IMHelper.Instance.ImportAccount(user);
                BindDefaultRole(user.Id);//绑定默认角色
                BindDefaultOrg(user.Id);//绑定默认机构
            }

            if (result.IsSuccess == false)
            {
                DeleteRegisterUser(user.Id);
                logger.Error("注册失败:" + result.Message);
                return ResultHelper.Fail("注册失败");
            }
            result.Tag = user.Code;
            return result;
        }

        /// <summary>
        /// IM同步失败就删除刚刚注册的信息
        /// </summary>
        public void DeleteRegisterUser(string userId)
        {
            var sql = @"
   DELETE FROM dbo.UserAccount WHERE Id=@Id 
   DELETE FROM dbo.UserLimit WHERE UserId=@Id 
   DELETE FROM dbo.UserSport WHERE UserId=@Id 
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", userId);

            var result = DbContext.GetInstance().Execute(cmd);
        }
        /// <summary>
        /// 注册成功,绑定默认角色名user(000002)
        /// </summary>
        /// <param name="userId"></param>
        public void BindDefaultRole(string userId)
        {
            string sqlStr = @"DELETE FROM LimitRoleUserMap WHERE UserId=@userid";
            var cmd = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Execute, sqlStr);
            cmd.Params.Add("@userid", userId);
            DbContext.GetInstance().Execute(cmd);
            LimitRoleUserMap userRole = new LimitRoleUserMap();
            userRole.RoleId = "000002";
            userRole.UserId = userId;
            userRole.SetNewEntity();
            DbContext.GetInstance().Execute(CommandHelper.CreateSave(userRole));

        }
        /// <summary>
        /// 注册成功,绑定默认机构(000002)
        /// </summary>
        /// <param name="userId"></param>
        public void BindDefaultOrg(string userId)
        {
            string sqlStr = @"UPDATE UserAccount SET OrganTypeId='00001' WHERE Id=@userid";
            var cmd = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Execute, sqlStr);
            cmd.Params.Add("@userid", userId);
            DbContext.GetInstance().Execute(cmd);
        }

    }

}
