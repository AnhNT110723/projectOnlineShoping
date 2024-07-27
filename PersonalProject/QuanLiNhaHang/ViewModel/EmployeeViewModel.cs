using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Input;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace QuanLiNhaHang.ViewModel
{
   public class EmployeeViewModel : BaseViewModel
    {

        private ObservableCollection<AccountDTO> _list;
        public ObservableCollection<AccountDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }



        private AccountDTO _selectedItem;
        public AccountDTO SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();
                if (SelectedItem != null)
                {
                    FullName = SelectedItem.FullName;
                    Email = SelectedItem.Email;
                    Password = SelectedItem.Password;
                    Gender = SelectedItem.Gender;
                    Status = SelectedItem.Status;
                    RoleName = SelectedItem.RoleName;

                    if (Gender == 1)
                        DisplayedGender = "Male";
                    else 
                        DisplayedGender = "Female";

                    DisplayedStatus = Status ? "Active" : "Inactive";

                }
            
            }
        }


        private string? _DisplayedGender;
        public string? DisplayedGender
        {
            get => _DisplayedGender;
            set
            {
                _DisplayedGender = value;
                OnPropertyChanged();
               
                if (_DisplayedGender == "Male")
                    Gender = 1;
                else 
                    Gender = 0;

            }
        }

        private string? _DisplayedStatus;
        public string? DisplayedStatus
        {
            get => _DisplayedStatus;
            set
            {
                _DisplayedStatus = value;
                OnPropertyChanged();
                if (_DisplayedStatus == "Active")
                    Status = true;
                else if (_DisplayedStatus == "Inactive")
                    Status = false;
            }
        }


        private string _FullName;
        public string FullName { get => _FullName; set { _FullName = value; OnPropertyChanged(); } }

        private string _Email;
        public string Email { get => _Email; set { _Email = value; OnPropertyChanged(); } }

        private string _Password;
        public string Password { get => _Password; set { _Password = value; OnPropertyChanged(); } }

        private int? _Gender;
        public int? Gender{ get => _Gender; set { _Gender = value; OnPropertyChanged(); } }

        private bool _Status;
        public bool Status { get => _Status; set { _Status = value; OnPropertyChanged(); } }

        private string? _RoleName;
        public string? RoleName { get => _RoleName; set { _RoleName = value; OnPropertyChanged(); } }

        private string _searchText;
        public string SearchText { get => _searchText; set { _searchText = value; OnPropertyChanged(); } }


        private ObservableCollection<string> _RoleNames;
        public ObservableCollection<string> RoleNames
        {
            get => _RoleNames;
            set { _RoleNames = value; OnPropertyChanged(); }
        }

        public ObservableCollection<string> GenderOptions { get; set; }

        public ObservableCollection<string> StatusOptions { get; set; }


        public ICommand AddAccountCommand { get; set; }
        public ICommand EditAccountCommand { get; set; }
        public ICommand DeleteAccountCommand { get; set; }

        public ICommand FilterCommand { get; set; }
        //Hàm chạy
        public EmployeeViewModel() {
            readAccount();


            addAccount();

            updateAccount();

            deleteAccount();

            FilterCommand = new RelayCommand<object>((p) => { return true; }, (p) =>
            {
                FilterFood();
            });
        }

        public void readAccount()
        {
            using (var context = new NhaHangProjectContext())
            {
                var account = from acc in context.Accounts
                                   join r in context.Roles on acc.RoleId equals r.RoleId
                                  
                                   select new AccountDTO
                                   {
                                       AccountId = acc.AccountId,
                                       FullName = acc.FullName,
                                       Email = acc.Email,
                                       Password= acc.Password,
                                       Gender = acc.Gender,
                                       RoleName = r.RoleName,
                                       Status = acc.Status,


                                   };

                var accountList = account.ToList();


                List = new ObservableCollection<AccountDTO>(accountList);
            }
            //Lấy dữ liệu Role type name để đẩy lên combobox
            using (var context = new NhaHangProjectContext())
            {
                RoleNames = new ObservableCollection<string>(context.Roles.Select(r => r.RoleName).ToList());
            }
            //Lấy dữ liệu male or female type name để đẩy lên combobox
            GenderOptions = new ObservableCollection<string> { "Male", "Female" };

            StatusOptions = new ObservableCollection<string> { "Active", "Inactive" };
        }

        public void addAccount()
        {

            AddAccountCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(FullName) || string.IsNullOrEmpty(DisplayedGender) 
                || string.IsNullOrEmpty(RoleName) || string.IsNullOrEmpty(Password)) return false;


                foreach (var food in List)
                {
                    if (food.Email == Email) return false;
                }

                return true;

            }, (p) =>
            {

                using (var context = new NhaHangProjectContext())
                {

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int roleId = context.Roles.Where(r => r.RoleName == RoleName).Select(r => r.RoleId).FirstOrDefault();


                    var newAccount = new Account() { FullName = FullName, Email = Email, Password= Password, Gender = Gender, RoleId = roleId, Status = Status};

                    // Thêm vào DbSet và lưu vào cơ sở dữ liệu
                    context.Accounts.Add(newAccount);
                    context.SaveChanges();

                    readAccount();
                }
            });

        }

        public void updateAccount()
        {
            EditAccountCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var account = context.Accounts.Where(acc => acc.AccountId == SelectedItem.AccountId).FirstOrDefault();


                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int  RoleId = context.Roles.Where(r => r.RoleName == RoleName).Select(r => r.RoleId).FirstOrDefault();


                    account.FullName = FullName;
                    account.Email = Email;
                    account.Password = Password; 
                    account.Gender = Gender;
                    account.Status = Status;
                    account.RoleId = RoleId;
                    context.SaveChanges();

                    readAccount();

                }
            });
        }

        public void deleteAccount()
        {
            DeleteAccountCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    //Lấy account theo id
                    var account = context.Accounts.Where(acc => acc.AccountId == SelectedItem.AccountId).FirstOrDefault();


                    if (account == null) return;

                    // Tìm RoleId từ Role Name được chọn
                    int RoleID = context.Roles.Where(r => r.RoleName == RoleName).Select(r => r.RoleId).FirstOrDefault();

                    MessageBoxResult result = MessageBox.Show("Are you want to delete this food?", "Delete", MessageBoxButton.YesNo, MessageBoxImage.Question);

                    if (result == MessageBoxResult.Yes)
                    {
                        // Xóa các bản ghi liên quan trong bảng BOOKING
                        var bookings = context.Bookings.Where(b => b.AccountId == account.AccountId).ToList();
                        if (bookings.Any())
                        {
                            context.Bookings.RemoveRange(bookings);
                        }

                        context.Accounts.Remove(account);
                        context.SaveChanges();
                    }

                    readAccount();

                }
            });
        }

        private void FilterFood()
        {
            if (string.IsNullOrWhiteSpace(SearchText))
            {
                readAccount();
            }
            else
            {
                using (var context = new NhaHangProjectContext())
                {

                    var query = from acc in context.Accounts
                                join r in context.Roles on acc.RoleId equals r.RoleId
                                where (acc.FullName.ToLower().Contains(SearchText.ToLower()))
                                select new AccountDTO
                                {
                                    AccountId = acc.AccountId,
                                    FullName = acc.FullName,
                                    Email = acc.Email,
                                    Password = acc.Password,
                                    Gender = acc.Gender,
                                    RoleName = r.RoleName,
                                    Status = acc.Status,


                                };
                   
                               


                    List = new ObservableCollection<AccountDTO>(query.ToList());
                }
            }
        }

    }
}
