using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YDL.BLL;

namespace YDL.Web.Handlers
{
    /// <summary>
    /// 验证码
    /// </summary>
    public class IdentifyingCode : IHttpHandler
    {
        /// <summary>
        /// 验证码图片
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ClearContent();
                context.Response.ContentType = "image/Jpeg";

                var vc = new ValCode();
                var code = vc.CreateValidateCode(4);

                HttpCookie hc = new HttpCookie("validatecode", code);
                TimeSpan ts = new TimeSpan(0, 2, 0);//2分钟
                hc.Expires = DateTime.Now.Add(ts);
                context.Response.Cookies.Set(hc);

                var codeImg = vc.CreateValidateGraphic(code);
                context.Response.BinaryWrite(codeImg);

            }
            catch
            {
                
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}