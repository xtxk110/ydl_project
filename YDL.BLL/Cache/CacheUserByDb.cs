using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Model;
using YDL.Utility;
using YDL.Map;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 采用数据库方式缓存账号
    /// </summary>
    public class CacheUserByDb : ICacheUser
    {
        public User GetUserById(string userId, string deviceType)
        {
            return UserHelper.GetOnlieUser(userId, deviceType, string.Empty);
        }

        public User GetUserByToken(string token)
        {
            return UserHelper.GetOnlieUser(string.Empty, string.Empty, token);
        }

        public bool AddToCache(User user, string deviceType)
        {
            var obj = new OnlineUser { UserId = user.Id };
            obj.SetCreateDate();
            obj.SetNewId();
            obj.SetRowAdded();
            obj.Token = Guid.NewGuid().ToString().EncryptByMD5();
            obj.DeviceType = deviceType;

            var entities = new List<EntityBase> { obj };
            var cmd = CommandHelper.CreateSave(entities);
            cmd.PreCommands = new List<Command> { AttachDeleteToken(user.Id, deviceType) };
            DbContext.GetInstance().Execute(cmd);

            user.DeviceType = obj.DeviceType;
            user.Token = obj.Token;


            return true;
        }

        /// <summary>
        /// 一种设备同时只允许一个登录，前面的会自动下线
        /// </summary>
        /// <param name="user"></param>
        /// <param name="deviceType"></param>
        /// <returns></returns>
        private static Command AttachDeleteToken(string userId, string deviceType)
        {
            var cmdDelete = CommandHelper.CreateProcedure(FetchType.Execute, "sp_DeleteOnlineUser ");
            cmdDelete.Params.Add("@userId", userId);
            return cmdDelete;
        }

        public void LoginOut(string userId,string deviceType)
        {
            DbContext.GetInstance().Execute(AttachDeleteToken(userId,deviceType));
        }

        public User Login(string code, string password, string deviceType)
        {
            var user = UserHelper.Validate(code, password);
            if (user != null)
            {
                AddToCache(user, deviceType);
                return user;
            }
            else
            {
                throw new Exception("账号或者密码错误！");
            }
        }
    }
}
