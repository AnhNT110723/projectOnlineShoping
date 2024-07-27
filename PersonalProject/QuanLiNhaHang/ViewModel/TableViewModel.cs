using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Documents;
using System.Windows.Input;


namespace QuanLiNhaHang.ViewModel
{
    public class TableViewModel : BaseViewModel
    {
        private ObservableCollection<TableDTO> _list;
        public ObservableCollection<TableDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }

        private TableDTO _selectedItem;
        public TableDTO SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();
                if (SelectedItem != null)
                {
                    TableName = SelectedItem.TableName;
                    TableTypeName = SelectedItem.TableTypeName;
                }
            }
        }


        private string _TableName;
        public string TableName { get => _TableName; set { _TableName = value; OnPropertyChanged(); } }

        private String _TableTypeName;
        public String TableTypeName { get => _TableTypeName; set { _TableTypeName = value; OnPropertyChanged(); } }


        private string _searchText;
        public string SearchText { get => _searchText; set { _searchText = value; OnPropertyChanged(); } }

        private ObservableCollection<string> _TableTypes;
        public ObservableCollection<string> TableTypes
        {
            get => _TableTypes;
            set { _TableTypes = value; OnPropertyChanged(); }
        }


        public ICommand AddTableCommand { get; set; }
        public ICommand EditTableCommand { get; set; }
        public ICommand DeleteTableCommand { get; set; }

        public ICommand FilterCommand { get; set; }
        public TableViewModel()
        {

            readTable();

            addTable();

            updateFood();

            deleteFood();


            FilterCommand = new RelayCommand<object>((p) => { return true; }, (p) =>
            {
                FilterFood();
            });
        }


        public void readTable()
        {
            using (var context = new NhaHangProjectContext())
            {
                var table = from tb in context.Tables
                            join tbp in context.Tabletypes on tb.TableTypeId equals tbp.TableTypeid

                            select new QuanLiNhaHang.Models.TableDTO
                            {
                                TableId = tb.TableId,
                                TableName = tb.TableName,
                                TableTypeName = tbp.TableTypeName
                            };

                var tableList = table.ToList();

                List = new ObservableCollection<QuanLiNhaHang.Models.TableDTO>(tableList);
            }

            //Lấy dữ liệu food type name để đẩy lên combobox
            using (var context = new NhaHangProjectContext())
            {
                TableTypes = new ObservableCollection<string>(context.Tabletypes.Select(tbt => tbt.TableTypeName).ToList());
            }

        }

        public void addTable()
        {

            AddTableCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (string.IsNullOrEmpty(TableName)) return false;


                foreach (var food in List)
                {
                    if (food.TableName == TableName) return false;
                }

                if (TableTypeName == null) return false;


                return true;

            }, (p) =>
            {

                using (var context = new NhaHangProjectContext())
                {

                    // Tìm FoodTypeId từ FoodTypeName được chọn
                    int tableTypeId = context.Tabletypes.Where(tbt => tbt.TableTypeName == TableTypeName).Select(tbt => tbt.TableTypeid).FirstOrDefault();


                    var newTable = new QuanLiNhaHang.Models.Table() { TableName = TableName, TableTypeId = tableTypeId, Status = 0, OpenTime = null, CloseTime = null };

                    // Thêm vào DbSet và lưu vào cơ sở dữ liệu
                    context.Tables.Add(newTable);
                    context.SaveChanges();

                    var newTabelDTO = new TableDTO()
                    {
                        TableId = newTable.TableId,
                        TableName = newTable.TableName,
                        TableTypeName = TableTypeName
                    };

                    List.Add(newTabelDTO);

                    RaiseTableListChanged();

                }
            });

        }


        public void updateFood()
        {
            EditTableCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    //tìm table theo id 
                    var table = context.Tables.Where(tb => tb.TableId == SelectedItem.TableId).FirstOrDefault();

                    // Tìm TableTypeId từ TableTypeName được chọn
                    int tableTypeId = context.Tabletypes.Where(tb => tb.TableTypeName == TableTypeName).Select(tb => tb.TableTypeid).FirstOrDefault();


                    table.TableName = TableName;
                    table.TableTypeId = tableTypeId;
                    context.SaveChanges();
                    readTable();

                    RaiseTableListChanged();
                }
            });
        }

        public void deleteFood()
        {
            DeleteTableCommand = new RelayCommand<object>((p) =>
            {
                // Kiểm tra tính hợp lệ của NewFood trước khi thêm vào List
                if (SelectedItem == null) return false;


                return true;

            }, (p) =>
            {
                using (var context = new NhaHangProjectContext())
                {
                    var table = context.Tables.Where(tb => tb.TableId == SelectedItem.TableId).FirstOrDefault();


                    if (table == null) return;

                    //Kiểm tra bàn có đang mở hay không
                    if(table.Status == 1)
                    {
                        MessageBox.Show("The table is currently open and cannot be deleted.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }

                    MessageBoxResult result = MessageBox.Show("Are you want to delete this food?", "Delete", MessageBoxButton.YesNo, MessageBoxImage.Question);

                    if (result == MessageBoxResult.Yes)
                    {
                        context.Tables.Remove(table);
                        context.SaveChanges();
                    }

                    readTable();
                    RaiseTableListChanged();
                }
            });
        }

        private void FilterFood()
        {
            if (string.IsNullOrWhiteSpace(SearchText))
            {
                readTable();
            }
            else
            {
                using (var context = new NhaHangProjectContext())
                {

                    var query = from tb in context.Tables
                                join tbp in context.Tabletypes on tb.TableTypeId equals tbp.TableTypeid
                                where (tb.TableName.ToLower().Contains(SearchText.ToLower()) || tbp.TableTypeName.ToLower().Contains(SearchText.ToLower()))
                                select new QuanLiNhaHang.Models.TableDTO
                                {
                                    TableId = tb.TableId,
                                    TableName = tb.TableName,
                                    TableTypeName = tbp.TableTypeName
                                };
                    


                    List = new ObservableCollection<TableDTO>(query.ToList());
                }
            }
        }
        private void RaiseTableListChanged()
        {
            // Lấy đối tượng MainWindowViewModel từ Main window và gọi phương thức cập nhật danh sách
            var mainWindow = Application.Current.MainWindow as MainWindow;
            var mainViewModel = mainWindow.DataContext as MainWindowViewModel;
            mainViewModel?.LoadTables();
        }
    }
}
