using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetActivityUserListFilter : FilterBase
    {
        public string ActivityId { get; set; }
        public string PetName { get; set; }
    }
}
