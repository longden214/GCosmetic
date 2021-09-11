using GCosmetic.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCosmetic.Controllers
{
    public class ErrorController : Controller
    {
        private CosmeticDbContext dbContext = new CosmeticDbContext();

        // GET: Error
        public ActionResult NotFound()
        {
            ViewBag.Configs = dbContext.configs.Where(x => x.status == true).ToList();
            return View();
        }
    }
}