using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
    public class MyAccountViewModel : BaseViewModel
    {




        private string _FullName;
        public string FullName { get => _FullName; set { _FullName = value; OnPropertyChanged(); } }

        private string _Email;
        public string Email { get => _Email; set { _Email = value; OnPropertyChanged(); } }

        private string _Password;
        public string Password { get => _Password; set { _Password = value; OnPropertyChanged(); } }

        private int? _Gender;
        public int? Gender { get => _Gender; set { _Gender = value; OnPropertyChanged(); } }

        private string _RoleName;
        public string RoleName { get => _RoleName; set { _RoleName = value; OnPropertyChanged(); } } 
        
        private string _newPassword;
        public string newPassword { get => _newPassword; set { _newPassword = value; OnPropertyChanged(); } } 

        private string _RePassword;
        public string RePassword { get => _RePassword; set { _RePassword = value; OnPropertyChanged(); } }    
        
        private DateTime? _DateOfBirth;
        public DateTime? DateOfBirth { get => _DateOfBirth; set { _DateOfBirth = value; OnPropertyChanged(); } }


        public ICommand SaveProfieCommand { get; set; }
        public ICommand NewPasswordCommand { get; set; }


        public MyAccountViewModel()
        {
            LoadData();
            SaveProfile();
            NewPassword();

        }

        private void LoadData()
        {
            var loginUser = Application.Current.Properties["LoggedInUser"];
            AccountDTO account = loginUser as AccountDTO;
            if(account == null) { return; }
            FullName = account.FullName;
            Email = account.Email;
            Password = account.Password;
            DateOfBirth = account.DateOfBirth?.ToDateTime(TimeOnly.MinValue); 
            Gender = account.Gender;
            RoleName = account.RoleName;
        }

        public void NewPassword()
        {
            NewPasswordCommand = new RelayCommand<object>((p) =>
            {
                return true;

            }, (p) =>
            {
                var loginUser = Application.Current.Properties["LoggedInUser"];
                AccountDTO accountLoggedIn = loginUser as AccountDTO;
                if(newPassword.Equals(accountLoggedIn.Password))
                {
                    MessageBox.Show("The new password must be different from the most recent old password.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                else if(newPassword != RePassword)
                {
                    MessageBox.Show("Password must equal repassword.", "Error",MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                } else if(newPassword.Length < 8)
                {
                    MessageBox.Show("Password must more than 8 character.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                } else
                {
                    using (var context = new NhaHangProjectContext())
                    {
                        var account = context.Accounts.FirstOrDefault(x => x.AccountId == accountLoggedIn.AccountId);
                        if (account == null) { return; }

                        account.Password = newPassword;
                        context.SaveChanges();

                        MessageBox.Show("Password change successfully", "Success", MessageBoxButton.OK, MessageBoxImage.None);

                   
                    }
                }

                
            });
        }

        public void SaveProfile()
        {
            SaveProfieCommand = new RelayCommand<object>((p) =>
            {
                return true;

            }, (p) =>
            {
                var loginUser = Application.Current.Properties["LoggedInUser"];
                AccountDTO accountLoggedIn = loginUser as AccountDTO;
                accountLoggedIn.FullName = FullName;
                accountLoggedIn.Email = Email;
                accountLoggedIn.DateOfBirth = DateOfBirth.HasValue ? DateOnly.FromDateTime(DateOfBirth.Value) : (DateOnly?)null;
                accountLoggedIn.Gender = Gender;
                using (var context = new NhaHangProjectContext())
                {
                    var account = context.Accounts.FirstOrDefault(x => x.AccountId == accountLoggedIn.AccountId);
                    if (account == null) { return; }

                    account.FullName = FullName;
                    account.Email = Email;
                    account.Gender = Gender;
                    account.DateOfBirth = DateOfBirth.HasValue ? DateOnly.FromDateTime(DateOfBirth.Value) : (DateOnly?)null;
                    context.SaveChanges();
                    MessageBox.Show("Change profile successfully", "Success", MessageBoxButton.OK, MessageBoxImage.None);

                }
            });
        }
    }
}
