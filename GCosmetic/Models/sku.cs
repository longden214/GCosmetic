namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class sku
    {
        public int id { get; set; }

        public double? price { get; set; }

        public int? product_id { get; set; }

        [Column("sku")]
        [StringLength(255)]
        public string sku1 { get; set; }

        public string sku_attributes { get; set; }

        public virtual product product { get; set; }
    }
}
