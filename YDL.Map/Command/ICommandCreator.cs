using System;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace YDL.Map
{
    internal interface ICommandCreator
    {
        DbCommand Get(Type type, Database db, Command cmdWrapper);
    }
}
