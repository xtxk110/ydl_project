using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using Newtonsoft.Json;
using YDL.Core;
using System.Configuration;

namespace YDL.BLL
{
    /// <summary>
    /// 团体对阵模板增 删  改
    /// </summary>
  public  class SaveGameLoopTemple_198 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTemplet>>(request);
            GameTeamLoopTemplet templet = req.FirstEntity();
            Response res = null;
            Command cmd = null;
            if(templet.RowState==RowState.Added || templet.RowState == RowState.Modified)
            {
                if (templet.PersonCount <= 0 || templet.PersonCount > 9)
                    return ResultHelper.Fail("上场人数不超过9人");
                if (templet.LoopCount <= 0 || templet.LoopCount > 9)
                    return ResultHelper.Fail("总对阵场数不超过9场");
            }

            if (templet.RowState == RowState.Added)//新增,
            {
                //假如上传基于模板ID,判断是否基于已有模板创建,不检查同名
                if (string.IsNullOrEmpty(templet.Id)) {
                    if (GameLoopTempletHelper.IsExistTemplet(templet.Name, false))
                        return ResultHelper.Fail("对阵模板重名");
                }
                else
                {
                    templet.Name = GameLoopTempletHelper.GetNewTempletName(templet.Name);//模板名称基于上个模板递增序号
                }
                    
                if (templet.Detail.Count <= 0)
                    return ResultHelper.Fail("缺少模板规则");
                templet.SetNewEntity();
                res= AddTemplet(templet, currentUser, true);
                res.Tag = false;
                res.Entities.Add(templet);
                return res;
            }else 
            {
                GameTeamLoopTemplet temp = GameLoopTempletHelper.GetTemplet(templet.Id);//获取对阵模板对象
                if(temp.CreatorId !=currentUser.Id)
                    return ResultHelper.Fail("不能修改或删除非自己创建的模板");   

                if (templet.RowState == RowState.Modified)//修改
                {
                    
                    if (GameLoopTempletHelper.IsUseTemplet(templet.Id))//模板在使用中,直接按内容新建模板
                    {
                        templet.SetNewEntity();
                        templet.RowState = RowState.Added;
                        templet.Name = GameLoopTempletHelper.GetNewTempletName(templet.Name);
                        res = AddTemplet(templet, currentUser,true);
                        if (res.IsSuccess)
                        {
                            res.Message = "模板在使用中,已保存为新的模板【" + templet.Name + "】";
                            res.Tag = true;//修改正在使用的模板保存,些值为true
                        }
                        

                        return res;

                    }
                    ///先删除对应模板ID所有的规则详情
                    string delSql = @"DELETE FROM GameTeamLoopTempletDetail WHERE TempletId=@templetId";
                    cmd = CommandHelper.CreateText(FetchType.Execute, delSql);
                    cmd.Params.Add("@templetId", templet.Id);
                    DbContext.GetInstance().Execute(cmd);
                    
                    ////////////////////////////////////////////////////////////
                    var entities = GameLoopTempletHelper.GetTemplets(templet.Name);//通过新名称检查模板
                    if (entities.Count > 0)
                    { var temp1 = entities[0] as GameTeamLoopTemplet;
                        if (temp1.Id != templet.Id)//假如有同名但是模板id与修改的模板ID不同
                        {
                            return ResultHelper.Fail("已存在相同名称对阵模板");
                        }
                    }
                    templet.SetCreateDate();
                    res = AddTemplet(templet, currentUser,false);
                    res.Tag = false;

                }
                else if (templet.RowState == RowState.Deleted)//删除
                {
                    if (GameLoopTempletHelper.IsUseTemplet(templet.Id))
                    {
                        res = ResultHelper.Fail("模板已被使用,不能删除");
                        res.Tag = false;
                        return res;
                    }
                    string delSql = @"DELETE FROM GameTeamLoopTemplet WHERE Id=@templetId  DELETE FROM GameTeamLoopTempletDetail WHERE TempletId=@templetId";
                    cmd = CommandHelper.CreateText(FetchType.Execute, delSql);
                    cmd.Params.Add("@templetId", templet.Id);
                    res = DbContext.GetInstance().Execute(cmd);
                    res.Tag = false;
                }
            }

            return res;
        }
        /// <summary>
        /// 保存实体模板
        /// </summary>
        /// <param name="templet"></param>
        /// <param name="currentUser"></param>
        /// <param name="flag">新增为true;纯修改为false</param>
        /// <returns></returns>
        private Response AddTemplet(GameTeamLoopTemplet templet,User currentUser,bool flag)
        {
            /////每个用户最多创建多少条模板,适当减少垃圾数据
            if (flag)
            {
                int maxCount = 10;//默认,配置文件读取错误
                try
                {
                    maxCount = int.Parse(ConfigurationManager.AppSettings["TempletMaxCount"]);
                }
                catch { }
                int templetCount = GameLoopTempletHelper.GetCountByUser(currentUser.Id);
                if (templetCount > maxCount)
                    return ResultHelper.Fail("模板数量已满");
            }
            //////////////////////////////////////////////////
            templet.IsEnable = true;//新建时,默认为启用
            templet.CreatorId = currentUser.Id;
            StringBuilder ruleStr = new StringBuilder();//根据规则生成规则字符串

            List<EntityBase> detailList = new List<EntityBase>();
            foreach (GameTeamLoopTempletDetail item in templet.Detail)//规则详情
            {
                item.RowState = RowState.Added;
                item.SetNewEntity();
                item.TempletId = templet.Id;
                detailList.Add(item);
                ////////////生成规则字符串
                string ruleNo = string.Empty;
                switch (item.OrderNo)
                {
                    case 1:
                        ruleNo = "①";
                        break;
                    case 2:
                        ruleNo = "②";
                        break;
                    case 3:
                        ruleNo = "③";
                        break;
                    case 4:
                        ruleNo = "④";
                        break;
                    case 5:
                        ruleNo = "⑤";
                        break;
                    case 6:
                        ruleNo = "⑥";
                        break;
                    case 7:
                        ruleNo = "⑦";
                        break;
                    case 8:
                        ruleNo = "⑧";
                        break;
                    case 9:
                        ruleNo = "⑨";
                        break;

                }
                ruleStr.Append(ruleNo + item.Code1 + "-" + item.Code2);
            }
            templet.RuleCode = ruleStr.ToString();
            var detailCmd = CommandHelper.CreateSave(detailList);
            var cmd = CommandHelper.CreateSave(templet);
            var res = DbContext.GetInstance().Execute(cmd);//保存主模板
            if(res.IsSuccess)
                res = DbContext.GetInstance().Execute(detailCmd);//不能同时使用多个CreateSave生成的命令列表,保存要出错,直接用SQL字符串生成的命令列表,则可以
            res.Entities.Add(templet);
            return res;
        }
    }
}
