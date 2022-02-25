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
    public class ProductController : Controller
    {
        private CosmeticDbContext dbContext = new CosmeticDbContext();
        // GET: Admin/Product
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
            var products = dbContext.Database.SqlQuery<product>("sp_product_list @search", sqlParams).ToList();

            var ProductList = (from p in products
                               join c in dbContext.categories on p.category_id equals c.id
                               orderby p.id descending
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.image,
                                   p.image_list,
                                   p.price,
                                   p.category_id,
                                   p.description,
                                   p.brand,
                                   p.content,
                                   p.slug,
                                   p.status,
                                   p.viewCount,
                                   p.CreatedDate,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price),
                                   cateName = c.name
                               }).ToList();

            var _pageSize = pageSize ?? 8;
            var pageIndex = page ?? 1;
            var totalPage = ProductList.Count();
            var numberPage = Math.Ceiling((double)totalPage / _pageSize);

            var data = ProductList.Skip((pageIndex - 1) * _pageSize).Take(_pageSize);

            return Json(new
            {
                proList = data,
                TotalItems = totalPage,
                CurrentPage = pageIndex,
                NumberPage = numberPage,
                PageSize = _pageSize
            }, JsonRequestBehavior.AllowGet);
        }

        // GET: Admin/Product/Create
        public ActionResult Create()
        {
            setViewBag();
            return View();
        }

        public void setViewBag(int? selected = null)
        {
            ViewBag.CateList = new SelectList(dbContext.categories.ToList(), "id", "name", selected);
        }

        [HttpPost]
        public JsonResult SaveProduct(product productData)
        {
            int Proid = 0;
            try
            {
                if (productData != null)
                {
                    object[] sqlParams =
                    {
                        new SqlParameter("@name",productData.name),
                        new SqlParameter("@brand",productData.brand),
                        new SqlParameter("@image",productData.image),
                        new SqlParameter("@image_list",productData.image_list),
                        new SqlParameter("@price",productData.price),
                        new SqlParameter("@description",productData.description != null ? productData.description:""),
                        new SqlParameter("@category_id",productData.category_id),
                        new SqlParameter("@content",productData.content != null ? productData.content:""),
                        new SqlParameter("@status",productData.status),
                        new SqlParameter("@slug",productData.slug),
                    };

                    var id = dbContext.Database.SqlQuery<int>("sp_InsertProduct @name,@brand,@image,@image_list,@price,@description,@category_id,@content,@status,@slug", sqlParams).Single();
                    Proid = id;
                }

                return Json(new { proId = Proid, newurl = Url.Action("Index", "Product") }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new { proId = Proid }, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult SaveAttribute(List<product_attributes> dataAttribute)
        {
            int[] AttrId = new int[dataAttribute.Count];
            try
            {
                if (dataAttribute != null)
                {
                    var i = 0;
                    foreach (var item in dataAttribute)
                    {
                        object[] sqlParams =
                        {
                            new SqlParameter("@name",item.name),
                            new SqlParameter("@product_id",item.product_id),
                        };

                        var id = dbContext.Database.SqlQuery<int>("sp_InsertAttribute @name,@product_id", sqlParams).Single();
                        AttrId[i] = id;
                        i++;
                    }

                }
                return Json(AttrId, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(AttrId, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult SaveAttributeValue(List<product_attribute_values> dataAttributeValues)
        {
            bool result = false;
            try
            {
                if (dataAttributeValues != null)
                {

                    foreach (var item in dataAttributeValues)
                    {
                        object[] sqlParams =
                        {
                            new SqlParameter("@name",item.name),
                            new SqlParameter("@attribute_id",item.attribute_id),
                            new SqlParameter("@status",item.status),
                        };

                        var id = dbContext.Database.SqlQuery<int>("sp_InsertAttributeValues @name,@attribute_id,@status", sqlParams).Single();
                        result = true;
                    }

                }
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(result, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult SaveSkus(List<sku> dataSkus)
        {

            try
            {
                if (dataSkus != null)
                {

                    foreach (var item in dataSkus)
                    {
                        object[] sqlParams =
                        {
                            new SqlParameter("@sku",item.sku1),
                            new SqlParameter("@product_id",item.product_id),
                            new SqlParameter("@price",item.price),
                            new SqlParameter("@sku_attr",item.sku_attributes)
                        };

                        var id = dbContext.Database.SqlQuery<int>("sp_InsertSku @sku,@product_id,@price,@sku_attr", sqlParams).Single();

                    }

                }

                return Json(new { ok = true, newurl = Url.Action("Index", "Product") }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new { ok = false }, JsonRequestBehavior.AllowGet);
            }

        }

        // GET: Admin/Product/Edit/5
        public ActionResult Edit(int proId)
        {
            var pro = dbContext.products.Find(proId);

            var AttrValueList = (from ats in dbContext.product_attributes
                                 join pd in dbContext.products on ats.product_id equals pd.id
                                 join av in dbContext.product_attribute_values on ats.attribute_id equals av.attribute_id
                                 where pd.id == proId
                                 select new
                                 {
                                     ValueId = av.value_id,
                                     ValueName = av.name,
                                     AttrId = av.attribute_id,
                                     Status = av.status
                                 }).ToList();

            ViewBag.ProAttributes = dbContext.product_attributes.Where(a => a.product_id == proId).Select(a => new { a.attribute_id, a.name }).ToList();
            ViewBag.AttrValues = AttrValueList;
            ViewBag.ProSkus = dbContext.skus.Where(a => a.product_id == proId).Select(a => new { a.id, a.price, a.sku1, a.product_id }).ToList();

            setViewBag(pro.category_id);
            return View(pro);
        }

        // POST: Admin/Product/Edit/5
        [HttpPost]
        public JsonResult EditProduct(product productData)
        {
           
            int Proid = 0;
            try
            {
                if (productData != null)
                {
                    object[] sqlParams =
                    {
                        new SqlParameter("@id",productData.id),
                        new SqlParameter("@name",productData.name),
                        new SqlParameter("@brand",productData.brand),
                        new SqlParameter("@image",productData.image),
                        new SqlParameter("@image_list",productData.image_list),
                        new SqlParameter("@price",productData.price),
                        new SqlParameter("@description",productData.description != null ? productData.description:""),
                        new SqlParameter("@category_id",productData.category_id),
                        new SqlParameter("@content",productData.content != null ? productData.content:""),
                        new SqlParameter("@status",productData.status),
                        new SqlParameter("@slug",productData.slug),
                    };

                    var id = dbContext.Database.SqlQuery<int>("sp_UpdateProduct @id,@name,@brand,@image,@image_list,@price,@description,@category_id,@content,@status,@slug", sqlParams).Single();
                    Proid = id;
                    if (Proid > 0)
                    {
                        DeleteAttr(Proid);
                        dbContext.SaveChanges();
                    }
                }
                return Json(new { proId = Proid, newurl = Url.Action("Index", "Product") }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                setViewBag(productData.id);
                return Json(new { proId = Proid }, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult EditStatus(int id)
        {
            bool result = false;
            try
            {

                var pro1 = dbContext.products.Find(id);
                var pro2 = dbContext.products.Find(id);
                if (pro1.status == true)
                {
                    pro2.status = false;
                }
                else
                {
                    pro2.status = true;
                }

                dbContext.Entry(pro2).State = EntityState.Modified;
                dbContext.SaveChanges();
                result = true;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(result, JsonRequestBehavior.AllowGet);
            }
        }

        public void DeleteAttr(int Proid)
        {
            var ProAttr = dbContext.product_attributes.Where(p => p.product_id == Proid).ToList();

            foreach (var item in ProAttr)
            {
                var ValueList = dbContext.product_attribute_values.Where(v => v.attribute_id == item.attribute_id).ToList();
                foreach (var valueItem in ValueList)
                {
                    dbContext.product_attribute_values.Remove(valueItem);
                }
            }

            foreach (var item in ProAttr)
            {
                dbContext.product_attributes.Remove(item);
            }

            var ProSkus = dbContext.skus.Where(s => s.product_id == Proid).ToList();
            foreach (var item in ProSkus)
            {
                dbContext.skus.Remove(item);
            }
        }

        // POST: Admin/Product/Delete/5
        [HttpPost]
        public JsonResult DeleteProduct(int id)
        {
            var result = false;
            try
            {
                DeleteAttr(id);
                var proItem = dbContext.products.Find(id);
                dbContext.products.Remove(proItem);
                dbContext.SaveChanges();

                result = true;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(result, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult AutocompleteBrand(string brand)
        {
            var proBrand = (from p in dbContext.products
                            where p.brand.ToLower().Contains(brand.ToLower())
                            group p by p.brand into b
                            select new BrandFilter
                            {
                                brandName = b.FirstOrDefault().brand,
                                brandCount = b.Count()
                            }).ToList();

            return Json(proBrand, JsonRequestBehavior.AllowGet);
        }
    }
}
