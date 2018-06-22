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
    /// 保存技术类别
    /// </summary>
    public class SaveCategoryOfTechnology : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<SysDic>>(request);
            var obj = req.FirstEntity();
            if (CoachHelper.Instance.IsExistCategory(obj))
            {
                return ResultHelper.Fail("已存在此技术类别名称, 请重新输入一个新的名称");
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.Code = "";
                obj.NameIndex = GetMaxNameIndex() + 1;
                obj.Type = "CategoryOfTechnology";
                obj.TrySetNewEntity();
            }


            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return result;

        }


        public int GetMaxNameIndex()
        {
            var sql = @"
SELECT MAX(NameIndex) AS NameIndex FROM dbo.SysDic WHERE  Type='CategoryOfTechnology'
";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                var obj = result.Entities.First() as SysDic;
                return obj.NameIndex;
            }
            return 0;
        }
    }
}
