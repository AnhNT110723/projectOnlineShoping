using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Food
{
    public int FoodId { get; set; }

    public string? FoodName { get; set; }

    public int? FoodTypeid { get; set; }

    public virtual Foodtype? FoodType { get; set; }

    public virtual ICollection<Menu> Menus { get; set; } = new List<Menu>();

    public virtual ICollection<TableFood> TableFoods { get; set; } = new List<TableFood>();
}
