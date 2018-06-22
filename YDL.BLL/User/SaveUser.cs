using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 修改保存用户信息
    /// </summary>
    public class SaveUser : IService
    {
        /// <summary>
        /// 修改保存用户信息 done
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            user.CityId = user.CityId.GetId();
            user.Sex = user.Sex.GetId();

            //验证城市
            if (user.CityId.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入城市。");
            }

            //验证昵称
            if (user.PetName.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入昵称。");
            }

            //处理姓名
            if (user.CardName.IsNullOrEmpty())
            {
                user.CardName = user.PetName;
            }

            user.ModifyHeadIcon();

            Response result = new Response();
            result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
            if (result.IsSuccess)
            {
                //同步更新用户IM 资料
                result = IMHelper.Instance.ImportAccount(user);
            }
            return result;
        }
    }

}
