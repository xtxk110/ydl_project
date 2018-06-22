using System;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using YDL.Model;

namespace YDL.Web
{
    public class ControllerLimit : ControllerFree
    {
        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);

            var request = requestContext.HttpContext.Request;
            if (request.RequestType.ToUpper() == "GET")
            {
                if (!OnlineHelper.IsAuthenticated)
                {
                    if (ValidateHelper.IsNeedValidate(request))
                    {
                        var response = requestContext.HttpContext.Response;
                        response.Redirect("~/login", true);
                    }
                }
            }
        }

    }
}