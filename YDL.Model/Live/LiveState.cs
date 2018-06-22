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
    /// 直播状态
    /// </summary>
    public class LiveState
    {
        public LiveState()
        {
            output = new List<LiveStatus>();
        }
        public List<LiveStatus> output { get; set; }

    }

    public class LiveStatus
    {
        public int status { get; set; }
    }
}
