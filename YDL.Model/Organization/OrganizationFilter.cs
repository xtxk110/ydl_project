using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;


namespace YDL.Model
{
    /// <summary>
    /// 组织机构
    /// </summary>
    [Table]
    public class OrganizationFilter : FilterBase
    {
        /// <summary>
        /// 机构名称
        /// </summary>
        [Field]
        public string Name { get; set; }
        /// <summary>
        /// 机构标识ID
        /// </summary>
        [Field]
        public string TypeId { get; set; }
        /// <summary>
        /// 上级机构标识ID
        /// </summary>
        [Field]
        public string ParentTypeId { get; set; }
        // <summary>
        /// 是否默认
        /// </summary>
        [Field(DataType = DataType.Boolean)]
        public bool IsDefault { get; set; }
        /// <summary>
        /// 下级计数器,每增加一次,+1
        /// </summary>
        [Field]
        public int SonCounter { get; set; }
        /// <summary>
        /// 下级数量,子级变动,随之更改
        /// </summary>
        [Field]
        public int SonAmount { get; set; }
        /// <summary>
        /// 此机构所属层级,比如1
        /// </summary>
        public int Level { get; set; }
        
    }
}
