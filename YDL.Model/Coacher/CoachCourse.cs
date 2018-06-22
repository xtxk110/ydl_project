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
    /// 教练课程表
    /// </summary>
    [Table]
    public class CoachCourse : HeadBase
    {
        public CoachCourse()
        {
            StudentList = new List<CoachStudent>();
            CoursePersonInfoList = new List<CoachCoursePersonInfo>();
        }

        /// <summary>
        /// 教练Id 
        /// </summary>
        [Field]
        public string CoachId { get; set; }


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
        /// 课程类型
        /// </summary>
        [Field]
        public string Type { get; set; }

        /// <summary>
        /// 场地Id
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 场地地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }

        /// <summary>
        /// 场地名称
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueName { get; set; }

        /// <summary>
        /// 课程类型名称
        /// </summary>
        [Field(isUpdate: false)]
        public string TypeName { get; set; }

        /// <summary>
        /// 课程空位数
        /// </summary>
        [Field(isUpdate: false)]
        public int EmptyPosition { get; set; }

        /// <summary>
        /// 课程已报名数
        /// </summary>
        [Field(isUpdate: false)]
        public int FillPosition { get; set; }

        /// <summary>
        /// 课程最大可报名人数
        /// </summary>
        public int CourseMaxPosition { get; set; }

        /// <summary>
        /// 课程报名学员列表
        /// </summary>
        public List<CoachStudent> StudentList { get; set; }

        /// <summary>
        /// 学员是否评论此课程
        /// </summary>
        [Field(isUpdate: false)]
        public int IsComment { get; set; }

        /// <summary>
        /// 学员是否报名此课程
        /// </summary>
        [Field(isUpdate: false)]
        public int IsJoined { get; set; }

        /// <summary>
        /// 教练姓名
        /// </summary>
        [Field(isUpdate: false)]
        public string CoachName { get; set; }

        /// <summary>
        /// 课程Id
        /// </summary>
        [Field(isUpdate: false)]
        public string CourseId { get; set; }

        /// <summary>
        /// 课程状态(用于学员,计算字段)
        /// </summary>
        public string CourseState { get; set; }

        /// <summary>
        /// 教练性别
        /// </summary>
        [Field(isUpdate: false)]
        public string CoacherSex { get; set; }

        /// <summary>
        /// 教练头像
        /// </summary>
        [Field(isUpdate: false)]
        public string CoacherHeadUrl { get; set; }


        /// <summary>
        ///学员Id
        /// </summary>
        [Field(isUpdate: false)]
        public string StudentUserId { get; set; }

        /// <summary>
        /// 学员Name
        /// </summary>
        [Field(isUpdate: false)]
        public string StudentName { get; set; }

        /// <summary>
        /// 是否分享此课程
        /// </summary>
        public bool IsShare { get; set; }

        /// <summary>
        /// 课程是否上完
        /// </summary>
        public bool IsFinished { get; set; }

        /// <summary>
        /// 学员Id 
        /// </summary>
        [Field(IsUpdate = false)]
        public string StudentId { get; set; }

        /// <summary>
        /// 课程等级 
        /// </summary>
        [Field]
        public int CourseGrade { get; set; }

        /// <summary>
        /// 课程等级 Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseGradeName { get; set; }

        /// <summary>
        /// 课程状态(原始数据库字段) 
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 课程内容 
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseContent { get; set; }
        /// <summary>
        /// 课程技术类别Id
        /// </summary>
        [Field(IsUpdate = false)]
        public string CategoryOfTechnologyId { get; set; }

        /// <summary>
        /// 课程技术类别Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CategoryOfTechnologyName { get; set; }

        /// <summary>
        /// 课程总结
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseSummary { get; set; }

        /// <summary>
        /// 教练分成比例
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal CoachCommissionPercentage { get; set; }

        /// <summary>
        /// 教练等级
        /// </summary>
        [Field(IsUpdate = false)]
        public int CoachGrade { get; set; }

        /// <summary>
        /// 城市Id
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 此节课的学生数量
        /// </summary>
        public int StudentNumber { get; set; }

        /// <summary>
        /// 学员评语
        /// </summary>
        [Field(IsUpdate = false)]
        public string StudentRemark { get; set; }

        /// <summary>
        /// 是否为当前场馆的课程管理员
        /// </summary>
        public bool IsCurrentCourseManager { get; set; }
        /// <summary>
        /// 机构分成比例
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal OrganizationCommissionPercentage { get; set; }

        /// <summary>
        /// 课程点评列表
        /// </summary>
        public List<CoachStudentRemark> CoachStudentRemarkList { get; set; }

        /// <summary>
        /// 城市Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CityName { get; set; }

        /// <summary>
        /// 集训课程Id
        /// </summary>
        [Field]
        public string CoachBootcampCourseId { get; set; }

        /// <summary>
        /// 课程详细能否编辑
        /// </summary>
        public bool CoachBootcampCourseDetailCanEdit { get; set; }


        /// <summary>
        /// 课程创建者Id
        /// </summary>
        [Field]
        public string CreatorId { get; set; }


        /// <summary>
        /// 集训Id
        /// </summary>
        [Field]
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 个人信息列表
        /// </summary>
        public List<CoachCoursePersonInfo> CoursePersonInfoList { get; set; }

        /// <summary>
        /// 预设的场馆( 获取的是附近第一个场馆(开了定位)或者列表第一个(没开定位))
        /// </summary>
        public Venue Venue;

        /// <summary>
        /// 课时列表
        /// </summary>
        public List<SysDic> CourseCountList { get; set; }

        /// <summary>
        /// 大课的Id
        /// </summary>
        [Field]
        public string BigCourseId { get; set; }

        /// <summary>
        /// 约课人Id
        /// </summary>
        [Field]
        public string ReservedPersonId { get; set; }

        /// <summary>
        /// 学员电话
        /// </summary>
        public string StudentMobile { get; set; }

        /// <summary>
        /// 课程名称Id(这个字段有点奇葩, 有时候他是教练Id, 有时候他是大课种类Id, 莫法 产品设计sb)
        /// </summary>
        [Field]
        public string CourseNameId { get; set; }


        /// <summary>
        /// 课程评分(取的是多个学员的平均值)
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal Score { get; set; }

        /// <summary>
        /// 课程目标Code
        /// </summary>
        [Field]
        public string CourseGoalCode { get; set; }

        /// <summary>
        /// 课程目标Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseGoalName { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }


        /// <summary>
        /// 课程名称Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseName { get; set; }
        /// <summary>
        /// 大课名称Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string BigCourseName { get; set; }

        /// <summary>
        /// 上课打卡地址
        /// </summary>
        [Field]
        public string StartCardAddress { get; set; }

        /// <summary>
        /// 下课打卡地址
        /// </summary>
        [Field]
        public string EndCardAddress { get; set; }

        /// <summary>
        /// 上课打卡时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? StartCardTime { get; set; }


        /// <summary>
        /// 下课打卡时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndCardTime { get; set; }


        /// <summary>
        /// 是否上课打卡
        /// </summary>
        public bool IsStartCard { get; set; }
        /// <summary>
        /// 是否下课打卡
        /// </summary>
        public bool IsEndCard { get; set; }

        
        /// <summary>
        /// 剩余次数
        /// </summary>
        public int Amount { get; set; }

        /// <summary>
        /// 教练单价
        /// </summary>
        public decimal CoachUnitPrice { get; set; }

        /// <summary>
        /// 大课单价
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal BigCourseUnitPrice { get; set; }


        /// <summary>
        /// 教练编码
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoachCode { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(IsUpdate = false)]
        public double VenueLng { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(IsUpdate = false)]
        public double VenueLat { get; set; }

        /// <summary>
        /// 大课 课程内容详情
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseContentDetail { get; set; }

        /// <summary>
        /// 大课 课程内容详情
        /// </summary>
        public string CourseContentDetails { get { return CoachDic.CourseContent; } set { CoachDic.CourseContent = value; } }

        /// <summary>
        /// 集训课名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampName { get; set; }

        /// <summary>
        /// 集训课程模板Id
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampCourseTemplateId { get; set; }


        /// <summary>
        ///我的课程评分
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal MyScore { get; set; }
        

    }
}