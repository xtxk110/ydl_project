using System;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using System.Runtime.Caching;
using NLog;
using System.Configuration;

namespace YDL.BLL
{
    /// <summary>
    /// 服务调用生成器
    /// </summary>
    public class ServiceBuilder
    {
        private string EMPTY_BLL_AQNAME;
        private string EMPTY_BLL_NAME;

        private static readonly ObjectCache serviceCache = MemoryCache.Default;
        private static readonly ServiceBuilder builder = new ServiceBuilder();
        private static Logger logger;


        private static string isDebug;

        private ServiceBuilder()
        {
            Type type = typeof(EmptyBLL);
            EMPTY_BLL_AQNAME = type.AssemblyQualifiedName;
            EMPTY_BLL_NAME = type.Name;
            logger = LoggerHelper.GetOperateLog();

            isDebug = ConfigurationManager.AppSettings["IsDebug"];
        }

        /// <summary>
        /// 获取生成器实例
        /// </summary>
        /// <returns></returns>
        public static ServiceBuilder GetInstance()
        {
            return builder;
        }



        /// <summary>
        /// 执行业务逻辑，供WEB服务调用
        /// </summary>
        /// <param name="serviceType"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public string Execute(string serviceType, string request, Formatting formatting)
        {
            var result = ExecuteService(serviceType, request);
            var rsp = JsonConvert.SerializeObject(result, formatting);
            LogRequestForDebug(serviceType, request, result);
            return rsp;
        }

        /// <summary>
        /// 记录请求到日志 ,默认不记录, web.config 配置为1才记录日志, 目的是抓取接口名和接口请求体, 方便调试
        /// </summary>
        public void LogRequestForDebug(string serviceType, string request, Response rsp)
        {
            if (!string.IsNullOrEmpty(isDebug))
            {
                if (isDebug == "1")
                {
                    dynamic parsedJson = JsonConvert.DeserializeObject(request);
                    var reqJson = JsonConvert.SerializeObject(parsedJson, Formatting.Indented);
                    var rspJson = JsonConvert.SerializeObject(rsp, Formatting.Indented);
                    string log = string.Format("ApiName: {0} ; \r\n {0} -> ApiRequestBody: \r\n {1} \r\n {0} -> ApiResponse: \r\n {2} ", serviceType, reqJson, rspJson);
                    logger.Debug(log);

                }
            }
        }
        /// <summary>
        /// 执行业务逻辑
        /// </summary>
        /// <param name="serviceType"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(ServiceType serviceType, Request request)
        {
            return ExecuteService(serviceType.ToString(), JsonConvert.SerializeObject(request));
        }

        private Response ExecuteService(string serviceName, string request)
        {
            Response result = null;

            var req = JsonConvert.DeserializeObject<Request>(request);

            //内部测试版本跳过服务器维护验证
            if (!req.IsInnerTest && Globals.IsMaintain())
            {
                //服务器维护提示
                result = ResultHelper.Fail(ErrorCode.SERVER_MAINTAIN, Globals.GetAppSettings(Globals.APP_KEY_MAINTAIN_TIME));
            }
            else
            {
                //正常执行
                if (serviceName.IsNotNullOrEmpty())
                {
                    try
                    {
                        Object bll = GetServiceObj(ToAqName(serviceName));

                        var cmd = JsonConvert.DeserializeObject<Request>(request);
                        if (bll is IServiceBase)
                        {
                            if (cmd.Token.IsNotNullOrEmpty())
                            {
                                User user = CacheUserBuilder.Instance.GetUserByToken(cmd.Token); //根据Token获取在线用户
                                if (user.IsNotNull())
                                {
                                    result = (bll as IServiceBase).Execute(user, request);
                                }
                                else
                                {
                                    result = ResultHelper.Fail(ErrorCode.OFFLINE, "您已经掉线，请重新登录！");
                                }
                            }
                            else
                            {
                                result = ResultHelper.Fail(ErrorCode.NOT_PASS_TOKEN, "没有传递有效Token。");
                            }
                        }
                        else
                        {
                            result = (bll as IService).Execute(request);
                        }
                        //操作成功尝试设置记录行数
                        if (result.IsSuccess && result.RowCount == 0 && result.Entities.IsNotNullOrEmpty())
                        {
                            result.RowCount = result.Entities.Count;
                        }
                    }
                    catch (Exception ex)
                    {
                        result = ResultHelper.Fail(ex);
                    }
                }
                else
                {
                    result = ResultHelper.Fail("没有指定具体服务名称！");
                }
            }

            return result;
        }

        private string ToAqName(string serviceName)
        {
            var aqName = EMPTY_BLL_AQNAME.Replace(EMPTY_BLL_NAME, serviceName.Trim());
            return aqName;
        }

        private object GetServiceObj(string aqName)
        {
            object bll = null;
            if (serviceCache.Contains(aqName))
            {
                bll = serviceCache.Get(aqName);
            }
            else
            {
                bll = Activator.CreateInstance(Type.GetType(aqName));

                var cacheItem = new CacheItemPolicy { Priority = CacheItemPriority.Default, SlidingExpiration = new TimeSpan(1, 0, 0, 0) };
                serviceCache.Add(aqName, bll, cacheItem);
            }
            return bll;
        }
    }
}
