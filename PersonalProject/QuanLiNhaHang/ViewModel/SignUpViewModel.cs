using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using QuanLiNhaHang.Models;

namespace QuanLiNhaHang.ViewModel
{
    public class SignUpViewModel : BaseViewModel
    {

        private string _FullName;
        public string FullName { get => _FullName; set { _FullName = value; OnPropertyChanged(); } }
            
        private string _Email;
        public string Email { get => _Email; set { _Email = value; OnPropertyChanged(); } }    
        
        private int _Gender;
        public int Gender { get => _Gender; set { _Gender = value; OnPropertyChanged(); } }  

        private DateTime _DateOfBirth;
        public DateTime DateOfBirth { get => _DateOfBirth; set { _DateOfBirth = value; OnPropertyChanged(); } }

        public ICommand NavigateToLoginCommand { get; set; }
        public ICommand SignUpCommand { get; set; }
        public SignUpViewModel() 
        {
            signUp();
            Back();
        }



        private void signUp()
        {

            SignUpCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {



            if (!ValidateSignUpData())
            {
                return;
            }

                using (var context = new NhaHangProjectContext())
                {
                    var isExistemail = context.Accounts.FirstOrDefault(x => x.Email == Email);
                    //Tài khoản đã tồn tại
                    if (isExistemail != null)
                    {
                        MessageBox.Show("Tài khoản này đã tồn tại!", "Faile", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    //nếu chưa thì sẽ gửi mk về mail và login
                    var otp = randomOTP();
                    SendOTPEmail(Email, otp);

                    var account = new Account
                    {
                        FullName = FullName,
                        Email = Email,
                        Gender = Gender,
                        DateOfBirth = DateOnly.FromDateTime(DateOfBirth),
                        Password = otp,
                        Status = true,
                        RoleId = 3 

                    };

                    context.Accounts.Add(account);
                    context.SaveChanges();

                    MessageBox.Show("Đăng ký thành công! Mật Khẩu đã gửi về mail của bạn vui lòng kiểm tra mật khẩu và đăng nhập", "Success", MessageBoxButton.OK, MessageBoxImage.Information);

                }
            LoginWindow login = new LoginWindow();
            login.Show();
                p.Close();
            });

            
        }


        private bool ValidateSignUpData()
        {
            if (string.IsNullOrEmpty(FullName))
            {
                MessageBox.Show("Vui lòng nhập họ và tên!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }

            if (string.IsNullOrEmpty(Email))
            {
                MessageBox.Show("Vui lòng nhập email!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }

            try
            {
                var addr = new MailAddress(Email);
                if (addr.Address != Email)
                {
                    MessageBox.Show("Email không hợp lệ!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                    return false;
                }
            }
            catch
            {
                MessageBox.Show("Email không hợp lệ!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }

            if (DateOfBirth == default)
            {
                MessageBox.Show("Vui lòng chọn ngày sinh!", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                return false;
            }

            return true;
        }

        public string randomOTP()
        {
            string s = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();
            char[] chars = s.ToCharArray();
            for (int i = 0; i < 5; i++)
            {
                sb.Append(chars[random.Next(0, chars.Length)]);
            }
            return sb.ToString();
        }
        public void SendOTPEmail(string toEmail, string otpEmail)
        {
            try
            {
                MailMessage mail = new MailMessage();

                mail.From = new MailAddress("tanhh244466666@gmail.com", "Nguyen Tuan Anh");

                mail.To.Add(toEmail);

                mail.Subject = "Verify your email account";

                mail.Body = otpEmail;

                mail.IsBodyHtml = false;
                
                //cấu hình cho email
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
                smtpClient.Port = 587;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential("tanhh244466666@gmail.com", "cdsppymuqbmstijr");
                smtpClient.EnableSsl = true;


                smtpClient.Send(mail);

                MessageBox.Show("Email sent successfully!");
            }
            catch (SmtpException smtpEx)
            {
                MessageBox.Show($"SMTP Error: {smtpEx.Message}");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error sending email: {ex.Message}");
            }
        }

        private void Back()
        {
            //Change profile
            NavigateToLoginCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                LoginWindow login = new LoginWindow();
                login.Show();
                p.Close();
            });
        }
    }
}
