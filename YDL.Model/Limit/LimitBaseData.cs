using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 权限基本配置
    /// </summary>
 public   class LimitBaseData:EntityBase
    {
        /// <summary>
        /// 权限的业务模块类型
        /// </summary>
        public string NameId { get; set; }
        /// <summary>
        /// 权限的业务模块类型名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 权限的动作类型:1操作2查看3特殊
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 具体权限的和(查看权限的值为1或0)
        /// </summary>
        public int Range { get; set; }
        /// <summary>
        /// 角色ID
        /// </summary>
        public string RoleId { get; set; }

        /// <summary>
        /// 具体权限集合
        /// </summary>
        public List<LimitDetail> DetailLimit { get; set; }
        /// <summary>
        /// 是否拥有权限,只针对权限值只有0或1的情况有效
        /// </summary>
        public bool IsSelected { get; set; }
    }
}
