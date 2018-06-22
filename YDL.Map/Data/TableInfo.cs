using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Map
{
    public class TableInfo
    {
        public string Table { get; set; }

        public string InsertSP { get; set; }

        public string UpdateSP { get; set; }

        public string DeleteSP { get; set; }

        public bool IsRowVersion { get; set; }

        public List<FieldInfo> Fields { get; set; }

        public TableInfo()
        {
            Fields = new List<FieldInfo>();
        }
    }
}
