using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public class BookingDTO
    {
        public int BookingId { get; set; }
        public int? AccountId { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public int? TableId { get; set; }
        public string? TableName { get; set; }
        public DateTime BookingDate { get; set; }
        public int NumberOfGuests { get; set; }
        public int? Status { get; set; }
        public int TableTypeId { get; set; }
        public string TableTypeName { get; set; }
        public int? StaffId { get; set; }
        public string StaffName { get; set; }
        public TimeOnly BookingTime { get; set; }

        public string statusText
        {
            get
            {
                if (Status == 0) return "Request";
                else if (Status == 1) return "Booked";
                else if (Status == 2) return "Success";
                else if (Status == 3) return "Customer Cancel";
                else return "Reject";
            }
        }   
    }
}
