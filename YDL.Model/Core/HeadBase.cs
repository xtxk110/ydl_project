using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 需要图片的从本类继承
    /// </summary>
    public class HeadBase : EntityBase
    {
        /// <summary>
        /// 宣传LOGO
        /// </summary>
        [Field]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 辅助字段，老头像
        /// </summary>
        public string HeadUrlOld { get; set; }

        /// <summary>
        /// 附件列表
        /// </summary>
        public List<FileInfo> Files { get; set; }
        /// <summary>
        /// 文件数
        /// </summary>
        public int FileCount { get; set; }
    }
}
