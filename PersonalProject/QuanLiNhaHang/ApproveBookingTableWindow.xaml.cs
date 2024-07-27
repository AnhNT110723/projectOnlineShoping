using QuanLiNhaHang.ViewModel.Staff;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace QuanLiNhaHang
{
    /// <summary>
    /// Interaction logic for Approve_RejectBookingTableWindow.xaml
    /// </summary>
    public partial class ApproveBookingTableWindow : Window
    {
        public ApproveBookingTableWindow(int bookingId, string tableName, string name, string Email, DateTime BookingDate, TimeOnly time, int tableTypeid)
        {
            InitializeComponent();
            this.DataContext = new ApproveOrRejectBookingViewModel(bookingId, tableName, name, Email,BookingDate,time,tableTypeid);
        }
    }
}
