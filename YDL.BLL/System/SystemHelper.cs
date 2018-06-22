using System.Collections.Generic;
using System;
using System.Linq;

using YDL.Core;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;
using System.Net;
using System.IO;
using System.Drawing;
using System.Web;
using System.Drawing.Imaging;
using RestSharp;
using System.Configuration;

namespace YDL.BLL
{
    public class SystemHelper
    {
        public static SystemHelper Instance = new SystemHelper();

        public string DownloadImageFromURL(string headUrl)
        {
            if (string.IsNullOrEmpty(headUrl))
            {
                return "";
            }

            string fileNameForDb = "";
            using (WebClient webClient = new WebClient())
            {
                byte[] data = webClient.DownloadData(headUrl);

                using (MemoryStream mem = new MemoryStream(data))
                {
                    using (var yourImage = Image.FromStream(mem))
                    {
                        //构建头像路径和名称
                        var fn = Ext.NewId() + ".jpg";
                        var datePath = DateTime.Now.ToString("yyyyMMdd");

                        var fileNameAndPath = Path.Combine(HttpContext.Current.Server
                            .MapPath(AnnexHelper.RootPath), datePath, fn);
                        fileNameForDb = Path.Combine(datePath, fn).Replace(@"\", @"/");
                        //如果目录不存在就创建目录
                        var targetPath = Path.GetDirectoryName(fileNameAndPath);
                        if (!Directory.Exists(targetPath))
                        {
                            Directory.CreateDirectory(targetPath);
                        }
                        //保存头像
                        yourImage.Save(fileNameAndPath, ImageFormat.Jpeg);
                    }
                }

            }

            return fileNameForDb;
        }
        public static MobileValCode GetValCode(string mobile)
        {
            var cmdLoop = CommandHelper.CreateText<YDL.Model.MobileValCode>(text: "SELECT Id,Code FROM dbo.MobileValCode WHERE Id=@mobile");
            cmdLoop.Params.Add(CommandHelper.CreateParam("@mobile", mobile));
            return DbContext.GetInstance().Execute(cmdLoop).Entities.FirstOrDefault() as MobileValCode;
        }

        public static string GetSerialNo(SerialNoType type)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_GetSerialNo");
            cmd.Params.Add(CommandHelper.CreateParam("@id", type.ToString()));
            return DbContext.GetInstance().Execute(cmd).Tag as string;
        }

        public static bool HasNewVersion(string deviceType, string deviceVersion)
        {
            var app = UserHelper.GetAppVersion();
            switch (deviceType)
            {
                case DeviceType.Android:
                    if (app.AndroidCode > Convert.ToInt32(deviceVersion))
                    {
                        return true;
                    }
                    break;

                case DeviceType.IPhone:
                case DeviceType.IPad:
                    if (app.IosCode > Convert.ToInt32(deviceVersion))
                    {
                        return true;
                    }
                    break;

                default:
                    break;
            }

            return false;
        }

        public static string appid = ConfigurationManager.AppSettings["appid"];
        public static string secret = ConfigurationManager.AppSettings["secret"];

        public WeiXinUserInfo getWeiXinUserInfo(string code)
        {
            RestClient client = new RestClient();
            client.BaseUrl = new Uri("https://api.weixin.qq.com/sns/");
            var reqRestToken = new RestRequest("oauth2/access_token", Method.GET);
            string tokenUrl = "?appid=" + appid + "&secret=" + secret + "&code=" + code + "&grant_type=authorization_code";
            reqRestToken.Resource += tokenUrl;
            var rsp = client.Execute<WeiXinUserInfo>(reqRestToken);
            var objToken = JsonConvert.DeserializeObject<WeiXinUserInfo>(rsp.Content);

            var reqUserInfo = new RestRequest("userinfo", Method.GET);
            string reqUserInfoUrl = "?access_token=" + objToken.access_token + "&openid=" + objToken.openid;
            reqUserInfo.Resource += reqUserInfoUrl;
            var rspUserInfo = client.Execute<WeiXinUserInfo>(reqUserInfo);
            return JsonConvert.DeserializeObject<WeiXinUserInfo>(rspUserInfo.Content);
        }

        public SysDic GetSysDicById(string Id)
        {
            var sql = @"
SELECT * FROM dbo.SysDic WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<SysDic>();
        }

        /// <summary>
        /// 检查响应结果是否出错, 出错就抛出异常,供前端显示或记录日志
        /// </summary>
        public static void CheckResponseIfError(Response rsp)
        {
            if (!rsp.IsSuccess)
            {
                throw new Exception(rsp.Message);
            }
        }

        /// <summary>
        /// 插入实体到数据库
        /// </summary>
        /// <param name="obj"></param>
        public void InsertEntity(EntityBase obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Added;
            obj.TrySetNewEntity();
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            CheckResponseIfError(result);
        }

        /// <summary>
        /// 修改实体
        /// </summary>
        /// <param name="obj"></param>
        public void UpdateEntity(EntityBase obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Modified;
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            CheckResponseIfError(result);
        }


        /// <summary>
        /// 在数据库删除实体
        /// </summary>
        /// <param name="obj"></param>
        public void DeleteEntity(EntityBase obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Deleted;
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            CheckResponseIfError(result);
        }

    }
}
