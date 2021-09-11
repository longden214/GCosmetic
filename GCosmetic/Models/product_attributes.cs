namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class product_attributes
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public product_attributes()
        {
            product_attribute_values = new HashSet<product_attribute_values>();
        }

        [Key]
        public int attribute_id { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        public int? product_id { get; set; }

        public virtual product product { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<product_attribute_values> product_attribute_values { get; set; }
    }
}
