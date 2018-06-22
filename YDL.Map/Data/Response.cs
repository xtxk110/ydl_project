using System.Collections.Generic;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using YDL.Core;
using YDL.Utility;
using System.Linq;

namespace YDL.Map
{
    //返回结果类
    public class Response
    {
        public Response()
        {
            Entities = new List<EntityBase>();
        }
        //是否执行成功
        public bool IsSuccess { get; set; }

        //消息
        public string Message { get; set; }

        //附加数据
        public object Tag { get; set; }

        //附加数据
        public object Tag1 { get; set; }

        //附加数据
        public object Tag2 { get; set; }

        //总行数
        public int RowCount { get; set; }

        //错误码
        public int ErrorCode { get; set; }

        //返回对象列表
        public List<EntityBase> Entities { get; set; }

        //SQL输出参数列表
        [JsonIgnore]
        public List<OutParam> OutParams { get; set; }

        //错误信息(用于调式)
        public string ErrorInfoForDebug { get; set; }

        //序列化成json字符串
        public string ToJsonString()
        {
            return JsonConvert.SerializeObject(this);
        }

        public void SetRowCount()
        {
            if (OutParams.IsNotNullOrEmpty())
            {
                RowCount = (int)OutParams.FirstOrDefault().value;
            }
            else if (Entities.IsNotNullOrEmpty())
            {
                RowCount = Entities.Count;
            }
        }

        public T FirstEntity<T>() where T : class
        {
            return Entities.FirstOrDefault() as T;
        }

    }
}
