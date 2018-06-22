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
    /// 是否已注册 (done)
    /// </summary>
    public class IsRegistered_184 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            string sql = @"
SELECT * FROM dbo.UserAccount WHERE Mobile =@Mobile
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@Mobile", req.Filter.Mobile);

            var result = DbContext.GetInstance().Execute(cmd);

            if (result.Entities.Count > 0)
            {
                result.Tag = true;
                User user = result.FirstEntity<User>();
                user.PetName = DealStar(user.PetName);
                result.Entities.Clear();
                result.Entities.Add(user);
                return result;
            }
            else
            {
                result.Tag = false;
                return result;
            }

        }

        public string DealStar(string PetName)
        {
            if (PetName.Length == 1)
            {
                return PetName;
            }
            else if (PetName.Length == 2)
            {
                return PetName.Substring(0, 1) + "*";
            }
            else if (PetName.Length > 2)
            {
                char first = PetName.First();
                char last = PetName.Last();
                string star = "";
                for (int i = 0; i < PetName.Length - 2; i++)
                {
                    star += "*";
                }

                return first + star + last;
            }
            return "";

        }

    }
}
