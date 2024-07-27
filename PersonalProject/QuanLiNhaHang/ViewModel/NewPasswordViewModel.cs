using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace QuanLiNhaHang.ViewModel
{
    public class NewPasswordViewModel : BaseViewModel
    {


        private string _NewPassword;
        public string NewPassword { get => _NewPassword; set { _NewPassword = value; OnPropertyChanged(); } }


        private string _ReNewPassword;
        public string ReNewPassword { get => _ReNewPassword; set { _ReNewPassword = value; OnPropertyChanged(); } }

        public ICommand NewPasswordCommand {  get; set; }
        public ICommand Cancel {  get; set; }
        public NewPasswordViewModel(string Email, string otp)
        {


            ResetNewPassword(Email);
            Back(Email, otp);
        }

        public void ResetNewPassword(string Email)
        {
            NewPasswordCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var checkAccExist = context.Accounts.FirstOrDefault(x => x.Email == Email) ;
                    if (NewPassword.Equals(checkAccExist.Password))
                    {
                        MessageBox.Show("The new password must be different from the most recent old password.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    else if (NewPassword != ReNewPassword)
                    {
                        MessageBox.Show("Password must equal repassword.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    else if (NewPassword.Length < 8)
                    {
                        MessageBox.Show("Password must more than 8 character.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    else
                    {
                        
                            var account = context.Accounts.FirstOrDefault(x => x.AccountId == checkAccExist.AccountId);
                            if (account == null) { return; }

                            account.Password = NewPassword;
                            context.SaveChanges();

                            MessageBox.Show("Password change successfully", "Success", MessageBoxButton.OK, MessageBoxImage.None);
                            LoginWindow login = new LoginWindow();
                            login.Show();
                            p.Close();
                    }
                }

            });
        }


        public void Back(string email, string otp)
        {
            Cancel = new RelayCommand<Window>((p) => { return true; }, (p) => {
                QuestionResetPasswordWindow login = new QuestionResetPasswordWindow(email, otp);
                login.Show();
                p.Close();
            });
        }
    }
}
