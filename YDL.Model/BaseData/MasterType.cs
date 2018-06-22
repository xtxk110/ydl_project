using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public static class MasterType
    {
        public static readonly BaseData USER = new BaseData { Id = "016000", Name = "用户" };
        public static readonly BaseData ACTIVITY = new BaseData { Id = "016001", Name = "活动" };
        public static readonly BaseData CLUB = new BaseData { Id = "016002", Name = "俱乐部" };
        public static readonly BaseData VENUE = new BaseData { Id = "016003", Name = "场馆" };
        public static readonly BaseData GAME = new BaseData { Id = "016004", Name = "赛事" };
        public static readonly BaseData NOTE = new BaseData { Id = "016005", Name = "笔记" };
        public static readonly BaseData REFUND = new BaseData { Id = "016006", Name = "退款" };
        public static readonly BaseData VIP_USE = new BaseData { Id = "016007", Name = "消费" };
        public static readonly BaseData COMPANY = new BaseData { Id = "016008", Name = "管理机构" };

        public static readonly BaseData COACH = new BaseData { Id = "016009", Name = "教练" };
        public static readonly BaseData COACHMSG = new BaseData { Id = "016009001", Name = "教练邀请消息" };

        public static readonly BaseData STUDENT = new BaseData { Id = "016010", Name = "学员" };
        public static readonly BaseData STUDENTPAY = new BaseData { Id = "016010001", Name = "学员购买教练支付" };
        public static readonly BaseData STUDENTBOOK = new BaseData { Id = "016010002", Name = "学员课程预约" };
        public static readonly BaseData STUDENTPTPAY = new BaseData { Id = "016010003", Name = "学员私教支付" };
        public static readonly BaseData STUDENTPTBOOK = new BaseData { Id = "016010004", Name = "学员私教预约" };
        public static readonly BaseData STUDENTPAYFORBOOTCAMP = new BaseData { Id = "016010005", Name = "学员购买集训支付" };
        public static readonly BaseData VIP_RECHARGE = new BaseData { Id = "016011", Name = "充值" };
        public static readonly BaseData COURSE = new BaseData { Id = "016012", Name = "课程" };
        public static readonly BaseData SYSTEM = new BaseData { Id = "016099", Name = "系统" };

        public static readonly BaseData YUEDOUPAY = new BaseData { Id = "016020001", Name = "购买悦豆支付" };
        public static readonly BaseData YUEDOUUSE = new BaseData { Id = "016020002", Name = "悦豆消费" };



        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { ACTIVITY, CLUB, VENUE, GAME, SYSTEM };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }

        public static BaseData find(String id)
        {
            List<BaseData> result = GetItems(false);
            foreach (BaseData obj in result)
            {
                if (obj.Id == id)
                {
                    return obj;
                }
            }
            return null;
        }
    }

}
