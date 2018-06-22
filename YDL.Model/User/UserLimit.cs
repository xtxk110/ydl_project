using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户权限
    /// </summary>
    [Table]
    public class UserLimit : EntityBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 创建俱乐部
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsClub { get; set; }

        /// <summary>
        /// 创建场馆
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsVenue { get; set; }

        /// <summary>
        /// 创建比赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsGame { get; set; }

        /// <summary>
        /// 创建积分赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsScoreGame { get; set; }

        /// <summary>
        /// 创建活动
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsActivity { get; set; }

        /// <summary>
        /// 创建笔记
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsNote { get; set; }

        /// <summary>
        /// 机构管理
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsCompany { get; set; }

        /// <summary>
        /// 教学管理员(又名 教练管理员)
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeachManage { get; set; }

        /// <summary>
        /// 是否为封闭机构教练
        /// </summary>
        public bool IsSealedCoach { get; set; }


        /// <summary>
        /// 是否为悦动力教练
        /// </summary>
        public bool IsYDLCoach { get; set; }

        /// <summary>
        /// 是否启用教练(包括ydl和封闭机构教练)
        /// </summary>
        public bool IsEnabledCoach { get; set; }


        ///// <summary>
        ///// 是否允许使用流量播放
        ///// </summary>
        //[Field(dataType: DataType.Boolean)]
        //public bool IsAllowMobileData { get; set; }


    }
}
