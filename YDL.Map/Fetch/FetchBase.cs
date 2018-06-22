using Microsoft.Practices.EnterpriseLibrary.Data;

namespace YDL.Map
{
    internal abstract class FetchBase
    {
        public Database CreateDatabase() {
            return DbHelper.CreateDatabase();
        }

        public abstract Response Execute(Command cmd);

    }
}
