using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 保存图片关系 (覆盖操作)
    /// </summary>
    public class SaveImagesRelation : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            //此接口需要传两个值
            //Id 是 某个对象主键 比如 (课程的Id)
            //Files 是这个 Id 要关联的 文件列表  
            var req = JsonConvert.DeserializeObject<Request<HeadBase>>(request);
            var obj = req.FirstEntity();
            List<EntityBase> entites = new List<EntityBase>();
          
            if (obj.RowState == RowState.Added)
            {
                //obj.TrySetNewEntity();
            }

            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            //返回保存后的正式Url 列表
            obj.TryGetFiles();
            result.Entities = obj.Files.ToList<FileInfo, EntityBase>();
            return result;

        }



    }
}
