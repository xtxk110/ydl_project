using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 教练模块的 字典数据
    /// </summary>
    public class CoachDic
    {
        public static string BigCourse = "027001";
        public static string SmallCourse = "027002";
        public static string PrivateCourse = "027003";
        public static string ExperienceCourse = "027004";
        public static string BootcampCourse = "027005";

        /// <summary>
        /// 默认10课时
        /// </summary>
        public static int CourseNum { get { return 10; } set { } }
        /// <summary>
        /// 公司联系电话
        /// </summary>
        public static string CompanyPhone { get { return "02885144497"; } set { } }
        /// <summary>
        /// 大课最大人数
        /// </summary>
        public static int BigCourseMaxPerson = 4;

        #region 课程状态

        /// <summary>
        /// 课程可以报名
        /// </summary>
        public static string CourseJoin = "Join";
        /// <summary>
        /// 课程开始
        /// </summary>
        public static string CourseStart = "Start";
        /// <summary>
        /// 课程未开始
        /// </summary>
        public static string CourseNotStart = "NotStart";
        /// <summary>
        /// 课程进行中
        /// </summary>
        public static string CourseProcessing = "Processing";
        /// <summary>
        /// 课程已完成
        /// </summary>
        public static string CourseFinished = "Finished";

        #endregion

        #region 集训状态

        /// <summary>
        /// 集训未发布
        /// </summary>
        public static string BootcampUnpublish = "Unpublish";
        /// <summary>
        /// 集训报名中
        /// </summary>
        public static string BootcampJoin = "Join";
        /// <summary>
        /// 集训结束
        /// </summary>
        public static string BootcampFinished = "Finished";
        /// <summary>
        /// 学员已报名
        /// </summary>
        public static string BootcampJoined = "Joined";


        #endregion

        /// <summary>
        /// 获取大课等级Name
        /// </summary>
        /// <param name="CourseGrade"></param>
        /// <returns></returns>
        public static string GetCourseGradeName(int CourseGrade)
        {
            if (CourseGrade == 1)
            {
                return "初级";
            }
            else if (CourseGrade == 2)
            {
                return "中级";
            }
            else
            {
                return "初级";
            }
        }

        /// <summary>
        /// 课程类型字典
        /// </summary>
        public static Dictionary<string, string> CoacherCourse = new Dictionary<string, string>()
        {
            { "027001","大课"},
            { "027002","小课"},
            { "027003","私教课"},
            { "027004","体验课"},
            { "027005","集训课"},
        };

        /// <summary>
        /// 课程类型字典
        /// </summary>
        public static Dictionary<string, string> CoacherGrade = new Dictionary<string, string>()
        {
            { "1","初级"},
            { "2","中级"},
            { "3","高级"},
            { "4","有效期"},
        };

        public static string YDLCoachOrgId = "ydl"; // 这个ydl 与数据库预制的 ydl 机构Id 相等, 不要修改

        public static string CourseContent = @"专项理论知识：包括乒乓球介绍、特点、技术和竞赛规则
实践部分：包括熟悉球性、乒乓球技巧、实战训练、教学比赛
身体素质练习";

        public const string DefaultCityId = "75";

        #region 机构或者教练类型
        /// <summary>
        /// 一般
        /// </summary>
        public const string Type_General = "General";
        /// <summary>
        /// 封闭机构
        /// </summary>
        public const string Type_Sealed = "Sealed";

        #endregion

        #region 集训类型
        /// <summary>
        /// 封闭机构的集训
        /// </summary>
        public const string Bootcamp_Sealed= "Sealed";
        /// <summary>
        /// 悦动力集训
        /// </summary>
        public const string Bootcamp_YDL= "YDL";

        #endregion


    }
}
