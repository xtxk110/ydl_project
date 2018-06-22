using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{

    public class RestApiHelper
    {

        public static IRestResponse<T> SendIMRequest<T>(RestRequest request, string identifier = "") where T : new()
        {
            return new IMRequest().SendRequest<T>(request, identifier);
        }

        public static Response SendIMRequestAndGetResponse(RestRequest request)
        {
            var rsp = SendIMRequest<IMMessageResult>(request);
            Response response = new Response() { IsSuccess = rsp.Data.ErrorCode == 0, Message = rsp.Data.ErrorInfo };
            return response;
        }

        public static IMMessageResult SendIMRequestAndGetResult(RestRequest request)
        {
            var rsp = SendIMRequest<IMMessageResult>(request);
            return rsp.Data;
        }

        public static IRestResponse<T> SendLiveRequest<T>(RestRequest request, string baseUrl, string queryString) where T : new()
        {
            return new LiveRequest().SendRequest<T>(request, baseUrl, queryString);
        }

    }

    #region 基类
    public class BaseRequest
    {
        public RestClient client;
        public BaseRequest()
        {
            client = new RestClient();
        }

        public virtual IRestResponse<T> SendRequest<T>(RestRequest request, string identifier = "") where T : new()
        {
            client.BaseUrl = new Uri("http://www.baidu.com");
            return client.Execute<T>(request);

        }

      
    }
    #endregion

    /// <summary>
    /// IM接口调用类
    /// </summary>
    public class IMRequest : BaseRequest
    {
        public static string baseUrl = ConfigurationManager.AppSettings["IMUrl"];
        public static string sdkappid = ConfigurationManager.AppSettings["sdkAppId"];
        public static string defaultIdentifier = ConfigurationManager.AppSettings["Identifier"]; //默认的Identifier 为admin ,可以进行任何操作
        public static string AccountType = ConfigurationManager.AppSettings["AccountType"];

        public static string userSig;

        public override IRestResponse<T> SendRequest<T>(RestRequest request, string identifier = "")
        {
            client.BaseUrl = new Uri(baseUrl);
            if (identifier == "")
            {
                identifier = defaultIdentifier;
            }
            string userSigStr = "";

            if (string.IsNullOrEmpty(userSig))
            {
                userSigStr = IMUserSig.GetUserSig(identifier);
            }


            string tokenURL = "?usersig=" + userSigStr + "&identifier=" + defaultIdentifier + "&sdkappid=" + sdkappid + "&contenttype=json";
            request.Resource += tokenURL;
            var rsp = client.Execute<T>(request);
            rsp.Data = JsonConvert.DeserializeObject<T>(rsp.Content);
            return rsp;
        }

        #region 错误码定义

        /// <summary>
        /// 腾讯IM错误代码含义
        /// </summary>
        private static Dictionary<int, string> ErrorCodeDic
        {
            get
            {
                Dictionary<int, string> eDic = new Dictionary<int, string>();
                #region SDK错误码
                eDic.Add(7000, "未知错误，内部错误，可提供使用接口、错误码、错误信息给客服解决");
                eDic.Add(6001, "回包解析失败，内部错误，可提供使用接口、错误码、错误信息给客服解决");
                eDic.Add(6003, "批量操作无成功结果，请检查输入列表是否合法（如用户是否存在，传入列表类型是否与API匹配）");
                eDic.Add(6004, "会话无效，getConversation时检查是否已经登陆，如未登录获取会话，会有此错误码返回。登录前未设置IM模式（winsdk），也会引起此错误。");
                eDic.Add(6005, "加载本地消息存储失败，可能存储文件有损坏，可联系客服定位具体问题");
                eDic.Add(6006, "文件传输-鉴权失败，可提供使用接口、错误码、错误信息给客服解决");
                eDic.Add(6007, "文件传输-获取 server 列表失败，可提供使用接口、错误码、错误信息给客服解决");
                eDic.Add(6008, "文件传输-上传失败，请检查网络是否连接");
                eDic.Add(6009, "文件传输-下载失败，请检查网络，或者文件、语音是否已经过期，目前资源文件存储7天");
                eDic.Add(6010, "HTTP 请求失败，可提供使用接口、错误码、错误信息给客服解决");
                eDic.Add(6011, "消息接收方无效，对方用户不存在（接收方需登陆过IMSDK或用账号导入接口导入）");
                eDic.Add(6012, "请求超时，请等网络恢复后重试。（Android SDK 1.8.0以上需要按照Readme进行配置，否则会出现此错误）");
                eDic.Add(6013, "SDK 未初始化或者用户未登陆成功，请先登陆，成功回调之后重试");
                eDic.Add(6014, "SDK 未登录，请先登陆，成功回调之后重试");
                eDic.Add(6016, "注册超时，需要重试");
                eDic.Add(6017, "API 参数无效，请检查参数是否符合要求，具体可查看错误信息进一步定义哪个字段");
                eDic.Add(6018, "SDK初始化失败，可能是部分目录无权限");
                eDic.Add(6200, "请求时没有网络，请等网络恢复后重试");
                eDic.Add(6201, "响应时没有网络，请等网络恢复后重试");
                eDic.Add(6207, "登录校验权限失败，具体查看错误信息");
                eDic.Add(6208, "其他终端登录帐号被踢，需重新登录");
                eDic.Add(6015, "操作进行中，登陆时返回请等待另一个登陆成功或失败后再次调用登陆");
                #endregion

                #region 公共错误码
                eDic.Add(80001, "文本安全打击。文本中可能包含敏感词汇。");
                eDic.Add(80002, "发消息包体过长，目前支持最大8k消息包体长度，请减少包体大小重试");
                #endregion

                #region REST API公共错误码
                eDic.Add(60002, "HTTP解析错误 ，请检查HTTP请求URL格式");
                eDic.Add(60003, "HTTP请求JSON解析错误，请检查JSON格式");
                eDic.Add(60004, "请求URI或JSON包体中帐号或签名错误");
                eDic.Add(60005, "请求URI或JSON包体中帐号或签名错误");
                eDic.Add(60006, "appid失效，请核对appid有效性");
                eDic.Add(60007, "rest接口调用频率超过限制，请降低请求频率");
                eDic.Add(60008, "服务请求超时或HTTP请求格式错误，请检查并重试");
                eDic.Add(60009, "请求资源错误，请检查请求URL");
                eDic.Add(60010, "请求需要APP管理员权限，请检查接口调用权限");
                eDic.Add(60011, "appid请求频率超限，请降低请求频率");
                eDic.Add(60012, "REST接口需要带sdkappid，请检查请求URL中的sdkappid");
                eDic.Add(60013, "HTTP响应包JSON解析错误");
                eDic.Add(60014, "置换id超时");
                #endregion

                #region 单发消息
                eDic.Add(90001, "Json格式解析失败,请检查请求包是否符合JSON规范。");
                eDic.Add(90002, "Json格式请求包中MsgBody不符合消息格式描述，或者MsgBody不是Array类型，请参考TIMMsgElement对象的定义。");
                eDic.Add(90003, "Json格式请求包中To_Account不符合消息格式描述，请检查To_Account类型是否为String。");
                eDic.Add(90004, "Json格式请求包体中MsgSeq不是Number类型或者其值范围不在0~4294967296。");
                eDic.Add(90005, "Json格式请求包体中MsgRandom不是Number类型或者其值范围不在0~4294967296。");
                eDic.Add(90006, "Json格式请求包体中MsgTimeStamp不是Number类型或者其值范围不在0~4294967296。");
                eDic.Add(90007, "Json格式请求包体中MsgBody类型不是Array类型，请将其修改为Array类型。");
                eDic.Add(90008, "Json格式请求包体中From_Account解析失败，请检查From_Account是否是String类型。");
                eDic.Add(90009, "服务端集成Rest API接口必须使用管理员才能成功发起请求，配置管理员可参见设置APP管理员。");
                eDic.Add(90010, "Json格式请求包不符合消息格式描述，请参考TIMMsgElement对象的定义。");
                eDic.Add(90011, "批量发消息目标账户超过500，请减少To_Account中目标账号数量。");
                eDic.Add(90012, "To_Account没有注册或不存在，请确认To_Account是否导入腾讯云或者是否拼写错误。");
                eDic.Add(90028, "To_Account不是Array类型。");
                eDic.Add(90029, "To_Account账号数量为0，请添加目标账户。");
                eDic.Add(90030, "SyncFromOldSystem不是Number类型或者其值范围不在0~4294967295。");
                eDic.Add(90031, "SyncFromOtherMachine不是Number类型或者其值范围不在0~4294967295。");
                eDic.Add(91000, "服务内部错误，请重试。");
                eDic.Add(90992, "服务内部错误，请重试；如果所有请求都返回该错误码，且APP配置了第三方回调，请检查APP服务器是否正常向腾讯云后台服务器返回回调结果。");
                #endregion

                #region 群组系统
                eDic.Add(10001, "调用时所携带的签名校验失败，请检查签名是否正确。");
                eDic.Add(10002, "系统错误，请再次尝试或联系技术客服。");
                eDic.Add(10003, "命令非法，请再次尝试或联系技术客服。");
                eDic.Add(10004, "参数非法。请根据应答包中的ErrorInfo字段，检查必填字段是否填充，或者字段的填充是否满足协议要求。");
                eDic.Add(10005, "请求包体中携带的用户数量过多。");
                eDic.Add(10006, "操作频率限制。请尝试降低调用的频率。");
                eDic.Add(10007, "操作权限不足。");
                eDic.Add(10008, "请求非法，可能是请求中携带的签名信息验证不正确，请再次尝试或联系技术客服。");
                eDic.Add(10009, "该群不允许群主主动退出。");
                eDic.Add(10010, "群组不存在，或者曾经存在过，但是目前已经被解散。");
                eDic.Add(10011, "解析 Json 包体失败。请检查包体的格式是否符合Json格式。");
                eDic.Add(10012, "发起操作的用户ID非法。请检查发起操作的用户ID是否填写正确。");
                eDic.Add(10013, "被邀请加入的用户已经是群成员。");
                eDic.Add(10014, "群已满员，无法将请求中的用户加入群组。如果是批量加人，可以尝试减少加入用户的数量。");
                eDic.Add(10015, "群组ID非法，请检查群组ID是否填写正确。");
                eDic.Add(10016, "APP后台通过第三方回调拒绝本次操作。");
                eDic.Add(10017, "因被禁言而不能发送消息，请检查发送者是否被设置禁言。");
                eDic.Add(10018, "应答包长度超限。因为请求的内容过多，导致应答包超过了最大包长（1MB），请尝试减少单次请求的数据量。");
                eDic.Add(10019, "被添加用户的帐号不存在，请检查用户帐号是否正确。");
                eDic.Add(10020, "消息内容过长，目前最大支持8000字节的消息，请调整消息长度。");
                eDic.Add(10021, "群组ID已被使用，请选择其他的群组ID。");
                eDic.Add(10023, "发消息的频率超限，请延长两次发消息时间的间隔。");
                eDic.Add(10024, "此邀请或者申请请求已经被处理。");
                eDic.Add(10025, "群组ID已被使用，并且操作者为群主，可以直接使用。");
                #endregion

                #region 资料系统
                eDic.Add(40001, "资料解包失败，如果是REST API返回的错误码请对照REST API介绍文档仔细查看请求包格式是否完整，如果是非REST API返回的错误请联系技术客服。");
                eDic.Add(40601, "设置资料头像URL太长，请不要设置超过500字节的内容。 ");
                eDic.Add(40602, "设置资料读取数据失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40603, "设置资料字段非法，请检查需要设置的资料字段名称，名称必须是这些值的其中一个：\"Tag_Profile_IM_Nick\"、\"Tag_Profile_IM_AllowType\"、“Tag_Profile_IM_Image” 。");
                eDic.Add(40604, "设置资料系统错误非法字段长度，请再次尝试或联系技术客服。 ");
                eDic.Add(40605, "设置资料请求参数非法，请再次尝试或联系技术客服。");
                eDic.Add(40606, "设置资料设置标准数据失败，请再次尝试或联系技术客服。");
                eDic.Add(40607, "设置资料非法字段，请再次尝试或联系技术客服。 ");
                eDic.Add(40608, "设置资料系统错误非法字段长度，请再次尝试或联系技术客服。 ");
                eDic.Add(40609, "设置资料设置自定义数据失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40701, "设置头像获取数据失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40702, "设置头像设置数据失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40703, "设置头像URL太长，请不要设置超过500字节的内容。");
                eDic.Add(40704, "设置头像头像参数数据不正确，请再次尝试或联系技术客服。");
                eDic.Add(40801, "获取资料字段非法 ，请检查需要获取的资料字段名称，名称必须是这些值的其中一个：\"Tag_Profile_IM_Nick\"、\"Tag_Profile_IM_AllowType\"、“Tag_Profile_IM_Image” 。");
                eDic.Add(40802, "获取资料系统执行标配任务失败，请再次尝试或联系技术客服。");
                eDic.Add(40803, "获取资料系统解析数据失败，请再次尝试或联系技术客服。");
                eDic.Add(40804, "获取资料非法字段 ，请检查需要获取的资料字段名称，名称必须是这些值的其中一个：\"Tag_Profile_IM_Nick\"、\"Tag_Profile_IM_AllowType\"、“Tag_Profile_IM_Image” 。");
                eDic.Add(40805, "获取资料系统执行自定义任务列表失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40806, "获取资料系统错误自定义字段长度非法 ，请再次尝试或联系技术客服。");
                eDic.Add(40807, "获取资料标配主Key不存在，请求中携带的Identifer不存在资料数据，有可能是该Identifer没有写入过资料导致的，请先给该Identifer写入资料或者忽略该错误。");
                eDic.Add(40808, "获取资料标配读取数据失败，请再次尝试或联系技术客服。");
                eDic.Add(40809, "获取资料自定义主Key不存在，请求中携带的Identifer不存在资料数据，有可能是该Identifer没有写入过资料导致的，请先给该Identifer写入资料或者忽略该错误。");
                eDic.Add(40810, "获取资料自定义读取数据失败，请再次尝试或联系技术客服。 ");
                eDic.Add(40901, "获取头像系统执行任务列表失败，请再次尝试或联系技术客服。 ");

                #endregion

                #region 关系链系统
                eDic.Add(30001, "关系链解包失败，如果是REST API返回的错误码请对照REST API介绍文档仔细查看请求包格式是否完整，如果是非REST API返回的错误请联系技术客服。");
                eDic.Add(30002, "SDKAppId非法，请再次尝试或联系技术客服。");
                eDic.Add(30501, "加好友来源参数错误，加好友来源字符串中必须符合如下格式：“AddSource_Type_XXXXXXXX”，即必须包含前缀“AddSource_Type_”，“XXXXXXXX”为App自定义填写，最长不超过8字节，一个符合规范的加好友来源参数例如“AddSource_Type_Android”。");
                eDic.Add(30502, "加好友参数长度错误，好友备注的长度不能超过96字节，分组名称的长度不能超过30字节，加好友附言的长度不能超过256字节。");
                eDic.Add(30503, "加好友个数错误，需要添加好友的个数为0，或者超过了1000。");
                eDic.Add(30504, "加好友获取SDKAppId失败，请再次尝试或联系技术客服。 ");
                eDic.Add(30505, "加好友执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30506, "获取好友列表错误，请再次尝试或联系技术客服。");
                eDic.Add(30507, "获取好友列表元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30508, "拉取好友列表行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30509, "添加己方好友信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30510, "添加己方好友信息元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30511, "添加己方好友信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30512, "删除己方未决错误，请再次尝试或联系技术客服。");
                eDic.Add(30513, "拉取黑名单列表错误，请再次尝试或联系技术客服。");
                eDic.Add(30514, "添加好友新建任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30515, "已设置被加好友为黑名单，请求中要求添加的好友已经在自己的黑名单列表中，所以无法添加为好友，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30516, "被加好友设置禁止被添加，请求中要求添加的好友的加好友验证方式设置的是“拒绝添加”，所以无法添加为好友，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30517, "未决一次被加满，请求中要求添加的好友中有大于100个好友设置的验证方式是“需要验证”，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30518, "加好友组满，请求中要求添加的好友携带了新的分组信息，但是已有的分组个数加上新的分组的个数超过了32个，目前分组最大个数为32个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30519, "加好友好友满，请求中可以直接添加为好友的好友个数和已有的好友个数之和超过了1000个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30520, "加好友好友已经存在，请求添加的好友已经是自己的好友了，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30521, "获取好友资料信息不存在，请求添加的好友在系统中不存在任何资料，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30522, "获取好友资料信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30523, "获取好友资料信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30524, "获取被加好友的的黑名单错误，请再次尝试或联系技术客服。");
                eDic.Add(30525, "已被被加好友设置为黑名单，请求中要求添加对方为好友，但是对方已经设置自己为黑名单了，所以无法添加为好友，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30526, "获取对方和己方的好友关系错误，请再次尝试或联系技术客服。");
                eDic.Add(30527, "获取对方和己方的好友关系行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30528, "添加对方好友信息时获取序列号错误，请再次尝试或联系技术客服。");
                eDic.Add(30529, "添加对方好友信息时获取序列号元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30530, "添加对方好友信息时获取未决错误，请再次尝试或联系技术客服。");
                eDic.Add(30531, "添加对方好友信息时获取未决行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30532, "添加对方好友信息时删除未决失败，请再次尝试或联系技术客服。");
                eDic.Add(30533, "添加对方好友信息时获取好友数目失败，请再次尝试或联系技术客服。");
                eDic.Add(30534, "添加对方好友信息时获取好友数目序列号不一致，请再次尝试或联系技术客服。");
                eDic.Add(30535, "添加对方好友信息好友满，请求中要求添加对方为好友，但是对方的好友表已经超过了1000个。");
                eDic.Add(30536, "添加对方好友信息元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30537, "添加对方好友信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30538, "添加对方好友信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30539, "加未决成功，使用特殊错误码特殊标示和好友加成功进行区分，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30601, "加好友回应动作参数错误，加好友回应的请求包中的回应动作参数的取值错误，合法的取值范围是：“Response_Action_Agree”、“Response_Action_AgreeAndAdd”和“Response_Action_Reject”。");
                eDic.Add(30602, "加好友回应参数长度错误，加好友回应的请求包中的备注内容超过96字节或者分组名称超过30字节。");
                eDic.Add(30603, "加好友回应好友个数错误，加好友回应的请求包中的好友个数为0或者超过1000。");
                eDic.Add(30604, "加好友回应获取未决错误，请再次尝试或联系技术客服。");
                eDic.Add(30605, "加好友回应获取未决元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30606, "加好友回应获取未决行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30607, "加好友回应获取好友数错误，请再次尝试或联系技术客服。");
                eDic.Add(30608, "加好友回应获取好友数序列号变化，请再次尝试或联系技术客服。");
                eDic.Add(30609, "加好友回应设置己方好友信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30610, "加好友回应设置己方好友信息元数据错，请再次尝试或联系技术客服。");
                eDic.Add(30611, "加好友回应设置己方好友信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30612, "加好友回应设置己方删除未决错误，请再次尝试或联系技术客服。");
                eDic.Add(30613, "加好友回应执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30614, "加好友回应未决不存在，在自己的未决请求列表中没有找到需要回应的好友曾经发起的加好友未决请求，有可能已经被滚动掉了，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30615, "加好友回应己方好友满，自己的好友表大于1000个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30616, "加好友回应组满，自己的分组大于32个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30617, "加好友回应好友已经存在，加好友回应请求包中的好友已经是自己的好友了，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30618, "加好友回应设置对方好友信息时检查好友存在失败，请再次尝试或联系技术客服。");
                eDic.Add(30619, "加好友回应设置对方好友信息时检查好友存在元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30620, "加好友回应设置对方好友信息时检查好友存在行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30621, "加好友回应设置对方好友信息时获取好友数失败，请再次尝试或联系技术客服。");
                eDic.Add(30622, "加好友回应设置对方好友信息时获取好友数序列号变化，请再次尝试或联系技术客服。");
                eDic.Add(30623, "加好友回应设置对方好友信息时添加好友元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30624, "加好友回应设置对方好友信息行添加好友行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30625, "加好友回应设置对方好友信息时添加好友错误，请再次尝试或联系技术客服。");
                eDic.Add(30626, "加好友回应设置对方好友信息时删除未决错误，请再次尝试或联系技术客服。");
                eDic.Add(30627, "加好友回应设置对方好友信息时设置序列号元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30628, "加好友回应设置对方好友信息时设置序列号错误，请再次尝试或联系技术客服。");
                eDic.Add(30629, "加好友回应新建任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30630, "加好友回应对方好友满，对方的好友表大于1000个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30701, "好友数据更新参数错误，请检查备注内容的长度是否超过96字节，分组名称的长度是否超过30字节，多个分组名称出现是否为空，Tag名称是否非法，目前的Tag名称只支持：“Tag_SNS_IM_Remark”和“Tag_SNS_IM_Group”。");
                eDic.Add(30702, "好友数据更新获取好友错误，请再次尝试或联系技术客服。");
                eDic.Add(30703, "好友数据更新获取好友元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30704, "好友数据更新获取好友行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30705, "好友数据更新标配信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30706, "好友数据更新标配信息元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30707, "好友数据更新标配信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30708, "好友数据更新自定义信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30709, "好友数据更新自定义信息元错误，请再次尝试或联系技术客服。");
                eDic.Add(30710, "好友数据更新自定义信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30711, "好友数据更新执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30712, "好友数据更新的好友不存在，在自己的好友表中没有找到需要更新的好友，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30713, "好友数据更新组满，分组总数大于32个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30801, "好友导入参数错误，请检查备注内容是否超过96字节，分组名称是否超过30字节，加好友附言的长度是否超过256字节，加好友来源字符串中是否符合如下格式：“AddSource_Type_XXXXXXXX”，即必须包含前缀“AddSource_Type_”，并且“XXXXXXXX”不能超过8个字节，Tag名称是否合法，自定义字段的值对应的内容长度是否超过512字节，如果以上错误均不是，请联系技术客服。");
                eDic.Add(30802, "好友导入获取SDKAppId失败，请再次尝试或联系技术客服。");
                eDic.Add(30803, "好友导入读好友数错误，请再次尝试或联系技术客服。");
                eDic.Add(30804, "好友导入获取组信息和序列号错误，请再次尝试或联系技术客服。");
                eDic.Add(30805, "好友导入获取组信息和序列号元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30806, "好友导入标配信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30807, "好友导入标配信息元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30808, "好友导入标配信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30809, "好友导入自定义信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30810, "好友导入自定义信息元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30811, "好友导入自定义信息错误，请再次尝试或联系技术客服。");
                eDic.Add(30812, "好友导入好友满，现有的好友个数加上导入好友的个数之和超过了1000个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30813, "好友导入组满，现有分组的个数已达到32个，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(30901, "好友关系检查参数错误，请求包中的检查参数取值非法，合法取值范围是：“CheckResult_Type_Singal”和“CheckResult_Type_Both”。");
                eDic.Add(30902, "好友关系检查执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30903, "好友关系检查获取好友错误，请再次尝试或联系技术客服。");
                eDic.Add(30904, "好友关系检查获取好友行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(30905, "好友关系检查新建任务失败，请再次尝试或联系技术客服。");
                eDic.Add(30906, "好友关系检查获取对方和己方好友关系错误，请再次尝试或联系技术客服。");
                eDic.Add(30907, "好友关系检查获取对方和己方好友关系元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31001, "获取未决参数错误，请求包中未决参数类型的取值非法，合法取值范围是：“Pendency_Type_ComeIn”、“Pendency_Type_SendOut”和“Pendency_Type_Both”。");
                eDic.Add(31002, "获取的好友来源错误，请再次尝试或联系技术客服。");
                eDic.Add(31003, "获取未决时主键不存在，请再次尝试或联系技术客服。");
                eDic.Add(31004, "获取未决时序列号错误，请再次尝试或联系技术客服。");
                eDic.Add(31005, "获取未决时序列号元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31006, "获取未决错误，请再次尝试或联系技术客服。");
                eDic.Add(31007, "获取未决元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31008, "获取未决昵称执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(31101, "拉取所有好友参数错误，请再次尝试或联系技术客服。");
                eDic.Add(31102, "拉取所有好友时字段数目异常，请求包体中的字段数量超过了30个。");
                eDic.Add(31103, "拉取所有好友主键不存在，请再次尝试或联系技术客服。");
                eDic.Add(31104, "拉取所有好友获取序列号错误，请再次尝试或联系技术客服。");
                eDic.Add(31105, "拉取所有好友获取序列号元数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31106, "拉取所有好友获取字段对应的字符串错误，请再次尝试或联系技术客服。");
                eDic.Add(31107, "拉取所有好友关系链标配信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31108, "拉取所有好友关系链标配信息组数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31109, "拉取所有好友关系链标配信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31110, "拉取所有好友关系链自定义信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31111, "拉取所有好友关系链自定义信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31112, "拉取所有好友执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(31201, "按列表拉取好友参数错误，请再次尝试或联系技术客服。");
                eDic.Add(31202, "按列表拉取好友时字段数目异常，请求包体中的字段数量超过了30个。");
                eDic.Add(31203, "按列表拉取好友主键不存在，请再次尝试或联系技术客服。");
                eDic.Add(31204, "按列表拉取好友关系链标配信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31205, "按列表拉取好友关系链标配信息组数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31206, "按列表拉取好友关系链标配信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31207, "按列表拉取好友关系链自定义信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31208, "按列表拉取好友关系链自定义信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31209, "按列表拉取好友取执行任务失败，请再次尝试或联系技术客服。");
                eDic.Add(31210, "按列表拉取好友获取字段对应的字符串错误，请再次尝试或联系技术客服。");
                eDic.Add(31211, "按列表拉取好友不存在，拉取指定好友，但是指定好友并不在好友表中，调用方可以捕捉该错误给用户一个合理的提示。");
                eDic.Add(31212, "拉取好友新建任务失败，请再次尝试或联系技术客服。");
                eDic.Add(31213, "拉取好友资料标配信息主键不存在，请再次尝试或联系技术客服。");
                eDic.Add(31214, "拉取好友资料标配信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31215, "拉取好友资料标配信息行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31216, "拉取好友资料自定义信息错误，请再次尝试或联系技术客服。");
                eDic.Add(31217, "拉取好友资料自定义行数据错误，请再次尝试或联系技术客服。");
                eDic.Add(31701, "删除好友的请求个数非法，删除好友请求包中的好友个数为0或者大于1000。");
                eDic.Add(31702, "删除好友的请求类型非法，删除好友请求包中的类型取值非法，合法取值范围是：“Delete_Type_Single”、“Delete_Type_Both”。");
                eDic.Add(31703, "校验正向的标配数据失败，请再次尝试或联系技术客服。");
                eDic.Add(31704, "请求删除的号码不是好友，调用方可以捕捉该错误码给用户一个合理的提示。");
                eDic.Add(31705, "删除正向的标配数据失败，请再次尝试或联系技术客服。");
                eDic.Add(31706, "删除反向数据失败，请再次尝试或联系技术客服。");
                eDic.Add(31707, "恶意删好友请求，删除频率过快，请再次尝试或联系技术客服。");
                eDic.Add(32901, "删除所有好友时校验SDKAppId失败，请再次尝试或联系技术客服。");
                eDic.Add(32902, "删除所有好友时删除标配数据失败，请再次尝试或联系技术客服。");
                eDic.Add(32903, "删除所有好友时删除自定义数据失败，请再次尝试或联系技术客服。");
                #endregion

                #region 帐号系统
                eDic.Add(70001, "sig过期，请尝试重新生成。如果是刚生成，就过期，请检查有效期填写的是否过小，或者填的0");
                eDic.Add(70002, "sig长度为0，请检查传入的sig是否正确");
                eDic.Add(70003, "sig校验失败，请确认下sig内容是否被截断，如缓冲区长度不够导致的内容截断");
                eDic.Add(70004, "sig校验失败，请确认下sig内容是否被截断，如缓冲区长度不够导致的内容截断");
                eDic.Add(70005, "sig校验失败，可用工具自行验证生成的sig是否正确");
                eDic.Add(70006, "sig校验失败，可用工具自行验证生成的sig是否正确");
                eDic.Add(70007, "sig校验失败，可用工具自行验证生成的sig是否正确");
                eDic.Add(70008, "sig校验失败，可用工具自行验证生成的sig是否正确");
                eDic.Add(70009, "用业务公钥验证sig失败，如果是用工具生成的公私钥，请到腾讯云应用配置页面上传对应的公钥");
                eDic.Add(70010, "sig校验失败，可用工具自行验证生成的sig是否正确");
                eDic.Add(70011, "sig中appid3rd与请求时的appid3rd不匹配，请检查登录时填写的appid3rd与sig中的是否一致");
                eDic.Add(70012, "sig中账号类型与请求时的账号类型不匹配，请检查登录时填写的账号类型与sig中的是否一致");
                eDic.Add(70013, "sig中identifier与请求时的identifier不匹配，请检查登录时填写的identifier与sig中的是否一致");
                eDic.Add(70014, "sig中sdkappid与请求时的sdkappid不匹配，请检查登录时填写的sdkappid与sig中的是否一致");
                eDic.Add(70015, "未找到该 appid 和账号类型对应的验证方式");
                eDic.Add(70016, "拉取到的公钥长度为0，请确认是否已经上传了公钥，如果是重新上传的公钥需要十分钟之后尝试");
                eDic.Add(70017, "内部第三方票据验证超时，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70018, "内部验证第三方票据失败");
                eDic.Add(70019, "通过https方式验证的票据字段为空，请正确填写sig");
                eDic.Add(70020, "sdkappid 未找到，请确认是否已经在腾讯云上配置");
                eDic.Add(70052, "票据被踢失败");
                eDic.Add(70101, "请求包信息为空");
                eDic.Add(70102, "请求包帐号类型错误");
                eDic.Add(70103, "电话号码格式错误");
                eDic.Add(70104, "邮箱格式错误");
                eDic.Add(70105, "TLS 帐号格式错误");
                eDic.Add(70106, "非法帐号格式类型");
                eDic.Add(70107, "Identifer 没有注册");
                eDic.Add(70113, "批量数量不合法");
                eDic.Add(70114, "安全原因被限制");
                eDic.Add(70115, "uin 不是对应 appid 的开发者 uin");
                eDic.Add(70140, "sdkappid 和 acctype 不匹配");
                eDic.Add(70145, "帐号类型错误");
                eDic.Add(70169, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70201, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70202, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70203, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70204, "appid 没有对应的 acctype");
                eDic.Add(70205, "查找 acctype 失败，请重试");
                eDic.Add(70206, "请求中批量数量不合法");
                eDic.Add(70207, "内部错误，请重试");
                eDic.Add(70208, "内部错误，请重试");
                eDic.Add(70209, "获取开发者 uin 标志失败");
                eDic.Add(70210, "请求中 uin 为非开发者 uin");
                eDic.Add(70211, "请求中 uin 非法");
                eDic.Add(70212, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70213, "访问内部数据失败，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70308, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70346, "票据校验失败");
                eDic.Add(70347, "票据因过期原因校验失败");
                eDic.Add(70348, "内部错误，请重试，如多次重试不成功，请@TLS帐号支持，QQ 3268519604");
                eDic.Add(70401, "内部错误，请重试");
                eDic.Add(70402, "参数非法。请检查必填字段是否填充，或者字段的填充是否满足协议要求");
                eDic.Add(70403, "发起操作者不是APP管理员，没有权限操作");
                eDic.Add(70050, "因失败且重试次数过多导致被限制，请检查票据是否正确，一分钟之后再试。");
                eDic.Add(70051, "帐号已被拉入黑名单，请联系 tls 帐号支持 3268519604");
                #endregion

                #region 开放消息
                eDic.Add(20001, "解析请求包失败");
                eDic.Add(20002, "签名鉴权失败");
                eDic.Add(20003, "账号无效或者账号未导入腾讯云");
                eDic.Add(20004, "网络异常，请重试");
                eDic.Add(20005, "服务器异常，请重试");
                eDic.Add(20006, "触发发单聊消息之前回调，APP后台返回禁止下发该消息");
                #endregion

                return eDic;
            }
        }

        /// <summary>
        /// 获取指定错误代码含义
        /// </summary>
        /// <param name="errCode"></param>
        /// <returns></returns>
        public static string GetErrorInfo(int errCode)
        {
            if (!ErrorCodeDic.Keys.Contains(errCode))
                return "未知错误：" + errCode;

            return ErrorCodeDic[errCode];
        }

        #endregion
    }


    /// <summary>
    /// 直播请求
    /// </summary>
    public class LiveRequest : BaseRequest
    {


        public IRestResponse<T> SendRequest<T>(RestRequest request, string baseUrl, string queryString) where T : new()
        {
            client.BaseUrl = new Uri(baseUrl);
            request.Resource += queryString; //queryString 为? 后的url部分
            var rsp = client.Execute<T>(request);
            rsp.Data = JsonConvert.DeserializeObject<T>(rsp.Content);
            return rsp;
        }
   
    }

}
