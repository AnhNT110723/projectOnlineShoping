using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public class OrderDTO
    {
        public int OrderId { get; set; }

        public int? AccountId { get; set; }

        public int? TableId { get; set; }
        public string TableName { get; set; }

        public DateTime OrderDate { get; set; }

        public decimal TotalAmount { get; set; }

        public int Status { get; set; }

        public string statusText
        {
            get
            {
                return Status == 0 ? "Paying" : "Success";
            }
        }

    }
}
