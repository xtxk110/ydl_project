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
    /// 内部信息表
    /// </summary>
    [Table]
    public class InnerInfo : EntityBase
    {
        /// <summary>
        /// 公司名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 公司介绍
        /// </summary>
        [Field]
        public string Content { get; set; }

        /// <summary>
        /// 支付宝Id
        /// </summary>
        [Field]
        public string AliPayId { get; set; }

        /// <summary>
        /// 公司地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>

        [Field(dataType: DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }
    }
}
