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
    public class OrderDetailViewModel : BaseViewModel
    {
        private ObservableCollection<OrderDetailDTO> _ListOrderDetail;
        public ObservableCollection<OrderDetailDTO> ListOrderDetail { get => _ListOrderDetail; set { _ListOrderDetail = value; OnPropertyChanged(); } }



        public OrderDetailViewModel(int OrderId)
        {

            LoadOrderDetailByOrderId(OrderId);
        }

        public void LoadOrderDetailByOrderId(int OrderId)
        {
            using(var context = new NhaHangProjectContext())
            {
                var query = (from odt in context.Orderdetails
                            join m in context.Menus on odt.MenuId equals m.MenuId
                            join f in context.Foods on m.FoodId equals f.FoodId
                            where odt.OrderId == OrderId
                            select new OrderDetailDTO
                            {
                                OrderDetailId = odt.OrderDetailId,
                                FoodName = f.FoodName,
                                Quantity = odt.Quantity,
                                Price = odt.Price,
                                Total = odt.Total
                            });

                var list = query.ToList();

                if(list.Count == 0) 
                {
                    // Hiển thị thông báo lỗi nếu không tìm thấy đặt phòng
                    MessageBox.Show("Order detail not found.");
                    return;
                } else
                {
                    ListOrderDetail = new ObservableCollection<OrderDetailDTO>(list);
                }

            }
        }


    }
}
