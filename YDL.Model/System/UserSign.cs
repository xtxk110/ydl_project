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
    /// 场馆签到
    /// </summary>
    [Table]
    public class UserSign : EntityBase
    {
        /// <summary>
        /// 关联类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 关联编号
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 当日场馆消费单数
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int VenueUseCount { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

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

        /// <summary>
        /// 头像
        /// </summary>
        [Field(isUpdate: false)]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

    }
}
