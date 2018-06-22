using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 解析二维码
    /// </summary>
    public class AnalysisQRCode : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<QRCode>>(request);
            var obj = req.Filter;
            var sql = @"
SELECT * FROM dbo.QRCode WHERE Id=@QRCodeId
";
            var cmd = CommandHelper.CreateText<QRCode>(FetchType.Fetch, sql);
            cmd.Params.Add("@QRCodeId ", obj.QRCodeId);
            var result = DbContext.GetInstance().Execute(cmd);
            //扫描次数加1
            if (result.Entities.Count > 0)
            {
                AddScanCount(result.Entities.First() as QRCode);
            }

            return result;


        }

        public Response AddScanCount(QRCode obj)
        {
            var sql = @"
UPDATE dbo.QRCode SET ScanCount=ScanCount+1 , ScanTime=@ScanTime 
WHERE MasterId=@MasterId  
    AND ActionType=@ActionType AND BusinessType=@BusinessType
";
            var cmd = CommandHelper.CreateText<QRCode>(FetchType.Execute, sql);
            cmd.Params.Add("@MasterId", obj.MasterId);
            cmd.Params.Add("@ActionType", obj.ActionType);
            cmd.Params.Add("@BusinessType", obj.BusinessType);
            cmd.Params.Add("@ScanTime", DateTime.Now);
            return DbContext.GetInstance().Execute(cmd);
        }

    }
}
