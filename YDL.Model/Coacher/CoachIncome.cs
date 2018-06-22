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
    /// 教练收入
    /// </summary>
    [Table]
    public class CoachIncome : EntityBase
    {
        /// <summary>
        /// 教练Id
        /// </summary>
        [Field]
        public string CoachId { get; set; }

        /// <summary>
        /// 课程Id
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 课程类型 (private 私教, public 大课)
        /// </summary>
        [Field]
        public string CourseType { get; set; }

        /// <summary>
        /// 课程类型名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseTypeName { get; set; }

        /// <summary>
        /// 原始金额
        /// </summary>
        [Field]
        public decimal OriginalMoney { get; set; }

        /// <summary>
        /// 教练分成比例
        /// </summary>
        [Field]
        public decimal CoachCommissionPercentage { get; set; }

        /// <summary>
        /// 教练实际收入
        /// </summary>
        [Field]
        public decimal CoachRealIncome { get; set; }


        /// <summary>
        /// 机构分成比例
        /// </summary>
        [Field]
        public decimal OrganizationCommissionPercentage { get; set; }

        /// <summary>
        /// 机构实际收入
        /// </summary>
        [Field]
        public decimal OrganizationRealIncome { get; set; }

        /// <summary>
        /// 教练或机构的实际收入(计算字段,方便前端绑定)
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal RealIncome { get; set; }

        /// <summary>
        /// 学员Id
        /// </summary>
        [Field]
        public string StudentId { get; set; }

        /// <summary>
        /// 合计收入
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal TotalIncome { get; set; }
    }
}