using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using YDL.BLL;
using YDL.Model;

namespace YDL.Web.Handlers
{
    /// <summary>
    /// 上传到临时目录
    /// </summary>
    public class AnnexUploadHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            var Request = context.Request;
            var Response = context.Response;
            int statusCode = 200;
            string result = string.Empty;
            try
            {
                // 获取数据
                HttpPostedFile file = Request.Files[0];
                string extname = System.IO.Path.GetExtension(file.FileName.ToLower());
                string diskPath = null, urlPath = null;

                if (!string.IsNullOrWhiteSpace(extname))
                {
                    extname = extname.TrimStart('.');
                    if (!AnnexHelper.AllowFiles.Contains(extname))
                    {
                        statusCode = -240;
                        throw new Exception("不允许上传“*." + extname + "”类型的文件");
                    }
                    if (AnnexHelper.MaxSize < file.InputStream.Length)
                    {
                        statusCode = -110;
                        throw new Exception("文件尺寸超出大小限制(最大允许上传" + AnnexHelper.MaxSizeName + "的文件");
                    }
                    string isTemp = context.Request["isTemp"];
                    if (string.IsNullOrEmpty(isTemp))
                    {
                        isTemp = "true";
                    }
                    AnnexHelper.CreateSaveDirectory(Convert.ToBoolean(isTemp), out urlPath, out diskPath);

                    string fname = string.Format("{0}.{1}", Guid.NewGuid(), extname);

                    diskPath = System.IO.Path.Combine(diskPath, fname);
                    urlPath = urlPath + fname;

                    using (System.IO.FileStream fs = new System.IO.FileStream(diskPath, System.IO.FileMode.CreateNew))
                    {
                        byte[] buff = new byte[file.InputStream.Length];

                        file.InputStream.Position = 0;
                        file.InputStream.Read(buff, 0, buff.Length);
                        fs.Write(buff, 0, buff.Length);
                        fs.Close();
                        fs.Dispose();
                    }

                }
                statusCode = 200;
                result = urlPath;

            }
            catch (Exception ex)
            {
                statusCode = statusCode == 200 ? 500 : statusCode;
                result = ex.Message;
            }
            finally
            {
                Response.StatusCode = statusCode;
                Response.Write(result);
                Response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}