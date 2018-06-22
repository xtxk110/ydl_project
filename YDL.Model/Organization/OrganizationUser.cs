using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 通过用户更改组织机构模型
    /// </summary>
  public  class OrganizationUser:EntityBase
    {
        /// <summary>
        /// 用户 ID
        /// </summary>
        public string UserId { get; set; }
        /// <summary>
        /// 组织机构TypeId
        /// </summary>
        public string OrgTypeId { get; set; }
    }
}
