using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取支付信息
    /// </summary>
    public class GetVipPayInfo : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipRelatedFilter>>(request);
            VipPayInfo obj = new VipPayInfo();
            Response rsp = new Response();
            if (req.Filter.BusinessType == MasterType.VENUE.Id)
            {
                rsp = GetVenuePayInfo(req, obj, currentUser);
            }
            else if (req.Filter.BusinessType == MasterType.STUDENTPAY.Id)
            {
                rsp = GetCoachPayInfo(req, obj, currentUser);
            }
            else if (req.Filter.BusinessType == MasterType.STUDENTPAYFORBOOTCAMP.Id)
            {
                rsp = GetBootcampPayInfo(req, obj, currentUser);
            }
            else if (req.Filter.BusinessType == MasterType.YUEDOUPAY.Id)
            {
                rsp = GetYueDouBuyPayInfo(req, obj, currentUser);
            }
           

            rsp.Entities = new List<EntityBase>();
            rsp.Entities.Add(obj);
            rsp.IsSuccess = true;
            return rsp;


        }
        public Response GetYueDouUsePayInfo(Request<GetVipRelatedFilter> req, VipPayInfo obj, User currentUser)
        {
            Response rsp = new Response();

            //获取我的余额
            var myBalance = VipHelper.GetVipAccount(currentUser.Id).FirstEntity<VipAccount>();
            if (myBalance != null)
            {
                obj.MyBalance = myBalance.Balance;
            }
            //折扣信息
            obj.Discount = 1;
            //支付状态
            if (req.Filter.PayType == "Use")
            {
                obj.PayState = GetVipUsePayState(req.Filter.PayId, req.Filter.PayType);
            }
            else
            {
                obj.PayState = GetVipBuyPayState(req.Filter.PayId, req.Filter.PayType);
            }
            //获取详细支付信息
            rsp = VipHelper.GetVipUseInfo(req.Filter.PayId, true);
            if (rsp.IsSuccess && rsp.Entities.Count > 0)
            {
                obj.VipUseInfo = rsp.FirstEntity<VipUse>();
            }
            //获取悦豆余额
            obj.YueDouBalance = PayHelper.Instance.GetYueDouBalance(currentUser.Id);
            //获取场馆的 头部信息(如名称,头像 等等)
            obj.VenuePayHeadInfo = VenueHelper.Instance.GetVenueById(req.Filter.MasterId);
            return rsp;
        }

        public Response GetYueDouBuyPayInfo(Request<GetVipRelatedFilter> req, VipPayInfo obj, User currentUser)
        {
            Response rsp = new Response();

            //获取我的余额
            var myBalance = VipHelper.GetVipAccount(currentUser.Id).FirstEntity<VipAccount>();
            if (myBalance != null)
            {
                obj.MyBalance = myBalance.Balance;
            }
            //折扣信息
            obj.Discount = 1;
            //支付状态
            if (req.Filter.PayType == "Use")
            {
                obj.PayState = GetVipUsePayState(req.Filter.PayId, req.Filter.PayType);
            }
            else
            {
                obj.PayState = GetVipBuyPayState(req.Filter.PayId, req.Filter.PayType);
            }
            //获取详细支付信息
            rsp = VipHelper.GetVipUseInfo(req.Filter.PayId, true);
            if (rsp.IsSuccess && rsp.Entities.Count > 0)
            {
                obj.VipUseInfo = rsp.FirstEntity<VipUse>();
            }

            return rsp;
        }
        public Response GetBootcampPayInfo(Request<GetVipRelatedFilter> req, VipPayInfo obj, User currentUser)
        {
            Response rsp = new Response();

            //获取我的余额
            var myBalance = VipHelper.GetVipAccount(currentUser.Id).FirstEntity<VipAccount>();
            if (myBalance != null)
            {
                obj.MyBalance = myBalance.Balance;
            }
            //折扣信息
            obj.Discount = 1;
            //支付状态
            if (req.Filter.PayType == "Use")
            {
                obj.PayState = GetVipUsePayState(req.Filter.PayId, req.Filter.PayType);
            }
            else
            {
                obj.PayState = GetVipBuyPayState(req.Filter.PayId, req.Filter.PayType);
            }
            //获取详细支付信息
            rsp = VipHelper.GetVipUseInfo(req.Filter.PayId, true);
            if (rsp.IsSuccess && rsp.Entities.Count > 0)
            {
                obj.VipUseInfo = rsp.FirstEntity<VipUse>();
            }
            //获取集训支付 头部信息(如集训名称,等等)
            obj.CoachBootcampHeadInfo = GetCoachBootcampHeadInfo(req.Filter.PayId);
            return rsp;
        }

        public CoachBootcamp GetCoachBootcampHeadInfo(string payId)
        {

            var sql = @"
SELECT 
	c.Name,
	c.BeginTime,
	c.EndTime
 FROM dbo.VipUse a
 INNER JOIN dbo.CoachStudentMoneyNotPay b ON a.MasterId = b.Id
 INNER JOIN dbo.CoachBootcamp c ON b.CoachBootcampId=c.Id
 WHERE a.Id=@Id

";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", payId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachBootcamp>();
        }

        public Response GetCoachPayInfo(Request<GetVipRelatedFilter> req, VipPayInfo obj, User currentUser)
        {
            Response rsp = new Response();

            //获取我的余额
            var myBalance = VipHelper.GetVipAccount(currentUser.Id).FirstEntity<VipAccount>();
            if (myBalance != null)
            {
                obj.MyBalance = myBalance.Balance;
            }
            //折扣信息
            obj.Discount = 1;
            //支付状态
            if (req.Filter.PayType == "Use")
            {
                obj.PayState = GetVipUsePayState(req.Filter.PayId, req.Filter.PayType);
            }
            else
            {
                obj.PayState = GetVipBuyPayState(req.Filter.PayId, req.Filter.PayType);
            }
            //获取详细支付信息
            rsp = VipHelper.GetVipUseInfo(req.Filter.PayId, true);
            if (rsp.IsSuccess && rsp.Entities.Count > 0)
            {
                obj.VipUseInfo = rsp.FirstEntity<VipUse>();
            }
            //获取教练支付 头部信息(如教练名称,等等)
            obj.CoachPayHeadInfo = GetCoachPayHeadInfo(req.Filter.PayId);
            return rsp;
        }

        public Response GetVenuePayInfo(Request<GetVipRelatedFilter> req, VipPayInfo obj, User currentUser)
        {
            Response rsp = new Response();
            //获取 Name, HeadUrl
            var sql = @"
SELECT HeadUrl,Name FROM dbo.Venue WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.MasterId);
            rsp = DbContext.GetInstance().Execute(cmd);
            if (rsp.Entities.Count > 0)
            {
                obj.HeadUrl = rsp.FirstEntity<Venue>().HeadUrl;
                obj.Name = rsp.FirstEntity<Venue>().Name;
            }
            //获取我的余额
            var myBalance = VipHelper.GetVipAccount(currentUser.Id).FirstEntity<VipAccount>();
            if (myBalance != null)
            {
                obj.MyBalance = myBalance.Balance;
            }
            //折扣信息
            obj.Discount = 1;
            //支付状态
            if (req.Filter.PayType == "Use")
            {
                obj.PayState = GetVipUsePayState(req.Filter.PayId, req.Filter.PayType);
            }
            else
            {
                obj.PayState = GetVipBuyPayState(req.Filter.PayId, req.Filter.PayType);
            }

            obj.VipRechargeScaleList = VipHelper.GetVipRechargeScaleList().Entities.ToList<EntityBase, VipRechargeScale>();
            obj.YueDouBalance = PayHelper.Instance.GetYueDouBalance(currentUser.Id);
            obj.ConvertibleProportion= UserHelper.GetConfig().YueDouConvertibleProportion;

            return rsp;
        }

        public string GetVipUsePayState(string Id, string payType)
        {

            var sql = @"
SELECT * FROM dbo.VipUse WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<VipUse>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return result.FirstEntity<VipUse>().PayState;
            }

            return "";
        }

        public string GetVipBuyPayState(string Id, string payType)
        {

            var sql = @"
SELECT * FROM dbo.VipBuy WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<VipBuy>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return result.FirstEntity<VipBuy>().PayState;
            }

            return "";
        }

        public CoachStudentMoney GetCoachPayHeadInfo(string payId)
        {

            var sql = @"
SELECT 
	b.CourseTypeId,
	b.CourseTypeName,
	b.Amount,
	c.HeadUrl,
	c.CardName AS CoachName,
	d.Name AS CityName,
    c.Sex
 FROM dbo.VipUse a
 INNER JOIN dbo.CoachStudentMoneyNotPay b ON a.MasterId = b.Id
 LEFT JOIN dbo.UserAccount c ON b.CoachId=c.Id
 LEFT JOIN dbo.City d ON b.CityId=d.Id
 WHERE a.Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", payId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }
    }
}
