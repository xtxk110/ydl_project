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
    /// 保存用户信息
    /// </summary>
    public class SaveClub : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Club>>(request);
            var club = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(club);
            if (club.RowState == RowState.Added)
            {
                club.TrySetNewEntity();
                club.CreatorId = currentUser.Id;
                //新建的时候要把创建人加入到成员表中
                entites.Add(createClubUser(currentUser, club));
            }
            //注册账号需要验证重复性
            var result = Validate(club);
            if (result.Entities.IsNotNullOrEmpty())
            {
                var obj = result.Entities.FirstOrDefault() as Club;
                return ResultHelper.Fail(string.Format("{0}已经存在[{1}]俱乐部名称。", obj.CityId, obj.Name));
            }

            club.ModifyHeadIcon();

            //获取将要保存的图片列表
            club.GetWillSaveFileList(entites);


            //活动场地，先删除，再保存
            var cmdSave = CommandHelper.CreateSave(entites);
            var cmdDeleteVenue = CommandHelper.CreateText(FetchType.Execute, "DELETE FROM ClubAddress WHERE ClubId=@clubId");
            cmdDeleteVenue.Params.Add("@clubId", club.Id);
            cmdSave.PreCommands = new List<Command> { cmdDeleteVenue };

            if (club.ClubAddressList.IsNotNullOrEmpty())
            {
                foreach (var obj in club.ClubAddressList)
                {
                    obj.SetNewEntity();
                    obj.ClubId = club.Id;
                    obj.VenueId = obj.VenueId.GetId();
                    entites.Add(obj);
                }
            }
            result = DbContext.GetInstance().Execute(cmdSave);
            if (result.IsSuccess)
            {
                //同步信息到IM群
                result = SynchronizeClubToIMGroup(club);
            }
            return result;
        }

        //同步俱乐部到IM群
		//如果要放开 俱乐部名称和介绍的长度限制,可以试着取消这两个字段的同步, 但需要和客服端目前他们没有依赖这两个字段
        public Response SynchronizeClubToIMGroup(Club obj)
        {
            Response rsp = new Response();
            if (obj.RowState == RowState.Added)
            {
                rsp = IMHelper.Instance.ImportExistClubToIMGroup(obj.Id);
            }
            else if (obj.RowState == RowState.Modified)
            {
                rsp = IMHelper.Instance.UpdateIMGroup(obj);
            }
            return rsp;
        }

        private static Response Validate(Club club)
        {
            var cmdVal = CommandHelper.CreateText<Club>(text: "SELECT a.Name,b.Name AS CityId FROM Club a INNER JOIN City b ON  a.CityId=b.Id WHERE a.Name=@Name AND a.CityId=@CityId AND a.Id!=@Id");
            cmdVal.Params.Add(CommandHelper.CreateParam("@Name", club.Name));
            cmdVal.Params.Add(CommandHelper.CreateParam("@CityId", club.CityId));
            cmdVal.Params.Add(CommandHelper.CreateParam("@Id", club.Id));
            var result = DbContext.GetInstance().Execute(cmdVal);
            return result;
        }

        private static ClubUser createClubUser(User currentUser, Club club)
        {
            ClubUser user = new ClubUser();
            user.SetNewId();
            user.SetCreateDate();
            user.SetRowAdded();
            user.ClubId = club.Id;
            user.UserId = currentUser.Id;
            user.Score = 0;
            user.PetName = currentUser.PetName;
            user.IsCreator = true;
            user.IsAdmin = true;
            user.LevelValue = 3;
            return user;
        }
    }

}
