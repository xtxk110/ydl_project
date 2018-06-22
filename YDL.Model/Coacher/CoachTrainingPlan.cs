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
    /// 教练对学员的训练计划
    /// </summary>
    [Table]
    public class CoachTrainingPlan : HeadBase
    {
        /// <summary>
        ///  学员Id
        /// </summary>
        [Field]
        public string StudentId { get; set; }

        /// <summary>
        /// 教练Id 
        /// </summary>
        [Field]
        public string CoachId { get; set; }

        /// <summary>
        /// 训练计划内容 
        /// </summary>
        [Field]
        public string TrainingPlanContent { get; set; }

         
    }
}