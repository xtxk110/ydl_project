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
    /// 笔记回复
    /// </summary>
    [Table]
    public class NoteReply : HeadBase
    {
        /// <summary>
        /// 重写头像字段
        /// </summary>
        [Field(isUpdate: false)]
        public new string HeadUrl { get; set; }

        /// <summary>
        /// 来源类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

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

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 内容
        /// </summary>
        [Field]
        public string Content { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }
    }
}
