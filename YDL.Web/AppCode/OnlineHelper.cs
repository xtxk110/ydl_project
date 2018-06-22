using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using YDL.BLL;
using YDL.Model;
using YDL.Utility;

namespace YDL.Web
{
    public class OnlineHelper : System.Web.SessionState.IRequiresSessionState
    {
        public static User GetCurrentUser()
        {
            var u = HttpContext.Current.Session[Constant.UserSessionKey] as User;
            if (u != null)
            {
                var user = CacheUserBuilder.Instance.GetUserByToken(u.Token);
                if (user != null)
                {
                    if (user.IsAdmin)
                        user.UserLimit = new UserLimit() { IsActivity = true, IsClub = true, IsGame = true, IsNote = true, IsVenue = true };
                    else if (u.UserLimit != null)
                        user.UserLimit = u.UserLimit;
                    else
                        user.UserLimit = new UserLimit() { IsActivity = false, IsClub = false, IsGame = false, IsNote = true, IsVenue = false };

                    return user;
                }
            }

            return null;
        }

        /// <summary>
        /// 获取当前会话是否是嵌入Moble的
        /// </summary>
        public static bool InsetMobile
        {
            get
            {
                var s = HttpContext.Current.Session["InsetMobile"];
                return (s != null && Convert.ToBoolean(s));
            }
        }

        /// <summary>
        /// 获取当前用户是否通过验证
        /// </summary>
        public static bool IsAuthenticated
        {
            get
            {
                return GetCurrentUser() != null;
            }
        }

        /// <summary>
        /// 检测客户端是否使用了代理
        /// </summary>
        /// <returns></returns>
        public static bool IsProxy()
        {
            return HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null;
        }
        /// <summary>
        /// 获取客户端IPV6的地址
        /// </summary>
        /// <returns></returns>
        public static string GetClientIpPv6()
        {
            string ipv6 = string.Empty;

            if (IsProxy())//客户端有使用代理
            {
                ipv6 = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else//客户端没有使用代理
            {
                ipv6 = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
            }
            return ipv6;

        }

        /// <summary>
        /// 获取客户端IPV4的地址
        /// </summary>
        /// <returns></returns>
        public static string GetClientIpPv4()
        {
            string ipv4 = String.Empty;
            foreach (IPAddress IPA in Dns.GetHostAddresses(HttpContext.Current.Request.UserHostAddress))
            {
                if (IPA.AddressFamily.ToString() == "InterNetwork")
                {
                    ipv4 = IPA.ToString();
                    break;
                }
            }
            if (ipv4 != String.Empty)
            {
                return ipv4;
            }

            foreach (IPAddress IPA in Dns.GetHostAddresses(Dns.GetHostName()))
            {
                if (IPA.AddressFamily.ToString() == "InterNetwork")
                {
                    ipv4 = IPA.ToString();
                    break;
                }
            }
            return ipv4;
        }

        /// <summary>
        /// 获取客户端IP地址
        /// 返回一个IPV4或IPV6的地址
        /// </summary>
        /// <returns></returns>
        public static string GetClientIP()
        {
            string ipv4 = GetClientIpPv4();
            return string.IsNullOrWhiteSpace(ipv4) ? GetClientIpPv6() : ipv4;
        }
    }
}