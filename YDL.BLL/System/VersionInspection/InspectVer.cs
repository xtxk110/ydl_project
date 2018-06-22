using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 客户端版本检测
    /// </summary>
    public class InspectVer_193:IService
    {
        public  Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<AppVersion>>(request);
            var temp = req.Filter;
            Response result = new Response();
            //如果不是内部测试以及PC端
            if (!req.IsInnerTest && temp.DeviceType != DeviceType.PC) {
                if (temp.ClientVer.IsNullOrEmpty())
                {
                    return ResultHelper.Fail("没有附加版本号。");
                }
                var cmd = CommandHelper.CreateText<AppVersion>(text: "SELECT TOP 1 * FROM AppVersion ORDER BY CreateDate DESC ");
                result = DbContext.GetInstance().Execute(cmd);
                AppVersion ver = result.Entities.FirstOrDefault() as AppVersion;
                int clientVer = 0;
                int.TryParse(temp.ClientVer, out clientVer);
                if(temp.DeviceType.Equals(DeviceType.IPad)|| temp.DeviceType.Equals(DeviceType.IPhone))
                {
                    if (ver.IosCode > clientVer)
                    {
                        result.Message = "发现新版本，请更新。";
                        result.ErrorCode = ErrorCode.NEW_VERSION;
                    }
                        
                }
                else if(temp.DeviceType.Equals(DeviceType.Android))
                {
                    if (ver.AndroidCode > clientVer)
                    {
                        result.Message = "发现新版本，请更新。";
                        result.ErrorCode = ErrorCode.NEW_VERSION;
                    }
                }
            }

                return result;
        }
    }
}
