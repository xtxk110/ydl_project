using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace YDL.Model
{
    /// <summary>
    /// 业务权限
    /// </summary>
    public class LimitName
    {
        public static readonly LimitBaseData GameOper = new LimitBaseData { NameId = RightModuleOpType.GameOper.ToString(), Name = RightModuleOpType.GameOper.GetEnumDescription(), Type = 1, Range = 871 };
        public static readonly LimitBaseData ActivityOper = new LimitBaseData { NameId = RightModuleOpType.ActivityOper.ToString(), Name = RightModuleOpType.ActivityOper.GetEnumDescription(), Type = 1, Range = 13159 };
        public static readonly LimitBaseData ClubOper = new LimitBaseData { NameId = RightModuleOpType.ClubOper.ToString(), Name = RightModuleOpType.ClubOper.GetEnumDescription(), Type = 1, Range = 1 };
        public static readonly LimitBaseData VenueOper = new LimitBaseData { NameId = RightModuleOpType.VenueOper.ToString(), Name = RightModuleOpType.VenueOper.GetEnumDescription(), Type = 1, Range = 3303 };
        public static readonly LimitBaseData VenueStatistics = new LimitBaseData { NameId = RightModuleOpType.VenueStatistics.ToString(), Name = RightModuleOpType.VenueStatistics.GetEnumDescription(), Type = 3 };
        public static readonly LimitBaseData VenueGetMoney = new LimitBaseData { NameId = RightModuleOpType.VenueGetMoney.ToString(), Name = RightModuleOpType.VenueGetMoney.GetEnumDescription(), Type = 3 };
        public static readonly LimitBaseData LiveAdd = new LimitBaseData { NameId = RightModuleOpType.LiveAdd.ToString(), Name = RightModuleOpType.LiveAdd.GetEnumDescription(), Type = 3 };
        public static readonly LimitBaseData GuessAdd = new LimitBaseData { NameId = RightModuleOpType.GuessAdd.ToString(), Name = RightModuleOpType.GuessAdd.GetEnumDescription(), Type = 3 };
        public static readonly LimitBaseData ScoreGameAdd = new LimitBaseData { NameId = RightModuleOpType.ScoreGameAdd.ToString(), Name = RightModuleOpType.ScoreGameAdd.GetEnumDescription(), Type = 3 };

        public static List<LimitBaseData> LimitList = new List<LimitBaseData> { GameOper, ActivityOper, ClubOper, VenueOper, LiveAdd, GuessAdd,ScoreGameAdd };
    }
}
