using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户jpush客户端RegId映射
    /// </summary>
    [Table]
    public class MsgReg : EntityBase
    {
        /// <summary>
        /// 客户端RegId(基类Id为UserId)
        /// </summary>
        [Field]
        public string RegId { get; set; }

        /// <summary>
        /// 更新日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime UpdateDate { get; set; }
    }
}
