using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web;
using Newtonsoft.Json;

using YDL.Core;
using YDL.Map;
using YDL.Utility;

namespace YDL.BLL
{
    public class AnnexHelper
    {
        private static string _rootPath;
        private static string _rootDiskPath;
        private static long _maxSize = -1;
        private static string _allowFiles;
        private static string _tempPath;

        public static Response GetAnnexList(string masterId)
        {
            var cmd = CommandHelper.CreateText<FileInfo>(text: "SELECT Id,MasterId,FileName,FilePath,Size,CreateDate FROM AnnexInfo WHERE MasterId=@MasterId");
            cmd.Params.Add(CommandHelper.CreateParam("@MasterId", masterId));

            return DbContext.GetInstance().Execute(cmd);
        }

        public static void PrepareAnnex(List<YDL.Model.FileInfo> files)
        {
            foreach (var annex in files)
            {
                if (annex.RowState == RowState.Added)
                {
                    annex.FilePath = AnnexHelper.ToValidDirectory(annex.FilePath);
                    annex.SetNewId();
                    annex.SetCreateDate();
                }
            }
        }

        public static Response SaveAnnex(List<YDL.Model.FileInfo> files)
        {
            PrepareAnnex(files);
            var cmd = CommandHelper.CreateSave(files);
            return DbContext.GetInstance().Execute(cmd);
        }

        public static Response DeleteAnnex(string id)
        {
            Command cmd = null;

            cmd = CommandHelper.CreateText(FetchType.Execute, "DELETE FROM FileInfo WHERE Id=@Id");
            cmd.Params.Add(CommandHelper.CreateParam("@Id", id));

            return DbContext.GetInstance().Execute(cmd);
        }

