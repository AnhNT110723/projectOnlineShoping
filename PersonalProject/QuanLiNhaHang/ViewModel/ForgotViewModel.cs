using QuanLiNhaHang.Models;
using QuanLiNhaHang.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using static System.Net.WebRequestMethods;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace QuanLiNhaHang.ViewModel
{
    public class ForgotViewModel : BaseViewModel
    {

        private string _email;
        public string Email
        {
            get => _email; set { _email = value; OnPropertyChanged(); }
        }

        public ICommand BackToLoginCommand { get; set; }
        public ICommand ReserPasswordCommand { get; set; }

       public ForgotViewModel()
        {

            ResetPassword();
            BackToLogin();
        }


        public void ResetPassword()
        {
            ReserPasswordCommand = new RelayCommand<Window>((p) => { return true; }, (p) => {

                using (var context = new NhaHangProjectContext())
                {
                    var checkAccExist = context.Accounts.FirstOrDefault(x => x.Email == Email);
                    if (checkAccExist == null)
                    {
                        MessageBox.Show("Email ny không tồn tại hoặc chưa được đăng kí, vui lòng kiểm tra lại Email.", "Warning", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }


                    //nếu tài khoản tồn tại thì gửi về mật khẩu mới về mail đó
                    string OTP = SendToEmail.randomOTP();
                    SendToEmail.SendEmail(Email, OTP,"Your OTP is");
                    MessageBox.Show("Vui lòng check OTP, OTP đã gửi về mail của bạn vui lòng kiểm tra và nhập OTP", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                    
                    QuestionResetPasswordWindow otp = new QuestionResetPasswordWindow(Email, OTP);
                    otp.Show();
                }
                    
                    p.Close();
               
            });
        }

        public void BackToLogin()
        {
            BackToLoginCommand = new RelayCommand<Window>((p) => { return true;  },(p) => {
                LoginWindow login = new LoginWindow();
                login.Show();
                p.Close();
            });
        }


    }
}
