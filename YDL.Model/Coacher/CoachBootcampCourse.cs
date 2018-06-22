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
    /// 集训的课程
    /// </summary>
    [Table]
    public class CoachBootcampCourse : EntityBase
    {
        /// <summary>
        /// 集训Id
        /// </summary>
        [Field]
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 课程开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 课程结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 课程内容
        /// </summary>
        [Field]
        public string CourseContent { get; set; }

        /// <summary>
        /// 学员或教练在课程详情里面是否有课
        /// </summary>
        [Field(IsUpdate = false)]
        public bool IsHaveCourse { get; set; }

        /// <summary>
        ///课程和学员教练相关的各种状态
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// 预约的人数
        /// </summary>
        [Field(IsUpdate = false)]
        public int AppointmentCount { get; set; }

        /// <summary>
        /// 课程时间
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseTime { get; set; }

        /// <summary>
        /// 场地地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }
        /// <summary>
        /// 集训课名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampName { get; set; }

        /// <summary>
        /// 有课日期
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime HaveCourseDate { get; set; }

        /// <summary>
        /// 封闭机构Id
        /// </summary>
        [Field]
        public string SealedOrganizationId { get; set; }

    }
}