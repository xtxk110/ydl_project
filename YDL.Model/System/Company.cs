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
    /// 公司信息
    /// </summary>
    [Table]
    public class Company : EntityBase
    {
        /// <summary>
        /// 悦动力机构固定编号
        /// </summary>
        public static readonly String YDL_COMPANY_ID = "5C2AE2B8-2D86-4110-AFA3-AA4136F58270";

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// LOGO
        /// </summary>
        [Field]
        public string HeadUrl { get; set; }

        /// <summary>
        /// 介绍
        /// </summary>
        [Field]
        public string Introduce { get; set; }

        /// <summary>
        /// 公司网址
        /// </summary>
        [Field]
        public string SiteUrl { get; set; }

        /// <summary>
        /// 电话
        /// </summary>
        [Field]
        public string Phone { get; set; }

        /// <summary>
        /// 停用标志
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsStop { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 微信
        /// </summary>
        [Field]
        public string WeiXin { get; set; }

        /// <summary>
        /// 管理员
        /// </summary>
        [Field]
        public string AdminId { get; set; }

        /// <summary>
        /// 支付宝帐号
        /// </summary>
        [Field]
        public string AlipayId { get; set; }

        /// <summary>
        /// 是否是管理机构
        /// </summary>
        [Field(dataType: DataType.Boolean, onlyInsert: true)]
        public bool IsManage { get; set; }

        /// <summary>
        /// 是否悦动力
        /// </summary>
        [Field(dataType: DataType.Boolean, onlyInsert: true)]
        public bool IsYDL { get; set; }
    }
}
