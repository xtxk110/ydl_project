using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// IM 用户信息
    /// </summary>
    public class PeopleInfo
    {
        /// <summary>
        /// 初始化
        /// </summary>
        public PeopleInfo()
        {
            To_Account = new List<string>();
            TagList = new List<string>();
        }
        /// <summary>
        /// 需要拉取哪些用户 Identifier的资料
        /// </summary>
        public List<string> To_Account { get; set; }
        /// <summary>
        /// 指定要拉取的资料对象的名称，支持标配资料和自定义资料的拉取，标配资料的相关信息参见：标配资料字段；自定义资料的相关信息参见：自定义资料字段。
        /// </summary>
        public List<string> TagList { get; set; }
    }
}
