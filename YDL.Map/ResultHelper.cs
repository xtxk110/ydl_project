using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Map
{
    public static class ResultHelper
    {
        /// <summary>
        /// 成功
        /// </summary>
        /// <returns></returns>
        public static Response Success(string message = null)
        {
            return new Response { IsSuccess = true, Message = message };
        }

        /// <summary>
        /// 成功
        /// </summary>
        /// <returns></returns>
        public static Response Success(List<EntityBase> entities, string message = null)
        {
            return new Response { IsSuccess = true, Message = message, Entities = entities };
        }

        /// <summary>
        /// 失败
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        public static Response Fail(string message)
        {
            return new Response { IsSuccess = false, Message = message };
        }

        /// <summary>
        /// 失败
        /// </summary>
        /// <returns></returns>
        public static Response Fail(Exception exception)
        {
            return new Response { IsSuccess = false, Message = exception.Message, ErrorInfoForDebug = exception.ToString() };
        }

        ///// <summary>
        ///// 数据不存在的错误
        ///// </summary>
        ///// <param name="message"></param>
        ///// <returns></returns>
        //public static Response DataNotExistError(string message)
        //{
        //    return new Response { IsSuccess = false, DataIsExist = false, Message = message };
        //}

        /// <summary>
        /// 失败
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        public static Response Fail(int errorCode, string message)
        {
            return new Response { IsSuccess = false, Message = message, ErrorCode = errorCode };
        }
        /// <summary>
        /// 创建response 并设置IsSuccess为true
        /// </summary>
        /// <returns></returns>
        public static Response CreateResponse()
        {
            return new Response { IsSuccess = true };
        }
    }
}
