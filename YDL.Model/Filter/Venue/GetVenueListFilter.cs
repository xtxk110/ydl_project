using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetVenueListFilter : FilterBase
    {
        public string Name { get; set; }
        public string CityId { get; set; }
        public string UserId { get; set; }
        public string IsOnlySelf { get; set; }
        public string IsUseVip { get; set; }
        /// <summary>
        /// 签约机构
        /// </summary>
        public string CompanyId { get; set; }
        /// <summary>
        /// 是否已签约
        /// </summary>
        public bool IsSign { get; set; }

        /// <summary>
        /// 当前用户经度
        /// </summary>
        public double CurUserLng { get; set; }

        /// <summary>
        /// 当前用户纬度
        /// </summary>
        public double CurUserLat { get; set; }

        /// <summary>
        /// 场地和当前用户的距离(单位M)
        /// </summary>
        public int Distance { get; set; }
        /// <summary>
        /// 场地状态 010001 未审核 010002 已审核
        /// </summary>
        public string State { get; set; }
    }
}
