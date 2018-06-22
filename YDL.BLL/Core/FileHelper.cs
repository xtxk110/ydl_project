using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 附件，头像操作帮助类
    /// </summary>
    public static class FileHelper
    {
        /// <summary>
        /// 获取文件列表
        /// </summary>
        /// <param name="obj"></param>
        public static void TryGetFiles(this HeadBase obj)
        {
            var cmd = CommandHelper.CreateText<FileInfo>(text: "SELECT * FROM FileInfo WHERE MasterId=@masterId ");
            cmd.Params.Add("@masterId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.IsNotNullOrEmpty())
            {
                obj.Files = result.Entities.ToList<EntityBase, FileInfo>();
            }
        }

        /// <summary>
        /// 获取文件列表(根据业务类型获取)
        /// </summary>
        /// <param name="obj"></param>
        public static void GetFilesByModule(this HeadBase obj, string businessType)
        {
            var cmd = CommandHelper.CreateText<FileInfo>(
                text: "SELECT * FROM FileInfo WHERE MasterId=@masterId AND MasterType=@masterType ");
            cmd.Params.Add("@masterId", obj.Id);
            cmd.Params.Add("@masterType", businessType);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.IsNotNullOrEmpty())
            {
                obj.Files = result.Entities.ToList<EntityBase, FileInfo>();
                obj.FileCount = result.Entities.Count;
            }
        }

        /// <summary>
        /// 新建或者修改头像
        /// </summary>
        /// <param name="obj"></param>
        public static void ModifyHeadIcon(this HeadBase obj)
        {
            if (obj.HeadUrl.IsNotNullOrEmpty() && obj.HeadUrl != obj.HeadUrlOld)
            {
                obj.HeadUrl = AnnexHelper.ToValidDirectory(obj.HeadUrl);
            }
        }

        /// <summary>
        /// 临时图片copy 到正式目录
        /// </summary>
        /// <param name="obj"></param>
        public static void TempToOfficial(this HeadBase obj)
        {
            if (obj.HeadUrl.IsNotNullOrEmpty() && obj.HeadUrl != obj.HeadUrlOld)
            {
                obj.HeadUrl = AnnexHelper.ToValidDirectory(obj.HeadUrl);
            }
        }

        /// <summary>
        /// 获取将要保存的文件列表
        /// 逻辑: 将前端传来的临时文件URL列表转换成正式文件URL列表, 并添加到 entities 实体, 待会统一保存
        /// </summary>
        public static void GetWillSaveFileList(this HeadBase obj, List<EntityBase> entities)
        {
            if (obj.Files.IsNotNull())
            {
                var fileList = obj.ModifyFiles();//逻辑: 将传来的临时URL 转成正式的URL 
                if (fileList.Count > 0)
                {
                    entities.AddRange(fileList);
                }
            }
        }


        /// <summary>
        /// 处理新建附件，并且返回对象集合供更新
        /// 逻辑: 将传来的临时URL 转成正式的URL , 并把这些正式的URL和主体(如课程Id)的关系 , 存到 FileInfo表, 这样后面通过课程Id就可以查到他的文件列表了
        /// </summary>
        /// <param name="obj"></param>
        public static List<EntityBase> ModifyFiles(this HeadBase obj)
        {
            //删除原来所有附件信息
            var cmd = CommandHelper.CreateText(FetchType.Execute, text: "DELETE FROM FileInfo WHERE MasterId=@masterId");
            cmd.Params.Add("@masterId", obj.Id);
            DbContext.GetInstance().Execute(cmd);

            List<EntityBase> result = new List<EntityBase>();
            foreach (var file in obj.Files)
            {
                if (file.RowState == RowState.Added)
                {
                    //新的文件 
                    file.TrySetNewEntity();
                    file.MasterId = obj.Id;
                    file.FilePath = AnnexHelper.ToValidDirectory(file.FilePath);
                }
                else
                {
                    //以前的文件 
                    file.MasterId = obj.Id;
                    file.SetRowAdded();
                }
                result.Add(file);
            }
            return result;
        }


        /// <summary>
        /// 获取将要保存的文件列表(根据MasterType操作)
        /// 逻辑: 将前端传来的临时文件URL列表转换成正式文件URL列表, 并添加到 entities 实体, 待会统一保存
        /// </summary>
        public static void GetWillSaveFileListByModule(this HeadBase obj, List<EntityBase> entities, string businessType)
        {
            if (obj.Files.IsNotNull())
            {
                var fileList = obj.ModifyFilesByModule(businessType);//逻辑: 将传来的临时URL 转成正式的URL 
                if (fileList.Count > 0)
                {
                    entities.AddRange(fileList);
                }
            }
        }

        /// <summary>
        /// 处理新建附件，并且返回对象集合供更新 (根据MasterType操作)
        /// 逻辑: 将传来的临时URL 转成正式的URL , 并把这些正式的URL和主体(如课程Id)的关系 , 存到 FileInfo表, 这样后面通过课程Id就可以查到他的文件列表了
        /// </summary>
        /// <param name="obj"></param>
        public static List<EntityBase> ModifyFilesByModule(this HeadBase obj, string businessType)
        {
            //删除原来所有附件信息
            var cmd = CommandHelper.CreateText(FetchType.Execute,
                text: "DELETE FROM FileInfo WHERE MasterId=@masterId AND MasterType=@masterType");
            cmd.Params.Add("@masterId", obj.Id);
            cmd.Params.Add("@masterType", businessType);

            DbContext.GetInstance().Execute(cmd);

            List<EntityBase> result = new List<EntityBase>();
            foreach (var file in obj.Files)
            {
                if (file.RowState == RowState.Added)
                {
                    //新的文件 
                    file.TrySetNewEntity();
                    file.MasterId = obj.Id;
                    file.MasterType = businessType;
                    file.FilePath = AnnexHelper.ToValidDirectory(file.FilePath);
                }
                else
                {
                    //以前的文件 
                    file.SetRowAdded();
                    file.TrySetNewEntity();
                    file.MasterId = obj.Id;
                    file.MasterType = businessType;

                }
                result.Add(file);
            }
            return result;
        }

    }
}
