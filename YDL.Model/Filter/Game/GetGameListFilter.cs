using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛列表条件
    /// </summary>
    public class GetGameListFilter : FilterBase
    {
        /// <summary>
        /// 俱乐部编号
        /// </summary>
        public string ClubId { get; set; }

        /// <summary>
        /// 城市编号
        /// </summary>
        public string CityId { get; set; }

        /// <summary>
        /// 比赛名称
        /// </summary>
        public String GameName;

        /// <summary>
        /// 比赛名称
        /// </summary>
        public String State;

        /// <summary>
        /// 是否仅仅查看自己参加的比赛
        /// </summary>
        public bool IsOnlySelf;
        /// <summary>
        /// 用户Id
        /// </summary>
        public string UserId;
    }
}