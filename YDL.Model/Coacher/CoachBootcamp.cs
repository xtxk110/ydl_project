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
    /// 集训
    /// </summary>
    [Table]
    public class CoachBootcamp : HeadBase
    {
        public CoachBootcamp()
        {
            BootcampStudentList = new List<User>();
        }

        /// <summary>
        /// 集训名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 场地
        /// </summary>
        [Field]
        public string VenueId { get; set; }
        /// <summary>
        /// 集训状态
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 原价格
        /// </summary>
        [Field]
        public decimal Price { get; set; }


        /// <summary>
        /// 优惠价格
        /// </summary>
        [Field]
        public decimal DiscountPrice { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 报名截止时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? JoinDeadline { get; set; }

        /// <summary>
        /// 集训简介
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 场馆地址
        /// </summary>
        [Field(IsUpdate = false)]
        public string VenueAddress { get; set; }

        /// <summary>
        /// 集训报名学员列表
        /// </summary>
        public List<User> BootcampStudentList { get; set; }

        /// <summary>
        /// 集训报名学员人数
        /// </summary>
        [Field(IsUpdate = false)]
        public int BootcampStudentCount { get; set; }

        /// <summary>
        /// 场馆名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string VenueName { get; set; }

        /// <summary>
        /// 是否为场馆课程管理员
        /// </summary>
        public bool IsVenueCourseManager { get; set; }

        /// <summary>
        /// 场馆课程管理员Code(可用于调试)
        /// </summary>
        public string VenueCourseManagerCode { get; set; }

        /// <summary>
        /// 集训总课时
        /// </summary>
        [Field]
        public int CourseCount { get; set; }

        /// <summary>
        /// 课程内容
        /// </summary>
        [Field]
        public string CourseContent { get; set; }

        /// <summary>
        /// 封闭机构id
        /// </summary>
        [Field]
        public string SealedOrganizationId { get; set; }

        /// <summary>
        /// 集训已创建课时
        /// </summary>
        [Field(IsUpdate =false)]
        public int CourseCreatedCount { get; set; }

        /// <summary>
        /// 集训类型
        /// </summary>
        [Field(IsUpdate = false)]
        public string BootcampType { get; set; }

    }
}