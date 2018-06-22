using System.Runtime.Serialization;

namespace YDL.Core
{
    public class IdNamePair : EntityBase
    {
        [Field] 
        public string Name { get; set; }
    }
}
