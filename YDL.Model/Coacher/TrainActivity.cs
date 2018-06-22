using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    [Table]
    public class TrainActivity:EntityBase
    {
        [Field]
        public string Grade { get; set; }
        [Field]
        public string Student { get; set; }
        [Field]
        public string Contact { get; set; }
    }
}
