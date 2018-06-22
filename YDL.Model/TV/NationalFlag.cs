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
    public class NationalFlag : EntityBase
    {
        /// <summary>
        /// 国家中文名
        /// </summary>
        [Field(isUpdate: false)]
        public string Name { get; set; }
        /// <summary>
        /// 国家图片URL
        /// </summary>
        [Field(isUpdate: false)]
        public string ImageUrl { get; set; }

    }
}