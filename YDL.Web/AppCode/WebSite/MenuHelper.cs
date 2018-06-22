using System.Collections.Generic;

namespace YDL.Web
{
    public static class MenuHelper {

        public static class MenuName
        {
            public const string TopMenu = "TopMenu";

            public const string HomePage = "首页";

            public const string Product = "产品";

            public const string About = "关于我们";
            public const string A_Company = "公司简介";
            public const string A_News = "新闻动态";
            public const string A_Join = "加入我们";
        }

        public static MenuInfo GetMenu(string name)
        { 
            MenuInfo m;
            switch (name)
            {
                case MenuName.TopMenu:
                    m = new MenuInfo { DisplayName = name, Children = new List<MenuInfo> { 
                        GetMenu(MenuName.HomePage),
                        GetMenu(MenuName.Product),
                        GetMenu(MenuName.About)
                    } };
                    break;

                case MenuName.HomePage:
                    m = new MenuInfo { DisplayName = name, ActionName = "Index", ControlerName = "WebSite" };
                    break;
                //产品
                case MenuName.Product:
                    m = new MenuInfo
                    {
                        DisplayName = name,
                        TitleImgPath = "product",
                        ActionName = "Product",
                        ControlerName = "WebSite",
                        BannerFileName = "ban_product.png"
                    };
                    break;
                
                //关于我们
                case MenuName.About:
                    m = new MenuInfo
                    {
                        DisplayName = name,
                        TitleImgPath = "about",
                        ActionName = "Company",
                        ControlerName = "WebSite",
                        BannerFileName = "ban_about.png",
                        Children = new List<MenuInfo> { 
                            GetMenu(MenuName.A_Company),
                            GetMenu(MenuName.A_News),
                            GetMenu(MenuName.A_Join)
                        }
                    };
                    break;
                case MenuName.A_Company:
                    m = new MenuInfo { DisplayName = name, BannerFileName = "ban_about.png", TitleImgPath = "about", ActionName = "Company", ControlerName = "WebSite", ParentName = MenuName.About };
                    break;
                case MenuName.A_News:
                    m = new MenuInfo { DisplayName = name, BannerFileName = "ban_about.png", TitleImgPath = "about", ActionName = "Company", ControlerName = "WebSite", ParentName = MenuName.About };
                    break;
                case MenuName.A_Join:
                    m = new MenuInfo { DisplayName = name, BannerFileName = "ban_about.png", TitleImgPath = "about", ActionName = "Join", ControlerName = "WebSite", ParentName = MenuName.About };
                    break;
                default:
                    m = GetMenu(MenuName.HomePage);
                    break;
            }
            return m;
        }
    }
}