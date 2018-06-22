using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

using YDL.Model;
using YDL.Utility;
using YDL.Map;
using YDL.Core;
using RestSharp;

namespace YDL.BLL
{
    public class UserHelper
    {
        public static UserHelper Instance = new UserHelper();
        public static bool IsSameChars(string str)
        {
            if (str.IsNotNullOrEmpty() && str.Length > 1)
            {
                return Regex.IsMatch(str, str.Substring(0, 1) + "{" + str.Length + "}");
            }
            return true;
        }

        // 从数据库取出并验证用户
        public static User Validate(string code, string password)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_ValidateUser");
            cmd.Params.Add(CommandHelper.CreateParam("@code", code));
            cmd.Params.Add(CommandHelper.CreateParam("@password", password));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault() as User;

            return obj;
        }

        public static string CreateCacheKey(User user)
        {
            return user.Id.EncryptByMD5() + Constant.Chr_Comma + user.Token;
        }

        public static UserLimit GetUserLimit(string userId)
        {
            var cmd = CommandHelper.CreateText<UserLimit>(text: "SELECT * FROM UserLimit WHERE UserId=@userId");
            cmd.CreateParamUser(userId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault() as UserLimit;
            if (obj != null)
            {
                //是否为封闭机构教练
                obj.IsSealedCoach = CoachHelper.Instance.IsSealedCoach(userId);
                obj.IsYDLCoach = CoachHelper.Instance.IsYDLCoach(userId);
                var coach = CoachHelper.Instance.GetCoach(userId);
                if (coach != null)
                {
                    obj.IsEnabledCoach = coach.IsEnabled;
                }
            }
            return obj;
        }

        public static User GetUserByCode(string code)
        {
            var cmd = CommandHelper.CreateText<User>(text: "SELECT * FROM UserAccount WHERE Code=@Code");
            cmd.Params.Add(CommandHelper.CreateParam("@Code", code));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault();
            if (obj == null)
                return null;
            return obj as User;
        }

        public static User GetUserByMobile(string Mobile)
        {
            var cmd = CommandHelper.CreateText<User>(text: "SELECT * FROM UserAccount WHERE Mobile=@Mobile");
            cmd.Params.Add(CommandHelper.CreateParam("@Mobile", Mobile));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault();
            if (obj == null)
                return null;
            return obj as User;
        }

        public static User GetUserById(string userId)
        {
            var cmd = CommandHelper.CreateText<User>(text: "SELECT * FROM UserAccount WHERE Id=@userId");
            cmd.CreateParamUser(userId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault() as User;
            return obj;
        }

        public static Config GetConfig()
        {
            var cmd = CommandHelper.CreateText<Config>(text: "SELECT * FROM Config ");
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault() as Config;

            return obj;
        }

        public static AppVersion GetAppVersion()
        {
            var cmd = CommandHelper.CreateText<AppVersion>(text: "SELECT TOP 1 * FROM AppVersion ORDER BY CreateDate DESC ");
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.Entities.FirstOrDefault() as AppVersion;

            return obj;
        }

        public static User GetOnlieUser(string userId, string deviceType, string token)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetOnlineUser");
            cmd.Params.Add("@userId", userId);
            cmd.Params.Add("@token", token);
            var result = DbContext.GetInstance().Execute(cmd).Entities.FirstOrDefault() as User;

            return result;
        }

        /// <summary>
        /// 当前登陆者是否为系统管理员(就是权限最高那个)
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsSystemManager(string currentUserId)
        {
            if (currentUserId == "001001") //id =001001 的用户为ydl 权限最高的管理员, 测试数据库和正式数据库都是这个值
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #region 处理俱乐部相关业务(共GetUser和GetUserInfoByCode两个接口公用)

        /// <summary>
        /// 处理俱乐部相关业务
        /// 包括: 计算当前登陆者是否为俱乐部管理员, 获取此用户群禁言状态 等等
        /// </summary>
        public void DealClubRelated(User user, string CurrentUserId, string ClubId, string UserCode)
        {
            if (!string.IsNullOrEmpty(ClubId) && !string.IsNullOrEmpty(CurrentUserId))
            {
                //计算当前登陆者是否为俱乐部管理员
                CountManageState(user, CurrentUserId, ClubId, UserCode);
                user.LevelValue = GetClub(ClubId, UserCode).LevelValue;
            }

            if (!string.IsNullOrEmpty(ClubId) && !string.IsNullOrEmpty(UserCode))
            {
                //获取此用户群禁言状态
                user.IMShutupState = GetGroupMemberShutupState(ClubId, UserCode);
            }
        }

        public User GetClub(string ClubId, string UserCode)
        {

            string sql = @"
SELECT 
    b.LevelValue 
FROM dbo.Club a
INNER JOIN dbo.ClubUser b ON a.Id=b.ClubId
INNER JOIN dbo.UserAccount c ON b.UserId=c.Id
WHERE b.ClubId=@ClubId AND c.Code=@UserCode
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", ClubId);
            cmd.Params.Add("@UserCode", UserCode);

            var result = DbContext.GetInstance().Execute(cmd);
            User user = result.FirstEntity<User>() ?? new User();
            return user;
        }

        public void CountManageState(User user, string CurrentUserId, string ClubId, string UserCode)
        {
            ClubUser objCurrentUser = GetClubUser(CurrentUserId, ClubId);
            user.IsClubManagerWithCurrentUser = objCurrentUser.IsAdmin;
            user.IsClubCreatorWithCurrentUser = objCurrentUser.IsCreator;
            user.IsSystemManagerWithCurrentUser = UserHelper.Instance.IsSystemManager(CurrentUserId);
            string queryUserId = GetUserByCode(UserCode).Id;
            ClubUser objQueryUser = GetClubUser(queryUserId, ClubId);
            user.IsClubManagerWithQueryUser = objQueryUser.IsAdmin;
            user.IsClubCreatorWithQueryUser = objQueryUser.IsCreator;
            user.ClubJoinTime = (DateTime)objQueryUser.CreateDate;
            user.PetName = objQueryUser.PetName;
        }

        /// <summary>
        /// 获取群成员禁言状态
        /// </summary>
        /// <param name="ClubId"></param>
        /// <param name="UserCode"></param>
        /// <returns></returns>
        public bool GetGroupMemberShutupState(string ClubId, string UserCode)
        {
            var reqRest = new RestRequest("v4/group_open_http_svc/get_group_shutted_uin", Method.POST);
            reqRest.AddJsonBody(new { GroupId = ClubId });

            var rsp = RestApiHelper.SendIMRequestAndGetResult(reqRest);
            IMGroupMember data = null;
            if (rsp.ShuttedUinList.Count > 0)
            {
                data = rsp.ShuttedUinList.Where(e => e.Member_Account == UserCode).FirstOrDefault();
            }

            if (data != null)
            {
                return true;//已禁言
            }
            else
            {
                return false;
            }
        }

        public ClubUser GetClubUser(string userId, string ClubId)
        {

            string sql = @"
SELECT * FROM dbo.ClubUser WHERE UserId=@UserId AND ClubId=@ClubId
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", userId);
            cmd.Params.Add("@ClubId", ClubId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return result.FirstEntity<ClubUser>();
            }
            else
            {
                ClubUser clubUser = new ClubUser();
                clubUser.IsAdmin = false;
                clubUser.IsCreator = false;
                return clubUser;
            }


        }
        #endregion  处理俱乐部相关业务(共GetUser和GetUserInfoByCode两个接口公用)

        public Response GetUserInfo(string userId, string CurrentUserId, string ClubId, string UserCode)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetUser");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", userId));

