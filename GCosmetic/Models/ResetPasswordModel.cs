using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GCosmetic.Models
{
    public class ResetPasswordModel
    {
        [Required(ErrorMessage = "Vui lòng nhập mật khẩu mới", AllowEmptyStrings = false)]
        [DataType(DataType.Password)]
        [RegularExpression(@"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*$", ErrorMessage = "Mật khẩu ít nhất 8 ký tự và có ít nhất 1 chữ số, 1 chữ hoa và 1 chữ thường!")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu mới và mật khẩu xác nhận không khớp")]
        public string ConfirmPassword { get; set; }

        [Required]
        public string ResetCode { get; set; }
    }
}