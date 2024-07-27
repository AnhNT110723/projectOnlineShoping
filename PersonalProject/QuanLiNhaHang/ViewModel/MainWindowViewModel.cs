
using QuanLiNhaHang.Models;
using QuanLiNhaHang.ViewModel.Admin;
using QuanLiNhaHang.ViewModel.Customer;
using QuanLiNhaHang.ViewModel.Staff;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
    public class MainWindowViewModel : BaseViewModel
    {
        public ICommand LoadedWindowCommand { get; set; }
        public ICommand FoodCommand { get; set; }

        public ICommand TableCommand { get; set; }
        public ICommand AccountCommand { get; set; }
        public ICommand LogoutCommand { get; set; }
        public ICommand OpenTableCommand { get; set; }
        public ICommand CloseTableCommand { get; set; }
        public ICommand BookingTableCommand { get; set; }
        #region menu 
        public ICommand MenuCommand { get; set; }
        #endregion
        public ICommand MyAccountCommand { get; set; }
        public ICommand ViewOrderCommand { get; set; }
        public ICommand RevenueCommand { get; set; }


        public ICommand FilterCommand { get; set; }
        public ICommand ManageActivityCommand { get; set; }
        //Staff
        public ICommand BookingCommand { get; set; }
        public ICommand ManageBookingCommand { get; set; }
        
        //Customer
        public ICommand ViewHistoryBookingCommand { get; set; }
        public ICommand CancelBookingTableCommand { get; set; }

        private QuanLiNhaHang.Models.Table _selectedItem;
        public QuanLiNhaHang.Models.Table SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();

            }
        }


       



        public bool IsLoaded = false;

        private ObservableCollection<Table> _Tables;
        public ObservableCollection<Table> Tables { get => _Tables; set { _Tables = value; OnPropertyChanged(); } }


        private string _searchText;
        public string SearchText
        {
            get => _searchText;
            set { _searchText = value; OnPropertyChanged(); }
        }     
        
        private int _numOfNotification;
        public int numOfNotification
        {
            get => _numOfNotification;
            set { _numOfNotification = value; OnPropertyChanged(); }
        }



        public MainWindowViewModel()
        {

            //LoadedWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            //{
            //    IsLoaded = true;
            //    if (p == null) return;

            //    var loggedInUser = Application.Current.Properties["LoggedInUser"] as AccountDTO;
            //    p.Hide();
            //    LoginWindow login = new LoginWindow();
            //    login.ShowDialog();

            //    if (login.DataContext == null) return;
            //    var loginVM = login.DataContext as LoginViewModel;
            //    if (loginVM != null)
            //    {
            //        if (loginVM.IsLogin == 1)
            //        {
            //            p.Show();

            //        }
            //        else if (loginVM.IsLogin == 2)
            //        {
            //            MainCustomerWindow mainCustomerWindow = new MainCustomerWindow();
            //            mainCustomerWindow.Show();
            //        }
            //        else
            //        {
            //            p.Close();
            //        }
            //    }

            //});

            LoadTables();
            //crud food
            FoodCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                CRUDFoodWindow fd = new CRUDFoodWindow();
                fd.ShowDialog();
            });

            //crid table
            TableCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                ManageTableWindow mtd = new ManageTableWindow();
                mtd.ShowDialog();
            });

            //CRUD Account
            AccountCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                EmployeeWindow ed = new EmployeeWindow();
                ed.DataContext = new EmployeeViewModel();
                ed.ShowDialog();
            });

            //Change profile
            MyAccountCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {

                MyAccountWindow myAccount = new MyAccountWindow();
                myAccount.DataContext = new MyAccountViewModel();
                myAccount.ShowDialog();

            });

            LogoutCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                // Xóa thông tin người dùng khỏi phiên
                Application.Current.Properties.Remove("LoggedInUser");

                if (p == null)
                {
                    MessageBox.Show("Unable to find the window.");
                    return;
                }

                LoginWindow login = new LoginWindow();
                login.Show();
                p.Close();

            });

            //Mở bàn
            OpenTableCommand = new RelayCommand<Object>((p) =>{return true; }, (p) =>
            {
                //cập nhật cho selected table thủ công
                if (p is Table selectedTable)
                {
                    SelectedItem = selectedTable;
                }

                if (SelectedItem == null)
                {
                    MessageBox.Show("SelectedItem is null");
                    return;
                }

                using (var context = new NhaHangProjectContext())
                {
                    // Cập nhật trạng thái theo table id
                    var table = context.Tables.FirstOrDefault(t => t.TableId == SelectedItem.TableId);

                    if (table == null) return;

                    if (table.Status == 1)
                    {
                        MessageBox.Show("This Table are opened.");
                    }
                    else if (table.Status == 2)
                    {
                        OpenTableWhenStatusBooked(table.TableId);
                        table.Status = 1;
                        context.SaveChanges();
                        LoadTables();
                    }
                    else
                    {
                        table.Status = 1;
                        context.SaveChanges();
                        LoadTables();
                    }
                }
            });

            //Đón bàn
            closeTable();


            //Đặt bàn online
            BookingTableCommand = new RelayCommand<Table>((p) => { return true; }, (p) => {

                if (p == null) return;
                SelectedItem = p;
                if(SelectedItem == null)
                {
                    MessageBox.Show("No table selected.");
                    return;
                }

                using(var context = new NhaHangProjectContext())
                {
                    // Cập nhật trạng thái theo table id từ cơ sở dữ liệu
                    var table = context.Tables.FirstOrDefault(t => t.TableId == SelectedItem.TableId);

                    if (table == null) return;

                    if (table.Status == 1)
                    {
                        MessageBox.Show("This Table is opened. Can't book table");
                    } 
                    else if(table.Status == 2)
                    {
                        MessageBox.Show("This Table is booked by another. Can't book table");
                    }
                    else
                    {
                        BookingWindow booking = new BookingWindow();
                        booking.ShowDialog();
                    }
                }


            });

            //chọn menu theo bàn đã mở
            MenuCommand = new RelayCommand<Table>((p) => { return true; }, (p) =>
            {

                if(p==null) return;

              
                    SelectedItem = p;

                if (SelectedItem == null)
                {
                    MessageBox.Show("No table selected.");
                    return;
                }

                using (var context = new NhaHangProjectContext())
                {
                    // Cập nhật trạng thái theo table id từ cơ sở dữ liệu
                    var table = context.Tables.FirstOrDefault(t => t.TableId == SelectedItem.TableId);

                    if (table == null) return;

                    if (table.Status == 0)
                    {
                        MessageBox.Show("This Table is closed. Can't choose menu");
                    }
                    else
                    {
                        MenuWindow menuWindow = new MenuWindow(SelectedItem.TableId);
                        menuWindow.ShowDialog();
                    }
                }

            });


            //View order
            ViewOrderCommand = new RelayCommand<Object>((p) => { return true; }, (p) =>
            {
                ViewOrderWindow viewOrderWd = new ViewOrderWindow();
                viewOrderWd.ShowDialog();
            });


            //View revenue
            RevenueCommand = new RelayCommand<Object>((p) => { return true; }, (p) =>
            {
                RevenueReportWindow viewRevenuerWd = new RevenueReportWindow();
                viewRevenuerWd.ShowDialog();
            });

            //Search theo name 
            FilterCommand = new RelayCommand<object>((p) => { return true; }, (p) =>
            {
                FilterTables();
            });


            //=======Customer==========
            //View history Booking
            ViewHistoryBookingCommand = new RelayCommand<Table>((p) => { return true; }, (p) => {

                BookingHistoryWindow booking = new BookingHistoryWindow();
                booking.DataContext = new ViewBookingHistoryViewModel();
                booking.ShowDialog();


            });

            CancelBookingTableCommand = new RelayCommand<Table>((p) => { return true; }, (p) => {
                //cập nhật cho selected table thủ công
                if (p is Table selectedTable)
                {
                    SelectedItem = selectedTable;
                }

                if (SelectedItem == null)
                {
                    MessageBox.Show("SelectedItem is null");
                    return;
                }

                using (var context = new NhaHangProjectContext())
                {
                    // Cập nhật trạng thái theo table id
                    var table = context.Tables.FirstOrDefault(t => t.TableId == SelectedItem.TableId);

                    if (table == null) return;

                    if (table.Status == 0)
                    {
                        MessageBox.Show("This Table are closed.");

                    }
                    else if (table.Status == 2)
                    {
                        QuestionCancelBookingTableWindow Cancelbooking = new QuestionCancelBookingTableWindow(SelectedItem.TableId);
                        Cancelbooking.ShowDialog();
                    }
                    else
                    {
                        MessageBox.Show("This Table are Opened.");
                    }
                }


            });

            Booking();

            //=======Staff==========
            ManageBooking();


            //=======Admin ========
            ManageActivty();
        }



        //Cập nhật trang thái của bàn khi thanh toán thành công
        public void UpdateTableStatus(int tableId, int newStatus)
        {
            var table = Tables.FirstOrDefault(t => t.TableId == tableId);
            if (table != null)
            {
                table.Status = newStatus;

                // OnPropertyChanged() không cần thiết vì ObservableCollection sẽ tự động thông báo về thay đổi

                using (var context = new NhaHangProjectContext())
                {
                    var tableInDb = context.Tables.FirstOrDefault(t => t.TableId == tableId);
                    if (tableInDb != null)
                    {
                        tableInDb.Status = newStatus;
                        context.SaveChanges(); // Lưu các thay đổi vào cơ sở dữ liệu
                    }
                }
            }
        }

        //Đọc bàn lên list 
        public void LoadTables()
        {
            using (var context = new NhaHangProjectContext())
            {
                Tables = new ObservableCollection<Table>(context.Tables.ToList());
                var queryNumber = context.Bookings
                    .Where(x => x.Status == 0)
//                    .DefaultIfEmpty() // Đảm bảo không có giá trị null
                    .ToList();
                // Kiểm tra kết quả của truy vấn
                if (queryNumber != null)
                {
                    numOfNotification = queryNumber.Count();
                }
                else
                {
                    numOfNotification = 0;
                }
            }

        }
        
        //Đóng bàn
        public void closeTable()
        {
            CloseTableCommand = new RelayCommand<Object>((p) => { return true; }, (p) =>
            {
                //cập nhật cho selected table thủ công
                if (p is Table selectedTable)
                {
                    SelectedItem = selectedTable;
                }

                if (SelectedItem == null)
                {
                    MessageBox.Show("SelectedItem is null");
                    return;
                }

                using (var context = new NhaHangProjectContext())
                {
                    // Cập nhật trạng thái theo table id
                    var table = context.Tables.FirstOrDefault(t => t.TableId == SelectedItem.TableId);

                    if (table == null) return;

                    if (table.Status == 0)
                    {
                        MessageBox.Show("This Table are closed.");
                        return;
                    }

                    table.Status = 0;
                    context.SaveChanges();
                    LoadTables();
                }
            });
        }
        //search bàn theo name
        private void FilterTables()
        {
           
            if (string.IsNullOrWhiteSpace(SearchText))
            {
                LoadTables();
            }
            else
            {
                using (var context = new NhaHangProjectContext())
                {
                    var query = context.Tables.Where(x => x.TableName.ToLower().Contains(SearchText.ToLower()));
                    Tables = new ObservableCollection<Table>(query.ToList());
                }
            }
        }

        public void Booking()
        {
            BookingCommand = new RelayCommand<object>((p) => { return true; }, (p) => {


                        BookingWindow booking = new BookingWindow();
                        booking.ShowDialog();
                


            });
        } 
        
        public void ManageBooking()
        {
            ManageBookingCommand = new RelayCommand<object>((p) => { return true; }, (p) => {

                        ManageBookingWindow booking = new ManageBookingWindow();
                        booking.ShowDialog();
                


            });
        }
        
        public void ManageActivty()
        {
            ManageActivityCommand = new RelayCommand<object>((p) => { return true; }, (p) => {

                        ManageActivityWindow activity = new ManageActivityWindow();
                        activity.ShowDialog();
            });
        }

        public void OpenTableWhenStatusBooked(int tableId)
        {
            using (var context = new NhaHangProjectContext())
            {
                var query = context.Bookings.FirstOrDefault(x => x.TableId == tableId);
                if (query == null) { return; }
                query.Status = 2;
                context.Bookings.Update(query);
                context.SaveChanges();
            }

            //Đồng bộ dữ liệu

            //Staff
            var manageBookingWindow = new ManageBookingWindow();
            manageBookingWindow.Show();

            var bookingVm = manageBookingWindow.DataContext as ManageBookingViewModel;
            bookingVm?.readData();
            manageBookingWindow.Close();

            //Đồng bộ hóa dữ liệu cho admin
            var manageActivityWindow = new ManageActivityWindow();
            manageActivityWindow.Show();
            var activityVm = manageActivityWindow.DataContext as ManageActivityViewModel;
            activityVm?.ReadData();
            manageActivityWindow.Close();


        }

    }
}
