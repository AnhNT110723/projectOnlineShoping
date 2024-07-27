using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public class TableDTO
    {
        public int TableId { get; set; }

        public string? TableName { get; set; }

        public int? TableTypeId { get; set; }

        public bool Status { get; set; }

        public DateTime? OpenTime { get; set; }

        public DateTime? CloseTime { get; set; }

        public int? FoodId { get; set; }

        public string? TableTypeName { get; set; }


        public virtual Food? Food { get; set; }

        public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

        public virtual Tabletype? TableType { get; set; }
    }
}
