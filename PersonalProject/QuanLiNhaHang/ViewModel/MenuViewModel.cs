using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{


    public class MenuViewModel : BaseViewModel
    {

        private ObservableCollection<FoodWithMenu> _list;
        public ObservableCollection<FoodWithMenu> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        private ObservableCollection<TableFoodTO> _listTableFood;
        public ObservableCollection<TableFoodTO> ListTableFood { get => _listTableFood; set { _listTableFood = value; OnPropertyChanged(); } }

        private FoodWithMenu? _selectedItem;
        public FoodWithMenu? SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();
                if (SelectedItem != null)
                {
                    FoodName = SelectedItem.FoodName;
                    Price = SelectedItem.Price;
                    SelectedItemWithFood = null; // Đặt SelectedItemWithFood về null khi SelectedItem thay đổi
                }

            }
        }

        private TableFoodTO _selectedItemWithFood;
        public TableFoodTO SelectedItemWithFood
        {
            get => _selectedItemWithFood;
            set
            {
                if (value != null)
                {
                    _selectedItemWithFood = value;
                    OnPropertyChanged();

                    FoodName = _selectedItemWithFood.FoodName;
                    Price = _selectedItemWithFood.Price;
                    Quantity = _selectedItemWithFood.Quantity;
                    SelectedItem = null;
                }
            }
        }

        private int _tableId;
        public int TableId
        {
            get => _tableId;
            set { _tableId = value; OnPropertyChanged(); }
        }

        private string? _FoodName;
        public string? FoodName { get => _FoodName; set { _FoodName = value; OnPropertyChanged(); } }

        private Decimal _Price;
        public Decimal Price { get => _Price; set { _Price = value; OnPropertyChanged(); } }

        private int _Quantity;
        public int Quantity { get => _Quantity; set { _Quantity = value; OnPropertyChanged(); } }

        private string _searchText;
        public string SearchText { get => _searchText; set { _searchText = value; OnPropertyChanged(); } }

        // Sự kiện thông báo khi đơn hàng mới được thêm
        public event Action OrderAdded;
        public ICommand AddToOrderCommand { get; set; }
        public ICommand CancelCommand { get; set; }

        public ICommand AddFoodWithCommand { get; set; }
        public ICommand UpdateFoodWithCommand { get; set; }
        public ICommand DeleteFoodWithCommand { get; set; }

        public ICommand FilterCommand { get; set; }

        public MenuViewModel(int tableId)
        {
            //Lấy đc id table by main window
            TableId = tableId;

            readFood();
            readFoodWithMenu(tableId);
            insertFoodWithMenu(tableId);
            UpdateFoodWithMenu(tableId);
            deleteFoodWithMenu(tableId);
            AddToOrder(tableId);
            Cancel();

            FilterCommand = new RelayCommand<object>((p) => { return true; }, (p) =>
            {
                FilterFood();
            });
        }


        public void readFood()
        {
            using (var context = new NhaHangProjectContext())
            {
                var foodWithMenu = from f in context.Foods
                                   join m in context.Menus on f.FoodId equals m.FoodId
                                   join ft in context.Foodtypes on f.FoodTypeid equals ft.FoodTypeid
                                   select new FoodWithMenu
                                   {
                                       FoodId = f.FoodId,
                                       FoodName = f.FoodName,
                                       Price = m.Price,
                                       FoodTypeName = ft.FoodTypeName
                                   };

                var foodList = foodWithMenu.ToList();
                if (foodList.Count == 0)
                {
                    // Log or break here to check if the list is empty
                    Console.WriteLine("No data found!");

                }

                List = new ObservableCollection<FoodWithMenu>(foodList);
            }

        }
        public void readFoodWithMenu(int tableId)
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

                ListTableFood = new ObservableCollection<TableFoodTO>(foodList);
            }

        }

        public void insertFoodWithMenu(int tableId)
        {
            AddFoodWithCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (string.IsNullOrEmpty(FoodName) || Quantity <= 0) return false;


                return true;

            }, (p) =>
            {

                using (var context = new NhaHangProjectContext())
                {

                    // Tìm FoodId từ FoodTypeName được chọn
                    int foodId = context.Foods.Where(ft => ft.FoodName == FoodName).Select(ft => ft.FoodId).FirstOrDefault();

                    decimal total = Price * Quantity;
                    var newTableFood = new TableFood() { TableId = tableId, FoodId = foodId, Quantity = Quantity, Price = Price, Total = total };


                    // Thêm vào DbSet và lưu vào cơ sở dữ liệu
                    context.TableFoods.Add(newTableFood);
                    context.SaveChanges();
                    readFoodWithMenu(tableId);

                }
            });
        }

        public void UpdateFoodWithMenu(int tableId)
        {
            UpdateFoodWithCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItemWithFood == null || SelectedItem != null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    if (_selectedItemWithFood != null)
                    {
                        var TableFood = context.TableFoods.Where(f => f.TableFoodId == SelectedItemWithFood.TableFoodId).FirstOrDefault();
                        if (TableFood != null)
                        {
                            TableFood.Quantity = Quantity;
                            TableFood.Total = Quantity * Price;
                            context.SaveChanges();
                        }
                    }

                    readFoodWithMenu(tableId);

                }
            });
        }

        public void deleteFoodWithMenu(int tableid)
        {
            DeleteFoodWithCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItemWithFood == null || SelectedItem != null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var TableFood = context.TableFoods.Where(f => f.TableFoodId == SelectedItemWithFood.TableFoodId).FirstOrDefault();


                    if (TableFood == null) return;

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    //      int foodTypeId = context.Foodtypes.Where(ft => ft.FoodTypeName == FoodTypeName).Select(ft => ft.FoodTypeid).FirstOrDefault();

                    MessageBoxResult result = MessageBox.Show("Are you want to delete this food?", "Delete", MessageBoxButton.YesNo, MessageBoxImage.Question);

                    if (result == MessageBoxResult.Yes)
                    {
                        context.TableFoods.Remove(TableFood);
                        context.SaveChanges();
                    }

                    readFoodWithMenu(tableid);

                }
            });
        }

        public void AddToOrder(int tableid)
        {
            AddToOrderCommand = new RelayCommand<Window>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                var TableWithMenu = getMenuWithFood(tableid) ;
                if (TableWithMenu.Count == 0) return false;


                return true;

            }, (p) =>
            {
                var result = MessageBox.Show("Are you sure want to add to order?","",MessageBoxButton.YesNoCancel, MessageBoxImage.Question);
                if (result == MessageBoxResult.Yes)
                {


                    using (var context = new NhaHangProjectContext())
                    {
                        if (CheckStatusOrder(tableid))
                        {

                            var TableWithMenu = getMenuWithFood(tableid);
                            decimal totalMenu = 0;
                            foreach (var item in TableWithMenu)
                            {
                                totalMenu += item.Total;
                            }

                            //Lấy ra kiểu của bàn và kiểm tra xem có phải bàn vip hay không
                            var isVipTable = (from tb in context.Tables
                                              join tbt in context.Tabletypes on tb.TableTypeId equals tbt.TableTypeid
                                              where tableid == tb.TableId
                                              select new TableDTO
                                              {
                                                  TableTypeName = tbt.TableTypeName
                                              }).FirstOrDefault();

                            if (isVipTable != null && isVipTable.TableTypeName == "VIP")
                            {
                                totalMenu += totalMenu * 0.1m;
                            }

                            var order = new Order() { TableId = tableid, OrderDate = DateTime.Now, TotalAmount = totalMenu, Status = 0 };


                            context.Orders.Add(order);
                            context.SaveChanges();
                            foreach (var item in TableWithMenu)
                            {
                                int foodId = context.Foods.Where(x => x.FoodName == item.FoodName).Select(x => x.FoodId).FirstOrDefault();
                                int menuId = context.Menus.Where(x => x.FoodId == foodId).Select(x => x.MenuId).FirstOrDefault();
                                var orderDetail = new Orderdetail() { OrderId = order.OrderId, MenuId = menuId, Quantity = item.Quantity, Price = item.Price, Total = item.Total };
                                context.Orderdetails.Add(orderDetail);
                                context.SaveChanges();

                            }
                       

                        }
                        
                        RevenueReportWindow revenue = new RevenueReportWindow();
                        if (revenue.DataContext == null) return;
                        var revenueVM = revenue.DataContext as RevennueReportViewModel;
                        revenueVM.LoadData(DateTime.Today);


                        PayBillWindow paybill = new PayBillWindow(tableid);
                        paybill.Show();
                        //Đóng mà hình này lại
                        p.Close();

                    }
                }
            });
        }
        public void Cancel()
        {
            CancelCommand = new RelayCommand<Window>((p) =>
            {
                return true;

            }, (p) =>
            {
                if (p != null) { p.Close(); }

            });
        }

