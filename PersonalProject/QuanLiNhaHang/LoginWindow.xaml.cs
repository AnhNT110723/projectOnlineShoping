using Microsoft.EntityFrameworkCore;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace QuanLiNhaHang
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        //private void Button_Click(object sender, RoutedEventArgs e)
        //{
        //    // lấy giá trị email và password từ các điều khiển ui
        //    string email = txtEmail.Text;
        //    string password = psbPass.Password;



        //    // Kiểm tra tính hợp lệ của thông tin đăng nhập
        //    using (var context = new NhaHangProjectContext())
        //    {
        //        // Tìm tài khoản với email và password khớp
        //        var account = context.Accounts.FirstOrDefault(a => a.Email == email && a.Password == password);

        //        if (account != null)
        //        {
        //            System.Windows.MessageBox.Show("Login successful!");
        //            this.DialogResult = true; // Đặt kết quả là true để biểu thị đăng nhập thành công
        //            this.Close();
        //        }
        //        else
        //        {
        //            System.Windows.MessageBox.Show("Invalid username or password.");
        //        }
        //    }
        
        //}
    }
}
