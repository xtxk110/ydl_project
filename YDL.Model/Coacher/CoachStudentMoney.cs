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
    /// 学员购买的次数--已支付表
    /// </summary>
    [Table]
    public class CoachStudentMoney : HeadBase
    {
        /// <summary>
        /// 学员Id
        /// </summary>
        [Field]
        public string StudentUserId { get; set; }
        /// <summary>
        /// 教练Id
        /// </summary>
        [Field]
        public string CoachId { get; set; }

        /// <summary>
        /// 剩余次数
        /// </summary>
        [Field]
        public int Amount { get; set; }


        /// <summary>
        /// 购买当时的总次数
        /// </summary>
        [Field]
        public int ThenTotalAmount { get; set; }


        /// <summary>
        /// 总的次数(计算出来的, 比如某个教练的总次数)
        /// </summary>
        [Field(IsUpdate = false)]
        public int TotalAmount { get; set; }


        /// <summary>
        /// 默认10课时起卖
        /// </summary>
        public int TotalCount { get { return CoachDic.CourseNum; } set { } }

        /// <summary>
        /// 当时的购买金额
        /// </summary>
        [Field]
        public decimal ThenMoney { get; set; }

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
        /// 截止时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime Deadline { get; set; }

        /// <summary>
        /// 教练等级
        /// </summary>
        [Field(IsUpdate =false)]
        public int CoachGrade { get; set; }


        /// <summary>
        /// 最后上课时间
        /// </summary>
        [Field(isUpdate: false)]
        public DateTime? LastCourseJoin { get; set; }


        /// <summary>
        /// 教练->我的学员列表界面->学员剩余次数字段
        /// </summary>
        [Field(isUpdate: false)]
        public int AmountSum { get; set; }


        /// <summary>
        /// 是否支付
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsPay { get; set; }

        /// <summary>
        /// 教练Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoachName { get; set; }

        /// <summary>
        /// 大课最小过期时间
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime BigCourseMinDeadline { get; set; }
        /// <summary>
        /// 大课最小过期时间--对应的剩余次数
        /// </summary>
        [Field(IsUpdate = false)]
        public int BigCourseMinDeadlineCount { get; set; }

        /// <summary>
        /// 价格(某个城市大课价格, 私教价格)
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal CoachPrice { get; set; }

        /// <summary>
        /// 城市Id
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 城市Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CityName { get; set; }

        /// <summary>
        /// 教练是否启用
        /// </summary>
        [Field(IsUpdate = false)]
        public bool CoachIsEnabled { get; set; }

        /// <summary>
        /// 公司电话
        /// </summary>
        public string CompanyPhone { get { return CoachDic.CompanyPhone; } }

        /// <summary>
        /// 集训Id
        /// </summary>
        [Field]
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 集训名称
        /// </summary>
        [Field(IsUpdate =false)]
        public string BootcampName { get; set; }
        /// <summary>
        /// 集训状态
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampState { get; set; }

        /// <summary>
        /// 集训截止时间
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime BootcampDeadline { get; set; }

        /// <summary>
        /// 集训id
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampId { get; set; }

        /// <summary>
        /// 教学点Id
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 教学点名称
        /// </summary>
        [Field(IsUpdate =false)]
        public string VenueName { get; set; }

        /// <summary>
        /// 学员姓名
        /// </summary>
        [Field(IsUpdate =false)]
        public string StudentName { get; set; }

        /// <summary>
        /// 学员电话
        /// </summary>
        [Field(IsUpdate = false)]
        public string StudentMobile { get; set; }

        /// <summary>
        /// 常用学员Id
        /// </summary>
        [Field]
        public string FrequentStudentId { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string StudentRemark { get; set; }
        
        /// <summary>
        /// 目标Code
        /// </summary>
        [Field]
        public string CourseGoalCode { get; set; }

        /// <summary>
        /// 大课Id
        /// </summary>
        [Field]
        public string BigCourseInfoId { get; set; }

        /// <summary>
        /// 课程名称Id
        /// </summary>
        [Field(IsUpdate =false)]
        public string CourseNameId { get; set; }

        /// <summary>
        /// 课程名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseName { get; set; }

        /// <summary>
        /// 教练的Code
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoachCode { get; set; }

        /// <summary>
        /// 大课的单价
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal BigCourseUnitPrice { get; set; }

        /// <summary>
        /// 教练的单价
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal CoachUnitPrice { get; set; }

        /// <summary>
        /// 课程目标Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseGoalName { get; set; }

        /// <summary>
        /// 大课名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string BigCourseName { get; set; }

        /// <summary>
        /// 已经上课列表
        /// </summary>
        public List<CoachCourse> HaveBeenCourseList;


    }
}