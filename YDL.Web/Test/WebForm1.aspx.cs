using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using YDL.BLL;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.Web.Test
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var str = "888898";
            //bool ismatch= Regex.IsMatch(str, str.Substring(0, 1) + "{" + str.Length + "}");

            //Request<CoachStudentBalance> request = new Request<CoachStudentBalance>();
            //CoachStudentBalance co = new CoachStudentBalance();
            //co.UserId = "1a627bd9-f993-4a59-b0ab-a61d00b9f8b8";
            //co.VenueId = "4882cb36-807f-4b73-8476-a5f400b12935";
            //co.Year = 0;
            //co.Month = 0;
            //co.TotalTimes = 50;


            ////Request<User> req = new Request<User>();
            ////req.Filter = new Model.User { Code = "android", Password = "123", DeviceVersion="" };
            ////var result = ServiceBuilder.GetInstance().Execute(ServiceType.Login, req);


            ////request.Token = (result.Entities.FirstOrDefault() as User).Token;
            //request.Entities = new List<CoachStudentBalance>() { co };

            //var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveCoachStudentBalance, request);

            //City city = new City { Code = "52", Name = "重庆", ParentId = "", RowState = RowState.Added };
            //Request<City> request = new Request<City> { Entities = new List<City> { city } };
            /*
            GetActivityListFilter filter = new GetActivityListFilter { PageIndex=1, PageSize=10 };

            Request<GetActivityListFilter> request = new Request<GetActivityListFilter> { Entities = new List<GetActivityListFilter> { filter } };
            var user = CacheUserBuilder.Instance.Login("admin", "001001");
            Response result = ResultHelper.CreateSuccess(new List<EntityBase> { user });

            var re = ServiceBuilder.GetInstance().Excute(ServiceType.GetActivityList, request);*/
            /*
            Request<User> req = new Request<User>();
            req.Filter=new Model.User{ Code="android", Password="123"};
            var result=ServiceBuilder.GetInstance().Excute(ServiceType.Login, req);


            req.Token = (result.Entities.FirstOrDefault() as User).Token;



            Request<GetActivityListFilter> request = new Request<GetActivityListFilter>();
            request.Filter = new GetActivityListFilter { PageIndex = 1, PageSize = 10 };
            request.Token = req.Token;
            var r = ServiceBuilder.GetInstance().Excute(ServiceType.GetActivityList, request);
            var temp = r;*/

            //Request<GameOrder> req = new Request<GameOrder> { Entities = new List<GameOrder> { new GameOrder {BeginRank=1,EndRank=16 } } };
            //ServiceBuilder.GetInstance().Excute(ServiceType.CreateGameOrderExtra, req);

            //double aaaa = 80.00;
            //string sh = Convert.ToString(aaaa);

            //string sh1111 = sh;

            ////抽签测试
            //GridView1.DataSource = SetSecondPlayer();
            //GridView1.DataBind();

            //短信测试 
            //var result=SmsHelper.SendSms("18683952608,18181963663", "悦动力注册验证码0900");
            //var temp = result;


            //发送请求的数据
            /*
            string strRespone = "";
            string sdkappid = "1400008708";
            string Identifier = "admin1";//管理员帐号
            string userSig = "eJxljstOg0AYRvc8BZltjc5FymDipoUm2FpDgFhXZDL8pWNhQDoobeO7q9hEEtfnfJezZds2SlbxtZCy7rTJzLEBZN-ZCKOrP9g0Ks*EyVib-4PQN6qFTGwNtAMkjuNQjMeOykEbtVUXQ*SV0mTED-k*G0Z*C26-05i7mI8VVQzwMUjnYTQv*Grp9ZMHvvOjDaU3HjnFnU*6N31K1vIpBG-RM5FUclGExfNO*7MU0uAYwf5jEy89WMtAl6-C5X7H6tlEJtVLaco6uh9NGlXB5dCUMc6m1B3Rd2gPqtaDQDFxCGU-tzGyPq0vSiFdbg__";
            string interfaceFunc = "v4/im_open_login_svc/account_import";
            string POSTURL = ConfigurationManager.AppSettings["IMUrl"] + interfaceFunc + "?usersig=" + userSig + "&identifier=" + Identifier + "&sdkappid=" + sdkappid + "&contenttype=json";
            string PostData = "{\"Identifier\":\"13550001111\",\"Nick\":\"dey\",\"FaceUrl\":\"http://www.gotopsports.com\"}";

            HttpWebRequest request = WebRequest.Create(POSTURL) as HttpWebRequest;
            request.Method = "POST";
            request.KeepAlive = false;
            request.ServicePoint.ConnectionLimit = 300;
            request.AllowAutoRedirect = true;
            request.Timeout = 50000;
            request.ReadWriteTimeout = 50000;
            request.ContentType = "application/json";
            //request.Accept = "application/xml";
            //request.Headers.Add("X-Auth-Token", HttpUtility.UrlEncode(""));

            byte[] bytes = Encoding.UTF8.GetBytes(PostData);
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(bytes, 0, bytes.Length);
            }


            HttpWebResponse SendSMSResponse = (HttpWebResponse)request.GetResponse();
            if (SendSMSResponse.StatusCode == HttpStatusCode.RequestTimeout)
            {
                if (SendSMSResponse != null)
                {
                    SendSMSResponse.Close();
                    SendSMSResponse = null;
                }
                if (request != null)
                {
                    request.Abort();
                }
            }
            else
            {
                StreamReader SendSMSResponseStream = new StreamReader(SendSMSResponse.GetResponseStream(), Encoding.GetEncoding("utf-8"));
                strRespone = SendSMSResponseStream.ReadToEnd();
            }

            txResponse.Text = strRespone;
            //UTF8Encoding encoding = new UTF8Encoding();
            //byte[] byte1 = encoding.GetBytes(PostData);
            //myHttpWebRequest.ContentType = "application/x-www-form-urlencoded";
            //myHttpWebRequest.ContentLength = byte1.Length;
            //Stream newStream = myHttpWebRequest.GetRequestStream();
            //newStream.Write(byte1, 0, byte1.Length);
            //newStream.Close();


            ////发送成功后接收返回的XML信息 
            //HttpWebResponse response = (HttpWebResponse)myHttpWebRequest.GetResponse();

            //string lcHtml = string.Empty;
            //Encoding enc = Encoding.GetEncoding("UTF-8");
            //Stream stream = response.GetResponseStream();
            //StreamReader streamReader = new StreamReader(stream, enc);
            //lcHtml = streamReader.ReadToEnd();*/
        }

        public static string GetMobileConfByUserId(string userid)
        {
            string rs = null;
            string strOnLine = "";
            if (!string.IsNullOrEmpty(userid))
            {
                if (string.IsNullOrEmpty(strOnLine))
                {
                    strOnLine = ConfigurationManager.AppSettings["OnLineUrl"];
                }
                ServicePointManager.DefaultConnectionLimit = 300;
                System.GC.Collect();
                CookieContainer cookieContainer = new CookieContainer();
                // 设置提交的相关参数 
                HttpWebRequest request = null;
                HttpWebResponse SendSMSResponse = null;
                Stream dataStream = null;
                StreamReader SendSMSResponseStream = null;
 
                try
                {
                    request = WebRequest.Create(strOnLine) as HttpWebRequest;
                    request.Method = "POST";
                    request.KeepAlive = false;
                    request.ServicePoint.ConnectionLimit = 300;
                    request.AllowAutoRedirect = true;
                    request.Timeout = 10000;
                    request.ReadWriteTimeout = 10000;
                    request.ContentType = "application/json";
                    request.Accept = "application/xml";
                    request.Headers.Add("X-Auth-Token", HttpUtility.UrlEncode(""));
                    string strContent = "{\"appId\":\"\",\"method\":\"\",\"tokenId\":\"\",\"data\":{\"userAccountId\":\"" + userid + "\"}}";
                    byte[] bytes = Encoding.UTF8.GetBytes(strContent);
                    request.Proxy = null;
                    request.CookieContainer = cookieContainer;
                    using (dataStream = request.GetRequestStream())
                    {
                        dataStream.Write(bytes, 0, bytes.Length);
                    }
                    SendSMSResponse = (HttpWebResponse)request.GetResponse();
                    if (SendSMSResponse.StatusCode == HttpStatusCode.RequestTimeout)
                    {
                        if (SendSMSResponse != null)
                        {
                            SendSMSResponse.Close();
                            SendSMSResponse = null;
                        }
                        if (request != null)
                        {
                            request.Abort();
                        }
                        return null;
                    }
                    SendSMSResponseStream = new StreamReader(SendSMSResponse.GetResponseStream(), Encoding.GetEncoding("utf-8"));
                    string strRespone = SendSMSResponseStream.ReadToEnd();

                    return strRespone;
                }
                catch (Exception ex)
                {

                    if (dataStream != null)
                    {
                        dataStream.Close();
                        dataStream.Dispose();
                        dataStream = null;
                    }
                    if (SendSMSResponseStream != null)
                    {
                        SendSMSResponseStream.Close();
                        SendSMSResponseStream.Dispose();
                        SendSMSResponseStream = null;
                    }
                    if (SendSMSResponse != null)
                    {
                        SendSMSResponse.Close();
                        SendSMSResponse = null;
                    }
                    if (request != null)
                    {
                        request.Abort();
                    }
                }
                finally
                {
                    if (dataStream != null)
                    {
                        dataStream.Close();
                        dataStream.Dispose();
                        dataStream = null;
                    }
                    if (SendSMSResponseStream != null)
                    {
                        SendSMSResponseStream.Close();
                        SendSMSResponseStream.Dispose();
                        SendSMSResponseStream = null;
                    }
                    if (SendSMSResponse != null)
                    {
                        SendSMSResponse.Close();
                        SendSMSResponse = null;
                    }
                    if (request != null)
                    {
                        request.Abort();
                    }
                }
            }
            return rs;
        }

        //以下测试类和测试方法请不要删除
        public class BaseData1
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Remark { get; set; }
        }

        private static List<BaseData1> SetSecondPlayer()
        {
            GameOrder order = new GameOrder() { GroupCount = 4, KnockoutCount = 4 };
            var totalPosition = order.GroupCount * order.KnockoutCount;

            order.GroupList = new List<GameGroup> { };
            for (int i = 1; i <= order.GroupCount; i++)
            {
                order.GroupList.Add(new GameGroup { Id = i + "队" });
            }

            int a = (int)Math.Log(32, 2);

            //获取所有分组出线人员
            var memberList = new List<GameGroupMember> { };
            for (int i = 1; i <= order.GroupCount; i++)
            {
                memberList.Add(new GameGroupMember { TeamId = i + "组—第1名" });
                memberList.Add(new GameGroupMember { TeamId = i + "组—第2名" });
                memberList.Add(new GameGroupMember { TeamId = i + "组—第3名" });
                memberList.Add(new GameGroupMember { TeamId = i + "组—第4名" });
            }
            //获取第二轮淘汰比赛所有场次（非附加赛）
            //var secondLoopList = GetSecondLoopList(order);
            //建立所有位置

            List<BaseData1> listPosition = new List<BaseData1>();
            for (int i = 0; i < totalPosition; i++)
            {
                listPosition.Add(new BaseData1 { Id = (i + 1), Name = string.Empty });
            }
            //找第一名位置
            List<int> source1 = KnockoutDrawHelper.CalRankPos(totalPosition, order.KnockoutCount, 1);
            List<int> source2 = KnockoutDrawHelper.CalRankPos(totalPosition, order.KnockoutCount, 2);
            List<int> source3 = KnockoutDrawHelper.CalRankPos(totalPosition, order.KnockoutCount, 3);
            List<int> source4 = KnockoutDrawHelper.CalRankPos(totalPosition, order.KnockoutCount, 4);

            source1 = KnockoutDrawHelper.SortIndexFor4(source1, 1);
            source2 = KnockoutDrawHelper.SortIndexFor4(source2, 2);
            source3 = KnockoutDrawHelper.SortIndexFor4(source3, 3);
            source4 = KnockoutDrawHelper.SortIndexFor4(source4, 4);

            for (int i = 0; i < totalPosition / order.KnockoutCount; i++)
            {
                listPosition[source1[i]].Name = memberList[i * order.KnockoutCount].TeamId;
            }

            for (int i = 0; i < totalPosition / order.KnockoutCount; i++)
            {
                listPosition[source2[i]].Name = memberList[i * order.KnockoutCount + 1].TeamId;
            }
            
            for (int i = 0; i < totalPosition / order.KnockoutCount; i++)
            {
                listPosition[source3[i]].Name = memberList[i * order.KnockoutCount + 2].TeamId;
            }

            for (int i = 0; i < totalPosition / order.KnockoutCount; i++)
            {
                listPosition[source4[i]].Name = memberList[i * order.KnockoutCount + 3].TeamId;
            }

            /*
            int groupCount = order.GroupList.Count;
            int scale = groupCount / order.KnockoutCount;
            if (order.KnockoutCount == 2)
            {
                scale = scale / 2;
            }
            for (int i = 0; i < groupCount; i++)
            {
                var group = order.GroupList[i];
                var members = memberList.Where(P => P.GroupId == group.Id).ToList();
                for (int j = 0; j < members.Count(); j++)
                {
                    listPosition[FindIndex(order, groupCount, scale, i, j)].Name = members[j].TeamId;
                }
            }*/
            return listPosition;
        }

        private static int FindIndex(GameOrder order, int groupCount, int scale, int i, int j)
        {
            //查找位置
            int index = 0;
            switch (j)
            {
                case 0:
                    index = i % 2 == 0 ? i * order.KnockoutCount : i * order.KnockoutCount + (order.KnockoutCount - 1);
                    break;

                case 1:
                    index = i % 2 == 0 ? ((groupCount - 1) - i) * order.KnockoutCount : (groupCount - i) * order.KnockoutCount;
                    /*
                    if (i < groupCount / 2)
                    {
                        index = i % 2 == 0 ? (i + 2 * scale) * order.KnockoutCount + order.KnockoutCount : (i + 2 * scale) * order.KnockoutCount - 1;
                    }
                    else
                    {
                        index = i % 2 == 0 ? (i - 2 * scale) * order.KnockoutCount + order.KnockoutCount : (i - 2 * scale) * order.KnockoutCount - 1;
                    }*/
                    break;

                case 2:
                    index = i % 2 == 0 ? (i + 1) * order.KnockoutCount + 1 : (i - 1) * order.KnockoutCount + 2;
                    /*
                    if ((i / 2) % 2 == 0)
                    {
                        index = i % 2 == 0 ? (i + (scale > 0 ? 2 : 0)) * order.KnockoutCount + 2 : (i + (scale > 0 ? 2 : 0)) * order.KnockoutCount + 1;
                    }
                    else
                    {
                        index = i % 2 == 0 ? (i - (scale > 0 ? 2 : 0)) * order.KnockoutCount + 2 : (i - (scale > 0 ? 2 : 0)) * order.KnockoutCount + 1;
                    }*/
                    break;

                case 3:
                    //if (groupCount == 8 && order.KnockoutCount == 4)
                    {
                        index = i % 2 == 0 ? ((groupCount - 1) - i) * order.KnockoutCount + 2 : ((groupCount - 1) - i) * order.KnockoutCount + 1;
                    }
                    //else
                    //{
                    //index = i % 2 == 0 ? (i + 1) * order.KnockoutCount + 2 : (i - 1) * order.KnockoutCount + 1;
                    //}
                    break;

                default:
                    throw new Exception("现在仅支持前2名，前4名出线淘汰赛。");
            }
            return index;
        }

        public void Test(params string[] name)
        {
            Test("s","d","s","5");
        }
    }
}