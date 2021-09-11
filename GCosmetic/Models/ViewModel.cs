using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCosmetic.Models
{
    public class BrandFilter
    {
        public string brandName { get; set; }
        public int brandCount { get; set; }
    }

    public class CategoryFilter
    {
        public int CateId { get; set; }
        public string CateName { get; set; }
        public int CateCount { get; set; }
    }

    public class RelatedProducts
    {
        public int id { get; set; }
        public string name { get; set; }
        public string slug { get; set; }
        public string image { get; set; }
        public double price { get; set; }
        public double priceMin { get; set; }
        public double priceMax { get; set; }

    }
}