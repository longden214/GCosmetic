using GCosmetic.Areas.Admin.Data;
using GCosmetic.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Security;

namespace GCosmetic.Areas.Admin.Controllers
{
    public class AccountController : Controller
    {
        private CosmeticDbContext dbContext = new CosmeticDbContext();
        private AccountModel accModel = new AccountModel();
        // GET: Admin/Account
        [Authorize]
        public ActionResult Index()
        {
            //var name = Session["username"].ToString();
            var name = HttpContext.Application["uName"].ToString();
            ViewBag.User = dbContext.users.FirstOrDefault(x => x.username == name);
            ViewBag.Configs = dbContext.configs.ToList();

            return View();
        }

        public ActionResult Login()
        {
            //Session["logo"] = dbContext.configs.Find(5).value;
            HttpContext.Application["logo"] = dbContext.configs.Find(5).value;

            var favicon = dbContext.configs.Find(6);
            HttpContext.Application["favicon"] = favicon.value;
            return View();
        }

        public void SendVerificationLinkEmail(string emailID, string activationCode, string emailFor)
        {
            var verifyUrl = "/Admin/Account/" + emailFor + "/" + activationCode;
            var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

            var fromEmail = new MailAddress("My Email", "Reset Password");
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = "My Password";

            string subject = "";
            string body = "";

            if (emailFor == "ResetPassword")
            {
                subject = "Thông báo mới từ G Cosmetic";
                
                body = System.IO.File.ReadAllText(Server.MapPath("~/Content/client/template/reset-password.html"));
                //string strHost = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery,"");
                //body = body.Replace("{{logoLink}}", strHost);

                //string logoImg = dbContext.configs.Find(5).value;
                //var logo = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, logoImg);
                //body = body.Replace("{{logo}}", logo);
                body = body.Replace("{{linkReset}}", link);
            }


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
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            HttpContext.Application["logo"] = dbContext.configs.Find(5).value;

            var favicon = dbContext.configs.Find(6);
            HttpContext.Application["favicon"] = favicon.value;

            ViewBag.Status = -1;
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string EmailID)
        {
            string message = "";
            int status = 0;

            var account = dbContext.users.Where(a => a.email == EmailID).FirstOrDefault();
            if (account != null)
            {
                //Send email for reset password
                string resetCode = Guid.NewGuid().ToString();
                SendVerificationLinkEmail(account.email, resetCode, "ResetPassword");

                account.ResetPasswordCode = resetCode;

                dbContext.Configuration.ValidateOnSaveEnabled = false;
                dbContext.SaveChanges();

                status = 1;
                message = "Liên kết đặt lại mật khẩu đã được gửi đến địa chỉ Email của bạn.";
            }
            else
            {
                message = "Không tìm thấy tài khoản.";
            }

            ViewBag.Status = status;
            ViewBag.Message = message;
            return View();
        }

