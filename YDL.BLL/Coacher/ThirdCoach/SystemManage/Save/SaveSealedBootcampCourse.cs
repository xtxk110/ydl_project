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
    /// 保存封闭机构集训课程模板(包括添加,修改,删除操作)
    /// </summary>
    public class SaveSealedBootcampCourse_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachBootcampCourse>>(request);
            var obj = req.FirstEntity();
            Response rsp = ResultHelper.CreateResponse();
            //删除
            if (obj.RowState == RowState.Deleted)
            {
                return Delete(obj);
            }

            #region 添加或修改
            string errorMsg;
            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValidForBootcampCourseTemplate(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            //判断时间范围是否和已有课程时间范围重合
            if (IsRepeatPeriodInPrivateCoach(obj))
            {
                return ResultHelper.Fail("和其他课程时间已重合, 不能创建课程");
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {

                obj.TrySetNewEntity();
            }
            var bootcamp = CoachHelper.Instance.GetCoachBootcampById(obj.CoachBootcampId);
            if (bootcamp != null)
            {
                obj.SealedOrganizationId = bootcamp.SealedOrganizationId;
            }
            else
            {
                return ResultHelper.Fail("封闭机构id不能为空");
            }

            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return rsp;
            #endregion 添加或修改

        }

        public Response Delete(CoachBootcampCourse obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

        /// <summary>
        /// 判断课程时间范围是否重合
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsRepeatPeriodInPrivateCoach(CoachBootcampCourse obj)
        {
            //此算法来源于 SO 的牛b算法, 当时本人写了几百行代码都没解决, SO 大神一句就搞定了, 膜拜
            //http://stackoverflow.com/questions/13513932/algorithm-to-detect-overlapping-periods

            var sql = @"
SELECT 
    COUNT(*) 
FROM dbo.CoachBootcampCourse 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND CoachBootcampId=@CoachBootcampId 
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id ";  //如果是修改操作, 把自己剔除掉判断 . 如果是添加操作, 所有记录参与判断
            }
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@BeginTime", obj.BeginTime);
            cmdVal.Params.Add("@EndTime", obj.EndTime);
            cmdVal.Params.Add("@CoachBootcampId", obj.CoachBootcampId);

            if (obj.RowState == RowState.Modified)
            {
                cmdVal.Params.Add("@Id", obj.Id);
            }

            var result = DbContext.GetInstance().Execute(cmdVal);
            if ((int)result.Tag == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

    }
}
