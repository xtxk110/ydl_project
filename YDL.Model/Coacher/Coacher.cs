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
    /// 教练
    /// </summary>
    [Table]
    public class Coacher : HeadBase
    {
        /// <summary>
        /// userId
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 教练状态Id
        /// </summary>
        [Field]
        public string State { get; set; }
        /// <summary>
        /// 教练状态Name
        /// </summary>
        [Field(isUpdate: false)]
        public string StateName { get; set; }

        /// <summary>
        /// 教龄
        /// </summary>
        [Field]
        public int CoachAge { get; set; }

        /// <summary>
        /// 等级
        /// </summary>
        [Field]
        public int Grade { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        [Field(isUpdate: false)]
        public string Name { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 资质证明
        /// </summary>
        [Field]
        public string Qualification { get; set; }

        /// <summary>
        /// 审核意见
        /// </summary>
        [Field]
        public string AuditOpinion { get; set; }

        /// <summary>
        /// 场馆Id
        /// </summary>
        [Field]
        public string VenueId { get; set; }
        /// <summary>
        /// 场馆名称
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueName { get; set; }

        /// <summary>
        /// 常驻地址审核状态
        /// </summary>
        [Field(isUpdate: false)]
        public int ResidentAddressAuditState { get; set; }

        /// <summary>
        /// 联系电话
        /// </summary>
        [Field(isUpdate: false)]
        public string Mobile { get; set; }

        /// <summary>
        /// 教练评分
        /// </summary>
        [Field(isUpdate: false)]
        public decimal Score { get { return scoreValue; } set { scoreValue = Helper.GetRoundOffByIEEE(value, 1); } }
        public decimal scoreValue;

        /// <summary>
        /// 场地 地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }

        /// <summary>
        /// 场地 经度
        /// </summary>
        [Field(isUpdate: false)]
        public double VenueLng { get; set; }

        /// <summary>
        /// 场地 纬度
        /// </summary>
        [Field(isUpdate: false)]
        public double VenueLat { get; set; }

        /// <summary>
        /// 身份证正面
        /// </summary>
        [Field]
        public string IdCardFrontUrl { get; set; }

        /// <summary>
        /// 身份证后面
        /// </summary>
        [Field]
        public string IdCardBackUrl { get; set; }

        /// <summary>
        /// 身份证号码
        /// </summary>
        [Field(isUpdate: false)]
        public string CardId { get; set; }


        /// <summary>
        /// 和教练(场地)的距离
        /// </summary>
        [Field(isUpdate: false)]
        public double Distance { get; set; }

        /// <summary>
        /// 教练联系电话(用公司的)
        /// </summary>
        [Field(isUpdate: false)]
        public string CompanyPhone { get; set; }

        /// <summary>
        /// 教练场地签退时间
        /// </summary>
        [Field(isUpdate: false)]
        public DateTime? SignOutTime { get; set; }
    }
}
