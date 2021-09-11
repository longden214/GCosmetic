using GCosmetic.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCosmetic.Areas.Admin.Controllers
{
    [Authorize]
    public class CategoryController : Controller
    {
        private CosmeticDbContext dbContext = new CosmeticDbContext();
        // GET: Admin/Category
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult loadData(string search, int? page, int? pageSize)
        {
            if (search == null)
            {
                search = "";
            }
            object[] sqlParams =
            {
                new SqlParameter("@search",search)
            };
            var CategoryList = dbContext.Database.SqlQuery<category>("sp_category_list @search", sqlParams).ToList();

            var _pageSize = pageSize ?? 8;
            var pageIndex = page ?? 1;
            var totalPage = CategoryList.Count();
            var numberPage = Math.Ceiling((double)totalPage / _pageSize);

            var data = CategoryList.Skip((pageIndex - 1) * _pageSize).Take(_pageSize);

            return Json(new
            {
                proList = data,
                TotalItems = totalPage,
                CurrentPage = pageIndex,
                NumberPage = numberPage,
                PageSize = _pageSize
            }, JsonRequestBehavior.AllowGet);
        }

        
        public JsonResult GetById(int id)
        {
            dbContext.Configuration.ProxyCreationEnabled = false;
            var item = dbContext.categories.Where(c => c.id == id).FirstOrDefault();
            return Json( item, JsonRequestBehavior.AllowGet);
        }

        // POST: Admin/Category/Create
        [HttpPost]
        public ActionResult Create(category model)
        {
            if (model.id > 0)
            {
                var item = dbContext.categories.Find(model.id);
                item.name = model.name;
                item.slug = model.slug;
                dbContext.Entry(item).State = EntityState.Modified;
                try
                {
                    dbContext.SaveChanges();

                    return Json(new { success = true, edit = true });
                }
                catch (Exception)
                {
                    return Json(new { success = false, edit = true });
                }
            }
            else
            {
                model.CreatedDate = DateTime.Now;
                dbContext.categories.Add(model);
                try
                {
                    dbContext.SaveChanges();
                    return Json(new { success = true, edit = false });
                }
                catch (Exception)
                {
                    return Json(new { success = false, edit = false });
                }
            }
        }

        // POST: Admin/Category/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            try
            {
                var cate = dbContext.categories.Where(x => x.id == id).FirstOrDefault();
                dbContext.categories.Remove(cate);

                dbContext.SaveChanges();
                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }
    }
}
