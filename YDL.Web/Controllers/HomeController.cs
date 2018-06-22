using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YDL.Web
{
    public class HomeController : ControllerLimit
    {
        public ActionResult Index()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }
    }
}