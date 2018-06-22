using System;
using System.Configuration;
using qcloudsms_csharp;
using YDL.Model;
using YDL.Map;
using YDL.Core;
using System.Collections.Generic;
using System.Linq;
using YDL.Utility;

namespace YDL.BLL
{
    public static class SmsHelper
    {
        // 短信应用SDK AppID
        private static int appid = Convert.ToInt32(ConfigurationManager.AppSettings["QCloudSMS_APPID"]);
        // 短信应用SDK AppKey
        private static string appkey = ConfigurationManager.AppSettings["QCloudSMS_APPKEY"];
        //发送验证码的短信模板ID
        private static int valCodeTemplateId = Convert.ToInt32(ConfigurationManager.AppSettings["QCloudSMS_ValCode_TempID"]);
        //课程预约、修改、取消短信模板ID
        private static int courseSmsTemplateId = Convert.ToInt32(ConfigurationManager.AppSettings["QCloudSMS_CourseSms_TempID"]);
        /// <summary>
        /// 短信单发
        /// </summary>
        /// <param name="phoneNumber">手机号</param>
        /// <param name="templateId">短信模板ID，腾讯云后台查询</param>
        /// <param name="msgParams">短信模板变量一次对应的值</param>
        /// <returns></returns>
        private static SmsSingleSenderResult SingleSend(string phoneNumber, int templateId, string[] msgParams)
        {
            SmsSingleSenderResult result;
            try
            {
                SmsSingleSender ssender = new SmsSingleSender(appid, appkey);
                result = ssender.sendWithParam("86", phoneNumber,
                    templateId, msgParams, "", "", "");
            }
            catch (Exception ex)
            {
                result = new SmsSingleSenderResult() { result = -1, errMsg = ex.Message };
            }

            return result;
        }

        /// <summary>
        /// 发送验证码
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="valCode"></param>
        /// <returns></returns>
        public static SmsSingleSenderResult SendValCode(string phoneNumber, string valCode)
        {
            return SingleSend(phoneNumber, valCodeTemplateId, new[] { valCode });
        }




