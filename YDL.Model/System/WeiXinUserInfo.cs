using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class WeiXinUserInfo
    {
        public string nickname { get; set; }
        public int sex { get; set; }
        public string headimgurl { get; set; }

        public string access_token { get; set; }

        public string openid { get; set; }

        public string unionid { get; set; }
    }
}
