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
    /// 获取我能使用的团体模板的总数
    /// </summary>
    public class GetMyTempletCount_198 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var res = GameLoopTempletHelper.GetTempletList(currentUser.Id, "", 2);
            res.SetRowCount();
            return res;
        }
    }
}
