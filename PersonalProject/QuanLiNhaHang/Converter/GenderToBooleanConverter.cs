using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace QuanLiNhaHang.Converter
{
    public class GenderToBooleanConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int gender && parameter is string targetGender)
            {
                if (int.TryParse(targetGender, out int targetGenderValue))
                {
                    return gender == targetGenderValue;
                }
            }
            return false;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isChecked && isChecked && parameter is string targetGender)
            {
                if (int.TryParse(targetGender, out int targetGenderValue))
                {
                    return targetGenderValue;
                }
            }
            return null;
        }
    }
}
