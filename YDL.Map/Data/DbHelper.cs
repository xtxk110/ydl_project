using System.Configuration;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

using System.Data.SqlClient;

namespace YDL.Map
{
    public static class DbHelper
    {
        public static Database CreateDatabase(string name = "conn")
        {
            return DatabaseFactory.CreateDatabase(name);
        }
    }
}
