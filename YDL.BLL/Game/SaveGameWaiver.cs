using System;
using System.Text;
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
    /// 弃权处理
    /// </summary>
    public class SaveGameWaiver : IServiceBase
    {
        /// <summary>
        /// 弃权处理
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request"></param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            return null;
        }
    }
}
