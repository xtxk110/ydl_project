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
    /// 活动/约球
    /// </summary>
    [Table]
    public class Activity : HeadBase
    {
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
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 当前用户是否是俱乐部成员
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Boolean)]
        public bool IsClubMember { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime BeginTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime EndTime { get; set; }

        /// <summary>
        /// 场馆Id和名字
        /// </summary>
        [Field]
        public string VenueId { get; set; }
        /// <summary>
        /// 场馆地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }

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
        /// 活动状态
        /// 业务备注: 目前只返回了  005001 进行中; 005005 已结束; 两种状态, 005009 已取消 状态没有返回给前端
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 活动类型
        /// </summary>
        [Field]
        public string Type { get; set; }



        /// <summary>
        /// 参加人数
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int UserCount { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 运动类型
        /// </summary>
        [Field]
        public string SportId { get; set; }

        /// <summary>
        /// 对战类型
        /// </summary>
        [Field]
        public string BattleStyle { get; set; }

        /// <summary>
        /// 查询辅助字段，回复数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ReplyCount { get; set; }

        /// <summary>
        /// 查询辅助字段，关联比赛编号
        /// </summary>
        [Field(isUpdate: false)]
        public string GameId { get; set; }

        /// <summary>
        /// 活动人员列表
        /// </summary>
        public List<ActivityUser> ActivityUserList { get; set; }
        /// <summary>
        /// 活动人员总数
        /// </summary>
        public int ActivityUserTotal { get; set; }

        /// <summary>
        /// 场馆地址经度
        /// </summary>
        [Field(dataType: DataType.Double, isUpdate: false)]
        public double Lng { get; set; }

        /// <summary>
        /// 场馆地址纬度
        /// </summary>
        [Field(dataType: DataType.Double, isUpdate: false)]
        public double Lat { get; set; }

    }
}
