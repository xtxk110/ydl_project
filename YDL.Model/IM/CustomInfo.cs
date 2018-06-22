using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    public class CustomInfo  : EntityBase
    {
        public string Id { get; set; }
        public string Type { get; set; }
        public string TypeName { get; set; }
        public string BusinessId { get; set; }
        public string Message { get; set; }

    }
}
