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
    /// 集训的学员
    /// </summary>
    [Table]
    public class CoachBootcampStudent : EntityBase
    {

        /// <summary>
        /// 集训Id
        /// </summary>
        [Field]
        public string CoachBootcampId { get; set; }

        /// <summary>
        /// 学员Id
        /// </summary>
        [Field]
        public string StudentId { get; set; }

        /// <summary>
        /// 封闭机构Id
        /// </summary>
        [Field]
        public string SealedOrganizationId { get; set; }

        /// <summary>
        /// 学员姓名
        /// </summary>
        [Field(IsUpdate =false)]
        public string StudentName { get; set; }
        
    }
}