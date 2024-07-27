using QuanLiNhaHang.Models;
using QuanLiNhaHang.ViewModel.Admin;
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
    public class BookingViewModel : BaseViewModel 
    {


        private string? _TableName;
        public string? TableName { get => _TableName; set { _TableName = value; OnPropertyChanged(); } }

        private string? _FullName;
        public string? FullName { get => _FullName; set { _FullName = value; OnPropertyChanged(); } }
        
        private string? _Email;
        public string? Email { get => _Email; set { _Email = value; OnPropertyChanged(); } }  
        
        private DateTime _SelectedDate;
        public DateTime SelectedDate { get => _SelectedDate; set { _SelectedDate = value; OnPropertyChanged(); } }
        
        private DateTime _SelectedTime;
        public DateTime SelectedTime { get => _SelectedTime; set { _SelectedTime = value; OnPropertyChanged(); } }


        private string? _TableTypeName;
        public string? TableTypeName { get => _TableTypeName; set { _TableTypeName = value; OnPropertyChanged(); } }

        private ObservableCollection<string> _TabletypeList;

        public ObservableCollection<string> TabletypeList
        {
            get => _TabletypeList;
            set
            {
                _TabletypeList = value;
                OnPropertyChanged();
            }
        }



        private int _NumberOfGuests;
        public int NumberOfGuests { get => _NumberOfGuests; set { _NumberOfGuests = value; OnPropertyChanged(); } } 
        
        private int _NumberOfTables;
        public int NumberOfTables { get => _NumberOfTables; set { _NumberOfTables = value; OnPropertyChanged(); } }

        public ICommand BookingTable { get; set; }
        public ICommand Cancel { get; set; }
        public BookingViewModel()
        {
            readData();
            BookTable();
            cancel();
        }


        public void readData()
        {
            var user = Application.Current.Properties["LoggedInUser"] as AccountDTO;
                FullName = user.FullName;
                Email = user.Email; 
            using(var context = new NhaHangProjectContext())
            {
                var tableType = context.Tabletypes.Select(r => r.TableTypeName).ToList();
                TabletypeList = new ObservableCollection<string>(tableType);
            }
        }

        public void BookTable ()
        {
            BookingTable = new RelayCommand<Window>((p) => {

                if (NumberOfGuests <= 0 || SelectedDate < DateTime.Today) return false;

                TimeOnly currentTime = TimeOnly.FromDateTime(DateTime.Now);
                if (SelectedDate == DateTime.Today && TimeOnly.FromDateTime(SelectedTime) < currentTime) return false;
                return true; 
            
            }, (p) =>
            {
            var user = Application.Current.Properties["LoggedInUser"] as AccountDTO;

                using (var context = new NhaHangProjectContext())
                {

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int TableTypeId = context.Tabletypes.Where(r => r.TableTypeName == TableTypeName).Select(r => r.TableTypeid).FirstOrDefault();
                    FullName = user.FullName;

                    Booking book = new Booking
                    {
                        AccountId = user.AccountId,
                        BookingDate = SelectedDate,
                        NumberOfGuests = NumberOfGuests,
                        BookingTime = TimeOnly.FromDateTime(SelectedTime),
                         TableTypeId = TableTypeId,
                         Status = 0
                    };


                    context.Bookings.Add(book);
                     context.SaveChanges();
                    MessageBox.Show("Đã gửi yều cầu đặt bàn thành công, nhân viên của chúng tôi sẽ phản hồi lại bạn trong khoảng từ 5 tới 10 phút. Xin cảm ơn quý khách."+ SelectedTime);
                }

                var manageBookingWindow = new ManageBookingWindow();
                 manageBookingWindow.Show();
               

                var bookingVm = manageBookingWindow.DataContext as ManageBookingViewModel;
                bookingVm?.readData();
                manageBookingWindow.Close();   
               

                var manageActivityWindow = new ManageActivityWindow();
                manageActivityWindow.Show();

                var activityVm = manageActivityWindow.DataContext as ManageActivityViewModel;
                activityVm?.ReadData();
                manageActivityWindow.Close();


                p.Close();
            });
           
            
        }

        public void cancel()
        {
            Cancel = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                if (p != null) { p.Close(); }

            });
        }
    }
}
