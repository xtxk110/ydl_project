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
    /// 机构添加教练
    /// </summary>
    public class SaveOrganizationCoach : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            var obj = req.FirstEntity();
            Response rsp = new Response();
            if (IsInYDLAuditFlow(obj.Id))
            {
                return ResultHelper.Fail("悦动力审核中的教练,不允许添加");
            }
            if (obj.RowState == RowState.Added)
            {
                rsp = AddCoach(obj);
            }
            else if (obj.RowState == RowState.Modified)
            {
                //先删除
                rsp = DeleteCoach(obj.Id);
                if (rsp.IsSuccess)
                {
                    //后添加
                    obj.RowState = RowState.Added;
                    rsp = AddCoach(obj);
                }
            }

            return rsp;
        }

        public bool IsInYDLAuditFlow(string coachId)
        {
            string sql = @"
SELECT * FROM dbo.CoachApply WHERE Id=@coachId AND State IN ('010001')
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@coachId", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public Response DeleteCoach(string id)
        {
            var sql = @"DELETE FROM dbo.Coach WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public Response AddCoach(Coach obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            obj.State = AuditState.PASS.Id;//审核通过
            obj.IsEnabled = true;
            obj.FileId = Ext.NewId();
            obj.CreateDate = DateTime.Now;



            //头像保存
            obj.ModifyHeadIcon();
            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);
            //保存身份证正面反面图片
            SaveIdCardImage(obj);
            Response rsp = new Response();

            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (rsp.IsSuccess)
            {
                rsp = UpdateCardId(obj.CardId, obj.Id);
            }

            return rsp;
        }

        public static void SaveIdCardImage(Coach obj)
        {
            if (obj.IdCardFrontUrl.IsNotNullOrEmpty())
            {
                obj.IdCardFrontUrl = AnnexHelper.ToValidDirectory(obj.IdCardFrontUrl);
            }

            if (obj.IdCardBackUrl.IsNotNullOrEmpty())
            {
                obj.IdCardBackUrl = AnnexHelper.ToValidDirectory(obj.IdCardBackUrl);
            }
        }


        public Response UpdateCardId(string CardId, string Id)
        {
            var sql = @"UPDATE dbo.UserAccount SET CardId=@CardId WHERE  Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CardId", CardId);
            cmd.Params.Add("@Id", Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


    }
}
