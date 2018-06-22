using System;

namespace YDL.Model
{
    public class YdlCustomException : System.Exception
    {
        public CustomExceptionType ExceptionType { get; set; }

        public int ErrorCode { get; set; }
        public string HelpString { get; set; }

        public YdlCustomException(string message, string helpString = null, int errorCode = -1, CustomExceptionType exceptionType = CustomExceptionType.Unkonw)
            : base(message)
        {

            ErrorCode = errorCode;
            HelpString = helpString;
            ExceptionType = exceptionType;
        }

        public override string ToString()
        {
            return ToString(true);
        }

        public string ToString(bool isShowErrorCode)
        {

            string s;

            if (isShowErrorCode && ErrorCode >= 0)
            {
                s = String.Format("{0}(错误码:{1})", Message, ErrorCode);
            }
            else
            {
                s = Message;
            }

            if (!String.IsNullOrWhiteSpace(s) && !String.IsNullOrWhiteSpace(HelpString))
            {
                s += HelpString;
            }

            return s;

        }

    }
}
