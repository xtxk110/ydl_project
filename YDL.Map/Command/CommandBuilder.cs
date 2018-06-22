using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

namespace YDL.Map
{
    internal class CommandBuilder
    {
        public Type Type { get; set; }

        public Database Db { get; set; }

        public Command CmdWrapper { get; set; }

        public DbCommand Get(ICommandCreator cmd)
        {
            return cmd.Get(Type, Db, CmdWrapper);
        }
    }
}
