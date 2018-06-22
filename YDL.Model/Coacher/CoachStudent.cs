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
    /// 学员实体
    /// </summary>
    [Table]
    public class CoachStudent : EntityBase
    {
        /// <summary>
        /// 学员Id
        /// </summary>
        [Field(isUpdate: false)]
        public string UserId { get; set; }
        /// <summary>
        /// 教练Id
        /// </summary>
        [Field(isUpdate: false)]
        public string CoachId { get; set; }

        /// <summary>
        /// 学员头像
        /// </summary>
        [Field(isUpdate: false)]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 学员姓名
        [Field(isUpdate: false)]
        public string Name { get; set; }

        /// <summary>
        /// 学员性别
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 评语
        /// </summary>
        [Field(isUpdate: false)]
        public string Remark { get; set; }

        /// <summary>
        /// 课程消费单价(学员报名这节课时的消费单价=当时购买总价/总次数)
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal ThenCourseUnitPrice { get; set; }

        /// <summary>
        /// 大课余额
        /// </summary>
        public CoachStudentBalance BigCourseBalance { get; set; }


        /// <summary>
        /// 私教余额
        /// </summary>
        public CoachStudentBalance PrivateCourseBalance { get; set; }

        /// <summary>
        /// 集训余额
        /// </summary>
        public CoachStudentBalance CoachBootcampBalance { get; set; }


        /// <summary>
        /// 集训课Id
        /// </summary>
        [Field(isUpdate: false)]
        public string CoachBootcampId { get; set; }

    }
}