using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YDL.BLL;
using YDL.Map;
using YDL.Utility;

namespace YDL.Web.Controllers
{
    public class WebSiteController : ControllerFree
    {
        private AESOperator aes = AESOperator.GetInstance();
        // GET: WebSite
        public ActionResult Index()
        {
            try
            {
                var menuInfo = MenuHelper.GetMenu(MenuHelper.MenuName.HomePage);
                return View(menuInfo);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        public ActionResult Index2()
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

        public ActionResult Product()
        {
            try
            {
                var menuInfo = MenuHelper.GetMenu(MenuHelper.MenuName.Product);
                return View(menuInfo);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        public ActionResult Company()
        {
            try
            {
                var menuInfo = MenuHelper.GetMenu(MenuHelper.MenuName.A_Company);
                return View(menuInfo);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }
        public ActionResult Join()
        {
            try
            {
                var menuInfo = MenuHelper.GetMenu(MenuHelper.MenuName.A_Join);
                return View(menuInfo);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        /// <summary>
        /// IOS二维码下载页面
        /// </summary>
        /// <returns></returns>
        public ActionResult DownPage_IOS()
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

        [Route("TestApi"), HttpPost]
        public string TestApi(string serviceName)
        {
            string isDebug = ConfigurationManager.AppSettings["IsDebug"].ToString();
            if (isDebug == "1")
            {
                Stream req = Request.InputStream;
                req.Seek(0, SeekOrigin.Begin);
                string json = new StreamReader(req).ReadToEnd();

                var result = ServiceBuilder.GetInstance().Execute(serviceName, json, Formatting.Indented);

                return result;
            }
            else
                return "hello";
        }


        /// <summary>
        ///  直接访问接口 ,此处添加的接口可以非加密的方式访问, 目前仅用于赛事电视方面的接口, 其他接口不要随便加到这里, 有安全风险
        /// </summary>
        /// <param name="serviceName"></param>
        /// <returns></returns>
        [Route("LocalApi"), HttpPost]
        public string LocalApi(string serviceName)
        {
            string isDebug = ConfigurationManager.AppSettings["IsDebug"].ToString();
            Stream req = Request.InputStream;
            req.Seek(0, SeekOrigin.Begin);
            string reqBodyJson = new StreamReader(req).ReadToEnd();
            ///////////////
                reqBodyJson = aes.Decrypt(reqBodyJson);
            /////////////////////////////////////
            Response result = new Map.Response(); ;
            switch (serviceName)
            {
                case "GetGameKnockLoopListForTV":
                    result = GetGameKnockLoopListForTV.Execute(reqBodyJson);
                    break;
                case "GetGameListForTV":
                    result = GetGameListForTV.Execute(reqBodyJson);
                    break;
                case "GetGameGroupListForTV":
                    result = GetGameGroupListForTV.Execute(reqBodyJson);
                    break;
                case "GetGameGroupForTV":
                    result = GetGameGroupForTV.Execute(reqBodyJson);
                    break;
                case "GetSocketIPAndPort_191":
                    result = GetSocketIPAndPort_191.Execute(reqBodyJson);
                    break;
                case "GetGameTVIpConfig_191":
                    result = GetGameTVIpConfig_191.Execute(reqBodyJson);
                    break;
                default:
                    return "";
            }

            ServiceBuilder.GetInstance().LogRequestForDebug(serviceName, reqBodyJson, result);
            string res= JsonConvert.SerializeObject(result, Formatting.None);
            ///////////////
            res = aes.Encrypt(res);
            /////////////////////////////////////
            return res;
        }

        [Route("TestPCApi"), HttpGet]
        public string TestPCApi()
        {

            Stream req = Request.InputStream;
            req.Seek(0, SeekOrigin.Begin);
            string bodyJson = new StreamReader(req).ReadToEnd();

            if (bodyJson.Length > 0)
            {
                return JsonConvert.SerializeObject("hello!你传了 body:" + bodyJson);
            }
            else
            {
                return JsonConvert.SerializeObject("hello! 你没传 body");
            }

        }

        [Route("TestPCPost"), HttpPost]
        public string TestPCPost()
        {

            Stream req = Request.InputStream;
            req.Seek(0, SeekOrigin.Begin);
            string bodyJson = new StreamReader(req).ReadToEnd();

            if (bodyJson.Length > 0)
            {
                return JsonConvert.SerializeObject("hello!你传了 body:" + bodyJson);
            }
            else
            {
                return JsonConvert.SerializeObject("hello! 你没传 body");
            }

        }

        public ActionResult NewIndex()
        {
            return View();
        }

    }
}