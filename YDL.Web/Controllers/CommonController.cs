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
    public class CommonController : ControllerFree
    {
        [HttpPost]
        public JsonResult GetVenueListByCity(string cityId)
        {
            try
            {
                Request<GetVenueListFilter> req = new Request<GetVenueListFilter>();
                req.Filter = new GetVenueListFilter { Name = string.Empty, CityId = cityId, PageIndex = 1, PageSize = 1000 };
                req.Token = CurrentUser.Token;

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetVenueList, req);
                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult SelectUserIndex(bool isMulti = true)
        {
            try
            {
                ViewBag.IsMulti = isMulti;
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult SelectUserIndexData(string keywords, int pageIndex = 1)
        {
            try
            {
                Request<GetUserListFilter> request = new Request<GetUserListFilter>();
                request.Filter = new GetUserListFilter { Keywords = keywords, PageIndex = pageIndex, PageSize = ViewHelper.PageSize };
                request.Token = CurrentUser.Token;
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetUserList, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }


        [HttpPost]
        public ActionResult PagerButton(Pager pager)
        {
            try
            {
                return PartialView(pager);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        /// <summary>
        /// 移交设置
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult TransferSettings(Transfer o)
        {
            try
            {
                return View(o);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult TransferSettingsSave(Transfer transfer)
        {
            try
            {
                transfer.RowState = RowState.Added;
                Request<Transfer> request = new Request<Transfer>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<Transfer> { transfer };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveTransfer, request);
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