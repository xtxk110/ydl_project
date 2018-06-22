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
    /// 设置教练价格
    /// </summary>
    public class SaveCoachPrice_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachPrice>>(request);
            var obj = req.FirstEntity();

            if (IsExistCity(obj))
            {
                return ResultHelper.Fail("已存在此城市价格,不能保存");
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.TrySetNewEntity();
                obj.IsEnabled = true;
                
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess)
            {
                result = SaveBigCourseInfo(obj);
            }
            return result;


        }

        private Response SaveBigCourseInfo(CoachPrice coachPrice)
        {
            Response rsp = new Response();
            rsp.IsSuccess = true;
            List<EntityBase> entites = new List<EntityBase>();
            //先删除
            DeleteAllBigcourseInfo();
            foreach (var obj in coachPrice.BigCourseInfoList)
            {
                //后添加
                entites.Add(obj);

                obj.RowState = RowState.Added;
                obj.CoachPriceId = coachPrice.Id;
                if (string.IsNullOrEmpty(obj.Id))
                {
                    //新纪录
                    obj.Id = Ext.NewId();
                }

                obj.CreateDate = DateTime.Now;
                obj.CourseContent = CoachDic.CourseContent;
                obj.ModifyHeadIcon();
                obj.GetWillSaveFileList(entites);
            }

            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (!rsp.IsSuccess)
            {
                return rsp;
            }

            return rsp;

        }

        private Response DeleteAllBigcourseInfo()
        {
            var sql = @"DELETE FROM CoachBigCourseInfo ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


        public bool IsExistCity(CoachPrice obj)
        {
            string sql = "";
            sql = @"
 SELECT * FROM CoachPrice WHERE CityCode=@CityCode
";
            if (obj.RowState == RowState.Modified)// 修改剔除自己
            {
                sql += "AND Id!=@Id";
            }
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@CityCode", obj.CityCode);
            cmd.Params.Add("@Id", obj.Id);
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


    }
}
