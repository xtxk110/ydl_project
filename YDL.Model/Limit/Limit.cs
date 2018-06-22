using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    [Table]
  public  class  Limit:EntityBase
    {
        /// <summary>
        /// 角色ID
        /// </summary>
        [Field]
        public string RoleId { get; set; }
        /// <summary>
        /// 业务权限名或枚举ID
        /// </summary>
        [Field]
        public string LimitName { get; set; }
        /// <summary>
        /// 权限合()只有操作权限是和,其他只有1,0)
        /// </summary>
        [Field]
        public int LimitDetail { get; set; }
        /// <summary>
        /// 权限动作类型  1操作,2查看,3特殊
        /// </summary>
        [Field]
        public int Type { get; set; }
    }
}
