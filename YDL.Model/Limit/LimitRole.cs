using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    [Table]
   public class LimitRole:EntityBase
    {
        /// <summary>
        /// 角色名称
        /// </summary>
        [Field]
        public string Name { get; set; }
        /// <summary>
        /// 是否默认,默认不能更改删除修改
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsDefault { get; set; }
        /// <summary>
        /// 角色用户关系集合
        /// </summary>
        [Field(IsUpdate =false)]
        public List<LimitRoleUserMap> MapList { get; set; }
        /// <summary>
        /// 用户 id,针对单个用户选择角色时有用,上传
        /// </summary>
        public string UserId { get; set; }
        /// <summary>
        ///此权限是否被拥有
        /// </summary>
        public bool IsChecked { get; set; }
    }
}
