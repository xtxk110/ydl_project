using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 裁判相关的比赛对阵列表条件
    /// </summary>
    public class GetGameJudgeLoopListFilter
    {
        public string Id { get; set; }
        public string OrderId { get; set; }
        public bool IsNotFinish { get; set; }
    }
}
