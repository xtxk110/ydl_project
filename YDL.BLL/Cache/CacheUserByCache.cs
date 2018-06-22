using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Runtime.Caching;
using System.Data;

using YDL.Model;
using YDL.Utility;
using YDL.Map;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 采用缓存方式实现账号缓存
    /// </summary>
    public class CacheUserByCache : ICacheUser
    {
        private static readonly string REGIN_NAME = "OnlineUser";
        private ObjectCache cacheUsers = MemoryCache.Default;

        public User GetUserById(string userId, string deviceType)
        {
            var key = userId.EncryptByMD5();
            foreach (var item in cacheUsers)
            {
                if (item.Key.StartsWith(key))
                {
                    return item.Value as User;
                }
            }
            return null;
        }

        public User GetUserByToken(string token)
        {
            foreach (var item in cacheUsers)
            {
                if (item.Key.EndsWith(token))
                {
                    return item.Value as User;
                }
            }
            return null;
        }

        public bool AddToCache(User user, string deviceType)
        {
            var temp = GetUserById(user.Id, deviceType);
            if (temp == null)
            {
                user.Token = Guid.NewGuid().ToString().EncryptByMD5();
                CacheItemPolicy p = new CacheItemPolicy { Priority = CacheItemPriority.Default };
                //p.AbsoluteExpiration = new DateTimeOffset(DateTime.Now.AddDays(5));
                cacheUsers.Add(new CacheItem(UserHelper.CreateCacheKey(user), user, REGIN_NAME), p);
            }
            else
            {
                user.Token = temp.Token;
            }
            return true;
        }

        public void LoginOut(string userId, string deviceType)
        {
            var temp = GetUserById(userId,null);
            if (temp != null)
            {
                var key = UserHelper.CreateCacheKey(temp);
                if (cacheUsers.Contains(key))
                {
                    cacheUsers.Remove(key);
                }
            }
        }

        public User Login(string code, string password, string deviceType)
        {
            User user = UserHelper.Validate(code, password);
            if (user != null)
            {
                LoginOut(user.Id, deviceType);
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
