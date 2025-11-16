using Hr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Hr.Infrastructure.Data;

public class HrDbContext : DbContext
{
    public HrDbContext(DbContextOptions<HrDbContext> options) : base(options) { }

    public DbSet<Employee> Employees => Set<Employee>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Employee>().HasKey(e => e.Id);
        modelBuilder.Entity<Employee>().HasIndex(e => e.EmployeeNumber).IsUnique();
        modelBuilder.Entity<Employee>().Property(e => e.EmployeeNumber).HasMaxLength(64);
        modelBuilder.Entity<Employee>().Property(e => e.FirstName).HasMaxLength(128);
        modelBuilder.Entity<Employee>().Property(e => e.LastName).HasMaxLength(128);
        modelBuilder.Entity<Employee>().Property(e => e.FullName).HasMaxLength(256);
        modelBuilder.Entity<Employee>().Property(e => e.Status).HasMaxLength(32);
    }
}