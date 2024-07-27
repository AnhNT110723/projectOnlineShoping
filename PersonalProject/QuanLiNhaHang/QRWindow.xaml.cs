﻿using QuanLiNhaHang.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;



namespace QuanLiNhaHang
{
    /// <summary>
    /// Interaction logic for QRWindow.xaml
    /// </summary>
    public partial class QRWindow : Window
    {
        public QRWindow(int tableid,decimal totalAmount)
        {
            InitializeComponent();
            this.DataContext = new QRViewModel(tableid, totalAmount);
        }

      
    }
}
