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
    /// 教练价格表
    /// </summary>
    [Table]
    public class CoacherPrice : EntityBase
    {
        /// <summary>
        /// 教练等级Id
        /// </summary>
        [Field]
        public int GradeId { get; set; }
        /// <summary>
        /// 教练等级Name
        /// </summary>
        [Field]
        public string GradeName { get; set; }
        /// <summary>
        /// 课程类型Id
        /// </summary>
        [Field]
        public string CourseTypeId { get; set; }
        /// <summary>
        /// 课程类型Name
        /// </summary>
        [Field]
        public string CourseTypeName { get; set; }

        /// <summary>
        /// 课程金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal CoursePrice { get; set; }

        /// <summary>
        /// 课程数量  
        /// </summary>
        public int CourseNum { get { return CoachDic.CourseNum; } set { } }

        /// <summary>
        /// 课程有效期至
        /// </summary>
        public DateTime? Deadline { get; set; }
    }
}