using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GameTeamLoopTempletFilter
    {
        /// <summary>
        /// 团体对阵模板名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 团体对阵模板ID
        /// </summary>
        public string TempletId { get; set; }
        /// <summary>
        /// 赛事ID(设置或查看团体对阵,才传此值)
        /// </summary>
        public string GameId { get; set; }
        /// <summary>
        /// 对阵ID(设置或查看团体对阵,才传此值)
        /// </summary>
        public string LoopId { get; set; }
        /// <summary>
        /// 新建模板时设定的上场人数(新建模板,检查重名时上传)
        /// </summary>
        public int PersonCount { get; set; }
        /// <summary>
        /// 修改模板且检查重名时,传true;新建时传false
        /// </summary>
        public bool ModifyFlag { get; set; }
        /// <summary>
        /// 是否启用主客队
        /// </summary>
        public bool IsGuest { get; set; }
    }
}
