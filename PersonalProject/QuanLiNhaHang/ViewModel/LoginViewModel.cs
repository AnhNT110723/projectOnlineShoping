
using MaterialDesignThemes.Wpf;
using Microsoft.Identity.Client;
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
    public class LoginViewModel : BaseViewModel
    {
        // Login
        private string _email;
        public string Email
        {
            get => _email;
            set
            {
                _email = value;
                OnPropertyChanged();
            }
        }

        private string _password;
        public string Password
        {
            get => _password;
            set
            {
                _password = value;
                OnPropertyChanged();
            }
        }

        public ICommand LoginCommand { get; set; }
        public ICommand PasswordChangedCommand { get; set; }
        public ICommand SignupCommand { get; set; }
        public ICommand ForgotPassWordCommand { get; set; }



        public int IsLogin { get; set; }
        public LoginViewModel()
        {
            IsLogin = 0;
            Email = "";
            Password = "";

            LoginCommand = new RelayCommand<Window>((p) => { return true; }, (p) => { Login(p); });
            PasswordChangedCommand = new RelayCommand<PasswordBox>((p) => { return true; }, (p) => { Password = p.Password; });
            signup();
            forgotPassword();
        }

        void Login(Window p)
        {
            if (p == null) return;
            if (string.IsNullOrEmpty(Email) || string.IsNullOrEmpty(Password))
            {
                MessageBox.Show("Please enter both email and password.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            try
            {
                using (var context = new NhaHangProjectContext())
                {


                        var account = context.Accounts.FirstOrDefault(a => a.Email == Email && a.Password == Password);
                        

                    if (account != null)
                    {
                        var roleName = context.Roles.Where(x => x.RoleId == account.RoleId).Select(x => x.RoleName).FirstOrDefault();
                        var LoggedIn = new AccountDTO()
                        {
                            AccountId = account.AccountId,
                            FullName = account.FullName,
                            Email = account.Email,
                            DateOfBirth = account.DateOfBirth,
                            Password = account.Password,
                            Gender = account.Gender,
                            RoleName = roleName,
                            RoleId = account.RoleId,
                        };

                        Application.Current.Properties["LoggedInUser"] = LoggedIn;

                        if (account.RoleId == 1)
                        {
                            MessageBox.Show("Login successful with role Admin!", "Success");
                            IsLogin = 1;
                            MainWindow main = new MainWindow();
                            main.DataContext = new MainWindowViewModel(); // Khởi tạo ViewModel đúng cách
                            Application.Current.MainWindow = main;
                            main.Show();
                            p.Close(); // Đóng cửa sổ đăng nhập
                        }
                        else if (account.RoleId == 2)
                        { 
                            IsLogin = 2;
                            MessageBox.Show("Login successful with role Staff!", "Success");
                            MainStaffWindow mainStaffWindow = new MainStaffWindow();
                            mainStaffWindow.DataContext = new MainWindowViewModel();
                            mainStaffWindow.Show();
                            p.Close(); // Đóng cửa sổ đăng nhập
                           
                          
                        } else
                        {
                            MessageBox.Show("Login successful with role Customer!", "Success");
                            IsLogin = 1;
                            MainCustomerWindow main = new MainCustomerWindow();
                            main.DataContext = new MainWindowViewModel();
                            main.Show();
                            p.Close(); // Đóng cửa sổ đăng nhập
                        }


                    }
                    else
                    {
                        IsLogin = 0;
                        MessageBox.Show("Invalid username or password.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                    }
                   
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error connecting to the database: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        void signup()
        {
            SignupCommand = new RelayCommand<Window>((p) => { return true; }, (p) => 
            {
                SignUpWindow signup = new SignUpWindow();
                signup.Show();
                p.Close();
            });
        }
        
        void forgotPassword()
        {
            ForgotPassWordCommand = new RelayCommand<Window>((p) => { return true; }, (p) => 
            {
                ForgotPasswordWIndow forgot = new ForgotPasswordWIndow();
                forgot.Show();
                p.Close();
            });
        }
    }
}

