using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel.Customer
{
    public class ViewBookingHistoryViewModel : BaseViewModel
    {

        private ObservableCollection<BookingDTO> _list;
        public ObservableCollection<BookingDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        public ICommand ViewHistoryBookingCommand { get; set; }

        public ViewBookingHistoryViewModel()
        {
            readData();
        }

        public void readData()
        {
            

                using (var context = new NhaHangProjectContext())
                {
                    var loggedInUser = Application.Current.Properties["LoggedInUser"];
                    var account = loggedInUser as AccountDTO;
                    if (account == null) return;
                    //Lấy list booking bay id từ cơ sở dữ liệu
                    var bookingById = from b in context.Bookings
                                      join a in context.Accounts on b.AccountId equals a.AccountId
                                      join tb in context.Tables on b.TableId equals tb.TableId
                                      where b.AccountId == account.AccountId
                                      select new BookingDTO
                                      {
                                          BookingId = b.BookingId,
                                          FullName = a.FullName,
                                          TableName = tb.TableName,
                                          BookingDate = b.BookingDate,
                                          BookingTime = b.BookingTime,
                                          NumberOfGuests = b.NumberOfGuests,
                                      };


                    if (bookingById == null) return;
                    var bookingList = bookingById.ToList();
                    if (bookingList.Count != 0)
                    List = new ObservableCollection<BookingDTO>(bookingById);


                }
        }
    }
}
