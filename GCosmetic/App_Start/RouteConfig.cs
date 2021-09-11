using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace GCosmetic
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
               name: "Product detail",
               url: "chi-tiet/{slug}-{id}",
               defaults: new { controller = "Home", action = "Product_Detail", id = UrlParameter.Optional },
               namespaces: new[] { "GCosmetic.Controllers" }
           );

            routes.MapRoute(
                name: "Search",
                url: "tim-kiem",
                defaults: new { controller = "Home", action = "SearchResult", id = UrlParameter.Optional },
                namespaces: new[] { "GCosmetic.Controllers" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "GCosmetic.Controllers" }
            );
        }
    }
}
