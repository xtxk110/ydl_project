using System;
using System.Collections.Generic;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using YDL.Model;

namespace YDL.Web
{
    public class ControllerFree : Controller
    {
        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
        }

        protected User CurrentUser
        {
            get{
                return OnlineHelper.GetCurrentUser();
            }
        }

        [NonAction]
        public JsonResult ToJson(object obj)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = obj };
        }

        [NonAction]
        public ActionResult RedirectToErrorPage(string errorMsg)
        {
            return View("Error", null, errorMsg);
        }

    }
}