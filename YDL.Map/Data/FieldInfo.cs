using System.Reflection;
using System.Runtime.Serialization;

namespace YDL.Map
{
    public class FieldInfo
    {
        public string Field { get; set; }

        public string DataType { get; set; }

        public bool IsKey { get; set; }

        public bool IsLink { get; set; }

        public bool IsUpdate { get; set; }

        public bool OnlyInsert { get; set; }

        public string Name { get; set; }

        public PropertyInfo Property { get; set; }
    }
}
