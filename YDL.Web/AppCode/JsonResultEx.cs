using System;
using System.Web.Mvc;
using Newtonsoft.Json;
using YDL.Model;

namespace YDL.Web
{
    /// <summary>
    /// JsonResult扩展，用于输出带错误处理功能的JSON结构
    /// </summary>
    public class JsonResultEx : JsonResult
    {
        private AjaxRequestErrorInfo _errorInfo;
        private Boolean _iserror = false;
        private object _obj;

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="obj">要输出的对象</param>
        public JsonResultEx(object obj)
        {
            this.JsonRequestBehavior = JsonRequestBehavior.AllowGet;

            if (obj is YdlCustomException)
            {
                YdlCustomException error = (YdlCustomException)obj;

                _iserror = true;
                _errorInfo = new AjaxRequestErrorInfo { errorCode = error.ErrorCode, errorType = error.ExceptionType, message = error.Message };
            }
            else if (obj is System.Exception)
            {
                _iserror = true;
                _errorInfo = new AjaxRequestErrorInfo { message = ((System.Exception)obj).Message };
            }
            else
            {
                _iserror = false;
                _obj = obj;
            }

        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="errorMsg">错误消息</param>
        public JsonResultEx(string errorMsg)
            : this(errorMsg, -1, CustomExceptionType.Unkonw)
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="errorMsg">错误消息</param>
        /// <param name="errorCode">错误码</param>
        public JsonResultEx(string errorMsg, int errorCode)
            : this(errorMsg, errorCode, CustomExceptionType.Unkonw)
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="exception">异常对象</param>
        public JsonResultEx(YdlCustomException exception)
            : this(exception.Message, exception.ErrorCode, exception.ExceptionType)
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="errorMsg">错误消息</param>
        /// <param name="errorCode">错误码</param>
        /// <param name="exceptionType">异常类型</param>
        public JsonResultEx(string errorMsg, int errorCode, CustomExceptionType exceptionType)
        {
            this.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            _errorInfo = new AjaxRequestErrorInfo { errorCode = errorCode, errorType = exceptionType, message = errorMsg };
            _iserror = true;
        }

        /// <summary>
        /// 执行结果
        /// </summary>
        /// <param name="context">控制器上下文</param>
        public override void ExecuteResult(ControllerContext context)
        {

            AjaxRequestResult obj = null;
            if (_obj is AjaxRequestResult)
            {
                obj = (AjaxRequestResult)_obj;
            }
            else
            {
                obj = new AjaxRequestResult();
                if (!_iserror)
                {
                    obj.value = _obj;
                }
                else
                {
                    obj.error = _errorInfo;
                }
            }

            new JsonSerializer().Serialize(context.HttpContext.Response.Output, obj);

            base.ExecuteResult(context);


        }

    }
}