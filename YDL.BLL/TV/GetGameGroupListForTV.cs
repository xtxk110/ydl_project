﻿using System;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Map;
using YDL.Utility;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛小组列表
    /// </summary>
    public class GetGameGroupListForTV 
    {
      
        public static Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameGroupListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<GameGroup>(FetchType.Fetch, "sp_GetGameGroupList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", req.Filter.GroupId));
            var result = DbContext.GetInstance().Execute(cmd);

            if (req.Filter.IsContainMember)
            {
                foreach (var group in result.Entities)
                {
                    GameHelper.SetGroupMemberList(group as GameGroup);
                }
            }

            return result;
        }

    }
}