using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public  class TableFoodTO
    {
        public int TableFoodId { get; set; }

        public string? TableName { get; set; }

        public string? FoodName { get; set; }

        public int Quantity { get; set; }

        public decimal Price { get; set; }

        public decimal Total { get; set; }

    }
}
