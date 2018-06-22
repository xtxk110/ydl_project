using System;
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
    /// 保存场地信息
    /// </summary>
    public class SaveVenue : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Venue>>(request);
            var obj = req.Entities.FirstOrDefault();

            obj.SportId = obj.SportId.GetId();
            obj.CityId = obj.CityId.GetId();
            if (string.IsNullOrEmpty(obj.CityId))
            {
                return ResultHelper.Fail("场地所在城市字段, 不能为空 ");
            }
            obj.CreatorId = obj.CreatorId.GetId();
            obj.AdminId = obj.AdminId.GetId();
            if(string.IsNullOrEmpty(obj.AdminId))//新需求,假如管理员ID,不存在,就设置为创建者ID
                obj.AdminId= obj.CreatorId.GetId();
            //一个人只能是一个场馆的管理员(二维码模块场馆收款, 东哥定的需求)
            //if (IsAdminIdRepeat(obj))//取消管理员设定限制(东哥,新需求)20180514 zq
            //{
                //return ResultHelper.Fail("您选择的场馆管理员已是其他场馆的管理员 , 请换一个 ");
            //}
            obj.State = obj.State.GetId();
            obj.CompanyId = obj.CompanyId.GetId();


            var cmd = CommandHelper.CreateText(FetchType.Scalar, "SELECT COUNT(*) FROM Venue a WHERE a.Name=@Name AND a.Id!=ISNULL(@Id,'')");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", obj.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@Id", obj.Id));
            var result = DbContext.GetInstance().Execute(cmd);
            if ((int)result.Tag > 0)
            {
                return ResultHelper.Fail("场馆名称已存在。");
            }

            List<EntityBase> entities = new List<EntityBase>();
            //注册账号需要验证重复性
            if (obj.RowState == RowState.Added)
            {
                obj.SetNewId();
                obj.SetCreateDate();

                //机构新增场馆时，自动签约、自动获取VIP标记
                if (obj.CompanyId.IsNotNullOrEmpty())
                {
                    obj.IsUseVip = true;
                    obj.State = AuditState.PASS.Id;

                    var comVenue = new CompanyVenues();
                    comVenue.SetNewId();
                    comVenue.SetCreateDate();
                    comVenue.SetRowAdded();

                    comVenue.CompanyId = obj.CompanyId;
                    comVenue.VenueId = obj.Id;

                    entities.Add(comVenue);
                }
            }

            obj.ModifyHeadIcon();

            entities.Add(obj);

            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entities);


            var resultFinal = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entities));
            return resultFinal;

        }

        public bool IsAdminIdRepeat(Venue obj)
        {
            string sql = "";
            sql = @"
SELECT * 
FROM dbo.Venue 
WHERE AdminId =@AdminId  
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id";
            }
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@AdminId", obj.AdminId);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
    }

}
