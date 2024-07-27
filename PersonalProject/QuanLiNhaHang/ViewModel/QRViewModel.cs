using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Windows.Media.Imaging;
using System.Windows.Input;
using System.Net;

using Newtonsoft.Json;
using System.Net.Http;
using System.Windows.Documents;
using System.Windows;
using QuanLiNhaHang.Models;


namespace QuanLiNhaHang.ViewModel
{
    public class QRViewModel : BaseViewModel
    {
        private string _ACCOUNT_NO;
        private string _BANK_ID;
        private string _ACCOUNT_NAME;
        private decimal _TotalAmount;
        private string _Content;

        public string ACCOUNT_NO
        {
            get => _ACCOUNT_NO;
            set
            {
                _ACCOUNT_NO = value;
                OnPropertyChanged();
            }
        }

        public string BANK_ID
        {
            get => _BANK_ID;
            set
            {
                _BANK_ID = value;
                OnPropertyChanged();
            }
        }

        public string ACCOUNT_NAME
        {
            get => _ACCOUNT_NAME;
            set
            {
                _ACCOUNT_NAME = value;
                OnPropertyChanged();
            }
        }
        public decimal TotalAmount
        {
            get => _TotalAmount;
            set
            {
                _TotalAmount = value;
                OnPropertyChanged();
            }
        }   
        
        public string Content
        {
            get => _Content;
            set
            {
                _Content = value;
                OnPropertyChanged();
            }
        }

        private BitmapSource _qrCodeImage;
        public BitmapSource QRCodeImage
        {
            get => _qrCodeImage;
            private set
            {
                _qrCodeImage = value;
                OnPropertyChanged();
            }
        }

        public ICommand GenerateQRCodeCommand { get; set; }

        public QRViewModel(int tableid, decimal totalAmount)
        {

             BANK_ID = "MB";
             ACCOUNT_NO = "0968640321111";
             ACCOUNT_NAME = "NGUYEN TUAN ANH";
            TotalAmount = totalAmount;
            Content = ""+ GenerateUniqueRandomNumber();

            GenerateQRCodeCommand = new RelayCommand<Window>((p) => true, async (p) =>
            {
                string paymentInfo = $"https://img.vietqr.io/image/{BANK_ID}-{ACCOUNT_NO}-compact2.png?amount={totalAmount}&addInfo={Content}&accountName={ACCOUNT_NAME}";

                BitmapImage qrBitmapImage = new BitmapImage();
                qrBitmapImage.BeginInit();
                qrBitmapImage.UriSource = new Uri(paymentInfo, UriKind.Absolute);
                qrBitmapImage.EndInit();

                QRCodeImage = qrBitmapImage;

                bool transactionStatus = await CheckPaidAsync(Content, totalAmount);
                //thanh toán thành công
                if (transactionStatus == true)
                {
                    using (var context = new NhaHangProjectContext())
                    {


                        //cập nhât trạng thai bill thanh toán thành công
                        var lastestOrderForTable = context.Orders.Where(x => x.TableId == tableid).OrderByDescending(x => x.OrderDate).FirstOrDefault();
                        if (lastestOrderForTable != null)
                        {
                            lastestOrderForTable.Status = 1;
                            context.SaveChanges();
                        }

                        //đồng bộ dữ liệu khi thêm order
                        ViewOrderWindow viewOrder = new ViewOrderWindow();
                        if (viewOrder.DataContext == null) return;
                        var vieworderVM = viewOrder.DataContext as ViewOrderViewModel;
                        vieworderVM.ReloadOrders();

                        // Gọi phương thức cập nhật trạng thái bàn để "tắt bàn" trong MainWindowViewModel
                        var mainViewModel = Application.Current.MainWindow as MainWindow;
                        var MainVM = mainViewModel.DataContext as MainWindowViewModel;
                        MainVM?.UpdateTableStatus(tableid, 0);
                        MainVM?.LoadTables();
                        p.Close();
                    }

                } else
                {
                    System.Windows.MessageBox.Show($"Transaction failed: {transactionStatus}");

                }
            });
        }

        public async Task<bool> CheckPaidAsync( string content, decimal price)
        {
            try
            {
                bool isSuccess = false;
                while (!isSuccess)
                {
                    await Task.Delay(1000);

                    var client = new HttpClient();
                    var response = await client.GetAsync("https://script.google.com/macros/s/AKfycbxKGfxCQ5OThSAtTVVZ3HHt1rFwbCa-DZvwsAuL_Oe1eS0XJ9fuUgGazBKJr9Bs2JrEOg/exec");
                    response.EnsureSuccessStatusCode();
                    string responseBody = await response.Content.ReadAsStringAsync();
                    dynamic data = JsonConvert.DeserializeObject(responseBody);

                    var lastPaid = data.data[data.data.Count - 1];
                    decimal lastPrice = lastPaid["Giá trị"];
                    string lastContent = lastPaid["Mô tả"];

                    if (lastPrice >= price && lastContent.Contains(content))
                    {
                        System.Windows.MessageBox.Show("Thanh toán thành công");
                        isSuccess = true;
                    }
                    
                }
                return isSuccess;
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show($"Lỗi: {ex.Message}");
                return false;
            }
        }


        public int GenerateUniqueRandomNumber()
        {
            Random random = new Random();
            int randomNumber = random.Next(100000, 1000000); // Tạo số ngẫu nhiên từ 100000 đến 999999 (6 chữ số)
            return randomNumber;
        }

    }
}
