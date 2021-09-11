namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("config")]
    public partial class config
    {
        public int id { get; set; }

        [StringLength(255)]
        public string title { get; set; }

        [StringLength(255)]
        public string value { get; set; }

        [Column(TypeName = "text")]
        public string url { get; set; }

        public bool? status { get; set; }

        public DateTime? CreatedDate { get; set; }
    }
}
