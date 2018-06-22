using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YDL.Model;
using YDL.Map;
using YDL.Core;

/// <summary>
/// 新网站入口
/// </summary>
namespace YDL.Web.Controllers
{
    public class WebController : FreeController
    {
        // GET: Web
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult About_us()
        {
            return View();
        }
        public ActionResult game()
        {
            return View();
        }
        public ActionResult Public_heart_coach()
        {
            return View();
        }
        /// <summary>
        /// 直播分享
        /// </summary>
        /// <returns></returns>
        public ActionResult LiveShare()
        {
            return View();
        }
        //抢课
        public ActionResult Take_lessons()
        {
            return View();
        }
        [HttpPost]
        public string Take_lessons(string Grade,string Student,string Contact)
        {
            string result = "0";//0操作成功;1信息不完善;2超过活动人数
            string sqlStr = @"SELECT COUNT(*) FROM TrainActivity ";
            

            if (string.IsNullOrEmpty(Grade) || string.IsNullOrEmpty(Student) || string.IsNullOrEmpty(Contact))
                return "1";

            List<EntityBase> entities = new List<EntityBase>();
            TrainActivity train = new TrainActivity { Grade = Grade, Student = Student, Contact = Contact };
            sqlStr = @"SELECT * FROM TrainActivity WHERE Student='@student'";
            var cmd = CommandHelper.CreateText<TrainActivity>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@student", Student);
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities.Count >0)
            {
                TrainActivity obj = res.Entities[0] as TrainActivity;
                train.Id = obj.Id;
                train.CreateDate = new DateTime();
                train.RowState = RowState.Modified;
            }
            else
            {
                cmd = CommandHelper.CreateText<TrainActivity>(FetchType.Fetch, sqlStr);
                res = DbContext.GetInstance().Execute(cmd);
                if (res.Entities.Count > 30)//超过多少人数不能参加
                    return "2";

                train.SetNewEntity();
            }
            res=DbContext.GetInstance().Execute(CommandHelper.CreateSave(train));
            return result;
        }
        public ActionResult success()
        {
            return View();
        }
        public ActionResult lose()
        {
            return View();
        }

    }
}