using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 团体对阵及模板规对阵映射
    /// </summary>
   public class GameLoopMapNew:EntityBase
    {
        /// <summary>
        /// 原团体对阵映射关系
        /// </summary>
        public List<GameLoopMap> LoopMapList { get; set; }
        /// <summary>
        /// 对阵模板规则映射关系
        /// </summary>
        public List<GameTeamLoopTempletMap> TempletMapList { get; set; }
    }
}
