using QuanLiNhaHang.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace QuanLiNhaHang
{
    /// <summary>
    /// Interaction logic for QuestionResetPasswordWindow.xaml
    /// </summary>
    public partial class QuestionResetPasswordWindow : Window
    {
        public QuestionResetPasswordWindow(string email, string otp)
        {
            InitializeComponent();
            this.DataContext = new OTPViewModel(email, otp);
        }
    }
}
