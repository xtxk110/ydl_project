using System;
using System.Collections.Generic;

namespace YDL.Map
{
    internal interface IMap
    {
        TableInfo Get(Type type);
    }
}
