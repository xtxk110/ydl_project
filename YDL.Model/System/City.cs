using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    [Table]
    public class City : EntityBase
    {
        /// <summary>
        /// 百度地图城市对照码
        /// </summary>
        [Field]
        public string CityCode { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 省份
        /// </summary>
        [Field]
        public string ParentId { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(dataType:DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }
    }
}
