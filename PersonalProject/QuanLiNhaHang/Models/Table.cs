using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Table
{
    public int TableId { get; set; }

    public string? TableName { get; set; }

    public int? TableTypeId { get; set; }

    public int? Status { get; set; }

    public DateTime? OpenTime { get; set; }

    public DateTime? CloseTime { get; set; }

    public string? BookedBy { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<TableFood> TableFoods { get; set; } = new List<TableFood>();

    public virtual Tabletype? TableType { get; set; }
}
