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
    /// 获取笔记列表(最下面还有GetNoteList2,用于游客模式)
    /// </summary>
    public class GetNoteList : IServiceBase
    {
        User _currentUser;
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetNoteListFilter>>(request);
            _currentUser = currentUser;

            var cmd = CommandHelper.CreateProcedure<Note>(text: "sp_GetNoteList");
            if (currentUser.Id == req.Filter.UserId)
                cmd.Params.Add("@isSelf", true);//查询自己的笔记 (自己笔记首页)
            else
                cmd.Params.Add("@isSelf", false);//查询别人的笔记 (笔记首页所有人的)

            cmd.Params.Add("@userId", currentUser.Id);
            cmd.Params.Add("@noteCreatorId", req.Filter.UserId);

            cmd.Params.Add("@isAll", req.Filter.IsAll); //true查询所有人 false 查询某个人

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            var noteList = result.Entities.ToList<EntityBase, Note>();
            List<Note> resultNoteList = new List<Note>();
            foreach (var item in noteList)
            {
                //获取笔记图片
                item.TryGetFiles();
                //获取笔记分享的课程摘要(如果有)
                if (!string.IsNullOrEmpty(item.CourseId))
                {
                    item.CourseSummary = NoteHelper.GetCourseSummary(item.CourseId);
                }

                if (!string.IsNullOrEmpty(item.Content))
                {
                    resultNoteList.Add(item);
                }
            }
            //过滤当前用户隐藏的笔记和 笔记创建人
            resultNoteList = FilterNoteListByCurrentUser(resultNoteList);
            result.Entities = resultNoteList.ToList<Note, EntityBase>();
            return result;
        }


        #region 过滤当前用户隐藏的笔记和 笔记创建人
        public List<Note> FilterNoteListByCurrentUser(List<Note> resultNoteList)
        {
            var hideNoteList = GetHideNoteList();
            var hideNoteCreatorList = GetHideNoteCreatorList();
            
            List<Note> noteList = new List<Note> ();
            foreach (var item in resultNoteList)
            {
                noteList.Add(item); //深度拷贝
            }
            //按笔记Id剔除
            foreach (var hideNote in hideNoteList)
            {
                foreach (var note in resultNoteList)
                {
                    if (note.Id == hideNote.HideNoteId)
                    {
                        noteList.Remove(note);
                    }
                }
            }

            //按笔记创建人剔除
            foreach (var hideCreator in hideNoteCreatorList)
            {
                foreach (var note in resultNoteList)
                {
                    if (note.CreatorId.GetId() == hideCreator.HideCreatorId)
                    {
                        noteList.Remove(note);
                    }
                }
            }

            return noteList;
        }
        public List<NoteHide> GetHideNoteList()
        {
            var sql = @"
 SELECT * FROM dbo.NoteHide
 WHERE WantHideUserId=@WantHideUserId 
";
            var cmd = CommandHelper.CreateText<NoteHide>(FetchType.Fetch, sql);
            cmd.Params.Add("@WantHideUserId", _currentUser.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, NoteHide>();
        }
        public List<NoteCreatorHide> GetHideNoteCreatorList()
        {
            var sql = @"
 SELECT * FROM dbo.NoteCreatorHide
 WHERE WantHideUserId=@WantHideUserId 
";
            var cmd = CommandHelper.CreateText<NoteCreatorHide>(FetchType.Fetch, sql);
            cmd.Params.Add("@WantHideUserId", _currentUser.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, NoteCreatorHide>();
        }
        #endregion

    }

    /// <summary>
    /// 获取笔记列表(用于游客模式)
    /// </summary>
    public class GetNoteList2 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetNoteListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Note>(text: "sp_GetNoteList");

            cmd.Params.Add("@isSelf", false);//查询别人的笔记 (笔记首页所有人的)

            cmd.Params.Add("@userId", "tourist");
            cmd.Params.Add("@noteCreatorId", req.Filter.UserId);

            cmd.Params.Add("@isAll", req.Filter.IsAll); //true查询所有人 false 查询某个人

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            var noteList = result.Entities.ToList<EntityBase, Note>();
            List<Note> resultNoteList = new List<Note>();
            foreach (var item in noteList)
            {
                //获取笔记图片
                item.TryGetFiles();
                //获取笔记分享的课程摘要(如果有)
                if (!string.IsNullOrEmpty(item.CourseId))
                {
                    item.CourseSummary = NoteHelper.GetCourseSummary(item.CourseId);
                }

                if (!string.IsNullOrEmpty(item.Content))
                {
                    resultNoteList.Add(item);
                }
            }

            result.Entities = resultNoteList.ToList<Note, EntityBase>();
            return result;
        }
    }
}
