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
    /// 场馆
    /// </summary>
    [Table]
    public class Venue : HeadBase
    {
        /// <summary>
        /// 初始化
        /// </summary>
        public Venue()
        {
        }
        /// <summary>
        /// 运动项目
        /// </summary>
        [Field]
        public string SportId { get; set; }



        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 介绍
        /// </summary>
        [Field]
        public string Introduce { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 手机
        /// </summary>
        [Field]
        public string Mobile { get; set; }

        /// <summary>
        /// QQ
        /// </summary>
        [Field]
        public string QQ { get; set; }

        /// <summary>
        /// 微信
        /// </summary>
        [Field]
        public string WeiXin { get; set; }

        /// <summary>
        /// 审核状态AuditState
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 支持VIP消费
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsUseVip { get; set; }

        /// <summary>
        /// 信用额度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double CreditLine { get; set; }

        /// <summary>
        /// 余额
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Balance { get; set; }

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
        /// 签约的管理机构
        /// </summary>
        [Field(isUpdate: false)]
        public string CompanyId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 查询辅助字段，回复数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ReplyCount { get; set; }

        /// <summary>
        /// 查询辅助字段，当日签到数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int SignCount { get; set; }

        /// <summary>
        /// 查询辅助字段，未确认结算单数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int VenueBillCount { get; set; }

        /// <summary>
        /// 查询辅助字段，机构对场馆的邀请状态
        /// </summary>
        [Field(isUpdate: false)]
        public string RequestState { get; set; }

        /// <summary>
        /// 查询辅助字段，场馆处理机构邀请时填写的消息内容
        /// </summary>
        [Field(isUpdate: false)]
        public string RequestReMsg { get; set; }

        /// <summary>
        /// 是否获取当前用户在场馆的角色
        /// 是教练？是学员？
        /// </summary>
        public bool IsGetMyRole { get; set; }

        /// <summary>
        /// 查询辅助字段，当前用户是否是此场馆教练
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Boolean)]
        public bool IsCoach { get; set; }

        /// <summary>
        /// 教练数
        /// </summary>
        [Field(isUpdate: false)]
        public int CoachCount { get; set; }



        /// <summary>
        /// 场地和当前用户的距离(单位KM)
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Double)]
        public double Distance { get; set; }

        /// <summary>
        /// 球桌数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int TableCount { get; set; }

        /// <summary>
        /// 打球单价
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal UnitPrice { get; set; }

        /// <summary>
        /// 单价单位
        /// </summary>
        [Field]
        public string UnitType { get; set; }



        /// <summary>
        /// 当前用户经度
        /// </summary>
        public double CurUserLng { get; set; }

        /// <summary>
        /// 当前用户纬度
        /// </summary>
        public double CurUserLat { get; set; }


        /// <summary>
        /// 是否为教学点
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsEnableTeachingPoint { get; set; }

        /// <summary>
        /// 运动项目名称
        /// </summary>
        [Field(isUpdate: false)]
        public string SportName { get; set; }

        /// <summary>
        /// 当前登陆者 是否收藏此场馆
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsFavorite { get; set; }

        /// <summary>
        /// 是否启用
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsEnabled { get; set; }

    }
}
