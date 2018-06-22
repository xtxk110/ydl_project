using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 段位模型
    /// </summary>
    [Table]
    public class ScoreGrade: EntityBase
    {
        [Field]
        public string GradeName { get; set; }
        [Field]
        public int GradeIndex { get; set; }
        [Field]
        public decimal LeftScore { get; set; }
        [Field]
        public decimal RightScore { get; set; }
    }
}
