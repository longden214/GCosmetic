using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace GCosmetic.Models
{
    public partial class CosmeticDbContext : DbContext
    {
        public CosmeticDbContext()
            : base("name=CosmeticDbContext")
        {
        }

        public virtual DbSet<category> categories { get; set; }
        public virtual DbSet<config> configs { get; set; }
        public virtual DbSet<ExceptionLogger> ExceptionLoggers { get; set; }
        public virtual DbSet<product> products { get; set; }
        public virtual DbSet<product_attribute_values> product_attribute_values { get; set; }
        public virtual DbSet<product_attributes> product_attributes { get; set; }
        public virtual DbSet<sku> skus { get; set; }
        public virtual DbSet<user> users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<category>()
                .HasMany(e => e.products)
                .WithOptional(e => e.category)
                .HasForeignKey(e => e.category_id);

            modelBuilder.Entity<config>()
                .Property(e => e.url)
                .IsUnicode(false);

            modelBuilder.Entity<ExceptionLogger>()
                .Property(e => e.ControllerName)
                .IsUnicode(false);

            modelBuilder.Entity<product>()
                .Property(e => e.image)
                .IsUnicode(false);

            modelBuilder.Entity<product>()
                .Property(e => e.image_list)
                .IsUnicode(false);

            modelBuilder.Entity<product>()
                .HasMany(e => e.product_attributes)
                .WithOptional(e => e.product)
                .HasForeignKey(e => e.product_id);

            modelBuilder.Entity<product>()
                .HasMany(e => e.skus)
                .WithOptional(e => e.product)
                .HasForeignKey(e => e.product_id);

            modelBuilder.Entity<sku>()
                .Property(e => e.sku1)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.username)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.email)
                .IsUnicode(false);

            modelBuilder.Entity<user>()
                .Property(e => e.password)
                .IsUnicode(false);
        }
    }
}
