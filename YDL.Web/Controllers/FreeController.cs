using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using YDL.BLL;
using YDL.Model;
using YDL.Core;
using YDL.Map;
using YDL.Utility;

namespace YDL.Web
{
    public class FreeController : ControllerFree
    {
        [HttpGet]
        public ActionResult Login(bool isIframe = false)
        {
            try
            {
                ViewBag.IsIframe = isIframe;
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult Login(string loginName, string pwd)
        {
            try
            {
                Request<User> req = new Request<User>();
                req.Filter = new User { Code = loginName, Password = pwd, DeviceType = DeviceType.PC };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.Login, req);
                if (result.IsSuccess)
                    Session[Constant.UserSessionKey] = result.Entities.FirstOrDefault() as User;

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpPost]
        public JsonResult Logoff()
        {
            try
            {
                Session.Remove(Constant.UserSessionKey);
                Session.Abandon();

                var result = ResultHelper.Success();
                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }
    }
}