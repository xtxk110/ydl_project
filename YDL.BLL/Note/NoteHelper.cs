using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    class NoteHelper
    {
        
        public static Response GetNoteSupportList(string noteId)
        {
            var cmd = CommandHelper.CreateProcedure<NoteSupport>(text: "sp_GetNoteSupportList");
            cmd.Params.Add("@noteId", noteId);
            cmd.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        public static CoachCourse GetCourseSummary(string courseId)
        {
            var sql = @"
SELECT 
	a.Id,
	a.CoachId,
	a.BeginTime,
	a.EndTime,
	a.Type,
	a.VenueId,
	a.CreateDate,
	b.HeadUrl AS CoacherHeadUrl,
	b.Sex AS CoacherSex,
	b.CardName AS CoachName,
	c.Name AS TypeName,
	d.Address AS VenueAddress
FROM dbo.CoachCourse  a
LEFT JOIN dbo.UserAccount b ON a.CoachId=b.Id
LEFT JOIN dbo.BaseData c ON a.Type =c.Id
LEFT JOIN dbo.Venue d ON a.VenueId=d.Id
WHERE a.Id=@CourseId

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachCourse>();
        }
    }
}
