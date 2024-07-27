using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class TableFood
{
    public int TableFoodId { get; set; }

    public int? TableId { get; set; }

    public int? FoodId { get; set; }

    public int Quantity { get; set; }

    public decimal Price { get; set; }

    public decimal Total { get; set; }

    public virtual Food? Food { get; set; }

    public virtual Table? Table { get; set; }
}
