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
    /// 保存集训
    /// </summary>
    public class SaveCoachBootcamp : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachBootcamp>>(request);
            var obj = req.FirstEntity();
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.State = CoachDic.BootcampUnpublish;
                obj.TrySetNewEntity();
            }
            obj.JoinDeadline = ((DateTime)obj.JoinDeadline).AddDays(1).AddMinutes(-1);
            obj.ModifyHeadIcon();
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            result.Tag = obj.Id;
            return result;

        }

    }
}
