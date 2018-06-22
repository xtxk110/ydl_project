using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 软件版本信息
    /// </summary>
    [Table]
    public class AppVersion : EntityBase
    {
        /// <summary>
        /// Pc版本号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int PcCode { get; set; }

        /// <summary>
        /// Pc版本名称
        /// </summary>
        [Field]
        public string PcName { get; set; }

        /// <summary>
        /// Pc备注
        /// </summary>
        [Field]
        public string PcRemark { get; set; }

        /// <summary>
        /// Android版本号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int AndroidCode { get; set; }

        /// <summary>
        /// Android版本名称
        /// </summary>
        [Field]
        public string AndroidName { get; set; }

        /// <summary>
        /// Android备注
        /// </summary>
        [Field]
        public string AndroidRemark { get; set; }

        /// <summary>
        /// Ios版本号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int IosCode { get; set; }

        /// <summary>
        /// Ios版本名称
        /// </summary>
        [Field]
        public string IosName { get; set; }

        /// <summary>
        /// 是否发布版本
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsRelease { get; set; }

        /// <summary>
        /// Ios备注
        /// </summary>
        [Field]
        public string IosRemark { get; set; }
        /// <summary>
        /// 安卓是否强制更新
        /// </summary>
        [Field(dataType: DataType.Boolean, isUpdate: false)]
        public bool AndroidIsUpdate { get; set; }
            /// <summary>
            /// IOS是否强制更新
            /// </summary>
        [Field(dataType: DataType.Boolean, isUpdate: false)]
        public bool IosIsUpdate { get; set; }
        /// <summary>
        /// 客户端APP版本
        /// </summary>
        //[Field(dataType:DataType.Int32,isUpdate:false)]
        public string ClientVer { get; set; }
        /// <summary>
        /// 设备类型
        /// </summary>
        public string DeviceType { get; set; }
        /// <summary>
        /// 是否是内部测试
        /// </summary>
        public bool InnerText { get; set; }
    }
}
