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
    /// 教练请假
    /// </summary>
    [Table]
    public class CoachLeave : HeadBase
    {
        /// <summary>
        /// 教练Id
        /// </summary>
        [Field]
        public string CoachId { get; set; }

        /// <summary>
        /// 请假类型
        /// </summary>
        [Field]
        public string LeaveType { get; set; }

        /// <summary>
        /// 请假类型名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string LeaveTypeName { get; set; }

        /// <summary>
        /// 请求状态
        /// </summary>
        [Field]
        public string State { get; set; }
        /// <summary>
        /// 起始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 请假天数
        /// </summary>
        [Field]
        public decimal LeaveDays { get; set; }

        /// <summary>
        /// 请假事由
        /// </summary>
        [Field]
        public string LeaveReason { get; set; }

        /// <summary>
        /// 审核人id
        /// </summary>
        public string AuditPersonId { get; set; }

        /// <summary>
        /// 教练Code
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoachCode { get; set; }
        /// <summary>
        /// 教练Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoachName { get; set; }

        /// <summary>
        /// 教练请假待审核数
        /// </summary>
        [Field(IsUpdate = false)]
        public int AuditCount { get; set; }



    }
}
