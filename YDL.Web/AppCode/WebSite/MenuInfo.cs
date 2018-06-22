using System.Collections.Generic;
namespace YDL.Web
{
    public class MenuInfo
    {
        public string DisplayName { get; set; }
        public string ActionName { get; set; }
        public string ControlerName { get; set; }
        public List<MenuInfo> Children { get; set; }
        public string ParentName { get; set; }
        /// <summary>
        /// 标题图片路径，只需设置图片所在文件夹名
        /// </summary>
        public string TitleImgPath { get; set; }
        public string BannerFileName { get; set; }
        
        public MenuInfo() { }
    }
}