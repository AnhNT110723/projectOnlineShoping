using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public class OrderDetailDTO
    {
        public int OrderDetailId { get; set; }

        public int? OrderId { get; set; }

        public string FoodName { get; set; }

        public int Quantity { get; set; }

        public decimal Price { get; set; }

        public decimal Total { get; set; }

    }
}
