
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using RestSharp;
using System.Collections.Generic;


namespace YDL.BLL
{
    public class LiveHelper
    {
        private static char[] DIGITS_LOWER = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

        public static LiveHelper Instance = new LiveHelper();

        public string GetPushUrl(string UserCode, bool isThirdparty)
        {
            return GetLiveUrl(UserCode, "livepush", isThirdparty);
        }
        public string GetPlayUrl(string UserCode, bool isThirdparty)
        {
            return GetLiveUrl(UserCode, "liveplay", isThirdparty);
        }
        public string GetLiveUrl(string UserCode, string type, bool isThirdparty)
        {
            string key = ConfigurationManager.AppSettings["live_key"].ToString();
            string bizid = ConfigurationManager.AppSettings["live_bizid"].ToString(); ;

            //拼接 url 前半部分
            string streamId = bizid + "_" + UserCode + "_" + (isThirdparty ? "1" : "0"); //直播码
            string urlPrefix = string.Format("rtmp://{0}.{1}.myqcloud.com/live/{2}?bizid={0}&", bizid, type, streamId);

            //拼接 url 后半部分 即?后参数(secret 和 过期时间)
            DateTime expireTime = DateTime.Now.AddDays(1).ToUniversalTime();
            var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var txTime = (expireTime.ToUniversalTime() - epoch).TotalSeconds;
            long txTimeL = Convert.ToInt64(txTime);

            return urlPrefix + GetSuffixUrl(key, streamId, txTimeL);
        }

        private string GetSuffixUrl(string key, string streamId, long txTime)
        {
            string txHexTime = txTime.ToString("X").ToUpper();
            string input = new StringBuilder().
                    Append(key).
                    Append(streamId).
                    Append(txHexTime).ToString();

            string txSecret = null;
            MD5 md5 = MD5.Create();
            byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);
            txSecret = byteArrayToHexString(hash);

            return txSecret == null ? "" :
                    new StringBuilder().
                           Append("txSecret=").
                           Append(txSecret).
                           Append("&").
                           Append("txTime=").
                           Append(txHexTime).ToString();

        }


        private string byteArrayToHexString(byte[] ba)
        {
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();
        }


