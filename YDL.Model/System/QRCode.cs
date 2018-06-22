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
    /// 二维码
    /// </summary>
    [Table]
    public class QRCode : EntityBase
    {
        /// <summary>
        /// 二维码Id
        /// </summary>
        public string QRCodeId { get; set; }
        /// <summary>
        /// 业务对象Id (比如用户的Id, 赛事的Id等等)
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 动作类型(二维码类型)
        /// </summary>
        [Field]
        public string ActionType { get; set; }

        /// <summary>
        /// 业务类型
        /// </summary>
        [Field]
        public string BusinessType { get; set; }

        /// <summary>
        /// 扫描次数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int ScanCount { get; set; }

        /// <summary>
        /// 扫描时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? ScanTime { get; set; }

        /// <summary>
        /// 二维码所属公司
        /// </summary>
        public string Company { get { return "cdydl"; } }
    }
}
