using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
  public   class LimitDetail
    {
        /// <summary>
        /// 权限标识
        /// </summary>
        public string Id { get; set; }
        /// <summary>
        /// 权限中文名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 权限值
        /// </summary>
        public int Range { get; set; }
        /// <summary>
        /// 是否拥有此权限
        /// </summary>
        public bool IsSelected { get; set; }
    }
}
