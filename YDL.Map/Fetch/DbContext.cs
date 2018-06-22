using YDL.Core;

namespace YDL.Map
{
    public class DbContext
    {
        static DbContext dbcontext = new DbContext();

        private DbContext()
        {
        }

        public static DbContext GetInstance()
        {
            return dbcontext;
        }

        public Response Execute(Command cmd)
        {
            FetchBase fetch = null;
            switch (cmd.FetchType)
            {
                case FetchType.Execute:
                    fetch = new FetchExecute();
                    break;

                case FetchType.Fetch:
                    fetch = new Fetch();
                    break;

                case FetchType.Scalar:
                    fetch = new FetchScalar();
                    break;

                case FetchType.Save:
                    fetch = new Save();
                    break;

                default:
                    break;
            }
            if (fetch != null)
            {
                return fetch.Execute(cmd);
            }
            return ResultHelper.Fail("在DbContext没有指定FetchType");
        }
    }
}
