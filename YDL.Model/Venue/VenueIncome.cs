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
    /// 场馆收入
    /// </summary>
    [Table]
    public class VenueIncome : EntityBase
    {

        //(计算字段, 方便前端绑定)
        [Field(IsUpdate = false)]
        public string CourseTypeName { get; set; }


        /// <summary>
        ///实际收入(计算字段,方便前端绑定)
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal RealIncome { get; set; }

        /// <summary>
        /// 合计收入
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal TotalIncome { get; set; }
    }
}