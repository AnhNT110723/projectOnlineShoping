using Microsoft.IdentityModel.Tokens;
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
  public  class FoodViewModel : BaseViewModel

    {
        private ObservableCollection<FoodWithMenu> _list;
        public ObservableCollection<FoodWithMenu> List { get => _list; set { _list = value; OnPropertyChanged(); } }


        private FoodWithMenu _selectedItem;
        public FoodWithMenu SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();
                if (SelectedItem != null)
                {
                    FoodName = SelectedItem.FoodName;
                    Price = SelectedItem.Price;
                    FoodTypeName = SelectedItem.FoodTypeName;
                }
            }
        }


        private ObservableCollection<string> _foodTypes;
        public ObservableCollection<string> FoodTypes
        {
            get => _foodTypes;
            set { _foodTypes = value; OnPropertyChanged(); }
        }


        private string _FoodTypeName;
        public string FoodTypeName { get => _FoodTypeName; set { _FoodTypeName = value; OnPropertyChanged(); } }

        private string _FoodName;
        public string FoodName { get => _FoodName; set { _FoodName = value; OnPropertyChanged(); } }

        private Decimal _Price;
        public Decimal Price { get => _Price; set { _Price = value; OnPropertyChanged(); } }

        private string _searchText;
        public string SearchText { get => _searchText; set { _searchText = value; OnPropertyChanged(); } }

        public ICommand AddFoodCommand { get; set; }
        public ICommand EditFoodCommand { get; set; }
        public ICommand DeleteFoodCommand { get; set; }
        public ICommand FilterCommand { get; set; }




        public FoodViewModel()
        {

            //Read dữ liệu từ db
            readFood();


            //add to database
            addFood();

            //Edit food
            updateFood();

            //Delete Food
            deleteFood();

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
            //Lấy dữ liệu food type name để đẩy lên combobox
            using (var context = new NhaHangProjectContext())
            {
                FoodTypes = new ObservableCollection<string>(context.Foodtypes.Select(ftn => ftn.FoodTypeName).ToList());
            }
        }

        public void addFood()
        {

            AddFoodCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (string.IsNullOrEmpty(FoodName)) return false;


                foreach (var food in List)
                {
                    if (food.FoodName == FoodName) return false;
                }

                if(string.IsNullOrEmpty(FoodTypeName)) return false;


                return true;

            }, (p) =>
            {

                using (var context = new NhaHangProjectContext())
                {

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int foodTypeId = context.Foodtypes.Where(ft => ft.FoodTypeName == FoodTypeName).Select(ft => ft.FoodTypeid).FirstOrDefault();


                    var newFood = new Food() { FoodName = FoodName, FoodTypeid = foodTypeId };

                    // Thêm vào DbSet và lưu vào cơ sở dữ liệu
                    context.Foods.Add(newFood);
                    context.SaveChanges();

                    var menu = new Menu() { FoodId = newFood.FoodId, Price = Price };
                    context.Menus.Add(menu);
                    context.SaveChanges();

                    var newFoodWithMenu = new FoodWithMenu()
                    {
                        FoodId = newFood.FoodId,
                        FoodName = newFood.FoodName,
                        Price = Price,
                        FoodTypeName = FoodTypeName
                    };

                    List.Add(newFoodWithMenu);
                }
            });

        }

        public void updateFood()
        {
            EditFoodCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var food = context.Foods.Where(f => f.FoodId == SelectedItem.FoodId).FirstOrDefault();
                    var menu = context.Menus.Where(m => m.FoodId == SelectedItem.FoodId).FirstOrDefault();

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int foodTypeId = context.Foodtypes.Where(ft => ft.FoodTypeName == FoodTypeName).Select(ft => ft.FoodTypeid).FirstOrDefault();


                    food.FoodName = FoodName;
                    food.FoodTypeid = foodTypeId;
                    menu.Price = Price;
                    context.SaveChanges();

                    readFood();

                }
            });
        }

        public void deleteFood()
        {
            DeleteFoodCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var food = context.Foods.Where(f => f.FoodId == SelectedItem.FoodId).FirstOrDefault();
                    var menu = context.Menus.Where(m => m.FoodId == SelectedItem.FoodId).FirstOrDefault();

                    if (food == null || menu == null) return;

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int foodTypeId = context.Foodtypes.Where(ft => ft.FoodTypeName == FoodTypeName).Select(ft => ft.FoodTypeid).FirstOrDefault();

                    MessageBoxResult result = MessageBox.Show("Are you want to delete this food?", "Delete", MessageBoxButton.YesNo, MessageBoxImage.Question);

                    if (result == MessageBoxResult.Yes)
                    {
                        context.Foods.Remove(food);
                        context.Menus.Remove(menu);
                        context.SaveChanges();
                    }

                    readFood();

                }
            });
        }


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

    }
}
