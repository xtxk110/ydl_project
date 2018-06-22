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
    /// 场馆折扣
    /// </summary>
    [Table]
    public class VenueDiscount : EntityBase
    {
        /// <summary>
        /// 场馆编号
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 费用类型
        /// </summary>
        [Field]
        public string CostTypeId { get; set; }

        /// <summary>
        /// 折扣
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Discount { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 结束日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime EndDate { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field(onlyInsert: true)]
        public string CreatorId { get; set; }


        /// <summary>
        /// 客户端条件辅助字段
        /// </summary>
        public DateTime? Today { get; set; }
    }
}
