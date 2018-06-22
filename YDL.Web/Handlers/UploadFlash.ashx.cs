using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YDL.Web.Handlers
{
    /// <summary>
    /// UploadFlash 的摘要说明
    /// </summary>
    public class UploadFlash : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/x-shockwave-flash";
            context.Response.WriteFile(context.Server.MapPath("~/Content/swf/swfupload.swf"));
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