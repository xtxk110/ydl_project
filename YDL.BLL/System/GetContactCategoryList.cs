using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取联系人类别列表
    /// </summary>
    public class GetContactCategoryList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var cmd = CommandHelper.CreateProcedure<ContactCategory>(text: "sp_GetContactCategoryList");
            cmd.CreateParamUser(currentUser.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }



}
