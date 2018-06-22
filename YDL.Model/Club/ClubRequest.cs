using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 加入俱乐部申请
    /// </summary>
    [Table(isRowVersion:true)]
    public class ClubRequest : EntityBase
    {
        /// <summary>
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 用户
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 状态(ClubRequestState:"0"申请中，"1"通过，"2"拒绝)
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 档位
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int Level { get; set; }

        /// <summary>
        /// 审核人
        /// </summary>
        [Field]
        public string AuditorId { get; set; }
    }

   
}
