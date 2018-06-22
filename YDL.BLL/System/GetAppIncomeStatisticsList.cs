using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取app收入统计(done)
    /// </summary>
    public class GetAppIncomeStatisticsList : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipBuyListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipBuy>(text: "GetAppIncomeStatisticsList");
            cmd.Params.Add(CommandHelper.CreateParam("@BeginTime", req.Filter.BeginDate));
            cmd.Params.Add(CommandHelper.CreateParam("@EndTime", req.Filter.EndDate));
            cmd.Params.Add(CommandHelper.CreateParam("@PayOption", req.Filter.PayOption));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            result.Tag = GetTotalAmount(req);

            return result;

        }

        /// <summary>
        /// 获取总共收入
        /// </summary>
        /// <returns></returns>
        public decimal GetTotalAmount(Request<GetVipBuyListFilter> req)
        {
            var sql = @"
SELECT 
    SUM(a.Amount) AS Amount
FROM(   
				SELECT  
					a.OrderNo,
					a.CreateDate,
					a.Amount ,
					a.PayOption,
					a.PayState,
					a.Remark
				FROM dbo.VipBuy a
				INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
				WHERE PayState='024002'  
				UNION ALL
				SELECT  
					a.OrderNo,
					a.CreateDate,
					a.Amount ,
					a.PayOption,
					a.PayState,
					a.Remark
				FROM dbo.VipUse a
				INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
				WHERE PayState='024002'  AND (a.PayOption='023002' OR a.PayOption='023004')
			) a
WHERE 1=1

";
            if (!string.IsNullOrEmpty(req.Filter.PayOption))
            {
                sql += " AND a.PayOption = @PayOption ";
            }
            if (req.Filter.BeginDate.HasValue && req.Filter.EndDate.HasValue)
            {
                sql += " AND a.CreateDate >= @BeginTime AND a.CreateDate <= @EndTime ";
            }
            var cmd = CommandHelper.CreateText<VipBuy>(FetchType.Fetch, sql);
            cmd.Params.Add(CommandHelper.CreateParam("@BeginTime", req.Filter.BeginDate));
            cmd.Params.Add(CommandHelper.CreateParam("@EndTime", req.Filter.EndDate));
            cmd.Params.Add(CommandHelper.CreateParam("@PayOption", req.Filter.PayOption));

            var result = DbContext.GetInstance().Execute(cmd);
            var vipbuy = result.FirstEntity<VipBuy>() ?? new VipBuy();
            return vipbuy.Amount;
        }
    }
}
