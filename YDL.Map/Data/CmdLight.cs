using System.Collections.Generic;
using System.Runtime.Serialization;
using YDL.Domain;

namespace YDL.Map
{
    //命令类，用于查询型
    [DataContract]
    public class CmdLight
    {
        //员工信息
        [DataMember]
        public Token Token { get; set; }
        //未用
        [DataMember]
        public string Text { get; set; }
        //用于分页，页大小
        [DataMember]
        public int PageSize { get; set; }
        //用于分页，页序号，从1开始
        [DataMember]
        public int PageIndex { get; set; }
        //业务方法参数集合
        [DataMember]
        public IDictionary<string, object> Parameters { get; set; }
    }
    //命令类，用于保存对象
    [DataContract]
    public class CmdLight<T> : CmdLight
    {
        [DataMember]
        public List<T> Entities { get; set; }
    }
}
