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
    /// 消费记录
    /// </summary>
    [Table]
    public class VipUse : EntityBase
    {
        /// <summary>
        /// 源类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 源单据号
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 流水号
        /// </summary>
        [Field]
        public string OrderNo { get; set; }

        /// <summary>
        /// 城市编号
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 场馆
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 消费类别
        /// </summary>
        [Field]
        public string CostTypeId { get; set; }

        /// <summary>
        /// 总金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal TotalAmount { get; set; }

        /// <summary>
        /// 折扣
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Discount { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 支付密码
        /// </summary>
        [Field(isUpdate: false)]
        public string PayPassword { get; set; }

        /// <summary>
        /// 支付免密码额度
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int PayNoPwdAmount { get; set; }

        /// <summary>
        /// 支付方式
        /// </summary>
        [Field]
        public string PayOption { get; set; }

        /// <summary>
        /// 支付编号
        /// </summary>
        [Field]
        public string PayId { get; set; }

        /// <summary>
        /// 支付状态
        /// </summary>
        [Field]
        public string PayState { get; set; }

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
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 是否自己创建标志
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsOwnCreate { get; set; }

        /// <summary>
        /// 实际消费人
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 是否实时更新金额
        /// </summary>
        public bool IsLiveUpdate { get; set; }

        /// <summary>
        /// 创建日期1
        /// </summary>
        [Field(dataType: DataType.Date, onlyInsert: true)]
        public DateTime CreateDate1 { get; set; }

        /// <summary>
        /// 主体Name
        /// </summary>
        public string MasterName { get; set; }

    }
}
