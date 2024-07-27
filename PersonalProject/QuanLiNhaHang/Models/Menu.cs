using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Menu
{
    public int MenuId { get; set; }

    public int? FoodId { get; set; }

    public decimal Price { get; set; }

    public virtual Food? Food { get; set; }

    public virtual ICollection<Orderdetail> Orderdetails { get; set; } = new List<Orderdetail>();
}
