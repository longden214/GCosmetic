namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class product_attribute_values
    {
        [Key]
        public int value_id { get; set; }

        [Required]
        [StringLength(255)]
        public string name { get; set; }

        public int? attribute_id { get; set; }

        public bool? status { get; set; }
        public virtual product_attributes product_attributes { get; set; }
    }
}
