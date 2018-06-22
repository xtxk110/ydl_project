
using Newtonsoft.Json;
using YDL.Map;
using YDL.Utility;
using YDL.Model;
using System.Collections.Generic;
using YDL.Core;
using System.Linq;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户列表(done)
    /// </summary>
    public class GetUserList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserListFilter>>(request);
            Response rsp = new Response();
            var userType = req.Filter.UserType;
            if (string.IsNullOrEmpty(userType))
            {
                //userType 为空获取 所有用户
                rsp = GetAllUser(req);
            }
            else if (userType == "Coacher")
            {
                //获取教练列表 - 弹窗用
                rsp = GetCoacherList(req);
            }
            else if (userType == "GeneralUser")
            {
                //获取一般用户 -剔除教练
                rsp = GetGeneralUser(req);
            }
            else if (userType == "TeachingPointCoach")
            {
                //获取教学点教练
                rsp = GetTeachingPointCoachList(req);
            }
            else if (userType == "BootcampStudent")
            {
                //获取集训课学员列表
                rsp = GetBootcampStudentList(req);
            }
            else if (userType == "BootcampAddStudentSelectList")
            {
                //获取集训课添加时的学员选择列表
                rsp = GetBootcampAddStudentSelectList(req);
            }

            return rsp;
        }

        public Response GetBootcampAddStudentSelectList(Request<GetUserListFilter> req)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetBootcampAddStudentSelectList");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.Params.Add(CommandHelper.CreateParam("@CoachBootcampId", req.Filter.CoachBootcampId));

            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            var userList = result.Entities.ToList<EntityBase, User>();
            // 将这个时间段被其他教练已选的学员标记出来
            var selectedUserList = GetOtherCoachArrangeStudentList(req);
            foreach (var selectedUser in selectedUserList)
            {
                
                var obj = userList.Where(e => e.Id == selectedUser.Id).FirstOrDefault();
                if (obj != null)
                {
                    obj.IsCanNotSelect = true;
                    var coach = UserHelper.GetUserById(selectedUser.CoachId);
                    string coachName = "";
                    if (coach != null)
                    {
                        coachName = UserHelper.GetUserName(coach);
                    }
                    obj.CanNotSelectReason = string.Format("[{0}]学员已经被[{1}]教练选择了", obj.CardName, coachName);
                }
            }
            return result;
        }

        /// <summary>
        /// 获取其他教练在这个时间段已排课的学员列表
        /// </summary>
        /// <returns></returns>
        private List<User> GetOtherCoachArrangeStudentList(Request<GetUserListFilter> req)
        {

            var sql = @"
SELECT
	b.YdlUserId AS Id,
    a.CoachId
FROM dbo.CoachCourse a
INNER JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
WHERE
	
	 a.BeginTime=@BeginTime
	AND a.EndTime=@EndTime
	AND a.CoachId!=@CoachId
    
     
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            //cmd.Params.Add(CommandHelper.CreateParam("@CoachBootcampId", req.Filter.CoachBootcampId));
            cmd.Params.Add(CommandHelper.CreateParam("@BeginTime", req.Filter.BootcampCourseBeginTime));
            cmd.Params.Add(CommandHelper.CreateParam("@EndTime", req.Filter.BootcampCourseEndTime));
            cmd.Params.Add(CommandHelper.CreateParam("@CoachId", req.Filter.CoachId));

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, User>() ?? new List<User>();
        }

        public Response GetBootcampStudentList(Request<GetUserListFilter> req)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetBootcampAppointmentStudentList");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.Params.Add(CommandHelper.CreateParam("@BootcampCourseId", req.Filter.CoachBootcampCourseId));

            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                User user = item as User;
                if (string.IsNullOrEmpty(user.CardName))
                {
                    user.CardName = user.PetName;
                }
            }

            return result;
        }

        public Response GetGeneralUser(Request<GetUserListFilter> req)
        {
            if (req.Filter.IsAdmin.IsNullOrEmpty())
            {
                req.Filter.IsAdmin = Constant.Str_Zero;
            }
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetGeneralUserList");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.Params.Add(CommandHelper.CreateParam("@isAdmin", req.Filter.IsAdmin));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        public Response GetAllUser(Request<GetUserListFilter> req)
        {
            if (req.Filter.IsAdmin.IsNullOrEmpty())
            {
                req.Filter.IsAdmin = Constant.Str_Zero;
            }
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetUserList");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.Params.Add(CommandHelper.CreateParam("@isAdmin", req.Filter.IsAdmin));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        public Response GetCoacherList(Request<GetUserListFilter> req)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetCoacherListForSelect");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                User user = item as User;
                if (string.IsNullOrEmpty(user.CardName))
                {
                    user.CardName = user.PetName;
                }
            }
            return result;
        }


        public Response GetTeachingPointCoachList(Request<GetUserListFilter> req)
        {
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetTeachingPointCoachList");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords));
            cmd.Params.Add(CommandHelper.CreateParam("@VenueId", req.Filter.VenueId));

            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                User user = item as User;
                if (string.IsNullOrEmpty(user.CardName))
                {
                    user.CardName = user.PetName;
                }
            }

            return result;
        }


    }

}
