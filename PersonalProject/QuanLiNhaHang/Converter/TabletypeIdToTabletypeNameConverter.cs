using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace QuanLiNhaHang.Converter
{
    public class TabletypeIdToTabletypeNameConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int tbtId)
            {
                if(tbtId == 1)
                {
                    return "Standard";
                } else if(tbtId == 2)
                {
                    return "VIP";
                } else { return "Outdoor"; };
            }
            return null; 
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
