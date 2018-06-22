using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 业务类型
    /// </summary>
    public static class BusinessType
    {

        public static readonly BaseData GAME = new BaseData { Id = "Game", Name = "赛事" };
        public static readonly BaseData VENUE = new BaseData { Id = "Venue", Name = "场馆" };
        public static readonly BaseData USER = new BaseData { Id = "User", Name = "用户" };
        public static readonly BaseData CLUB = new BaseData { Id = "Club", Name = "俱乐部" };
        public static readonly BaseData CoachApply = new BaseData { Id = "CoachApply", Name = "教练申请" };
        public static readonly BaseData CoachFormal = new BaseData { Id = "CoachFormal", Name = "正式教练" };

    }
}
