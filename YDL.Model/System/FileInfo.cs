using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 附件信息
    /// </summary>
    [Table]
    public class FileInfo : EntityBase
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 业务编号
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 原始文件名称
        /// </summary>
        [Field]
        public string FileName { get; set; }

        /// <summary>
        /// 文件路径
        /// </summary>
        [Field]
        public string FilePath { get; set; }

        /// <summary>
        /// 大小
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Size { get; set; }

        /// <summary>
        /// 文件类型
        /// </summary>
        [Field]
        public string FileType { get; set; }

        /// <summary>
        /// 文件存储在第三方服务器的ID标识
        /// </summary>
        [Field(onlyInsert: true)]
        public string FileCloudId { get; set; }

        /// <summary>
        /// 业务类型2
        /// </summary>
        [Field]
        public string MasterType2 { get; set; }

        /// <summary>
        /// 业务编号2
        /// </summary>
        [Field]
        public string MasterId2 { get; set; }

        /// <summary>
        /// 缩略图路径
        /// </summary>
        [Field]
        public string CoverPath { get; set; }
    }
}
