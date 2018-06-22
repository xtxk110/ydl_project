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
    /// 新建接口时,返回场次数组和参赛人员个数数组
    /// </summary>
    public class GetTempletOther_198 : IService
    {
        public Response Execute(string request)
        {
            Response res = ResultHelper.Success();
            res.Tag = new int[] { 2, 3, 4, 5, 6, 7, 8, 9 };//参赛人员个数数组
            res.Tag1 = new int[] { 3, 5, 7, 9 };//场次数组

            return res;
        }
    }
}
