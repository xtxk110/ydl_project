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
    /// 封闭机构保存教练(将普通用户添加为教练, 支持添加和修改操作)
    /// </summary>
    public class SaveSealedOrganizationCoach_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            Response rsp = ResultHelper.CreateResponse();
            foreach (var obj in req.Entities)
            {
                if (IsYDLCoach(obj.Id))//如果是ydl机构教练
                {
                    //特殊处理: 在 SealedOrganizationId字段上赋值表示, 此教练即是悦动力教练又是封闭机构教练
                    rsp = SetSealedOrganizationId(obj);
                    SystemHelper.CheckResponseIfError(rsp);
                }
                else
                {
                    //添加或修改封闭机构教练
                    rsp = SaveSealedOrganizationCoach(obj);
                    SystemHelper.CheckResponseIfError(rsp);
                }
            }

            return rsp;

        }


        public Response SetSealedOrganizationId(Coach obj)
        {
            Response rsp = ResultHelper.CreateResponse();
            if (obj.RowState == RowState.Added)
            {
                var sql = @"
UPDATE dbo.Coach SET SealedOrganizationId=@SealedOrganizationId WHERE Id=@Id
";
                var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
                cmd.Params.Add("@SealedOrganizationId", obj.SealedOrganizationId);
                cmd.Params.Add("@Id", obj.Id);

                rsp = DbContext.GetInstance().Execute(cmd);

            }
            else if (obj.RowState == RowState.Modified)
            {
                return ResultHelper.Fail("悦动力教练不允许修改");
            }
            return rsp;
        }

        /// <summary>
        /// 封闭机构教练处理
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public Response SaveSealedOrganizationCoach(Coach obj)
        {
            Response rsp = ResultHelper.CreateResponse();
            if (IsInYDLAuditFlow(obj.Id))
            {
                return ResultHelper.Fail("悦动力审核中的教练,不允许添加");
            }
            if (obj.RowState == RowState.Added)
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
            else if (obj.RowState == RowState.Modified)
            {
                //从数据库查询出原始教练信息
                Coach originalCoach = CoachHelper.Instance.GetCoach(obj.Id);
                //赋新修改的值
                originalCoach.HeadUrl = obj.HeadUrl;
                originalCoach.Name = obj.Name;

                originalCoach.IdCardBackUrl = obj.IdCardBackUrl;
                originalCoach.IdCardFrontUrl = obj.IdCardFrontUrl;
                originalCoach.CardId = obj.CardId;

                originalCoach.VenueId = obj.VenueId;
                originalCoach.BeginTeachingDate = obj.BeginTeachingDate;
                originalCoach.Qualification = obj.Qualification;
                //先删除
                rsp = DeleteCoach(originalCoach.Id);
                if (rsp.IsSuccess)
                {
                    //后添加
                    originalCoach.RowState = RowState.Added;
                    rsp = AddCoach(originalCoach);
                }
            }
             
            return rsp;

        }


        public bool IsYDLCoach(string coachId)
        {
            string sql = @"
SELECT * FROM dbo.Coach WHERE Id=@coachId AND OrganizationId='ydl'
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
            obj.OrganizationId = "";

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
                if (!string.IsNullOrEmpty(obj.HeadUrl))
                {
                    rsp = UpdateHeadUrl(obj.HeadUrl, obj.Id);
                }

                if (!string.IsNullOrEmpty(obj.CardId))
                {
                    rsp = UpdateCardId(obj.CardId, obj.Id);
                }

                if (!string.IsNullOrEmpty(obj.Name))
                {
                    rsp = UpdateCardName(obj.Name, obj.Id);
                }

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



        public Response UpdateHeadUrl(string HeadUrl, string Id)
        {
            HeadUrl = AnnexHelper.ToValidDirectory(HeadUrl);
            var sql = @"UPDATE dbo.UserAccount SET HeadUrl=@HeadUrl WHERE  Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@HeadUrl", HeadUrl);
            cmd.Params.Add("@Id", Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


        public Response UpdateCardName(string CardName, string Id)
        {
            var sql = @"UPDATE dbo.UserAccount SET CardName=@CardName WHERE  Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CardName", CardName);
            cmd.Params.Add("@Id", Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
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
