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
    /// 俱乐部活动地址
    /// </summary>
    [Table]
    public class ClubAddress : EntityBase
    {
        /// <summary>
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 场馆头像
        /// </summary>
        [Field(isUpdate: false)]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 场馆地址经度
        /// </summary>
        [Field(dataType: DataType.Double, isUpdate: false)]
        public double Lng { get; set; }

        /// <summary>
        /// 场馆地址纬度
        /// </summary>
        [Field(dataType: DataType.Double, isUpdate: false)]
        public double Lat { get; set; }

        /// <summary>
        /// 场馆地址
        /// </summary>
        [Field(IsUpdate =false)]
        public string Address { get; set; }
    }
}
