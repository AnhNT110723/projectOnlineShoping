using QuanLiNhaHang.Models;
using QuanLiNhaHang.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel.Staff
{
     public class RejectBookingViewModel : BaseViewModel
    {

        private string _Content;
        public string Content { get => _Content; set { _Content = value; OnPropertyChanged(); } }
        public ICommand RejectCommand { get; set; }
        public ICommand CancelCommand { get; set; }

        public RejectBookingViewModel(int bookingId, string tableName, string name, string Email, DateTime BookingDate, TimeOnly time, int tableTypeid)
        {
            RejectBookingTableAndSendEmail(bookingId, Email, Content, tableName);
            Cancel();
        }


        public void RejectBookingTableAndSendEmail(int bookingId, string Email, string Content, string tableName)
        {
            RejectCommand = new RelayCommand<Window>((p) =>
            {
                return true;
            }, (p) =>
            {
                MessageBoxResult result = MessageBox.Show("Are you sure want to reject to this request?", "", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    SendToEmail.SendEmail(Email, Content, "Yêu cầu đặt bàn của bạn đã bị hủy bỏ");
                    using (var context = new NhaHangProjectContext())
                    {
                        var queryTableID = context.Tables.FirstOrDefault(x => x.TableName == tableName);
                        var query = context.Bookings.FirstOrDefault(x => x.BookingId == bookingId);

                        if (query == null)
                        {
                            MessageBox.Show("Booking not found.");
                            return; // Hoặc xử lý theo cách khác nếu cần
                        }
                        query.Status = 4;
                        context.SaveChanges();
                        MessageBox.Show("Successfull");

                        NotifyViewModels();

                        // Close the current window
                        if (p != null)
                        {

                            p.Close();
                        }
                    }
                }
            });
        }

        private void NotifyViewModels()
        {
            var manageBookingWindow = Application.Current.Windows.OfType<ManageBookingWindow>().FirstOrDefault();
            // Nếu cửa sổ không tồn tại, tạo và mở nó
            if (manageBookingWindow == null)
            {
                manageBookingWindow = new ManageBookingWindow();
                manageBookingWindow.Show();
            }

            var bookingVm = manageBookingWindow.DataContext as ManageBookingViewModel;
            bookingVm?.readData();


            // Tìm cửa sổ MainStaffWindow và cập nhật dữ liệu
            var mainWindow = Application.Current.Windows.OfType<MainStaffWindow>().FirstOrDefault();
            if (mainWindow != null)
            {
                var mainViewModel = mainWindow.DataContext as MainWindowViewModel;
                mainViewModel?.LoadTables();

            }
            else
            {
                MessageBox.Show("MainStaffWindow not found.");
            }
        }
        public void Cancel()
        {
            CancelCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                if (p != null)
                {
                    ManageBookingWindow booking = new ManageBookingWindow();
                    booking.Show();
                    p.Close();
                }

            });

        }
    }
}