            var result = DbContext.GetInstance().Execute(cmd);
            User user = result.FirstEntity<User>();
            if (user == null)
            {
                return ResultHelper.Fail("未找到此用户, 请检测 用户id是否传对");
            }
            user.CityId = user.CityIdCombine;
            user.IsYDLCoach = CoachHelper.Instance.IsYDLCoach(userId);
            //处理俱乐部相关
            DealClubRelated(user, CurrentUserId, ClubId, UserCode);

            return result;
        }



        /// <summary>
        /// 获取姓名, 没有则返回昵称
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static string GetUserName(User user)
        {
            if (string.IsNullOrEmpty(user.CardName))
            {
                return user.PetName;
            }
            return user.CardName;
        }
        /// <summary>
        /// 获取相应用户的名称,多个以逗号隔开
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static string GetMultiUserName(string userId)
        {
            StringBuilder sb = new StringBuilder();
            if (string.IsNullOrEmpty(userId))
                return sb.ToString();
            userId = userId.Trim().Trim(',');
            if (userId.Contains(","))
            {
                string[] users = userId.Split(',');
                foreach(string item in users)
                {
                    string name = "";
                    try
                    {
                        name = GetUserName(GetUserById(item));
                    }catch(Exception e)
                    {

                    }
                    sb.Append(name);
                    sb.Append(",");
                }
            }
            else
            {
                string name = "";
                try
                {
                    name = GetUserName(GetUserById(userId));
                }
                catch (Exception e)
                {

                }
                sb.Append(name);
            }

            return sb.ToString().Trim(',');
        }
    }
}
