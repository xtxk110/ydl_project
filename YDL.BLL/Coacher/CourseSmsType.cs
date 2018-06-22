using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;

namespace YDL.BLL
{
    public enum CourseSmsType
    {
        [Description("保存约课")]
        Save = 0,
        [Description("修改约课")]
        Update = 1,
        [Description("取消约课")]
        Cancel =2
    }
}
