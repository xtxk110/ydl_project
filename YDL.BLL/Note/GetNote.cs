using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取笔记
    /// </summary>
    public class GetNote : IServiceBase
    {
        /// <summary>
        /// 获取笔记
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Note</param>
        /// <returns>Note</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Note>>(request);

            var cmd = CommandHelper.CreateProcedure<Note>(text: "sp_GetNote");
            cmd.Params.Add("@noteId", req.Filter.Id);
            cmd.Params.Add("@userId", currentUser.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            var note = result.FirstEntity<Note>();
            if (note == null)
            {
                return ResultHelper.Fail(ErrorCode.DATA_NOTEXIST, "未找到此精彩瞬间");
            }
            note.TryGetFiles();
            var support = NoteHelper.GetNoteSupportList(note.Id.ToString());
            note.SupportList = support.Entities.ToList<EntityBase, NoteSupport>();
            note.SupportCount = support.RowCount;
            if (!string.IsNullOrEmpty(note.CourseId))
            {
                note.CourseSummary = NoteHelper.GetCourseSummary(note.CourseId);
            }

            return result;
        }
    }

}
