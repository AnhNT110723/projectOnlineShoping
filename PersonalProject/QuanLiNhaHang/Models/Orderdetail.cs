using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Orderdetail
{
    public int OrderDetailId { get; set; }

    public int? OrderId { get; set; }

    public int? MenuId { get; set; }

    public int Quantity { get; set; }

    public decimal Price { get; set; }

    public decimal Total { get; set; }

    public virtual Menu? Menu { get; set; }

    public virtual Order? Order { get; set; }
}
