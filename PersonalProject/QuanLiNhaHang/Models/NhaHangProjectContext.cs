using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace QuanLiNhaHang.Models;

public partial class NhaHangProjectContext : DbContext
{
    public NhaHangProjectContext()
    {
    }

    public NhaHangProjectContext(DbContextOptions<NhaHangProjectContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Answer> Answers { get; set; }

    public virtual DbSet<Booking> Bookings { get; set; }

    public virtual DbSet<Food> Foods { get; set; }

    public virtual DbSet<Foodtype> Foodtypes { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Orderdetail> Orderdetails { get; set; }

    public virtual DbSet<Question> Questions { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Table> Tables { get; set; }

    public virtual DbSet<TableFood> TableFoods { get; set; }

    public virtual DbSet<Tabletype> Tabletypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=TUAN-ANH ;Initial Catalog=Nha_Hang_PROJECT; Trusted_Connection=SSPI;Encrypt=false");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.AccountId).HasName("PK__ACCOUNT__349DA5A6E82B64D3");

            entity.ToTable("ACCOUNT");

            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FullName).HasMaxLength(255);
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.Role).WithMany(p => p.Accounts)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ACCOUNT__RoleId__398D8EEE");
        });

        modelBuilder.Entity<Answer>(entity =>
        {
            entity.HasKey(e => e.AnswerId).HasName("PK__ANSWER__D4825004D7B97D97");

            entity.ToTable("ANSWER");

            entity.Property(e => e.AnswerText).HasMaxLength(1000);

            entity.HasOne(d => d.Question).WithMany(p => p.Answers)
                .HasForeignKey(d => d.QuestionId)
                .HasConstraintName("FK__ANSWER__Question__04E4BC85");
        });

        modelBuilder.Entity<Booking>(entity =>
        {
            entity.HasKey(e => e.BookingId).HasName("PK__BOOKING__73951AED57FCEC66");

            entity.ToTable("BOOKING");

            entity.Property(e => e.AccountId).HasColumnName("accountId");
            entity.Property(e => e.BookingDate).HasColumnType("datetime");

            entity.HasOne(d => d.Account).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.AccountId)
                .HasConstraintName("FK__BOOKING__account__07C12930");

            entity.HasOne(d => d.Table).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.TableId)
                .HasConstraintName("FK__BOOKING__TableId__08B54D69");

            entity.HasOne(d => d.TableType).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.TableTypeId)
                .HasConstraintName("FK__BOOKING__TableTy__09A971A2");
        });

        modelBuilder.Entity<Food>(entity =>
        {
            entity.HasKey(e => e.FoodId).HasName("PK__FOOD__856DB3EBB2520412");

            entity.ToTable("FOOD");

            entity.Property(e => e.FoodName).HasMaxLength(200);

            entity.HasOne(d => d.FoodType).WithMany(p => p.Foods)
                .HasForeignKey(d => d.FoodTypeid)
                .HasConstraintName("FK__FOOD__FoodTypeid__3E52440B");
        });

        modelBuilder.Entity<Foodtype>(entity =>
        {
            entity.HasKey(e => e.FoodTypeid).HasName("PK__FOODTYPE__D3CE2854BCC543A5");

            entity.ToTable("FOODTYPE");

            entity.Property(e => e.FoodTypeName).HasMaxLength(200);
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.HasKey(e => e.MenuId).HasName("PK__MENU__C99ED2302707A5E6");

            entity.ToTable("MENU");

            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Food).WithMany(p => p.Menus)
                .HasForeignKey(d => d.FoodId)
                .HasConstraintName("FK__MENU__FoodId__45F365D3");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__ORDER__C3905BCF677B60CC");

            entity.ToTable("ORDER");

            entity.Property(e => e.OrderDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.TotalAmount).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Account).WithMany(p => p.Orders)
                .HasForeignKey(d => d.AccountId)
                .HasConstraintName("FK__ORDER__AccountId__48CFD27E");

            entity.HasOne(d => d.Table).WithMany(p => p.Orders)
                .HasForeignKey(d => d.TableId)
                .HasConstraintName("FK__ORDER__TableId__49C3F6B7");
        });

        modelBuilder.Entity<Orderdetail>(entity =>
        {
            entity.HasKey(e => e.OrderDetailId).HasName("PK__ORDERDET__D3B9D36CD3145CBC");

            entity.ToTable("ORDERDETAIL");

            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Total).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Menu).WithMany(p => p.Orderdetails)
                .HasForeignKey(d => d.MenuId)
                .HasConstraintName("FK__ORDERDETA__MenuI__4E88ABD4");

            entity.HasOne(d => d.Order).WithMany(p => p.Orderdetails)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__ORDERDETA__Order__4D94879B");
        });

        modelBuilder.Entity<Question>(entity =>
        {
            entity.HasKey(e => e.QuestionId).HasName("PK__QUESTION__0DC06FACA128B7E5");

            entity.ToTable("QUESTION");

            entity.Property(e => e.QuestionName).HasMaxLength(1000);
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RoleId).HasName("PK__ROLE__8AFACE1AF0D1C619");

            entity.ToTable("ROLE");

            entity.Property(e => e.RoleName)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Table>(entity =>
        {
            entity.HasKey(e => e.TableId).HasName("PK__TABLE__7D5F01EE2F3854C5");

            entity.ToTable("TABLE");

            entity.Property(e => e.BookedBy).HasMaxLength(255);
            entity.Property(e => e.CloseTime).HasColumnType("datetime");
            entity.Property(e => e.OpenTime).HasColumnType("datetime");
            entity.Property(e => e.TableName).HasMaxLength(50);

            entity.HasOne(d => d.TableType).WithMany(p => p.Tables)
                .HasForeignKey(d => d.TableTypeId)
                .HasConstraintName("FK__TABLE__TableType__4316F928");
        });

        modelBuilder.Entity<TableFood>(entity =>
        {
            entity.HasKey(e => e.TableFoodId).HasName("PK__TABLE_FO__827E385CB245599C");

            entity.ToTable("TABLE_FOOD");

            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Total).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Food).WithMany(p => p.TableFoods)
                .HasForeignKey(d => d.FoodId)
                .HasConstraintName("FK__TABLE_FOO__FoodI__52593CB8");

            entity.HasOne(d => d.Table).WithMany(p => p.TableFoods)
                .HasForeignKey(d => d.TableId)
                .HasConstraintName("FK__TABLE_FOO__Table__5165187F");
        });

        modelBuilder.Entity<Tabletype>(entity =>
        {
            entity.HasKey(e => e.TableTypeid).HasName("PK__TABLETYP__2B98ED518F4D2DD7");

            entity.ToTable("TABLETYPE");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
