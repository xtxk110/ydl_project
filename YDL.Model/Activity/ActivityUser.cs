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
    /// 活动预约/确认
    /// </summary>
    [Table]
    public class ActivityUser : EntityBase
    {
        /// <summary>
        /// 活动
        /// </summary>
        [Field]
        public string ActivityId { get; set; }

        /// <summary>
        /// 参与者
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 头像
        /// </summary>
        [Field(isUpdate:false)]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 是否实际参加
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsJoined { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }
    }
}
