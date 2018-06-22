using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// IM 设置用户信息
    /// </summary>
    public class PeopleSetInfo
    {
        /// <summary>
        /// 初始化
        /// </summary>
        public PeopleSetInfo()
        {
            ProfileItem = new List<PeopleSetInfoItem>();
        }
        /// <summary>
        /// 需要设置该Identifier的资料
        /// </summary>
        public string From_Account { get; set; }
        /// <summary>
        /// 待设置的用户的资料对象数组，数组中每一个对象都包含了Tag和Value。
        /// </summary>
        public List<PeopleSetInfoItem> ProfileItem { get; set; }
    }

    public class PeopleSetInfoItem
    {
        public string Tag { get; set; }
        public string Value { get; set; }
    }
}
