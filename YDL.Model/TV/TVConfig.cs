using System.Collections.Generic;
using YDL.Core;

namespace YDL.Model
{

    [Table]
    public class TVConfig : EntityBase
    {
        public TVConfig()
        {
            TVCodeList = new List<string>();
        }
        [Field]
        public string UserCode { get; set; }

        [Field]
        public string TVCode { get; set; }
        /// <summary>
        /// 直播时，连接SOCKET 登录时的USERCODE
        /// </summary>
        //[Field]
        //public string LiveCode { get; set; }

        public List<string> TVCodeList { get; set; }

    }
}
