using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 俱乐部成员
    /// </summary>
    [Table]
    public class ClubUser : EntityBase
    {
        /// <summary>
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 用户
        /// </summary>
        [Field]
        public string UserId { get; set; }


        /// <summary>
        /// 头像URL
        /// </summary>
        [Field(isUpdate: false)]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 用户编码
        /// </summary>
        [Field(isUpdate: false)]
        public string Code { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 是创建人
        /// </summary>
        [Field]
        public bool IsCreator { get; set; }

        /// <summary>
        /// 是管理员
        /// </summary>
        [Field]
        public bool IsAdmin { get; set; }

        /// <summary>
        /// 昵称
        /// </summary>
        [Field]
        public string PetName { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        [Field(isUpdate:false)]
        public string CardName { get; set; }

        /// <summary>
        /// 等级名称
        /// </summary>
        [Field(isUpdate:false)]
        public string HonorName { get; set; }

        /// <summary>
        /// 档位
        /// </summary>
        [Field]
        public int LevelValue { get; set; }

        /// <summary>
        /// 俱乐部积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Score { get; set; }

        
        [Field(isUpdate: false)]
        public string UserCode { get; set; }

    }
}
