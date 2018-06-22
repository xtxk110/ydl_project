using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取笔记回复列表条件
    /// </summary>
    public class GetNoteReplyListFilter: FilterBase
    {
        /// <summary>
        /// 笔记编号
        /// </summary>
        public string NoteId { get; set; }
    }
}
