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
    /// 保存充值配送比率
    /// </summary>
    public class SaveVipRechargeScale : IService
    {
        /// <summary>
        /// 保存充值配送比率
        /// </summary>
        /// <param name="request">实体VipRechargeScale</param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipRechargeScale>>(request);
            var temp = req.Entities.OrderBy(p => p.Min).ToList();
            if (temp.Count == 0)
            {
                return ResultHelper.Fail("无数据。");
            }

            for (int i = 0; i < temp.Count; i++)
            {
                var obj = temp[i];
                if (obj.Min >= obj.Max)
                {
                    return ResultHelper.Fail("开始金额必须小于结束金额。");
                }

                if (i > 0 && obj.Min != temp[i - 1].Max + 1)
                {
                    return ResultHelper.Fail("开始金额必须等于前一区间的结束金额加1。");
                }

                obj.CreatorId = obj.CreatorId.GetId();
                obj.RowState = RowState.Added;
                if (obj.Id.IsNullOrEmpty())
                {
                    obj.TrySetNewEntity();
                    obj.LastDate = (DateTime)obj.CreateDate;
                }
                else
                {
                    obj.LastDate = DateTime.Now;
                }
            }

            var cmd = CommandHelper.CreateSave(req.Entities);
            var cmdDelete = CommandHelper.CreateText(FetchType.Execute, "DELETE FROM VipRechargeScale");
            cmd.PreCommands = new List<Command> { cmdDelete };

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

    }

}
