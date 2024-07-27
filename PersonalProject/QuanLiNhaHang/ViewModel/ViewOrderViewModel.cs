using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel
{
    public class ViewOrderViewModel : BaseViewModel
    {
        private ObservableCollection<OrderDTO> _list;
        public ObservableCollection<OrderDTO> List { get => _list; set { _list = value; OnPropertyChanged(); } }



        private OrderDTO _selectedItem;
        public OrderDTO SelectedItem
        {
            get => _selectedItem; set
            {
                _selectedItem = value; OnPropertyChanged();

            }
        }

        public ICommand ViewDetailCommand { get; set; }

        public ViewOrderViewModel()
        {
            LoadViewOrder();
            ShowViewOrderDetail();
        }

        public void LoadViewOrder()
        {
            using (var context = new NhaHangProjectContext())
            {
                var query = from o in context.Orders
                            join t in context.Tables on o.TableId equals t.TableId
                            select new OrderDTO
                            {
                                OrderId = o.OrderId,
                                TableName = t.TableName,
                                OrderDate = o.OrderDate,
                                TotalAmount = o.TotalAmount,
                                Status = o.Status,
                            };

                var list = query.ToList();
                List = new ObservableCollection<OrderDTO>(list);

            }
        }

        public void ReloadOrders()
        {
            LoadViewOrder();
        }

        public void ShowViewOrderDetail()
        {
            ViewDetailCommand = new RelayCommand<Object>((p) =>
            {
                return true;

            }, (p) =>
            {
                if (p is OrderDTO order)
                {
                    SelectedItem = order;
                }

                if (SelectedItem == null)
                {
                    MessageBox.Show("SelectedItem is null");
                    return;
                }

                ViewOrderDetailWindow orderDetail = new ViewOrderDetailWindow(SelectedItem.OrderId);
                orderDetail.ShowDialog();
            });
        }


        public void UpdateOrderStatus(int orderId, int newStatus)
        {
            using (var context = new NhaHangProjectContext())
            {
                var order = context.Orders.FirstOrDefault(o => o.OrderId == orderId);
                if (order != null)
                {
                    order.Status = newStatus;
                    context.SaveChanges();
                }
            }
            // Làm mới danh sách đơn hàng sau khi cập nhật trạng thái
            ReloadOrders();
        }
    }
}
