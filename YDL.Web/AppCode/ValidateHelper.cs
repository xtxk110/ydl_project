using System;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using YDL.Model;

namespace YDL.Web
{
    public static class ValidateHelper
    {
        private static string[] notValidatePages = null;

        static ValidateHelper()
        {
            SetNotValidatePages();
        }

        public static bool IsNeedValidate(HttpRequestBase request)
        {
            bool result = true;
            string urlPath = request.Path.ToLower();

            foreach (string page in notValidatePages)
            {
                if (urlPath.Contains(page))
                {
                    result = false;
                    break;
                }
            }
            return result;
        }

        public static void SetNotValidatePages()
        {
            if (notValidatePages == null)
            {
                notValidatePages = ConfigurationManager.AppSettings["NotValidateSessionPages"].ToLower().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            }
        }
    }
}