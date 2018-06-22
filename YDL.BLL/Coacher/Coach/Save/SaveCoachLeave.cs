using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存教练请假
    /// </summary>
    public class SaveCoachLeave_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachLeave>>(request);
            var obj = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {
                obj.TrySetNewEntity();
                obj.State = AuditState.PROCESSING.Id;
            }

            obj.ModifyHeadIcon();
            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return result;
        }

    }

}
