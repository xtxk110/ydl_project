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
    /// 隐藏笔记
    /// </summary>
    [Table]
    public class NoteHide : EntityBase
    {

        /// <summary>
        /// 想隐藏人Id
        /// </summary>
        [Field]
        public string WantHideUserId { get; set; }

        /// <summary>
        /// 被隐藏精彩瞬间Id
        /// </summary>
        [Field]
        public string HideNoteId { get; set; }

    }
}
