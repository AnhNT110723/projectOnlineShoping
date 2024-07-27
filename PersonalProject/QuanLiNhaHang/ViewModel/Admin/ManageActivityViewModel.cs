using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace QuanLiNhaHang.ViewModel.Admin
{
    public class ManageActivityViewModel : BaseViewModel
    {
        private ObservableCollection<BookingDTO> _list;
        public ObservableCollection<BookingDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        public ManageActivityViewModel()
        {
            ReadData();

        }

        public void ReadData()
        {
            using(var context = new NhaHangProjectContext())
            {
                var queryList = from b in context.Bookings
                                join a in context.Accounts on b.AccountId equals a.AccountId
                                join tbt in context.Tabletypes on b.TableTypeId equals tbt.TableTypeid
                                join s in context.Accounts on b.StaffId equals s.AccountId into sj
                                from s in sj.DefaultIfEmpty()
                                join tb in context.Tables on b.TableId equals tb.TableId into tbj
                                from tb in tbj.DefaultIfEmpty()
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
                                    BookingTime = b.BookingTime,
                                    TableName = tb == null ? null : tb.TableName,
                                    StaffName = s == null ? null : s.FullName
                                };

                List = new ObservableCollection<BookingDTO>(queryList.ToList());
            }
        }

    }
}
