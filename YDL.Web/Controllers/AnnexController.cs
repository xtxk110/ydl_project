using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YDL.BLL;
using YDL.Utility;
using System.Runtime.Serialization;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;

namespace YDL.Web
{
    public class AnnexController : ControllerFree
    {
        /// <summary>
        /// 二维码图片
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [HttpGet]
        public FileResult imgqr(string code)
        {
            if (code.IsNotNullOrEmpty())
            {
                try
                {
                    var filename = string.Format("{0}/qrcode/{1}.png", AnnexHelper.RootPath, code);
                    var soureName = Server.MapPath(filename);
                    if (!System.IO.File.Exists(soureName))
                    {
                        using (var ms = new MemoryStream())
                        {
                            if (GetQRCode(code, ms))
                            {
                                Image img = Image.FromStream(ms);
                                img.Save(filename);
                            }
                        }
                    }
                    return File(soureName, "image/png");
                }
                catch (Exception)
                {
                }
            }
            return null;
        }

        /// <summary>
        /// 获取二维码
        /// </summary>
        /// <param name="code">待编码的字符</param>
        /// <param name="ms">输出流</param>
        ///<returns>True if the encoding succeeded, false if the content is empty or too large to fit in a QR code</returns>
        private static bool GetQRCode(string code, MemoryStream ms)
        {
            var encoder = new QrEncoder(ErrorCorrectionLevel.M);
            QrCode qr;
            if (encoder.TryEncode(code, out qr))//对内容进行编码，并保存生成的矩阵
            {
                var render = new GraphicsRenderer(new FixedModuleSize(4, QuietZoneModules.Two));//大小33*4
                render.WriteToStream(qr.Matrix, ImageFormat.Png, ms);
            }
            else
            {
                return false;
            }
            return true;

        }

        ///<summary>查看指定地址的图片,并指定一个压缩尺寸</summary>
        /// <param name="picurl">图片地址URL</param>
        /// <param name="height">压缩成指定高度的图片</param>
        /// <param name="width">压缩成指定宽度的图片</param>
        [HttpGet]
        public FileResult img(string picurl, int? width, int? height)
        {
            Response.Clear();
            //首先检测客户端有无缓存，有则直接返回
            if (Request.Headers["If-Modified-Since"] != null && TimeSpan.FromTicks(DateTime.Now.Ticks - DateTime.Parse(Request.Headers["If-Modified-Since"]).Ticks).Seconds < 100)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.NotModified;//304表示图片没有被修改过
                Response.AddHeader("Content-Encoding", "gzip");
                Response.StatusDescription = "Not Modified";
                return null;
            }

            string sourceFileName = string.Empty;
            //是否是空图片
            if (string.IsNullOrWhiteSpace(picurl))
            {
                return null;
            }

            if (!picurl.StartsWith(AnnexHelper.RootPath))
                picurl = AnnexHelper.RootPath + "/" + picurl;

            sourceFileName = Server.MapPath(picurl);
            //图片是否存在
            if (!System.IO.File.Exists(sourceFileName))
            {
                return null;
            }
            //根据指定宽度、高度和50%的质量压缩
            sourceFileName = PictureHelper.GetPicThumbnail(sourceFileName, height, width, 50);
            if (string.IsNullOrEmpty(sourceFileName))
                return null;

            string extName = System.IO.Path.GetExtension(sourceFileName).Replace(".", "");
            string contentType = PictureHelper.GetMimeType(extName);


            Response.AddFileDependency(sourceFileName);
            //Response.Cache.SetETagFromFileDependencies();
            Response.Cache.SetLastModifiedFromFileDependencies();
            Response.Cache.SetCacheability(System.Web.HttpCacheability.Public);
            Response.Cache.SetMaxAge(new TimeSpan(365, 0, 0, 0));
            Response.Cache.SetExpires(DateTime.Now.AddYears(1));
            Response.Cache.SetSlidingExpiration(true);

            Response.AddHeader("Content-Type", contentType);

            return File(sourceFileName, contentType);

        }
    }
}