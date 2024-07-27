using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
   public class AccountDTO
    {
        public int AccountId { get; set; }

        public string? FullName { get; set; }

        public string Email { get; set; } = null!;

        public string Password { get; set; } = null!;

        public int? Gender { get; set; }

        public int RoleId { get; set; }

        public DateOnly? DateOfBirth { get; set; }

        public bool Status { get; set; }
        public string? RoleName { get; set; }

        public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

        public virtual Role Role { get; set; } = null!;
    }
}
