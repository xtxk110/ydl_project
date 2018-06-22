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
    /// 机构
    /// </summary>
    [Table]
    public class CoachOrganization : HeadBase
    {
        /// <summary>
        /// 机构名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 机构地址
        /// </summary>
        [Field]
        public string Address { get; set; }
        /// <summary>
        /// 分成比例
        /// </summary>
        [Field]
        public decimal CommissionPercentage { get; set; }

        /// <summary>
        /// 管理员Id
        /// </summary>
        [Field]
        public string ManagerId { get; set; }

        /// <summary>
        /// 管理员Name
        /// </summary>
        [Field(IsUpdate =false)]
        public string ManagerName { get; set; }

        /// <summary>
        /// 机构类型
        /// </summary>
        [Field]
        public string OrgType { get; set; }

        /// <summary>
        /// 机构教练人数
        /// </summary>
        [Field(IsUpdate = false)]
        public int CoachCount { get; set; }

        /// <summary>
        /// 机构课程数
        /// </summary>
        [Field(IsUpdate = false)]
        public int CourseCount { get; set; }

        /// <summary>
        /// 机构学员数
        /// </summary>
        [Field(IsUpdate = false)]
        public int StudentCount { get; set; }


    }
}