        /// <summary>
        /// 查询对阵详情
        /// </summary>
        /// <param name="guess"></param>
        public GuessVS GetVSDetail(string VsOrderId, string VsGameLoopId)
        {
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameOrderVSDetail");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", VsOrderId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@isExtra", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@groupOrderNo", 0));
            cmd.Params.Add(CommandHelper.CreateParam("@GameLoopId", VsGameLoopId));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GameLoop>();

            GuessVS guessVS = new GuessVS();
            guessVS.LeftId = obj.Team1Id.GetId();
            guessVS.LeftName = obj.Team1Id.GetName();
            guessVS.LeftHeadUrl = obj.Team1HeadUrl;
            if (obj.IsTeam)
            {
                guessVS.LeftScore = obj.Team1;
            }
            else
            {
                guessVS.LeftScore = obj.Game1;

            }

            guessVS.RightId = obj.Team2Id.GetId();
            guessVS.RightName = obj.Team2Id.GetName();
            guessVS.RightHeadUrl = obj.Team2HeadUrl;
            if (obj.IsTeam)
            {
                guessVS.RightScore = obj.Team2;
            }
            else
            {
                guessVS.RightScore = obj.Game2;
            }

            guessVS.TableNumber = obj.TableNo;
            guessVS.MasterJudgeName = obj.MasterJudgeId.GetName();
            guessVS.SecondJudgeName = obj.JudgeId.GetName();
            guessVS.BeginTime = obj.BeginTime;
            guessVS.State = obj.State.GetId();
            guessVS.GameId = obj.GameId;

            return guessVS;

        }

        /// <summary>
        /// 赛事是否处于直播中
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsInLive(string GameId)
        {
            string sql = @"
SELECT * 
FROM dbo.LiveRoom 
WHERE GameId=@GameId
	AND State='Active'
";
            var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Fetch, sql);
            cmd.Params.Add("@GameId", GameId);
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
        /// <summary>
        /// 获取通用的直播分享地址(.m3u8,.flv)
        /// </summary>
        /// <param name="playUrl">直播播放URL</param>
        /// <param name="formatFlag">分享的格式,默认m3u8格式;1 m3u8格式,2 flv格式</param>
        /// <returns></returns>
        public string GetShareUrl(string playUrl, int formatFlag = 1)
        {
            string result = playUrl;
            if (result.Contains("?"))
                result = result.Substring(0, result.IndexOf('?'));
            if (result != null && result.StartsWith("rtmp"))
                result = result.Replace("rtmp:", "http:");

            switch (formatFlag)
            {
                case 1://生成m3u8格式链接
                    if (result != null && result.EndsWith(@".flv"))
                        result = result.Replace(@".flv", @".m3u8");
                    if (result != null && !result.EndsWith(@".m3u8"))
                        result = result + @".m3u8";
                    break;
                case 2://生成FLV格式链接
                    if (result != null && result.EndsWith(@".m3u8"))
                        result = result.Replace(@".m3u8", @".flv");
                    if (result != null && !result.EndsWith(@".flv"))
                        result = result + @".flv";
                    break;
            }
            return result;
        }
        /// <summary>
        /// 通过腾讯云开放接口统计直播相关信息(腾讯云统计接口并未全部开放,有可能无法使用)
        /// </summary>
        /// <param name="liveInterface">腾讯云统计接口字符串,比如:Get_LiveStat,Get_LivePushStat,Get_LivePlayStat</param>
        /// <param name="streamId">腾讯云直播ID</param>
        /// <returns></returns>
        public static string GetLiveStatistics(string liveInterface, string streamId = null)
        {
            ////////拼接查询参数///////////////////
            //有效时间
            DateTime expireTime = DateTime.Now.AddMinutes(10);
            var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var txTime = (expireTime.ToUniversalTime() - epoch).TotalSeconds;
            long expireUnixTime = Convert.ToInt64(txTime);
            //安全签名及API key和API appid
            int appid = 0;
            int.TryParse(ConfigurationManager.AppSettings["live_appid"].ToString(), out appid);
            string apikey = ConfigurationManager.AppSettings["live_apikey"].ToString();
            string sign = CloseBlackScreenLiveSchedule.CreateMD5(apikey + expireUnixTime.ToString());
            // --------------------------------------------------------------------------------------
            string baseUrl = "http://statcgi.video.qcloud.com/";
            string url = string.Format("/common_access?cmd ={0}&interface={1}&t={2}&sign={3}&Param.n.page_no=1&Param.n.page_size=300", appid, liveInterface, expireTime, sign);
            if (!string.IsNullOrEmpty(streamId))
                url = url + "&Param.s.stream_id=" + streamId;
            //---------------------------------------------------------------------------------------
            RestRequest request = new RestRequest();
            request.Resource = url;
            RestClient client = new RestClient(new Uri(baseUrl));
            var rsp = client.Execute<LiveStatisticsRsp>(request);
            var test = rsp.Data;
            return "";
        } 
    }
    /// <summary>
    /// 直播腾讯接口返回信息类
    /// </summary>
    public class LiveStatisticsRsp
    {
        public int ret { get; set; }
        public string message { get; set; }
        public List<OutputObj> output { get; set; }

        ////////////////////////////////////////////////
        public class OutputObj
        {
            public int stream_count { get; set; }
            public double total_bandwidth { get; set; }
            public int total_online { get; set; }
            public List<StreamInfoObj> stream_info { get; set; }

            ////////////////////////////////////////////////////
            public class StreamInfoObj
            {
                public string stream_name { get; set; }
                public double bandwidth { get; set; }
                public int online { get; set; }
                public string client_ip { get; set; }
                public string server_ip { get; set; }
                public int fps { get; set; }
                public int speed { get; set; }
            }
        }
    }
}
