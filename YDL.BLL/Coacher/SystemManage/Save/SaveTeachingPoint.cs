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
    /// 保存教学点
    /// </summary>
    public class SaveTeachingPoint : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<TeachingPoint>>(request);
            var obj = req.FirstEntity();
            Response rsp = new Response();
            //先删除之前的教练员
            DeleteTeachingPointCoacherIds(obj.VenueId);
            //再插入传来的教练员Id
            foreach (var item in obj.CoacherIds.Split(','))
            {
                if (item != null)
                {
                    rsp = InsertTeachingPointCoacherIds(item, obj.VenueId);
                }
            }
            if (rsp.IsSuccess == false)
            {
                return ResultHelper.Fail("教学点教练员保存失败, 请重试");
            }

            //再将此场馆设置为教学点
            string sql = @"
UPDATE dbo.Venue 
SET  IsEnableTeachingPoint=@IsEnableTeachingPoint
WHERE  Id=@VenueId
";
            var cmd = CommandHelper.CreateText<TeachingPoint>(FetchType.Execute, sql);
            cmd.Params.Add("@VenueId", obj.VenueId);
            cmd.Params.Add("@IsEnableTeachingPoint", obj.IsEnableTeachingPoint);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }



        public Response DeleteTeachingPointCoacherIds(string VenueId)
        {
            var sql = @"DELETE FROM dbo.CoachTeachingPointCoaches WHERE VenueId=@VenueId ";
            var cmd = CommandHelper.CreateText<TeachingPoint>(FetchType.Execute, sql);
            cmd.Params.Add("@VenueId", VenueId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
        public Response InsertTeachingPointCoacherIds(string CoacherId, string VenueId)
        {
            CoachTeachingPointCoaches obj = new CoachTeachingPointCoaches();
            obj.VenueId = VenueId;
            obj.CoacherId = CoacherId;
            obj.RowState = RowState.Added;
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.TrySetNewEntity();

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return result;
        }
    }
}
