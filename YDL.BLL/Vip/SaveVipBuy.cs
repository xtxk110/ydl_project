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
    /// 保存购买记录(done)
    /// </summary>
    public class SaveVipBuy : IServiceBase
    {
        /// <summary>
        /// 保存购买记录
        /// </summary>
        /// <param name="request">实体VipBuy</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipBuy>>(request);
            var obj = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState != RowState.Deleted)
            {
                obj.CreatorId = obj.CreatorId.GetId();
                obj.UserId = obj.UserId.GetId();
                obj.PayOption = obj.PayOption.GetId();
                obj.PayState = obj.PayState.GetId();
                obj.OrderNo = SystemHelper.GetSerialNo(SerialNoType.VipBuy);
                obj.TrySetNewEntity();
                obj.CreateDate1 = (DateTime)obj.CreateDate;
            }
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess && obj.RowState == RowState.Added)
            {
                result.Tag = obj.Id;//返回主键，供下一步使用。
            }

            return result;
        }

    }

}
