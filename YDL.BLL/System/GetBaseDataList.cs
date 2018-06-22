
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某种基础数据列表
    /// </summary>
    public class GetBaseDataList : IServiceBase
    {
        /// <summary>
        /// 获取某种基础数据列表
        /// </summary>
        /// <param name="request">包含BaseData对象，设置属性值ParentId(多个逗号隔开)</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<BaseData>>(request);
            var cmd = CommandHelper.CreateText<BaseData>(text: "SELECT Id,Name,GroupId FROM BaseData WHERE CHARINDEX(GroupId,@GroupId)>0 AND IsEnable=1");
            cmd.Params.Add(CommandHelper.CreateParam("GroupId", req.Filter.GroupId));

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
