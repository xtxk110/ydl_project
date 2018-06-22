using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 保存学员购买的课时
    /// </summary>
    public class SaveCoachStudentMoney_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachStudentMoneyNotPay>>(request);
            var obj = req.FirstEntity();
            if (string.IsNullOrEmpty(obj.CityId))
            {
                obj.CityId = "75";
            }
            if (CoachHelper.Instance.IsCoach(currentUser.Id))
            {
                return ResultHelper.Fail("对不起, 你是教练, 不能购买其他教练的课程");
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {

                string FrequentStudentId = SaveFrequentStudent(obj, currentUser.Id);  //保存联系人到我的常用学员里面
                obj.FrequentStudentId = FrequentStudentId;
                obj.CourseTypeName = CoachDic.CoacherCourse[obj.CourseTypeId];
                obj.ThenTotalAmount = obj.Amount;
                obj.Deadline = CoachHelper.GetDeadline(obj.CourseTypeId, obj.ThenTotalAmount / 10);
                obj.IsPay = false;
                obj.CoachBootcampId = "";
                obj.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess)
            {

                //生成 待支付订单
                result = SaveWaitPay(obj, currentUser);

            }

            return result;

        }


        public string SaveFrequentStudent(CoachStudentMoneyNotPay moneyObj, string currentUserId)
        {
            //先查询此联系人是否存在
            var objFrequentStudent = CoachHelper.Instance.GetFrequentStudent(currentUserId, moneyObj.StudentMobile, "");
            string FrequentStudentId;
            if (objFrequentStudent == null)
            {
                //不存在才添加此常用学员
                CoachFrequentStudent obj = new CoachFrequentStudent();
                obj.Name = moneyObj.StudentName;
                obj.Mobile = moneyObj.StudentMobile;
                obj.CreatorId = currentUserId;
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(obj);
                obj.RowState = RowState.Added;
                obj.TrySetNewEntity();
                FrequentStudentId = obj.Id;
                var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
                if (result.IsSuccess == false)
                {
                    throw new Exception("保存常用学员失败");
                }
            }
            else
            {
                FrequentStudentId = objFrequentStudent.Id;
            }

            return FrequentStudentId;

        }


        public Response SaveWaitPay(CoachStudentMoneyNotPay obj, User currentUser)
        {
            Response rsp = new Response();
            //生成 待支付订单
            var vipUse = new VipUse();
            vipUse.Id = Ext.NewId();
            vipUse.MasterType = MasterType.STUDENTPAY.Id;
            vipUse.MasterId = obj.Id;
            vipUse.CityId = obj.CityId;
            vipUse.VenueId = "";
            vipUse.CostTypeId = CostType.COACHCOST.Id;

            vipUse.TotalAmount = obj.ThenMoney;
            vipUse.Discount = 1;
            vipUse.Amount = obj.ThenMoney * vipUse.Discount;
            vipUse.PayState = PayState.PAY.Id;//待支付
            vipUse.IsOwnCreate = true;
            if (obj.CourseTypeId == CoachDic.BigCourse)
            {
                vipUse.Remark = "购买大课" + obj.Amount + "课时";
            }
            else if (obj.CourseTypeId == CoachDic.PrivateCourse)
            {
                vipUse.Remark = "购买私教" + obj.Amount + "课时";
            }

            vipUse.UserId = currentUser.Id;
            vipUse.CreatorId = currentUser.Id;
            vipUse.CreateDate = DateTime.Now;
            rsp.Tag = VipHelper.SaveVipUse(vipUse);
            rsp.IsSuccess = true;

            return rsp;
        }


    }
}
