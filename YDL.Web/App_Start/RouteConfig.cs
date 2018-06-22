using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace YDL.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            //路由规则
            routes.Clear();
            routes.RouteExistingFiles = true;
            //routes.MapHubs(new HubConfiguration() { EnableDetailedErrors = true });

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{*allextfile}", new { allextfile = @".*\.(asmx|aspx|asp|dll|php|jsp|jsf|jpg|png|gif|bmp|rar|zip|js|css|pdf|htm|html|swf|txt|xml|ico|icon)(/.*)?" });
            routes.IgnoreRoute("Annexs/{*pathInfo}");
            routes.IgnoreRoute("Download/{*pathInfo}");
            routes.IgnoreRoute("Handlers/{*pathInfo}");

            routes.MapRoute(
                "Login", // Route name
                "Login", // URL with parameters
                new { controller = "Free", action = "Login", id = UrlParameter.Optional } // Parameter defaults
            );
            routes.MapRoute(
                "LoginOut", // Route name
                "LoginOut", // URL with parameters
                new { controller = "Home", action = "LoginOut", id = UrlParameter.Optional } // Parameter defaults
            );
            routes.MapRoute(
                "Home", // Route name
                "Home", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

            routes.MapRoute(
                "MobilePackDownload", // Route name
                "Annex/MobilePackDownload/{packname}", // URL with parameters
                new { controller = "Free", action = "MobilePackDownload", packname = UrlParameter.Optional } // Parameter defaults
            );

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Web", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );
           // routes.MapRoute(
           //    "Default", // Route name
           //    "{controller}/{action}/{id}", // URL with parameters
           //    new { controller = "WebSite", action = "Index", id = UrlParameter.Optional } // Parameter defaults
           //);
        }
    }
}
