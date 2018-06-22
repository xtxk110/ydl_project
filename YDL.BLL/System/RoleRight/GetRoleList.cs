using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    public class GetRoleList_196 : IService
    {
        public Response Execute(string request)
        {
            string sqlStr = @"SELECT * FROM LimitRole";// WHERE Id != '000002'
            var cmd = CommandHelper.CreateText<LimitRole>(FetchType.Fetch, sqlStr);
            var resp= DbContext.GetInstance().Execute(cmd);
            return resp;
        }
    }
}
