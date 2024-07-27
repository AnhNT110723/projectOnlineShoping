using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Foodtype
{
    public int FoodTypeid { get; set; }

    public string? FoodTypeName { get; set; }

    public virtual ICollection<Food> Foods { get; set; } = new List<Food>();
}