        /// <summary>
        /// 获取上传文件的最大限制
        /// </summary>
        public static long MaxSize
        {
            get
            {
                if (_maxSize == -1)
                {
                    _maxSize = long.Parse((ConfigurationManager.AppSettings["FileMaxSize"]));
                }
                return AnnexHelper._maxSize;
            }
        }
        /// <summary>
        /// 获取上传文件的最大限制显示名称
        /// </summary>
        public static string MaxSizeName
        {
            get { return GetFileSizeString(MaxSize); }
        }
        /// <summary>
        /// 获取文件尺寸字符串
        /// </summary>
        /// <param name="size"></param>
        /// <returns></returns>
        public static string GetFileSizeString(long size)
        {
            if (size < 1024)
            {
                return size + "byte";
            }

            float tmp = (float)size / 1024f;
            if (tmp < 1024f)
            {
                return Math.Round(tmp, 2) + "KB";
            }
            tmp = (float)tmp / 1024f;
            if (tmp < 1024f)
            {
                return Math.Round(tmp, 2) + "MB";
            }
            tmp = (float)tmp / 1024f;
            if (tmp < 1024f)
            {
                return Math.Round(tmp, 2) + "GB";
            }
            tmp = (float)tmp / 1024f;
            if (tmp < 1024f)
            {
                return Math.Round(tmp, 2) + "TB";
            }

            return "";

        }
        /// <summary>
        /// 获取允许上传的文件类型扩展名字符串
        /// </summary>
        public static string AllowFiles
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_allowFiles))
                {
                    _allowFiles = ConfigurationManager.AppSettings["AllowFiles"];
                }
                return AnnexHelper._allowFiles;
            }
        }
        /// <summary>
        /// 获取附件存方根路径
        /// </summary>
        public static string RootPath
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_rootPath))
                    _rootPath = System.Configuration.ConfigurationManager.AppSettings["FileFolder"];
                return _rootPath;
            }
        }

        /// <summary>
        /// 获取文件的临时存方路径
        /// </summary>
        public static string TempPath
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_tempPath))
                {
                    _tempPath = string.Format("{0}/Temp", RootPath.TrimEnd('/'));
                }
                return AnnexHelper._tempPath;
            }
        }
        /// <summary>
        /// 获取存放附件有磁盘根路径
        /// </summary>
        public static string RootDiskPath
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_rootDiskPath))
                {
                    _rootDiskPath = HttpContext.Current.Server.MapPath(RootPath);
                }
                return _rootDiskPath;
            }
        }
        /// <summary>
        /// 将URL地址转为碰盘地址
        /// </summary>
        /// <param name="urlpath"></param>
        public static string ConvertToDiskPath(string urlpath)
        {
            return HttpContext.Current.Server.MapPath(urlpath);
        }
        /// <summary>
        /// 生成文件全路径
        /// </summary>
        /// <returns></returns>
        public static string BuildFullUrlPath(string datePath)
        {
            return string.Format("{0}/{1}", RootPath.TrimEnd('/'), datePath.TrimStart('/'));
        }
        /// <summary>
        /// 获取指定的目录是否在临时目录中
        /// </summary>
        /// <param name="urlpath">Url路径</param>
        /// <returns></returns>
        public static bool IsInTemp(string urlpath)
        {
            return urlpath.ToLower().StartsWith(TempPath.ToLower());
        }

        /// <summary>
        /// 创建上传文件的保存路径
        /// </summary>
        /// <param name="isTemp">是否是临时文件</param>
        /// <param name="diskPath">文件的保存磁盘路径</param>
        /// <param name="urlPath">文件的保存磁盘路径对应的URL地址</param>
        /// <returns></returns>
        public static void CreateSaveDirectory(bool isTemp, out string urlPath, out string diskPath)
        {
            urlPath = ConfigurationManager.AppSettings["FileFolder"];
            diskPath = HttpContext.Current.Server.MapPath(urlPath);

            if (isTemp)
            {
                diskPath = System.IO.Path.Combine(diskPath, "Temp");
                urlPath = urlPath.TrimEnd('/') + "/Temp/";
            }
            var subPath = DateTime.Now.ToString("yyyyMMdd");

            diskPath = System.IO.Path.Combine(diskPath, subPath);
            urlPath = string.Format("{0}{1}/", urlPath, subPath);

            //创建目录
            if (!System.IO.Directory.Exists(diskPath))
            {
                System.IO.Directory.CreateDirectory(diskPath);
            }
            System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(diskPath);
            dir.Attributes = dir.Attributes ^ System.IO.FileAttributes.ReadOnly;


        }

        public static void RemoveFile(string filename)
        {
            if (File.Exists(filename))
            {
                var filePath = Path.GetDirectoryName(filename);
                //删除压缩文件(含压缩文件)
                if (Directory.Exists(filePath))
                {
                    foreach (var f in Directory.GetFiles(filePath, string.Format("{0}*.*", Path.GetFileNameWithoutExtension(filename))))
                    {
                        File.Delete(f);
                    }
                }
            }

        }
        /// <summary>
        /// 将临时文件拷贝到正式目录中,并返回正式文件URL
        /// </summary>
        /// <param name="urlFileName">含文件名临时文件路径</param>
        /// <returns></returns>
        public static string ToValidDirectory(string urlFileName)
        {
            if (string.IsNullOrWhiteSpace(urlFileName)) return string.Empty;
            if (!urlFileName.Contains("Temp"))
            {
                //如果不是临时目录路径则直接返回
                return urlFileName;
            }
            //如果文件存在临时目录中才处理
            if (IsInTemp(urlFileName))
            {
                //将相对路径转为磁盘路径
                var tempFile = HttpContext.Current.Server.MapPath(urlFileName);
                var fn = Path.GetFileName(tempFile);
                var datePath = DateTime.Now.ToString("yyyyMMdd");

                var toFile = Path.Combine(HttpContext.Current.Server.MapPath(RootPath), datePath, fn);//正式目录路径

                //将文件拷到正式目录中
                if (!File.Exists(toFile))
                {
                    var targetPath = Path.GetDirectoryName(toFile);
                    if (!Directory.Exists(targetPath))
                    {
                        Directory.CreateDirectory(targetPath);
                    }
                    File.Copy(tempFile, toFile, true);
                }

                try
                {
                    //删除临时文件
                    RemoveFile(tempFile);
                }
                catch (Exception)
                {
                    //吃掉异常, 有时候会出现删除时, 此文件在占用的情况导致删不掉 , 
                    //暂时不管, 删不掉就删不掉, 后面多了手动删除这个目录即可
                }


                //数据据只存yyyyMMdd/文件名
                return string.Format("{0}/{1}", datePath, fn);
            }
            else
                return urlFileName.Replace(RootPath, "").TrimStart('/');

        }

        public bool IsFileLocked(FileInfo file)
        {
            FileStream stream = null;
            try
            {
                stream = file.Open(FileMode.Open, FileAccess.Read, FileShare.None);
            }
            catch (IOException)
            {
                return true;
            }
            finally
            {
                if (stream != null)
                {
                    stream.Close();
                }
            }

            return false;
        }

    }
}
