namespace GCosmetic.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ExceptionLogger")]
    public partial class ExceptionLogger
    {
        public int Id { get; set; }

        public string ExceptionMessage { get; set; }

        [StringLength(255)]
        public string ControllerName { get; set; }

        public string ExceptionStackTrace { get; set; }

        public DateTime? LogTime { get; set; }
    }
}
