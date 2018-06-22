using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 支付信息
    /// </summary>
    [Table]
    public class VipPayInfo : EntityBase
    {
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 头像
        /// </summary>
        public string HeadUrl { get; set; }
        /// <summary>
        /// 我的余额
        /// </summary>
        public decimal MyBalance { get; set; }
        /// <summary>
        /// 折扣
        /// </summary>
        public decimal Discount { get; set; }
        /// <summary>
        /// 支付状态
        /// </summary>
        public string PayState { get; set; }

        /// <summary>
        /// 充值赠送比例
        /// </summary>
        public List<VipRechargeScale> VipRechargeScaleList { get; set; }

        /// <summary>
        /// 消费支付详细信息
        /// </summary>
        public VipUse VipUseInfo { get; set; }

        /// <summary>
        /// 教练模块支付头部信息
        /// </summary>
        public CoachStudentMoney CoachPayHeadInfo { get; set; }

        /// <summary>
        ///集训支付头部信息
        /// </summary>
        public CoachBootcamp CoachBootcampHeadInfo { get; set; }

        /// <summary>
        /// 悦豆余额
        /// </summary>
        public int YueDouBalance { get; set; }


        /// <summary>
        /// 场馆支付头像信息
        /// </summary>
        public Venue VenuePayHeadInfo { get; set; }

        /// <summary>
        /// 场馆Id
        /// </summary>
        public string VenueId { get; set; }

        /// <summary>
        /// 支付的悦豆
        /// </summary>
        public int YueDouAmount { get; set; }

        /// <summary>
        /// 当前登陆者Id
        /// </summary>
        public string CurrentUserId { get; set; }


        /// <summary>
        /// 悦豆兑换比例
        /// </summary>
        public int ConvertibleProportion { get; set; }

    }
}
