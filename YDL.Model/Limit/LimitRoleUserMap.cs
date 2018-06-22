using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    [Table]
    public class LimitRoleUserMap:FilterBase
    {
        /// <summary>
        /// 角色ID
        /// </summary>
        [Field]
        public string RoleId { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        [Field]
        public string UserId { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        [Field(IsUpdate =false)]
        public string CardName { get; set; }
        /// <summary>
        /// 昵称
        /// </summary>
        [Field(IsUpdate = false)]
        public string PetName { get; set; }
        /// <summary>
        /// 电话
        /// </summary>
        [Field(IsUpdate = false)]
        public string Mobile { get; set; }
        /// <summary>
        /// 登录账号
        /// </summary>
        [Field(IsUpdate = false)]
        public string Code { get; set; }

    }
}
