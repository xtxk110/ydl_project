using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;

namespace YDL.BLL
{
    public enum CoursePersonType
    {
        [Description("教练")]
        Coacher=0,
        [Description("学生")]
        Student=1
    }
}