//Tìm kiếm food theo tên
        private void FilterFood()
        {
            if (string.IsNullOrWhiteSpace(SearchText))
            {
                readFood();
            }
            else
            {
                using (var context = new NhaHangProjectContext())
                {

                    var query = from f in context.Foods
                                       join m in context.Menus on f.FoodId equals m.FoodId
                                       join ft in context.Foodtypes on f.FoodTypeid equals ft.FoodTypeid
                                       where (f.FoodName.ToLower().Contains(SearchText.ToLower()))
                                       select new FoodWithMenu
                                       {
                                           FoodId = f.FoodId,
                                           FoodName = f.FoodName,
                                           Price = m.Price,
                                           FoodTypeName = ft.FoodTypeName
                                       };


                    List = new ObservableCollection<FoodWithMenu>(query.ToList());
                }
            }
        }

        //nếu trạng thái order là 0 thì có thể tiếp tục thanh toán mà khogo add mới
        private bool CheckStatusOrder(int tableId)
        {
            using (var context = new NhaHangProjectContext())
            {
                var statusOrder = context.Orders.Where(x => x.TableId == tableId).OrderByDescending(x => x.OrderDate).FirstOrDefault();
                if (statusOrder != null)
                {
                    //trạng thái đang thanh toán nên không cần add vào order vả bảng order detail nữa
                    if(statusOrder.Status == 0) return false;
                }
            }

            return true;
        }
        private ObservableCollection<TableFoodTO> getMenuWithFood(int tableId)
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

                return new ObservableCollection<TableFoodTO>(foodList);
            }
        }
    }
}
