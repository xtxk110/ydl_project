using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using YDL.Core;

namespace YDL.Model
{
    public class BannerInfo : EntityBase
    {
        [Field]
        public string ControlName { get; set; }

        [Field]
        public string BannerPath { get; set; }

        [Field]
        public string DetailImgPath { get; set; }

        [Field]
        public string Subject { get; set; }

        [Field(dataType:DataType.Int32)]
        public int SortOrder { get; set; }

        [Field(dataType: DataType.Boolean)]
        public bool IsEnabled { get; set; }
    }
}
