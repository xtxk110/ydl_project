using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Text;

namespace YDL.Web
{
    public static class ViewHelper
    {
        static string _url;
        /// <summary>
        /// 静态资原缓存
        /// </summary>
        static System.Web.Caching.Cache _staticCache;
        static ViewHelper()
        {
            _staticCache = System.Web.HttpRuntime.Cache;
        }

        public static int PageSize
        {
            get
            {
                return 10;
            }
        }

        /// <summary>
        /// 获取网站运行的根目录
        /// </summary>
        public static string RootUrl
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_url))
                {
                    _url = HttpContext.Current.Request.ApplicationPath;
                    if (!_url.EndsWith("/"))
                        _url = _url + "/";
                }

                return _url;
            }
        }
        public static string AbsUrl
        {
            get
            {
                var url = HttpContext.Current.Request.Url.AbsoluteUri;
                url = url.Replace(HttpContext.Current.Request.Url.PathAndQuery, "");

                return string.Format("{0}/{1}", url.TrimEnd('/'), RootUrl.TrimStart('/'));
            }
        }
        /// <summary>
        /// 生成虚拟路径
        /// </summary>
        /// <param name="vpath">带“~”的虚拟路径</param>
        /// <returns></returns>
        public static string BuildPath(string vpath)
        {
            return string.IsNullOrWhiteSpace(vpath) ? vpath : vpath.Replace("~/", RootUrl);
        }
        /// <summary>
        /// 生成静态资源路径(处理了缓存)
        /// </summary>
        /// <param name="vpath">带“~”的虚拟路径</param>
        /// <returns></returns>
        public static string BuildStaticPath(string vpath)
        {
            if (string.IsNullOrWhiteSpace(vpath))
                return vpath;
            var filename = HttpContext.Current.Server.MapPath(vpath);
            if (System.IO.File.Exists(filename))
            {
                var cacheitem = _staticCache[vpath];
                //缓存资源的最后修改时间，以免每次都访问磁盘读取时间
                if (cacheitem == null)
                {
                    cacheitem = System.IO.File.GetLastWriteTime(filename);
                    _staticCache.Add(vpath,
                        cacheitem,
                        new System.Web.Caching.CacheDependency(filename),
                        System.Web.Caching.Cache.NoAbsoluteExpiration,
                        System.Web.Caching.Cache.NoSlidingExpiration,
                        System.Web.Caching.CacheItemPriority.Default,
                        null);
                }

                return string.Format("{0}?v={1}", BuildPath(vpath), ((DateTime)cacheitem).ToFileTime());
            }
            else
                return BuildPath(vpath);

        }

        /// <summary>
        /// 转换整数数组
        /// </summary>
        /// <param name="Content"></param>
        /// <returns></returns>
        public static int[] ToIntArray(string[] stringArray)
        {
            int[] c = new int[stringArray.Length];
            for (int i = 0; i < stringArray.Length; i++)
            {
                c[i] = Convert.ToInt32(stringArray[i].ToString());
            }
            return c;
        }

        /// <summary>
        /// 对长文本字符串进行编码并返回已编辑码的字符串
        /// </summary>
        /// <param name="s">长文本字符串</param>
        /// <param name="codeScript">是否对javascript脚本进行编码</param>
        /// <returns></returns>
        public static string LongTextEncode(string s, bool codeScript = true)
        {
            if (string.IsNullOrWhiteSpace(s))
                return string.Empty;
            var regOpt = RegexOptions.IgnoreCase | RegexOptions.Multiline;
            s = System.Web.HttpContext.Current.Server.HtmlEncode(s);
            if (codeScript)
                s = Regex.Replace(Regex.Replace(s, "<script[^>]*?>", "&lt;script&gt;", regOpt), @"<\/script>", @"&lt;\/script&gt;");


            return Regex.Replace(s, @"(\r?\n)+", "<br/>", regOpt);
        }

        /// <summary>
        /// 处里内容（为提到、话题生成链接）
        /// </summary>
        /// <param name="content"></param>
        /// <returns></returns>
        public static string ProcessContent(string content)
        {
            if (string.IsNullOrWhiteSpace(content)) return content;
            var topic_Matchs = Regex.Matches(content, "#(\\w{1,50})#", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            if (topic_Matchs != null && topic_Matchs.Count > 0)
            {
                foreach (Match m in topic_Matchs)
                {
                    content = content.Replace(m.Value, string.Format("<a href=\"{0}?topic={1}\" target=\"_top\">{2}</a>", BuildPath("~/"), System.Web.HttpContext.Current.Server.UrlEncode(m.Value.Replace("#", "")), m.Value));
                }
            }
            return content;
        }

        /// <summary>
        /// 获取指定Model的值
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="model"></param>
        /// <param name="propertyName">属性名称</param>
        /// <returns></returns>
        public static T GetModelValue<T>(object model, string propertyName)
        {
            var t = model.GetType();
            var pinfo = t.GetProperty(propertyName, BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
            if (pinfo != null)
                return (T)pinfo.GetValue(model, null);
            else
                return default(T);

        }

        /// <summary>
        /// 格试化数字
        /// </summary>
        /// <param name="number">数字</param>
        /// <param name="currency">是否显示货币符号</param>
        /// <param name="comma">是否添加千分位</param>
        /// <param name="dlen">小数位数</param>
        /// <returns></returns>
        public static string FormatNumber(object number, bool currency, bool comma = true, int dlen = 2)
        {

            string v = string.Format("{0}{1}", currency ? "C" : "N", dlen);
            v = string.Format("{0:" + v + "}", number).TrimEnd('0').TrimEnd('.');
            if (!comma)
            {
                v.Replace(",", "");
            }
            return v;
        }

        /// <summary>
        /// 处理HTML文档
        /// </summary>
        /// <param name="htmlContent"></param>
        /// <returns></returns>
        public static string ProcessHtml(string htmlContent)
        {
            if (string.IsNullOrWhiteSpace(htmlContent)) return htmlContent;

            var regOpt = RegexOptions.IgnoreCase | RegexOptions.Multiline;
            htmlContent = Regex.Replace(htmlContent, @"<script[^>]*?>[\s\S]+?<\/script>", "", regOpt);

            return Regex.Replace(htmlContent, "src=[\",\']?((\\.\\.)?/)*([^\\\\,/,:,*,\\?,\",\\|,<,>]+/)+[^\\\\,/,:,*,\\?,\",\\|,<,>]+\\.[a-z]{2,4}[\",\']?", ReplaceResourcePath, regOpt);

        }

        public static string ReplaceResourcePath(Match mc)
        {
            //如图片地址已处理则不作处理
            //if (Regex.IsMatch(mc.Value, "~/", RegexOptions.IgnoreCase | RegexOptions.Multiline))
            //return mc.Value;
            //取出src中的地址
            var sub_mc = Regex.Match(Regex.Replace(mc.Value, "(src='|src=\")", "", RegexOptions.IgnoreCase | RegexOptions.Multiline), "((\\.\\.)?/)*([^\\\\,/,:,*,\\?,\",\\|,<,>]+/)+[^\\\\,/,:,*,\\?,\",\\|,<,>]+\\.[a-z]{2,4}", RegexOptions.IgnoreCase | RegexOptions.Multiline);

            if (sub_mc != null)
            {
                //1、将../置为空
                string str = Regex.Replace(sub_mc.Value, @"(\.\./)+", "", RegexOptions.IgnoreCase | RegexOptions.Multiline);

                //经过以上三个步骤现在的地址已变为没有目录前导符的路径了，那么只需在最前面加上“~/”后放入src="{url}"中即可;
                if (sub_mc.Value.StartsWith("~"))
                    return mc.Value.Replace(sub_mc.Value, BuildPath(sub_mc.Value));
                else
                    return mc.Value;


            }
            else
                return mc.Value;


        }

        public static string FileFolderPath
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["FileFolder"].ToString();
            }
        }
    }
}