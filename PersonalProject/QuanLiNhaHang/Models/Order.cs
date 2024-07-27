using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public int? AccountId { get; set; }

    public int? TableId { get; set; }

    public DateTime OrderDate { get; set; }

    public decimal TotalAmount { get; set; }

    public int Status { get; set; }

    public virtual Account? Account { get; set; }

    public virtual ICollection<Orderdetail> Orderdetails { get; set; } = new List<Orderdetail>();

    public virtual Table? Table { get; set; }
}
