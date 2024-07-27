using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public int? AccountId { get; set; }

    public int? TableId { get; set; }

    public DateTime BookingDate { get; set; }

    public TimeOnly BookingTime { get; set; }

    public int NumberOfGuests { get; set; }

    public int? Status { get; set; }

    public int? TableTypeId { get; set; }

    public int? StaffId { get; set; }

    public virtual Account? Account { get; set; }

    public virtual Table? Table { get; set; }

    public virtual Tabletype? TableType { get; set; }
}
