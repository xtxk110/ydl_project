using System.Runtime.Serialization;

using YDL.Core;

namespace YDL.Map
{

    public class DbParam
    {
        public DataType Type { get; set; }

        public ParamDirection Direction { get; set; }

        public string Name { get; set; }

        public int Size { get; set; }

        public object Value { get; set; }
    }
}
