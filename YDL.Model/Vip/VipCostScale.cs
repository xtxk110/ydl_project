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
    /// 费用结算分配比例
    /// </summary>
    [Table]
    public class VipCostScale : EntityBase
    {
        /// <summary>
        /// 机构编号
        /// </summary>
        [Field]
        public string CompanyId { get; set; }

        /// <summary>
        /// 费用类型
        /// </summary>
        [Field]
        public string CostTypeId { get; set; }

        /// <summary>
        /// 城市编号
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// YDL比例
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal YdlScale { get; set; }

        // <summary>
        /// 机构比例
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal CompanyScale { get; set; }

        // <summary>
        /// 场馆比例
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal VenueScale { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        ///<summary>
        /// 最后更新时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime LastDate { get; set; }
    }
}
