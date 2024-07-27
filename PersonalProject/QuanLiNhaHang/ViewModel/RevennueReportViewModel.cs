using LiveCharts;
using LiveCharts.Defaults;
using LiveCharts.Wpf;
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiNhaHang.ViewModel
{
    public class RevennueReportViewModel : BaseViewModel
    {
        private SeriesCollection _seriesCollection;
        public SeriesCollection SeriesCollection
        {
            get { return _seriesCollection; }
            set
            {
                _seriesCollection = value;
                OnPropertyChanged();
            }
        }

        private ObservableCollection<string> _labels;
        public ObservableCollection<string> Labels
        {
            get { return _labels; }
            set
            {
                _labels = value;
                OnPropertyChanged(nameof(Labels));
            }
        }
        public Func<double, string> Formatter { get; set; }

        public RevennueReportViewModel()
        {
            LoadData(DateTime.Today);
        }

        public void LoadData(DateTime selectedDate)
        {
            // Generate labels (days of the month)
            Labels = new ObservableCollection<string>();
            int daysInMonth = DateTime.DaysInMonth(selectedDate.Year, selectedDate.Month);
            for (int day = 1; day <= daysInMonth; day++)
            {
                Labels.Add($"Ngày {day}");
            }

           
            SeriesCollection = new SeriesCollection
            {
                new LineSeries
                {
                    Title = "Doanh thu",
                    Values = ValuePrice(selectedDate) // Example method to generate random values for demonstration
                }
            };
        }

        private ChartValues<ObservablePoint> ValuePrice(DateTime selectedDate)
        {
            //Tạo danh sách các điểm dữ liệu cho biểu đồ
            var values = new ChartValues<ObservablePoint>();

            using (var context = new NhaHangProjectContext())
            {
                var query = from Order in context.Orders
                            where Order.OrderDate.Year == selectedDate.Year && Order.OrderDate.Month == selectedDate.Month
                            group Order by Order.OrderDate.Day into g
                            select new
                            {
                                Day = g.Key,
                                TotalRevenue = g.Sum(o => o.TotalAmount)
                            };

                foreach (var value in query)
                {
                    values.Add(new ObservablePoint(value.Day - 1, (double)value.TotalRevenue)); // Giảm đi 1 để bắt đầu từ 0
                }
            }

            return values;
        }

        // Method to handle selection change of date or month (for example, in a calendar control)
        public void UpdateData(DateTime selectedDate)
        {
            LoadData(selectedDate);
        }
    }
}
