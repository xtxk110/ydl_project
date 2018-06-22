using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 群成员
    /// </summary>
    [Table]
    public class IMGroupMember : EntityBase
    {
        public IMGroupMember()
        {
            
        }
        [Field(IsUpdate = false)]
        public string Member_Account { get; set; }
        [Field(IsUpdate = false)]
        public string Role { get; set; }

        /// <summary>
        /// 禁言截止时间(UTC格式)（即世界协调时间）
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal ShuttedUntil { get; set; }
        /// <summary>
        /// 是否禁言
        /// </summary>
        public bool IsShutup { get; set; }

        ///// <summary>
        ///// 禁言截止时间(一般格式)
        ///// </summary>
        //[Field(IsUpdate = false)]
        //public DateTime ShutupDeadline { get; set; }

       
    }


}
