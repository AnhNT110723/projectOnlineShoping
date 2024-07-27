using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel.Staff
{
    public class ManageBookingViewModel : BaseViewModel
    {

        private ObservableCollection<BookingDTO> _list;
        public ObservableCollection<BookingDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        private BookingDTO _selectedItem;
        public BookingDTO SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();
                if (SelectedItem != null)
                {
                    using (var context = new NhaHangProjectContext()) {
                        var queryCBX = context.Tables.Where(t => t.Status == 0 && t.TableTypeId == SelectedItem.TableTypeId).Select(t => t.TableName).ToList();
                        TableList = new ObservableCollection<string>(queryCBX);
                    }
                   
                }
            }
        }

        private string _TableName;
        public string TableName { get => _TableName; set { _TableName = value; OnPropertyChanged(); } }

        private ObservableCollection<string> _TableList;
        public ObservableCollection<string> TableList { get => _TableList; set { _TableList = value; OnPropertyChanged(); } }

        public ICommand ApproveCommand {  get; set; }
        public ICommand RejectCommand {  get; set; }
        public ManageBookingViewModel()
        {
            readData();
            ApproveBooking();
            RejectBooking();
        }


        public void readData()
        {
            using (var context = new NhaHangProjectContext())
            {
                var queryCBX = context.Tables.Where(t => t.Status == 0).Select(t => t.TableName).ToList();
                TableList = new ObservableCollection<string>(queryCBX);

                var queryList = from b in context.Bookings
                                join a in context.Accounts on b.AccountId equals a.AccountId
                                join tbt in context.Tabletypes on b.TableTypeId equals tbt.TableTypeid
                                orderby b.BookingId descending
                                select new BookingDTO
                                {
                                    BookingId = b.BookingId,
                                    FullName = a.FullName,
                                    Email = a.Email,
                                    TableTypeName = tbt.TableTypeName,
                                    NumberOfGuests = b.NumberOfGuests,
                                    Status = b.Status,
                                    TableTypeId = tbt.TableTypeid,
                                    BookingDate = b.BookingDate,
                                    BookingTime = b.BookingTime
                                };

                List = new ObservableCollection<BookingDTO>(queryList);

            }
        }

        public void ApproveBooking()
        {
            ApproveCommand = new RelayCommand<Window>((p) => {
                if (SelectedItem == null) return false;
                return true;
            }, (p) =>
            {
                ApproveBookingTableWindow window = new ApproveBookingTableWindow(SelectedItem.BookingId,TableName, SelectedItem.FullName, SelectedItem.Email, SelectedItem.BookingDate, SelectedItem.BookingTime, SelectedItem.TableTypeId);
                 window.Show();
                p.Close();
            });

        }

        public void RejectBooking()
        {
            RejectCommand = new RelayCommand<Window>((p) =>
            {
                return true;
            }, (p) =>
            {
                RejectBookingWindow window = new RejectBookingWindow(SelectedItem.BookingId, TableName, SelectedItem.FullName, SelectedItem.Email, SelectedItem.BookingDate, SelectedItem.BookingTime, SelectedItem.TableTypeId);
                window.Show();
                p.Close();
            });

        }
    }
}
