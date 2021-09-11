namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("product")]
    public partial class product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public product()
        {
            product_attributes = new HashSet<product_attributes>();
            skus = new HashSet<sku>();
        }

        public int id { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        [StringLength(255)]
        public string brand { get; set; }

        [StringLength(255)]
        public string image { get; set; }

        [Column(TypeName = "text")]
        public string image_list { get; set; }

        public double? price { get; set; }

        public string description { get; set; }

        public int? category_id { get; set; }

        public string content { get; set; }

        public bool? status { get; set; }

        public int? viewCount { get; set; }

        [Required]
        [StringLength(255)]
        public string slug { get; set; }

        public DateTime? CreatedDate { get; set; }

        public virtual category category { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<product_attributes> product_attributes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<sku> skus { get; set; }
    }
}
