using GCosmetic.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace GCosmetic.Controllers
{
    public class HomeController : Controller
    {
        private CosmeticDbContext dbContext = new CosmeticDbContext();

        public ActionResult Index()
        {
            var proBrand = (from p in dbContext.products
                            group p by p.brand into b
                            select new BrandFilter
                            {
                                brandName = b.FirstOrDefault().brand,
                                brandCount = b.Count()
                            }).ToList();

            var proCates = (from p in dbContext.products
                            join c in dbContext.categories on p.category_id equals c.id
                            group p by p.category_id into cl
                            select new CategoryFilter
                            {
                                CateId = (int)cl.FirstOrDefault().category_id,
                                CateName = cl.FirstOrDefault().category.name,
                                CateCount = cl.Count()
                            }).ToList();

            ViewBag.BrandList = proBrand;
            ViewBag.CateList = proCates;
            ViewBag.Configs = dbContext.configs.Where(x => x.status == true).ToList();
            return View();
        }
        [HttpGet]
        public JsonResult loadData(int? page, int? pageSize, double? priceMin, double? priceMax, string sort = "", string cateFilter = "", string brFilter = "")
        {
            string query = "Select * from product";

            if (cateFilter != "" || brFilter != "")
            {
                query += " WHERE ";
            }

            if (cateFilter != "")
            {
                query += " category_id in (" + cateFilter + ") ";
            }

            if (cateFilter != "" && brFilter != "")
            {
                query += " AND ";
            }

            if (brFilter != "")
            {
                var brFilter2 = brFilter.Replace('"', ' ');
                query += " brand in (" + brFilter2 + ") ";
            }
            if (sort != "")
            {
                var orderBy = sort.Split('-');
                query += " order by" + " " + orderBy[0] + " " + orderBy[1];
            }

            var products = dbContext.products.SqlQuery(query).ToList();

            var ProductList = (from p in products
                               where p.status == true
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.slug,
                                   p.image,
                                   p.price,
                                   p.status,
                                   p.description,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).ToList();

            //TH 1: nằm trong khoảng
            if (priceMin <= priceMax && priceMin != null && priceMax != null)
            {
                ProductList = (from p in ProductList
                               where (p.priceMin >= priceMin && p.priceMin <= priceMax) || (p.price >= priceMin && p.price <= priceMax) || (p.priceMax >= priceMin && p.priceMax <= priceMax)
                               where p.status == true
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.slug,
                                   p.image,
                                   p.price,
                                   p.status,
                                   p.description,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).ToList();
            }

            //TH 2: từ 0 đến Max
            if (priceMin == null && priceMax > 0 && priceMax != null)
            {
                ProductList = (from p in ProductList
                               where (p.price <= priceMax) && (p.priceMax <= priceMax || p.priceMin <= priceMax)
                               where p.status == true
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.slug,
                                   p.image,
                                   p.price,
                                   p.status,
                                   p.description,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).ToList();
            }

            //TH 3: từ Min đến vô cực
            if (priceMax == null && priceMin != null && priceMin > 0)
            {
                ProductList = (from p in ProductList
                               where (p.price >= priceMin) || (p.priceMin >= priceMin || p.priceMax >= priceMin)
                               where p.status == true
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.slug,
                                   p.image,
                                   p.price,
                                   p.status,
                                   p.description,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).ToList();
            }

            var _pageSize = pageSize ?? 16;
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

        public JsonResult getBrandByCategory(string listCate)
        {
            
            if (listCate != "")
            {
                var myInClause = listCate.Split(',').Select(Int32.Parse).ToList();

                var proBrand = (from p in dbContext.products
                                where myInClause.Contains((int)p.category_id)
                                group p by p.brand into b
                                select new BrandFilter
                                {
                                    brandName = b.FirstOrDefault().brand,
                                    brandCount = b.Count()
                                }).ToList();

                return Json(new { data = proBrand, result = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var proBrand = (from p in dbContext.products
                                group p by p.brand into b
                                select new BrandFilter
                                {
                                    brandName = b.FirstOrDefault().brand,
                                    brandCount = b.Count()
                                }).ToList();

                return Json(new { data = proBrand,  result = false }, JsonRequestBehavior.AllowGet);
            }
        }

        [OutputCache(Duration = 60, VaryByParam = "id")]
        public ActionResult Product_Detail(int? id)
        {
            if (id != null)
            {
                var pro = dbContext.products.Find(id);
                if (pro == null)
                {
                    return RedirectToAction("Index");
                }
                ViewBag.Product = pro;
                ViewBag.img_list = pro.image_list.Split(',');

                var proItem = (from p in dbContext.products
                               where p.id == id
                               select new
                               {
                                   p.id,
                                   p.price,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).FirstOrDefault();
                var pr = "";
                var priceStr = String.Format("{0:#,##0}", proItem.price.Value);
                var priceMaxStr = String.Format("{0:#,##0}", proItem.priceMax.Value);
                var priceMinStr = String.Format("{0:#,##0}", proItem.priceMin.Value);

                if (proItem.price.Value > 0)
                {
                    pr = priceStr + " VNĐ";
                }
                else
                {

                    if (proItem.priceMax.Value == proItem.priceMin.Value && proItem.priceMax.Value > 0 && proItem.priceMin.Value > 0)
                    {
                        pr = priceMaxStr + " VNĐ";
                    }
                    else if (proItem.priceMax.Value == 0 && proItem.priceMin.Value == 0 && proItem.price.Value == 0)
                    {
                        pr = "Liên hệ";
                    }
                    else
                    {
                        pr = priceMinStr + " ~ " + priceMaxStr + " VNĐ";
                    }
                }

                ViewBag.price = pr;

                var AttrValueList = (from ats in dbContext.product_attributes
                                     join pd in dbContext.products on ats.product_id equals pd.id
                                     join av in dbContext.product_attribute_values on ats.attribute_id equals av.attribute_id
                                     where pd.id == id
                                     select av).ToList();

                ViewBag.ProAttributes = dbContext.product_attributes.Where(a => a.product_id == id).ToList();
                ViewBag.AttrValues = AttrValueList;

                var RelatedProducts = (from p in dbContext.products
                                       where p.category_id == pro.category_id.Value || p.brand.ToLower().Equals(pro.brand.ToLower())
                                       where p.id != pro.id && p.status == true
                                       select new RelatedProducts
                                       {
                                           id = p.id,
                                           name = p.name,
                                           slug = p.slug,
                                           image = p.image,
                                           price = (double)p.price,
                                           priceMax = (double)((from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price)),
                                           priceMin = (double)((from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price))
                                       }).ToList();

                if (RelatedProducts.Count == 0)
                {
                    RelatedProducts = (from p in dbContext.products
                                       where p.id != pro.id && p.status == true
                                       orderby p.id descending
                                       select new RelatedProducts
                                       {
                                           id = p.id,
                                           name = p.name,
                                           slug = p.slug,
                                           image = p.image,
                                           price = (double)p.price,
                                           priceMax = (double)((from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price)),
                                           priceMin = (double)((from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price))
                                       }).Take(8).ToList();
                }

                ViewBag.Related = RelatedProducts;
                ViewBag.Configs = dbContext.configs.Where(x => x.status == true).ToList();
                return View();
            }

            return RedirectToAction("Index");
        }

        public JsonResult SkuPrice(string skuAttr, int proId)
        {
            var skuItem = dbContext.skus.Where(s => s.sku_attributes == skuAttr && s.product_id == proId).FirstOrDefault();
            double price = -1;
            if (skuItem != null)
            {
                price = skuItem.price.Value;
            }

            return new JsonResult { Data = price, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        [OutputCache(Duration = 60, VaryByParam = "search")]
        public ActionResult SearchResult(string search)
        {
            ViewBag.Configs = dbContext.configs.Where(x => x.status == true).ToList();
            ViewBag.result = search;
            return View();
        }

        [HttpGet]
        public JsonResult loadDataSearch(int? page, int? pageSize, string search = "", string sort = "")
        {
            object[] sqlParams =
            {
                new SqlParameter("@search",search),
                new SqlParameter("@orderby",sort)
            };
            var products = dbContext.Database.SqlQuery<product>("sp_search_result @search,@orderby", sqlParams).ToList();

            var ProductList = (from p in products
                               where p.status == true
                               select new
                               {
                                   p.id,
                                   p.name,
                                   p.slug,
                                   p.image,
                                   p.price,
                                   p.description,
                                   priceMax = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price),
                                   priceMin = (from c in dbContext.skus where c.product_id == p.id select c).Max(c => c.price) == null ? 0 : (from c in dbContext.skus where c.product_id == p.id select c).Min(c => c.price)
                               }).ToList();

            var _pageSize = pageSize ?? 16;
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

        [HttpPost]
        public JsonResult GetSearchValue(string search)
        {
            if (search == null)
            {
                search = "";
            }
            object[] sqlParams =
           {
                new SqlParameter("@search",search)
            };

            var searchs = dbContext.Database.SqlQuery<product>("sp_product_search @search", sqlParams).ToList();

            return new JsonResult { Data = searchs, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        [HttpPost]
        public JsonResult SendRegisterEmail(string emailID)
        {
            bool status = false;
            if (emailID != "")
            {
                var fromEmail = new MailAddress("longden214@gmail.com", "Đăng ký nhận tin");
                var fromEmailPassword = "ahihi214";
                var toEmail = new MailAddress("longden214@gmail.com");
                

                string subject = "Thông báo mới từ G Cosmetic";

                string body = System.IO.File.ReadAllText(Server.MapPath("~/Content/client/template/Register-email.html"));

                body = body.Replace("{{email}}", emailID);

                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromEmail.Address, fromEmailPassword)
                };

                using (var message = new MailMessage(fromEmail, toEmail)
                {
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                })
                    smtp.Send(message);

                status = true;
            }
            return new JsonResult { Data = status, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}