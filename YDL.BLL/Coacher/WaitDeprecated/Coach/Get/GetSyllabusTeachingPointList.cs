using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取课程表大课教学点列表 (不同身份的人,返回不同的数据)
    /// </summary>
    public class GetSyllabusTeachingPointList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = new Response();
            var userRole = CoachHelper.GetUserRole(req.Filter.CurrentUserId);
            var isTeachingPointManager = CoachHelper.Instance.IsTeachingPointManager(req.Filter.CurrentUserId);
            if (isTeachingPointManager) //如果是教学点课程管理员
            {
                //获取既是教学点课程管理员的
                rsp = GetRelatedTechingPoint(req.Filter.CurrentUserId);
            }
            else if (userRole.IsCoach) 
            {
                //获取教练的
                rsp = GetCoachSyllabusTechingPoint(req.Filter.CurrentUserId);
            }
            else
            {
                //获取学员的
                rsp = GetStudentSyllabusTechingPoint(req);
            }


            return rsp;

        }


        //获取学员的教学点列表(其实就是所有教学点分页查询)
        public Response GetStudentSyllabusTechingPoint(Request<GetCoachRelatedFilter> req)
        {
            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetSyllabusTeachingPointList");
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            return result;
        }

        //获取 教练的 教学点 (此人参与的教学点, 在这些教学点里面上课)
        public Response GetCoachSyllabusTechingPoint(string CoacherId)
        {

            var sql = @"
  SELECT 
	b.Id,
	b.HeadUrl,
	b.Name,
    b.TableCount,
	c.Name AS SportName,
    b.Address
 FROM dbo.CoachTeachingPointCoaches a
 INNER JOIN dbo.Venue b ON a.VenueId=b.Id
 LEFT JOIN dbo.SportType c ON b.SportId=c.Id
 WHERE CoacherId=@CoacherId AND b.IsEnableTeachingPoint=1
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoacherId", CoacherId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        //获取 课程管理员的 教学点
        //(因为教学点课程管理员也可能是个教练 , 故获取 此人参与的教学点+此人管理的教学点 两种数据)
        public Response GetRelatedTechingPoint(string CoacherId)
        {

            var sql = @"
/*此人管理的教学点(为这个教学点的课程管理员)*/
SELECT 
	b.Id,
	b.HeadUrl,
	b.Name,
    b.TableCount,
	c.Name AS SportName,
    b.Address
 FROM dbo.Venue b
 LEFT JOIN dbo.SportType c ON b.SportId=c.Id
 WHERE b.CourseManagerId=@CoacherId AND b.IsEnableTeachingPoint=1
 UNION
/*此人参与的教学点(在这些教学点里面上课)*/
 SELECT 
	b.Id,
	b.HeadUrl,
	b.Name,
    b.TableCount,
	c.Name AS SportName,
    b.Address
 FROM dbo.CoachTeachingPointCoaches a
 INNER JOIN dbo.Venue b ON a.VenueId=b.Id
 LEFT JOIN dbo.SportType c ON b.SportId=c.Id
 WHERE CoacherId=@CoacherId AND b.IsEnableTeachingPoint=1

";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoacherId", CoacherId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