        /*
        private static string EnCode = "C50067";
        private static string EnPass = "pzoNH7";
        private static string UrlFormat = "http://www3.mob800.com/interface/Send.aspx?enCode={0}&enPass={1}&userName=sys&mob={2}&msg={3}";
        private static string Prefix = "【悦动力】";

        public static string SendSms(string mobiles, string msg)
        {
            string strRet = null;
            try
            {
                string url = string.Format(UrlFormat, EnCode, EnPass, mobiles, HttpUtility.UrlEncode(Prefix + msg, Encoding.GetEncoding("gb2312")));
                if (url == null || url.Trim().ToString() == "")
                {
                    return strRet;
                }
                string targeturl = url.Trim().ToString();
                HttpWebRequest hr = (HttpWebRequest)WebRequest.Create(targeturl);
                hr.UserAgent = "Mozilla/4.0  (compatible; MSIE 6.0; Windows NT 5.1)";
                hr.Method = "GET";
                hr.Timeout = 60 * 1000;
                hr.Headers.Add("content", "text/html; charset=gb2312");
                WebResponse hs = hr.GetResponse();
                Stream sr = hs.GetResponseStream();
                StreamReader ser = new StreamReader(sr, Encoding.Default);
                strRet = ser.ReadToEnd();
            }
            catch (Exception ex)
            {
                strRet = ex.Message;
            }
            return strRet;

        }
         * */
         /// <summary>
         /// 课程序预约、修改预约时间，取消预约 SMS短信发送
         /// </summary>
         /// <param name="obj">课程预约对象</param>
         /// <returns></returns>
         public static SmsSingleSenderResult SendCourseSms(User current,CoachCourse obj,CoursePersonType personType,CourseSmsType smsType)
        {
            string telNO = GetTelNo(current,obj,personType);//移动电话号码
            string param1 = GetCourseOrderPerson(current,obj,personType);//约课人
            string param2 = GetCourseSmsType(smsType);//约课动作  增加，修改，取消
            string param3 = GetCourseName(obj);//课程类型，大课名称或私教课（教练）
            string param4 = GetCourseSmsDate(obj);//上课时间 格式：yyyy年MM月dd日 周  HH:mm


            SmsSingleSenderResult result;
            string[] param = new string[] { param1,param2, param3, param4 };
            result= SingleSend(telNO, courseSmsTemplateId, param);

            return result;
        }
        /// <summary>
        /// 获取对应课程SMS 接收人电话（分教练或学员）
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="personType"></param>
        /// <returns></returns>
        private static string GetTelNo(User current,CoachCourse obj, CoursePersonType personType)
        {
            string userid = "";
            string telno = string.Empty;
            switch (personType)
            {
                case CoursePersonType.Student:
                    if (string.IsNullOrEmpty(current.Id))
                        userid = obj.CreatorId;
                    else
                        userid = current.Id;
                    break;
                case CoursePersonType.Coacher:
                    userid = obj.CoachId;
                    break;
            }
            User user = UserHelper.GetUserById(userid);
            if (user != null)
            {
                telno = user.Mobile;
            }
            return telno;
        }
        /// <summary>
        /// 获取约课人姓名
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="personType"></param>
        /// <returns></returns>
        private static string GetCourseOrderPerson(User current,CoachCourse obj, CoursePersonType personType) {
            string username = "你";
            if (personType == CoursePersonType.Coacher)
            {
                string userid = string.Empty;
                if (string.IsNullOrEmpty(current.Id))
                    userid = obj.CreatorId;
                else
                    userid = current.Id;
                User user = UserHelper.GetUserById(userid);
                if (user != null)
                    username = user.PetName;
            }
            return username;
        }
        /// <summary>
        /// 根据课程类型返回正在操作的课程名称
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        private static string GetCourseName(CoachCourse obj)
        {
            string courseName = string.Empty;

            if (obj.Type == CoachDic.BigCourse)
            {
                string sql = "";
                sql = @"SELECT * FROM dbo.CoachBigCourseInfo WHERE id=@bigCourseId";
                var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
                cmd.Params.Add("@bigCourseId", obj.BigCourseId);
                var result = DbContext.GetInstance().Execute(cmd);
                var data = result.Entities.FirstOrDefault() as CoachBigCourseInfo;
                if (data != null)
                    courseName = data.Name ;


            }else if (obj.Type == CoachDic.PrivateCourse)
            {
                User user = UserHelper.GetUserById(obj.CoachId);
                if (user != null)
                    courseName = user.PetName+ "（私教）的课程";
                else
                    courseName = "私教的课程";
            }
            return courseName;
        }
        /// <summary>
        /// 根据约课时间段返回待定上课日期（单天）
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        private static string GetCourseSmsDate(CoachCourse obj)
        {
            System.Text.StringBuilder dateStr = new System.Text.StringBuilder();
            DateTime? dt = obj.BeginTime;
            if(dt != null)
            {
                dateStr.Append(dt.Value.ToString("yyyy年MM月dd日 "));
                dateStr.Append(GetDayOfWeek(dt.Value.DayOfWeek));
                dateStr.Append(dt.Value.ToString(" HH:mm"));
            }

            return dateStr.ToString();
        }
        private static string GetDayOfWeek(DayOfWeek day)
        {
            string result = string.Empty;
            switch (day)
            {
                case DayOfWeek.Sunday:
                    result = "周日";
                    break;
                case DayOfWeek.Monday:
                    result = "周一";
                    break;
                case DayOfWeek.Tuesday:
                    result = "周二";
                    break;
                case DayOfWeek.Wednesday:
                    result = "周三";
                    break;
                case DayOfWeek.Thursday:
                    result = "周四";
                    break;
                case DayOfWeek.Friday:
                    result = "周五";
                    break;
                case DayOfWeek.Saturday:
                    result = "周六";
                    break;
                
            }
            return result;
        }
        /// <summary>
        /// 获取课程操作
        /// </summary>
        /// <param name="courseAction"></param>
        /// <returns></returns>
        private static string GetCourseSmsType(CourseSmsType courseAction)
        {
            string result = string.Empty;
            switch (courseAction)
            {
                case CourseSmsType.Save:
                    result = "预约";
                    break;
                case CourseSmsType.Update:
                    result = "修改";
                    break;
                case CourseSmsType.Cancel:
                    result = "取消";
                    break;
            }
            return result;
        }
    }
}
