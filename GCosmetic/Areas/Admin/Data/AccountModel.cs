using GCosmetic.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace GCosmetic.Areas.Admin.Data
{
    public class AccountModel
    {

        private CosmeticDbContext dbContext = null;
        
        public AccountModel()
        {
            dbContext = new CosmeticDbContext();
        }

        public List<user> Login(string uname,string password)
        {
            object[] sqlParams =
            {
                new SqlParameter("@username",uname),
                new SqlParameter("@password",password),
            };
            return dbContext.Database.SqlQuery<user>("sp_account_login @username,@password", sqlParams).ToList();
        }

        public user GetAccount(string uname)
        {
            return dbContext.users.SingleOrDefault(x => x.username == uname);
        }

        public string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text  
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it  
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits  
                //for each byte  
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }

       
    }

    public class LoginViewModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Vui lòng nhập tên tài khoản!")]
        public string username { set; get; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Vui lòng nhập mật khẩu!")]
        public string password { set; get; }
        public bool RememberMe { set; get; }
    }
}