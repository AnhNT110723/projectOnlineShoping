
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;


namespace QuanLiNhaHang.ViewModel
{
    public class BillViewModel : BaseViewModel
    {
        private ObservableCollection<TableFoodTO> _list;
        public ObservableCollection<TableFoodTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        private string? _TableName;
        public string? TableName { get => _TableName; set { _TableName = value; OnPropertyChanged(); } }

        private decimal _TotalAmount;
        public decimal TotalAmount { get => _TotalAmount; set { _TotalAmount = value; OnPropertyChanged(); } }

        private DateTime _OrderDate;
        public DateTime OrderDate { get => _OrderDate; set { _OrderDate = value; OnPropertyChanged(); } }

        public ICommand CashpaymentCommand { get; set; }
        public ICommand TransferPaymentCommand { get; set; }
        public ICommand CancelCommand { get; set; }


        public BillViewModel(int tableid)
        {
            loadData(tableid);
            CashPayment(tableid);
            TransferPayment(tableid);
            Cancel(tableid);
        }
        
        public void loadData(int tableId)
        {
            using (var context = new NhaHangProjectContext())
            {
                var foodWithMenu = from tbf in context.TableFoods
                                   join tb in context.Tables on tbf.TableId equals tb.TableId
                                   join f in context.Foods on tbf.FoodId equals f.FoodId
                                   where tbf.TableId == tableId
                                   select new TableFoodTO
                                   {
                                       TableFoodId = tbf.TableFoodId,
                                       FoodName = f.FoodName,
                                       TableName = tb.TableName,
                                       Quantity = tbf.Quantity,
                                       Price = tbf.Price,
                                       Total = tbf.Total
                                   };

                var foodList = foodWithMenu.ToList();
                if (foodList.Count == 0)
                {
                    // Log or break here to check if the list is empty
                    Console.WriteLine("No data found!");

                }

                List = new ObservableCollection<TableFoodTO>(foodList);

                TableName = context.Tables.Where(x => x.TableId == tableId).Select(x => x.TableName).FirstOrDefault();
                OrderDate = DateTime.Now;

                decimal totalMenu = 0;
                foreach (var item in foodList)
                {
                    totalMenu += item.Total;
                }
                TotalAmount = totalMenu;


            }
        }

        public void CashPayment(int tableId)
        {
            CashpaymentCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                //xóa hết menu mà bạn này vừa đặt trong table food và đóng bàn
                using (var context = new NhaHangProjectContext())
                {
                    var foodWithMenu = from tbf in context.TableFoods
                                       join tb in context.Tables on tbf.TableId equals tb.TableId
                                       join f in context.Foods on tbf.FoodId equals f.FoodId
                                       where tbf.TableId == tableId
                                       select new TableFoodTO
                                       {
                                           TableFoodId = tbf.TableFoodId,
                                           FoodName = f.FoodName,
                                           TableName = tb.TableName,
                                           Quantity = tbf.Quantity,
                                           Price = tbf.Price,
                                           Total = tbf.Total
                                       };

                    var foodList = foodWithMenu.ToList();

                    List = new ObservableCollection<TableFoodTO>(foodList);
                    //sau khi thanh toán thì sẽ xóa data ra khỏi bàn ăn
                    foreach (var item in foodList)
                    {
                        var TableFood = context.TableFoods.Where(t => t.TableId == tableId).FirstOrDefault();
                        context.TableFoods.Remove(TableFood);
                        context.SaveChanges();
                    }

                    //cập nhât trạng thai bill thanh toán thành công
                    var lastestOrderForTable = context.Orders.Where(x => x.TableId == tableId).OrderByDescending(x => x.OrderDate).FirstOrDefault();
                    if(lastestOrderForTable != null)
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
                    MainVM?.UpdateTableStatus(tableId, 0);
                    MainVM?.LoadTables();

                }
                MessageBox.Show("Thanh toán thành công","Information");
                p.Close();

            });

        }

        public void TransferPayment(int  tableId)
        {
            TransferPaymentCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {


                QRWindow qr = new QRWindow(tableId, TotalAmount);
                qr.ShowDialog();

            });
        }
        public void Cancel(int tableId)
        {
            CancelCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                if (p != null) 
                { 
                    MenuWindow menu = new MenuWindow(tableId);
                    menu.Show();
                    p.Close(); 
                }

            });


        }

    }
}
