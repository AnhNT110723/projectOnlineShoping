using QuanLiNhaHang.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.Models
{
    public class FoodWithMenu : BaseViewModel
    {


        private int _FoodId;
        public int FoodId { get => _FoodId; set { _FoodId = value; OnPropertyChanged(); } }

        private string _FoodName;
        public string FoodName { get => _FoodName; set { _FoodName = value; OnPropertyChanged(); } }

        private decimal _Price;
        public decimal Price { get => _Price; set { _Price = value; OnPropertyChanged(); } }

        private int _FoodTypeid;
        public int FoodTypeid { get => _FoodTypeid; set { _FoodTypeid = value; OnPropertyChanged(); } }


        private string _FoodTypeName;
        public string FoodTypeName { get => _FoodTypeName; set { _FoodTypeName = value; OnPropertyChanged(); } }
    }
}
