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
    /// 笔记赞
    /// </summary>
    [Table]
    public class NoteSupport : EntityBase
    {
        /// <summary>
        /// 笔记编号
        /// </summary>
        [Field]
        public string NoteId { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

    }
}
