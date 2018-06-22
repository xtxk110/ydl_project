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
    /// 俱乐部
    /// </summary>
    [Table]
    public class Club : HeadBase
    {
        /// <summary>
        /// 运动类别
        /// </summary>
        [Field]
        public string SportId { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 介绍
        /// </summary>
        [Field]
        public string Introduce { get; set; }

        /// <summary>
        /// 签名
        /// </summary>
        [Field]
        public string SignName { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 创建人手机
        /// </summary>
        [Field(isUpdate: false)]
        public string Mobile { get; set; }

        /// <summary>
        /// 加群请求数目
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int RequestCount { get; set; }

        /// <summary>
        /// 档位数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int LevelValue { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 停用俱乐部
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsStop { get; set; }
        /// <summary>
        ///俱乐部成员
        /// </summary>
        public List<ClubUser> ClubUserList { get; set; }
        /// <summary>
        /// 俱乐部成员人数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int UserCount { get; set; }

        /// <summary>
        /// 申请加入俱乐部状态:0未加入，1已加入
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int JoinedState { get; set; }

        /// <summary>
        /// 当前登陆者是否为创建人
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsCreator { get; set; }

        /// <summary>
        /// 当前登陆者是否为管理员
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsAdmin { get; set; }

        /// <summary>
        /// 俱乐部常活动地方
        /// </summary>
        public List<ClubAddress> ClubAddressList { get; set; }

    }
}
