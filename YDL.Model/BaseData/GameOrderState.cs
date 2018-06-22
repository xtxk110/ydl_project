using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 比赛大轮次状态
    /// </summary>
    public class GameOrderState
    {
        public static readonly BaseData GROUP = new BaseData { Id = "013", Name = "大轮次状态" };

        public static readonly BaseData NOTSTART = new BaseData { Id = "013001", Name = "未开始", GroupId = GROUP.Id };
        public static readonly BaseData PROCESSING = new BaseData { Id = "013002", Name = "进行中", GroupId = GROUP.Id };
        public static readonly BaseData FINISH = new BaseData { Id = "013003", Name = "已结束", GroupId = GROUP.Id };
    }
}
