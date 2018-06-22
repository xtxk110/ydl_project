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
    public class CoachPrice : EntityBase
    {
        public CoachPrice()
        {
            BigCourseInfoList = new List<CoachBigCourseInfo>();
        }
        /// <summary>
        /// 大课
        /// </summary>
        [Field]
        public decimal BigCourse { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityCode { get; set; }
        /// <summary>
        /// 城市名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CityName { get; set; }

        /// <summary>
        /// A级教练价格
        /// </summary>
        [Field]
        public decimal AGrade { get; set; }

        /// <summary>
        /// B级教练价格
        /// </summary>
        [Field]
        public decimal BGrade { get; set; }

        /// <summary>
        /// C级教练价格
        /// </summary>
        [Field]
        public decimal CGrade { get; set; }

        /// <summary>
        /// 是否启用
        /// </summary>
        [Field]
        public bool IsEnabled { get; set; }

        /// <summary>
        /// 大课有效期(单位是月份, 3 表示三个月)
        /// </summary>
        public int BigCourseValidDate { get; set; }

        /// <summary>
        /// 大课信息列表
        /// </summary>
        public List<CoachBigCourseInfo> BigCourseInfoList { get; set; }


    }
}