using GCosmetic.CustomFilter;
using System.Web;
using System.Web.Mvc;

namespace GCosmetic
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new ExceptionHandlerAttribute());
        }
    }
}
