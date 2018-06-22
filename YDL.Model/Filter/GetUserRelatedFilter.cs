using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    ///用户相关的过滤
    /// </summary>
    public class GetUserRelatedFilter : FilterBase
    {
        /// <summary>
        /// 用户id
        /// </summary>
        public string UserId { get; set; }
        /// <summary>
        /// 用户Code
        /// </summary>
        public string UserCode { get; set; }

        /// <summary>
        /// 俱乐部Id
        /// </summary>
        public string ClubId { get; set; }

        public string Mobile { get; set; }

        public string WeiXinTempCode { get; set; }

        public string QQOpenId { get; set; }

        public string PetName { get; set; }
        public string Sex { get; set; }
        public string WeiXinUnionId { get; set; }
        public string HeadUrl { get; set; }

        public string UnBindType { get; set; }

    }
}
