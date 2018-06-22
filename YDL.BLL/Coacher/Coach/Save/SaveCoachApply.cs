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
    /// <summary>
    /// 教练申请
    /// </summary>
    public class SaveCoachApply : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachApply>>(request);
            var obj = req.FirstEntity();

            //审核中的教练不能再申请
            var coacher = GetCoacher(obj.Id);
            if (coacher.State != null)
            {
                if (coacher.State == AuditState.PROCESSING.Id)
                {
                    return ResultHelper.Fail("审核中的教练不能再申请");
                }

            }

            //将之前的拒绝记录删除
            DeleteReject(currentUser.Id, coacher.Id);

            //添加教练申请
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.State = AuditState.PROCESSING.Id;
                obj.IsEnabled = true;
                obj.FileId = Ext.NewId();
                obj.OrganizationId = "ydl"; //默认ydl机构, id赋ydl可以关联机构表的预制数据(预制了一个ydl机构)
                obj.CommissionPercentage = 100; //默认分成比例
                obj.CreateDate = DateTime.Now;

            }

            obj.SealedOrganizationId = "";
            //头像保存
            obj.ModifyHeadIcon();
            //获取将要保存的图片列表
            obj.GetWillSaveFileListByModule(entites, BusinessType.CoachApply.Id);
            //保存身份证正面反面图片
            SaveIdCardImage(obj);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return result;
        }

        public static void SaveIdCardImage(CoachApply obj)
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


        public CoachApply GetCoacher(string userId)
        {
            var sql = @"
SELECT * FROM dbo.CoachApply WHERE Id=@UserId
";
            var cmd2 = CommandHelper.CreateText<CoachApply>(FetchType.Fetch, sql);
            cmd2.Params.Add("@UserId", userId);
            var result2 = DbContext.GetInstance().Execute(cmd2);
            var coacher = result2.Entities.FirstOrDefault() as CoachApply;
            if (coacher != null)
            {
                return coacher;
            }
            else
            {
                return new CoachApply();
            }
        }

        public void DeleteReject(string userId, string applyId)
        {

            //删除教练被拒绝的申请
            var sql2 = @"
DELETE FROM dbo.CoachApply WHERE State='010003' AND Id=@UserId
";
            var cmd2 = CommandHelper.CreateText(FetchType.Execute, sql2);
            cmd2.Params.Add("@UserId", userId);
            var result2 = DbContext.GetInstance().Execute(cmd2);


        }






    }

}
