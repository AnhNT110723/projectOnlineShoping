using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Tabletype
{
    public int TableTypeid { get; set; }

    public string? TableTypeName { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Table> Tables { get; set; } = new List<Table>();
}
