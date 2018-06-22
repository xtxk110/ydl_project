using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取教练相关数据的Filter
    /// </summary>
    public class GetCoachRelatedFilter : FilterBase
    {
        public GetCoachRelatedFilter()
        {
            VenueIdList = new List<string>();
            StudentIdList = new List<string>();
        }
        /// <summary>
        /// 教练名
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 教练Id
        /// </summary>
        public string CoachId { get; set; }

        /// <summary>
        /// 学员Id
        /// </summary>
        public string StudentId { get; set; }

        /// <summary>
        /// 教练等级Id
        /// </summary>
        public string GradeId { get; set; }

        /// <summary>
        /// 课程开始时间
        /// </summary>
        public DateTime BeginTime { get; set; }

        /// <summary>
        /// 课程结束时间
        /// </summary>
        public DateTime EndTime { get; set; }

        /// <summary>
        /// 排序字段
        /// </summary>
        public string OrderColumn { get; set; }

        /// <summary>
        /// 排序类型
        /// </summary>
        public string OrderType { get; set; }

        /// <summary>
        /// 城市Id
        /// </summary>
        public string CityId { get; set; }

        /// <summary>
        /// 当前用户位置经度
        /// </summary>
        public double CurUserLng { get; set; }

        /// <summary>
        /// 当前用户位置纬度
        /// </summary>
        public double CurUserLat { get; set; }

        /// <summary>
        /// 课程Id
        /// </summary>
        public string CourseId { get; set; }

        /// <summary>
        /// 课程查询时间
        /// </summary>
        public DateTime CourseTime { get; set; }

        /// <summary>
        /// 获取教练课程列表->筛选场地列表  
        /// </summary>
        public List<string> VenueIdList { get; set; }

        /// <summary>
        /// 获取教练课程列表->筛选学员列表   
        /// </summary>
        public List<string> StudentIdList { get; set; }

        /// <summary>
        /// 学员姓名
        /// </summary>
        public string StudentName { get; set; }

        /// <summary>
        /// 场馆Id
        /// </summary>
        public string VenueId { get; set; }

        /// <summary>
        /// 课程类型Id
        /// </summary>
        public string CourseTypeId { get; set; }

        /// <summary>
        /// 教练和当前用户的距离(单位米)
        /// </summary>
        public int Distance { get; set; }

       
        /// <summary>
        /// 课程表时间
        /// </summary>
        public DateTime SyllabusTime { get; set; }
        /// <summary>
        /// 课程名称Id
        /// </summary>
        public string CourseNameId { get; set; }

        /// <summary>
        /// 大课Id
        /// </summary>
        public string BigCourseInfoId { get; set; }

        /// <summary>
        /// 教练请假Id
        /// </summary>
        public string CoachLeaveId { get; set; }

        /// <summary>
        /// 教练请假状态
        /// </summary>
        public string CoachLeaveState { get; set; }

        /// <summary>
        /// 集训班id
        /// </summary>
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 封闭机构id
        /// </summary>
        public string SealedOrganizationId { get; set; }

        /// <summary>
        /// 机构名称
        /// </summary>
        public string OrganizationName { get; set; }

        /// <summary>
        /// 集训名称
        /// </summary>
        public string BootcampName { get; set; }

        /// <summary>
        /// 封闭机构管理员Id
        /// </summary>
        public string SealedOrganizationManagerId { get; set; }

        /// <summary>
        /// 集训课程模板Id
        /// </summary>
        public string BootcampCourseTemplateId { get; set; }

        /// <summary>
        /// 余额表Id
        /// </summary>
        public string CoachStudentMoneyId { get; set; }

    }

}
