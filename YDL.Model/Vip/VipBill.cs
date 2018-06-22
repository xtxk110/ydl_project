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
    /// 结算单
    /// </summary>
    public class VipBill : EntityBase
    {
        /// <summary>
        /// 标题
        /// </summary>
        [Field]
        public string Title { get; set; }

        /// <summary>
        /// 机构编号
        /// </summary>
        [Field]
        public string CompanyId { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        [Field(dataType:DataType.DateTime)]
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 结束日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime EndDate { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 确认人帐号
        /// </summary>
        [Field]
        public string ConfirmerId { get; set; }

        /// <summary>
        /// 确认日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? ConfirmDate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 支付日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? PayDate { get; set; }

        /// <summary>
        /// 支付备注
        /// </summary>
        [Field]
        public string PayRemark { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }
    }
}
