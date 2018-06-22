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
    /// 教练
    /// </summary>
    [Table]
    public class Coach : HeadBase
    {

        /// <summary>
        /// 性别
        /// </summary>
        [Field(IsUpdate = false)]
        public string Sex { get; set; }

        /// <summary>
        /// 身份证正面
        /// </summary>
        [Field]
        public string IdCardFrontUrl { get; set; }

        /// <summary>
        /// 身份证后面
        /// </summary>
        [Field]
        public string IdCardBackUrl { get; set; }
        /// <summary>
        /// 场馆Id
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 场馆名称
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueName { get; set; }
        /// <summary>
        /// 场馆地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }
        /// <summary>
        /// 场馆纬度
        /// </summary>
        [Field(isUpdate: false)]
        public double VenueLat { get; set; }
        /// <summary>
        /// 场馆经度
        /// </summary>
        [Field(isUpdate: false)]
        public double VenueLng { get; set; }

        /// <summary>
        /// 开始执教日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTeachingDate { get; set; }
        /// <summary>
        /// 资质证明
        /// </summary>
        [Field]
        public string Qualification { get; set; }

        /// <summary>
        /// 教练分成比例
        /// </summary>
        [Field]
        public decimal CommissionPercentage { get; set; }


        /// <summary>
        /// 教练状态Id
        /// </summary>
        [Field]
        public string State { get; set; }
        /// <summary>
        /// 教练状态Name
        /// </summary>
        [Field(isUpdate: false)]
        public string StateName { get; set; }
        /// <summary>
        /// 等级
        /// </summary>
        [Field]
        public int Grade { get; set; }
        /// <summary>
        /// 审核意见
        /// </summary>
        [Field]
        public string AuditOpinion { get; set; }

        /// <summary>
        /// 审核时间
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime AuditDateTime { get; set; }

        /// <summary>
        /// 是否启用
        /// </summary>
        [Field]
        public bool IsEnabled { get; set; }

        /// <summary>
        /// 机构Id
        /// </summary>
        [Field]
        public string OrganizationId { get; set; }

        /// <summary>
        /// 教练名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string Name { get; set; }

        /// <summary>
        /// 教练评分
        /// </summary>
        [Field(IsUpdate = false)]
        public decimal Score { get; set; }
        /// <summary>
        /// 教龄
        /// </summary>
        [Field(IsUpdate = false)]
        public int CoachAge { get; set; }

        /// <summary>
        /// 教练编码
        /// </summary>
        [Field(IsUpdate = false)]
        public string Code { get; set; }

        /// <summary>
        /// 文件(图片) Id
        /// </summary>
        [Field]
        public string FileId { get; set; }

        /// <summary>
        /// 电话
        /// </summary>
        [Field(IsUpdate = false)]
        public string Mobile { get; set; }

        /// <summary>
        /// 身份证号码
        /// </summary>
        [Field(isUpdate: false)]
        public string CardId { get; set; }


        /// <summary>
        /// 常驻地址审核状态
        /// </summary>
        [Field(isUpdate: false)]
        public int ResidentAddressAuditState { get; set; }

        /// <summary>
        /// 和教练(场地)的距离
        /// </summary>
        [Field(isUpdate: false)]
        public double Distance { get; set; }

        /// <summary>
        /// 当前登录者能否管理这个教练
        /// </summary>
        [Field(IsUpdate = false)]
        public bool CurrentUserCanManageThisCoach { get; set; }

        /// <summary>
        /// 机构管理员Id
        /// </summary>
        [Field(IsUpdate = false)]
        public string OrganizationManagerId { get; set; }

        /// <summary>
        /// 教练单价
        /// </summary>
        public decimal CoachUnitPrice { get; set; }


        /// <summary>
        /// 教练单价
        /// </summary>
        public string CompanyPhone { get { return CoachDic.CompanyPhone; } }

        /// <summary>
        /// 当前登陆者是不是教练
        /// </summary>
        public bool CurrentUserIsCoach { get; set; }

        /// <summary>
        /// 是否有审核信息(用于区分走悦动力申请流程 和机构直接添加教练)
        /// true 表示走的是 悦动力 申请流程, false 表示 是机构直接添加的教练
        /// </summary>
        public bool IsHaveYDLAuditInfo { get; set; }

        /// <summary>
        /// 是否为悦动力教练
        /// </summary>
        public bool IsYDLCoach { get; set; }


        /// <summary>
        /// 封闭机构Id
        /// </summary>
        [Field]
        public string SealedOrganizationId { get; set; }

    }
}
