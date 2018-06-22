using System.Linq;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using RestSharp;
using System;
using YDL.Utility;
using System.Threading.Tasks;
using System.Threading;
using YDL.Core;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 导入所有俱乐部到IM群
	/// 文档：https://www.qcloud.com/document/product/269/1615
    /// 注意: 
    ///     腾讯im 应该是用的 utf-8, 三个字节存储一个汉字
    ///     Name 最长30字节 等于 10个汉字
    ///     Introduction 最长240字节 等于 80个汉字
    /// </summary>
    public class ImportClubAll : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            Response rsp = new Response();
            List<Club> listClub = GetAllClub();
            ImportClub obj = new ImportClub();
            List<Club> nameTooLong = new List<Club>();
            foreach (var item in listClub)
            {
                rsp = IMHelper.Instance.ImportExistClubToIMGroup(item.Id);

                if (rsp.Message== "group id has be used!")
                {
                    continue;
                }

                if (rsp.Message== "group name is too long" || rsp.Message== "introduction is too long")
                {
                    nameTooLong.Add(item);
                    continue;
                }

                if (rsp.IsSuccess==false)
                {
                    continue;
                }
                Thread.Sleep(100);
            }
            rsp.Entities.AddRange(nameTooLong);
            return rsp;
        }


        public List<Club> GetAllClub()
        {
            var sql = @"
SELECT * FROM dbo.Club
";
            var cmd = CommandHelper.CreateText<Club>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, Club>();
        }
 

    }
}
