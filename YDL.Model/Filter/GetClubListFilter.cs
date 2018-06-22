using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetClubListFilter : FilterBase
    {
        public string SportTypeId { get; set; }
        public string CityId { get; set; }
        public string Name { get; set; }
    }
}
