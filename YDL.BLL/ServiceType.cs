using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.BLL
{
    public enum ServiceType
    {
        //登陆
        Login,

        //退出
        LoginOut,

        //保存城市
        SaveCity,

        //获取城市列表
        GetCityList,

        //保存用户
        SaveUser,

        //获取单个用户
        GetUser,

        //获取用户列表
        GetUserList,

        //获取基础数据列表
        GetBaseDataList,

        //获取运动类型列表
        GetSportTypeList,

        //获取用户运动爱好列表
        GetUserSportList,

        //保存用户运动爱好
        SaveUserSport,

        //获取我的俱乐部列表
        GetClubMyList,

        //获取单个俱乐部
        GetClub,

        //保存俱乐部
        SaveClub,

        //获取俱乐部列表
        GetClubList,

        //获取俱乐部成员列表
        GetClubUserList,

        //保存俱乐部申请
        SaveClubRequest,

        //获取某俱乐部未处理申请列表
        GetClubRequestList,

        //审批加入请求
        AuditClubRequest,

        //启用俱乐部档位功能
        EnableClubLevel,

        //移除俱乐部某个成员
        RemoveClubUser,

        //获取俱乐部等级定义列表
        GetClubHonorList,

        //保存俱乐部等级定义
        SaveClubHonor,
        
        //保存活动
        SaveActivity,

        //保存活动成员
        SaveActivityUser,

        //更新活动成员状态
        SetActivityUserState,

        //获取指定活动信息
        GetActivity,

        //获取活动列表
        GetActivityList,

        //获取活动成员列表
        GetActivityUserList,

        //取消活动
        CancelActivity,

        //删除活动成员
        CancelActivityUser,

        DeleteAnnex,
        /// <summary>
        /// 获取比赛
        /// </summary>
        GetGame,
        /// <summary>
        /// 比赛列表
        /// </summary>
        GetGameList,
        /// <summary>
        /// 保存比赛
        /// </summary>
        SaveGame,
        /// <summary>
        /// 参赛队
        /// </summary>
        GetGameTeam,
        /// <summary>
        /// 保存团队
        /// </summary>
        SaveGameTeam,
        /// <summary>
        /// 参赛队审核
        /// </summary>
        AuditGameTeam,
        /// <summary>
        /// 参赛队反审核
        /// </summary>
        ReversalGameTeam,
        /// <summary>
        /// 删除指定队伍
        /// </summary>
        DeleteGameTeamById,
        /// <summary>
        /// 比赛成员
        /// </summary>
        GetGameTeamList,
        /// <summary>
        /// 获取场地列表
        /// </summary>
        GetVenueList,

        /// <summary>
        /// 定义首轮，并自动创建剩下轮次，可以形成拓扑图(小组赛不创建，创建淘汰赛轮次的所有比赛，不包含附加赛)
        /// </summary>
        CreateGameOrder,
        /// <summary>
        /// 轮次胜场设置
        /// </summary>
        SaveGameOrderWin,
        /// <summary>
        /// 更新比赛状态
        /// </summary>
        SaveGameState,
        /// <summary>
        /// 获取比赛轮次列表
        /// </summary>
        GetGameOrderList,
        /// <summary>
        /// 保存小组抽签
        /// </summary>
        SaveGameGroup,
        /// <summary>
        /// 比赛分组列表
        /// </summary>
        GetGameGroupList,

        CreateGameOrderExtra,

        SaveGameTeamSeed,
        /// <summary>
        /// 保存比赛裁判
        /// </summary>
        SaveGameJudge,
        /// <summary>
        /// 比赛裁判列表
        /// </summary>
        GetGameJudgeList,
        /// <summary>
        /// 比赛对阵信息
        /// </summary>
        GetGameOrderLoopList,
        /// <summary>
        /// 对阵明细
        /// </summary>
        GetGameLoopDetailList,
        /// <summary>
        /// 设置相同单位
        /// </summary>
        UpdateGameCorpTeamId,
        /// <summary>
        /// 移交保存
        /// </summary>
        SaveTransfer,
        /// <summary>
        /// 管理机构停用/启用
        /// </summary>
        SaveCompanyIsStop,
        SaveCoach,
        GetCoachList,
        GetCoach,
        GetSignVenueList,
        sp_SetCoachMsgState,
        SaveCoachMsgHandle,
        GetStundentList,
        SaveCoachTrainPrice,
        SaveVenueReleased,
        SaveCoachStudentBalance
    }
}
