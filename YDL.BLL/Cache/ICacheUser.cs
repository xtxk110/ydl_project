using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Runtime.Caching;
using System.Data;

using YDL.Model;
using YDL.Utility;
using System.Threading.Tasks;

namespace YDL.BLL
{
    /// <summary>
    /// 账号缓存接口
    /// </summary>
    public interface ICacheUser
    {
        User GetUserById(string userId,string deviceType);

        User GetUserByToken(string token);

        bool AddToCache(User user, string deviceType);

        void LoginOut(string token,string deviceType);

        User Login(string code, string password,string deviceType);
    }
}
