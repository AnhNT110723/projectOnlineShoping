using QuanLiNhaHang.Models;
using QuanLiNhaHang.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
    public class OTPViewModel :BaseViewModel
    {
        private string _OTP;
        public string OTP
        {
            get => _OTP; set { _OTP = value; OnPropertyChanged(); }
        }

        public ICommand ConfirmCommand { get; set; }
        public ICommand Cancel { get; set; }

        public OTPViewModel(string email, string otp)
        {
            ConfirmROTP(email, otp);
            CancelWD();
        }


        public void ConfirmROTP(string email, string otp)
        {
            ConfirmCommand = new RelayCommand<Window>((p) => { return true; }, (p) => {


                using (var context = new NhaHangProjectContext())
                {


                    if (!otp.Equals(OTP))
                    {
                        MessageBox.Show("Sai OTP, vui lòng kiểm tra lại email đế nhập OTP chính xác", "Faile", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    } 
                    
                    MessageBox.Show("Thành công, vui lòng nhập mật khẩu mới", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
               
                    NewPasswordWindow newpass = new NewPasswordWindow(email, otp);
                    newpass.Show();
                    p.Close();

                }
            });
        }

        public void CancelWD()
        {
            Cancel = new RelayCommand<Window>((p) => { return true; }, (p) => {
                ForgotPasswordWIndow forgot = new ForgotPasswordWIndow();
                forgot.Show();
                p.Close();
            });
        }
    }
}
