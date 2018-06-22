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
    public class TVInfo : EntityBase
    {

        [Field(isUpdate: false)]
        public string Code { get; set; }

        [Field(isUpdate: false)]
        public string Name { get; set; }

        [Field(isUpdate: false)]
        public string Type { get; set; }

        [Field(isUpdate: false)]
        public int SortIndex { get; set; }

    }
}