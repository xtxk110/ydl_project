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
    /// 隐藏笔记创建人
    /// </summary>
    [Table]
    public class NoteCreatorHide : EntityBase
    {

        /// <summary>
        /// 想隐藏人Id
        /// </summary>
        [Field]
        public string WantHideUserId { get; set; }

        /// <summary>
        /// 被隐藏笔记创建人Id
        /// </summary>
        [Field]
        public string HideCreatorId { get; set; }

    }
}
