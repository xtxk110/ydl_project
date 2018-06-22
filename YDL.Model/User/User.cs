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
    /// 用户
    /// </summary>
    [Table(name: "UserAccount")]
    public class User : HeadBase
    {
        /// <summary>
        /// 消息推送注册Id
        /// </summary>
        [Field(isUpdate: false)]
        public string RegId { get; set; }

        /// <summary>
        /// 登陆成功回传Token
        /// </summary>
        [Field(isUpdate: false)]
        public string Token { get; set; }

        /// <summary>
        /// 移动设备类型
        /// </summary>
        [Field(isUpdate: false)]
        public string DeviceType { get; set; }

        /// <summary>
        /// 移动设备Token
        /// </summary>
        [Field(isUpdate: false)]
        public string DeviceToken { get; set; }

        /// <summary>
        /// 移动设备版本号
        /// </summary>
        [Field(isUpdate: false)]
        public string DeviceVersion { get; set; }

        /// <summary>
        /// 编号
        /// </summary>
        [Field]
        public string Code { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string PetName { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 城市名称（注册用户时候客户端传入）
        /// </summary>
        public string CityName { get; set; }

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
        /// 乒乓球积分
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ScoreTT { get; set; }

        /// <summary>
        /// 老密码
        /// </summary>
        public string PasswordOld { get; set; }

        /// <summary>
        /// 密码
        /// </summary>
        [Field]
        public string Password { get; set; }

        /// <summary>
        /// 支付密码
        /// </summary>
        [Field(isUpdate: false)]
        public string PayPassword { get; set; }

        /// <summary>
        /// 支付免密码额度
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int PayNoPwdAmount { get; set; }

        /// <summary>
        /// 身份证
        /// </summary>
        [Field]
        public string CardId { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        [Field]
        public string CardName { get; set; }

        /// <summary>
        /// 支付宝
        /// </summary>
        [Field]
        public string AliPayId { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field]
        public string Sex { get; set; }

        /// <summary>
        /// QQ
        /// </summary>
        [Field]
        public string QQ { get; set; }

        /// <summary>
        /// WEIXIN
        /// </summary>
        [Field]
        public string Weixin { get; set; }

        /// <summary>
        /// 所在公司
        /// </summary>
        [Field]
        public string CompanyId { get; set; }

        /// <summary>
        /// 是裁判
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsJudge { get; set; }

        /// <summary>
        /// 管理员
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsAdmin { get; set; }

        /// <summary>
        /// 停用标志
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsStop { get; set; }

        /// <summary>
        /// 生日（可空类型）
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? Birthday { get; set; }

        /// <summary>
        /// 手机
        /// </summary>
        [Field]
        public string Mobile { get; set; }

        /// <summary>
        /// 验证码
        /// </summary>
        public string ValCode { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 签名
        /// </summary>
        [Field]
        public string SignName { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 用户权限
        /// </summary>
        public UserLimit UserLimit { get; set; }

        /// <summary>
        /// 软件版本
        /// </summary>
        public AppVersion AppVersion { get; set; }

        /// <summary>
        /// 公共配置
        /// </summary>
        public Config Config { get; set; }

        /// <summary>
        /// 邀请签约消息状态
        /// </summary>
        [Field(isUpdate: false)]
        public string RequestState { get; set; }

        /// <summary>
        /// 查询辅助字段，学员处理场馆邀请时填写的消息内容
        /// </summary>
        [Field(isUpdate: false)]
        public string RequestReMsg { get; set; }

        /// <summary>
        /// 场馆
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueId { get; set; }

        /// <summary>
        /// 用户Id
        /// </summary>
        [Field(isUpdate: false)]
        public string userId { get; set; }

        /// <summary>
        /// 是否为教练(包括ydl教练和封闭机构教练)
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsCoacher { get; set; }


        /// <summary>
        /// 当前登陆者是否为俱乐部管理员
        /// </summary>
        public bool IsClubManagerWithCurrentUser { get; set; }
        /// <summary>
        /// 当前登陆者是否为俱乐部创建者
        /// </summary>
        public bool IsClubCreatorWithCurrentUser { get; set; }

        /// <summary>
        /// 当前登陆者是否为系统管理员
        /// </summary>
        public bool IsSystemManagerWithCurrentUser { get; set; }

        /// <summary>
        /// 查询用户是否为俱乐部管理员
        /// </summary>
        public bool IsClubManagerWithQueryUser { get; set; }
        /// <summary>
        /// 查询用户是否为俱乐部创建者
        /// </summary>
        public bool IsClubCreatorWithQueryUser { get; set; }

        /// <summary>
        /// 查询用户的俱乐部加入时间
        /// </summary>
        public DateTime ClubJoinTime { get; set; }
        /// <summary>
        /// 群禁言状态
        /// </summary>
        public bool IMShutupState { get; set; }

        public int LevelValue { get; set; }

        /// <summary>
        /// 微信平台用户唯一id
        /// </summary>
        [Field]
        public string WeiXinUnionId { get; set; }

        /// <summary>
        /// QQ平台用户唯一id
        /// </summary>
        [Field]
        public string QQOpenId { get; set; }

        [Field(IsUpdate = false)]
        public string CityIdCombine { get; set; }

        public int LoginType { get; set; }

        /// <summary>
        /// 第三方登陆状态
        /// </summary>
        public string ThirdPartyLoginState { get; set; }

        public bool IsBindQQ { get; set; }
        public bool IsBindTXWeiXin { get; set; }

        public bool IsSetPayPassword { get; set; }
        /// <summary>
        /// 是否启用免密支付
        /// </summary>
        public bool IsEnablePayNoPwdAmount { get; set; }

        /// <summary>
        /// 训练计划
        /// </summary>
        [Field(IsUpdate = false)]
        public string TrainingPlanContent { get; set; }

        /// <summary>
        /// 教练Id
        /// </summary>
        [Field(isUpdate: false)]
        public string CoachId { get; set; }
        /// <summary>
        /// 是否能选择
        /// </summary>
        public bool IsCanNotSelect { get; set; }
        /// <summary>
        /// 不能被选择的原因
        /// </summary>
        public string CanNotSelectReason { get; set; }
        /// <summary>
        /// 是否为封闭机构教练
        /// </summary>
        public bool IsSealedCoach { get; set; }

        /// <summary>
        /// 是否悦动力教练
        /// </summary>
        [Field(isUpdate: false)]
        public bool IsYDLCoach { get; set; }
      /// <summary>
      /// 组织机构ID
      /// </summary>
      [Field(IsUpdate =false)]
        public string OrganTypeId { get; set; }
        /// <summary>
        ///  组织机构名称
        /// </summary>
        [Field(IsUpdate =false)]
        public string OrgName { get; set; }
        /// <summary>
        /// 某个用户权限列表
        /// </summary>
        public List<Limit> LimitList { get; set; }
        /// <summary>
        /// 根据用户登录账号 获取此用户的 UserSig
        /// </summary>
        public IMToken ImToken { get; set; }

    }
}
