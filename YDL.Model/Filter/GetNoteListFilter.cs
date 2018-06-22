using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取笔记列表条件
    /// </summary>
    public class GetNoteListFilter : FilterBase
    {
        /// <summary>
        /// true查询所有人 false 查询某个人
        /// </summary>
        public bool IsAll { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public string UserId { get; set; }
    }
}
