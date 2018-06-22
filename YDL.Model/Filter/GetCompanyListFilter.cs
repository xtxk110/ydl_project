using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetCompanyListFilter : FilterBase
    {
        public string Name { get; set; }
        public bool IsManage { get; set; }

        public bool ShowAll { get; set; }
    }
}
