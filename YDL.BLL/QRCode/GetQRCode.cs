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
    /// 获取二维码
    /// </summary>
    public class GetQRCode : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<QRCode>>(request);
            var obj = req.Filter;
            Response rsp = new Response();
            QRCode qrcode = new QRCode();
            string qrcodeId = GetQRCodeIdByMasterId(obj);
            if (!string.IsNullOrEmpty(qrcodeId))
            {
                //已存在直接返回
                //UpdateQRCode(obj);
                qrcode.QRCodeId = qrcodeId;
            }
            else
            {
                //不存在, 则添加
                qrcode.QRCodeId = AddQRCode(obj);
            }

            rsp.Entities = new List<EntityBase>();
            rsp.Entities.Add(qrcode);
            rsp.IsSuccess = true;
            return rsp;
        }

        public string AddQRCode(QRCode obj)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Added;
            obj.ScanCount = 0;
            obj.ScanTime = DateTime.Now;
            obj.TrySetNewEntity();

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return obj.Id;
        }


        //        public Response UpdateQRCode(QRCode obj)
        //        {
        //            var sql = @"
        //UPDATE [dbo].[QRCode]
        //   SET 
        //      [ActionType] = @ActionType,
        //      [ClassName] = @ClassName,
        //      [ActionTypeValue] =@ActionTypeValue
        // WHERE  MasterId=@MasterId";
        //            var cmd = CommandHelper.CreateText<QRCode>(FetchType.Execute, sql);
        //            cmd.Params.Add("@ActionType", obj.ActionType);
        //            cmd.Params.Add("@ClassName", obj.ClassName);
        //            cmd.Params.Add("@ActionTypeValue", obj.ActionTypeValue);
        //            cmd.Params.Add("@MasterId", obj.MasterId);

        //            var result = DbContext.GetInstance().Execute(cmd);
        //            return result;
        //        }

        public string GetQRCodeIdByMasterId(QRCode obj)
        {
            if (string.IsNullOrEmpty(obj.MasterId))
            {
                return null;
            }

            string sql = "";
            sql = @"
SELECT Id FROM dbo.QRCode 
WHERE MasterId=@MasterId  
    AND ActionType=@ActionType AND BusinessType=@BusinessType
";
            var cmd = CommandHelper.CreateText<QRCode>(FetchType.Fetch, sql);
            cmd.Params.Add("@MasterId", obj.MasterId);
            cmd.Params.Add("@ActionType", obj.ActionType);
            cmd.Params.Add("@BusinessType", obj.BusinessType);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return result.Entities.First().Id;
            }
            else
            {
                return null;
            }

        }
    }
}