        public ActionResult ResetPassword(string id)
        {
            HttpContext.Application["logo"] = dbContext.configs.Find(5).value;

            var favicon = dbContext.configs.Find(6);
            HttpContext.Application["favicon"] = favicon.value;

            if (string.IsNullOrWhiteSpace(id))
            {
                return HttpNotFound();
            }

            var user = dbContext.users.Where(a => a.ResetPasswordCode == id).FirstOrDefault();
            if (user != null)
            {
                ResetPasswordModel model = new ResetPasswordModel();
                model.ResetCode = id;
                return View(model);
            }
            else
            {
                return HttpNotFound();
            }

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordModel model)
        {
            
            if (ModelState.IsValid)
            {
                    var user = dbContext.users.Where(a => a.ResetPasswordCode == model.ResetCode).FirstOrDefault();
                    if (user != null)
                    {
                        user.password = new AccountModel().MD5Hash(model.NewPassword);
                        user.ResetPasswordCode = "";
                        dbContext.Configuration.ValidateOnSaveEnabled = false;
                        dbContext.SaveChanges();

                        return RedirectToAction("Login");
                    }
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {

            if (ModelState.IsValid)
            {
                var data = new AccountModel().Login(model.username, accModel.MD5Hash(model.password));
                if (data.Count() > 0)
                {
                    FormsAuthentication.SetAuthCookie(model.username, model.RememberMe);
                    Session["username"] = data.FirstOrDefault().username;
                    Session["id"] = data.FirstOrDefault().id;
                    //Session["avatar"] = data.FirstOrDefault().avatar;
                    //Session["displayName"] = data.FirstOrDefault().displayName;

                    HttpContext.Application["uName"] = data.FirstOrDefault().username;
                    HttpContext.Application["uId"] = data.FirstOrDefault().id;
                    HttpContext.Application["avatar"] = data.FirstOrDefault().avatar;
                    HttpContext.Application["displayName"] = data.FirstOrDefault().displayName;

                    var favicon = dbContext.configs.Find(6);
                    HttpContext.Application["favicon"] = favicon.value;
                    return RedirectToAction("Index", "Dashboard");
                }
                else
                {
                    ModelState.AddModelError("", "Tài khoản không chính xác!");
                }
            }

            return View(model);
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            HttpContext.Application.Clear();
            return RedirectToAction("Login", "Account");
        }

        [HttpPost]
        public ActionResult EditAccount(user model)
        {
            //var uid = Convert.ToInt32(Session["id"].ToString());
            var uid = Convert.ToInt32(HttpContext.Application["uId"].ToString());
            var item = dbContext.users.Find(uid);
            item.username = model.username;
            item.displayName = model.displayName;
            item.email = model.email;
            item.avatar = model.avatar;
            dbContext.Entry(item).State = EntityState.Modified;
            try
            {
                HttpContext.Application["avatar"] = model.avatar;
                HttpContext.Application["displayName"] = model.displayName;
                //Session["avatar"] = model.avatar;
                dbContext.SaveChanges();

                return Json(new { success = true, avatar_src = HttpContext.Application["avatar"].ToString(), displayName = HttpContext.Application["displayName"].ToString() });
            }
            catch (Exception)
            {
                return Json(new { success = false });
            }
        }

        [HttpPost]
        public ActionResult ChangePassword(user model)
        {
            var uid = Convert.ToInt32(HttpContext.Application["uId"].ToString());
            var item = dbContext.users.Find(uid);
            item.password = new AccountModel().MD5Hash(model.password);
            dbContext.Entry(item).State = EntityState.Modified;
            try
            {
                dbContext.SaveChanges();

                return Json(new { success = true });
            }
            catch (Exception)
            {
                return Json(new { success = false });
            }
        }

        [HttpPost]
        public JsonResult ValidationPassword(string pass)
        {
            var uid = Convert.ToInt32(HttpContext.Application["uId"].ToString());
            var _pass = new AccountModel().MD5Hash(pass);

            var data = dbContext.users.Where(x => x.id == uid && x.password == _pass).ToList();
            if (data.Count() > 0)
            {
                return Json(new { success = true });
            }
            else
            {
                return Json(new { success = false });
            }
        }

        [HttpPost]
        public ActionResult EditWebsite(List<config> models)
        {
            var logo = "";
            var favicon = "";
            foreach (var cg in models)
            {
                var item = dbContext.configs.Find(cg.id);
                item.value = cg.value;
                item.status = cg.status;
                if (cg.id == 5)
                {
                    logo = cg.value;
                }

                if (cg.id == 6)
                {
                    favicon = cg.value;
                }
                dbContext.Entry(item).State = EntityState.Modified;
            }

            try
            {
                dbContext.SaveChanges();
                //Session["logo"] = logo;
                HttpContext.Application["logo"] = logo;
                HttpContext.Application["favicon"] = favicon;

                return Json(new { success = true, adminLogo = HttpContext.Application["logo"].ToString() });
            }
            catch (Exception)
            {
                return Json(new { success = false });
            }
        }
    }
}