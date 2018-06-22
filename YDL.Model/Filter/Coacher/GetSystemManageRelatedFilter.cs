using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{


    /// <summary>
    /// 系统管理相关Filter
    /// </summary>
    public class GetSystemManageRelatedFilter : FilterBase
    {
        public GetSystemManageRelatedFilter()
        {

        }
        /// <summary>
        /// 当前登陆者Id
        /// </summary>
        public string CurrentUserId { get; set; }
        /// <summary>
        /// 教练Id
        /// </summary>
        public string CoachId { get; set; }
        /// <summary>
        /// 机构名称
        /// </summary>
        public string OrganizationName { get; set; }
        /// <summary>
        /// 机构Id
        /// </summary>
        public string OrganizationId { get; set; }


        /// <summary>
        /// 场馆名称
        /// </summary>
        public string VenueName { get; set; }

        /// <summary>
        /// 教练收入开始时间
        /// </summary>
        public DateTime CoachIncomeBeginTime { get; set; }

        /// <summary>
        /// 教练收入结束时间
        /// </summary>
        public DateTime CoachIncomeEndTime { get; set; }

        /// <summary>
        /// 教练状态
        /// </summary>
        public string CoachState { get; set; }

        /// <summary>
        ///是否联系
        /// </summary>
        public bool IsContact { get; set; }
        /// <summary>
        /// 学员Id
        /// </summary>
        public string StudentId { get; set; }

        /// <summary>
        /// 是否只出教学点
        /// </summary>
        public bool IsOnlyTeachingPoint { get; set; }

        /// <summary>
        /// 集训Id
        /// </summary>
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 集训的课程开始时间
        /// </summary>
        public DateTime BootcampCourseBeginTime { get; set; }

        /// <summary>
        /// 集训的课程结束时间
        /// </summary>
        public DateTime BootcampCourseEndTime { get; set; }

        /// <summary>
        /// 是否用于课程表
        /// </summary>
        public bool IsForSyllabus { get; set; }

        /// <summary>
        /// 集训课程Id
        /// </summary>
        public string CoachBootcampCourseId { get; set; }
        /// <summary>
        /// 大课信息Id
        /// </summary>
        public string BigCourseInfoId { get; set; }
        /// <summary>
        /// 技术类别名称
        /// </summary>
        public string TeachTypeName { get; set; }

        /// <summary>
        /// 教练价格Id
        /// </summary>
        public string CoachPriceId { get; set; }

        /// <summary>
        /// 城市Id
        /// </summary>
        public string CityId { get; set; }
    }
}
