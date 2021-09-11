using System.Web;
using System.Web.Optimization;

namespace GCosmetic
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/vendor/jquery-3.3.1.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                    "~/Scripts/jquery.countdown.min.js",
                    "~/Scripts/jquery.meanmenu.min.js",
                    "~/Scripts/jquery.scrollUp.js",
                    "~/Scripts/jquery.fancybox.min.js",
                    "~/Scripts/jquery.nice-select.min.js",
                    "~/Scripts/jquery-ui.min.js",
                    "~/Scripts/owl.carousel.min.js",
                    "~/Scripts/popper.min.js",
                    "~/Scripts/bootstrap.min.js",
                    "~/Scripts/plugins.js",
                    "~/Scripts/mustache.min.js",
                    "~/Content/admin/assets/js/toastr.min.js",
                    "~/Scripts/main.js",
                    "~/Scripts/style.js"
                ));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/vendor/modernizr-3.5.0.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.min.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/font-awesome.min.css",
                        "~/Content/animate.css",
                        "~/Content/nice-select.css",
                        "~/Content/jquery.fancybox.css",
                        "~/Content/jquery-ui.min.css",
                        "~/Content/meanmenu.min.css",
                        "~/Content/owl.carousel.min.css",
                        "~/Content/bootstrap.min.css",
                        "~/Content/toastr.css",
                        "~/Content/default.css",
                        "~/Content/style.css",
                        "~/Content/responsive.css"
                        ));

        }
    }
}
