using Microsoft.EntityFrameworkCore.Metadata.Internal;
using QuanLiNhaHang.Models;
using QuanLiNhaHang.Utils;
using QuanLiNhaHang.ViewModel.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel.Staff
{
    public class ApproveOrRejectBookingViewModel : BaseViewModel
    {






        private string _Content;
        public string Content { get => _Content; set { _Content = value; OnPropertyChanged(); } }
        public ICommand ApproveCommand { get; set; }
        public ICommand CancelCommand { get; set; }
        public ApproveOrRejectBookingViewModel(int bookingId, string tableName, string name, string Email, DateTime BookingDate, TimeOnly time, int tableTypeid)
        {
            using (var context = new NhaHangProjectContext())
            {
                var queryTableType = context.Tabletypes.FirstOrDefault(t => t.TableTypeid == tableTypeid);
                Content = "Xin chào: " + name + "\n"
                    + "Quý khách đã đặt bàn thành công\n" +
                    "Tên Bàn  : " + tableName + "\n" +
                    "Loại Bàn : " + queryTableType.TableTypeName + "\n" +
                    "Ngày     : " + BookingDate + "\n" +
                    "Thời Gian:" + time + "\n" +
                    "Thời gian đặt bàn là 2 tiếng kể từ khi quý khách nhận được Email, nếu quý khách sau 2 tiếng quý khách vẫn chưa mở bàn thì trạng thái \"đặt bàn\" sẽ mất hiệu lực.\n" +
                    "Cám ơn quý khách.";
            }

            ApproveBookingTableAndSendEmail(bookingId, Email, Content, tableName);
            Cancel();
        }

        public void ApproveBookingTableAndSendEmail(int bookingId, string Email, string Content, string tableName)
        {
            ApproveCommand = new RelayCommand<Window>((p) =>
            {
                return true;
            }, (p) =>
            {
                MessageBoxResult result = MessageBox.Show("Are you sure want to approve to this request?", "", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    var StaffAccount = Application.Current.Properties["LoggedInUser"] as AccountDTO;
                    SendToEmail.SendEmail(Email, Content, "Yêu cầu đặt bàn của bạn đã được chấp thuận");
                    using (var context = new NhaHangProjectContext())
                    {
                        var queryTableID = context.Tables.FirstOrDefault(x => x.TableName == tableName);
                        var query = context.Bookings.FirstOrDefault(x => x.BookingId == bookingId);

                        if (query == null)
                        {
                            MessageBox.Show("Booking not found.");
                            return; // Hoặc xử lý theo cách khác nếu cần
                        }
                        if(queryTableID == null)
                        {
                            MessageBox.Show("Table not found.");
                            return; // Hoặc xử lý theo cách khác nếu cần
                        }
                        query.TableId = queryTableID.TableId;
                        query.Status = 1;
                        query.StaffId = StaffAccount.AccountId;
                        context.SaveChanges();
                        MessageBox.Show("Successfull");



                        NotifyViewModels(queryTableID.TableId);

                        // Close the current window
                        if (p != null)
                        {
                            p.Close();
                        }
                    }
                }
            });
        }

        private void NotifyViewModels(int tableId)
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

            //Đồng bộ hóa dữ liệu cho admin
            var manageActivityWindow = new ManageActivityWindow();
            manageActivityWindow.Show();
            var activityVm = manageActivityWindow.DataContext as ManageActivityViewModel;
            activityVm?.ReadData();
            manageActivityWindow.Close();

            // Tìm cửa sổ MainStaffWindow và cập nhật dữ liệu
            var mainWindow = Application.Current.Windows.OfType<MainStaffWindow>().FirstOrDefault();
            if (mainWindow != null)
            {
                var mainViewModel = mainWindow.DataContext as MainWindowViewModel;
                mainViewModel?.UpdateTableStatus(tableId, 2);
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
