using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 团体小组赛计分模式
    /// </summary>
    public sealed class TeamScoreMode
    {
        /// <summary>
        /// 标准模式
        /// </summary>
        public static readonly BaseData STANDARD = new BaseData { Id = "028001", Name = "标准模式" };

        /// <summary>
        /// 爱猕模式（团体对阵打完，胜场数为得分）
        /// </summary>
        public static readonly BaseData SINGLE_RACE = new BaseData { Id = "028002", Name = "爱猕模式" };
    }
}
