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
    /// 充值配送比率
    /// </summary>
    [Table]
    public class VipRechargeScale : EntityBase
    {
        /// <summary>
        /// 最小金额
        /// </summary>
        [Field(dataType:DataType.Int32)]
        public int Min { get; set; }

        /// <summary>
        /// 最大金额
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Max { get; set; }

        /// <summary>
        /// 配送比例
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Scale { get; set; }

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
