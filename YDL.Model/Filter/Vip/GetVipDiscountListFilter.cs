using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetVipDiscountListFilter : FilterBase
    {
        /// <summary>
        /// 城市编号
        /// </summary>
        public String CityId { get; set; }
    }
}
