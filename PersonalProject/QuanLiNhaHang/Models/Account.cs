using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Account
{
    public int AccountId { get; set; }

    public string? FullName { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public int? Gender { get; set; }

    public int RoleId { get; set; }

    public bool Status { get; set; }

    public DateOnly? DateOfBirth { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Role Role { get; set; } = null!;
}
