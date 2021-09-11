namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class user
    {
        public int id { get; set; }

        [Required]
        [StringLength(100)]
        public string username { get; set; }

        [Required]
        public string displayName { get; set; }

        [Required]
        public string email { get; set; }

        [StringLength(255)]
        public string avatar { get; set; }

        [StringLength(255)]
        public string password { get; set; }

        public DateTime? CreatedDate { get; set; }

        [StringLength(255)]
        public string ResetPasswordCode { get; set; }
    }
}
