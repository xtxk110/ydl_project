using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Core
{
    public class TableProcedurePair
    {
        public string Table { get; set; }

        public string InsertSP { get; set; }

        public string UpdateSP { get; set; }

        public string DeleteSP { get; set; }
    }
}
