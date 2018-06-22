using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;
using RestSharp;
using System.Timers;

namespace YDL.BLL
{
    /// <summary>
    /// 关闭黑屏直播或设置直播状态
    /// 如果主播的手机意外断网，或者 App 意外崩溃了，Client 会丧失通知服务器的机会，从而在房间列表中残留一些黑屏房间（主播已经没法推流了，但是没有人关闭这些房间，所以观众进入房间后看到的是黑屏）
    /// 这种房间需要定时清理哈
    /// </summary>
    public class CloseBlackScreenLiveSchedule
    {

        private static Timer timer = new Timer();
        public static void AutoCloseBlackScreenLive()
        {
            //60秒钟检查一次是否有黑屏房间
            //SchedulerHelper.AutoExecuteJob(CloseBlackScreenLive, 0, 0, 0, 60);
            timer.Interval = 60000;//计时器间隔毫秒数；
            timer.AutoReset = true;
            timer.Elapsed += CloseBlackScreenLive;
            timer.Start();
        }

        /// <summary>
        /// 启动计时器
        /// </summary>
        public static void StartTimer() {
            if (!timer.Enabled)
                timer.Start();
        }
        public static void CloseBlackScreenLive(object sender, ElapsedEventArgs e)
        {
            //计时器回调执行期关闭计时器，执行完后再次打开，以免前后计时回调穿插
            List<LiveRoom> list = GetAllActiveLiveList();
            if (list.Count == 0){//如果数据库中状态为"Acitve"的直播为0，则停止计时器
                timer.Stop();
                return;
            }

            timer.Stop();//关闭计时器
            foreach (var item in list)
            {
                bool isNotPush = CheckLiveIsNotPush(item);
                if (isNotPush)//已断流或关闭
                {
                    item.NotPushCount += 1;
                    if (item.NotPushCount > 9)//检查到十次都是已断流, 确定为黑屏房价, 关闭此黑屏房间
                    {
                        item.State = LiveDic.Close;
                        item.NotPushCount = 0;//超一定次数后，更改状态且次数归于0，以便后续使用
                        SystemHelper.Instance.UpdateEntity(item);
                    }
                    else //没有达到3次回写数据库
                    {
                        SystemHelper.Instance.UpdateEntity(item);
                    }
                }
                else
                {
                    if(item.NotPushCount != 0)
                    {
                        item.NotPushCount = 0;
                        SystemHelper.Instance.UpdateEntity(item);
                    }
                    
                }
            }
            timer.Enabled = true;//打开计时器
        }

        public static List<LiveRoom> GetAllActiveLiveList()
        {
            var sql = @"
   SELECT * 
   FROM LiveRoom
   WHERE State='Active'
";
            var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, LiveRoom>() ?? new List<LiveRoom>();
        }

        /// <summary>
        /// 检查直播状态（设置直播状态）
        /// </summary>
        /// <param name="liveRoom"></param>
        /// <param name="IsSet">默认不设置直播状态</param>
        /// <returns></returns>
        public static bool CheckLiveIsNotPush(LiveRoom liveRoom,bool IsSet=false)
        {
            string interface_str = "Live_Channel_GetStatus";//腾讯API直播状态查询接口
            if (IsSet)
                interface_str = "Live_Channel_SetStatus";//腾讯API直播状态设置接口
            //有效时间
            DateTime expireTime = DateTime.Now.AddMinutes(10);
            var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var txTime = (expireTime.ToUniversalTime() - epoch).TotalSeconds;
            long expireUnixTime = Convert.ToInt64(txTime);

            //安全签名
            string apikey = ConfigurationManager.AppSettings["live_apikey"].ToString();
            string input = apikey + expireUnixTime.ToString();
            string sign = CreateMD5(input);

            //拼接查询直播状态的url
            string appid = ConfigurationManager.AppSettings["live_appid"].ToString();
            User user = UserHelper.GetUserById(liveRoom.AnchorId);
            string userCode = user != null ? user.Code : "";
            string bizid = ConfigurationManager.AppSettings["live_bizid"].ToString(); ;
            string streamId = bizid + "_" + userCode+"_"+(liveRoom.IsThirdparty?"1":"0"); //直播码
            string baseUrl = "http://fcgi.video.qcloud.com";
            string queryStringUrl = string.Format(@"?appid={0}&interface={1}&Param.s.channel_id={2}&t={3}&sign={4}"
, appid, interface_str, streamId, expireUnixTime, sign);
            if (IsSet)
                queryStringUrl = queryStringUrl + @"&Param.n.status=1";//增加设置状态参数

            //判断是否在推流
            var reqRest = new RestRequest("common_access", Method.GET);
            var rsp = RestApiHelper.SendLiveRequest<LiveState>(reqRest, baseUrl, queryStringUrl);
            var obj = rsp.Data;
            bool isNotPush = false;
            if (obj != null && obj.output.Count > 0)
            {

                if (obj.output[0].status != 1)//0：断流；1：开启；3：关闭
                {
                    isNotPush = true;
                }
            }
            else
                isNotPush = true;

            return isNotPush;


        }

        public static string CreateMD5(string input)
        {
            // Use input string to calculate MD5 hash
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert the byte array to hexadecimal string
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    sb.Append(hashBytes[i].ToString("x2"));
                }
                return sb.ToString();
            }
        }



    }

}
