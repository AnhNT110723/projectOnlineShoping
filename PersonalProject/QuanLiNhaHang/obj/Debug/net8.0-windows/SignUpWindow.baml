   M S B A M L   `   `   `  ����H  DQuanLiNhaHang, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:QuanLiNhaHangQuanLiNhaHang  5   	   A%clr-namespace:QuanLiNhaHang.ConverterQuanLiNhaHang.Converter  5	   	        QuanLiNhaHang.SignUpWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:QuanLiNhaHang     5   	   ;	Converter%clr-namespace:QuanLiNhaHang.Converter     5	   	   _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5
   
   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5   	   -   5        $��signupWindow��5   	      MaterialDesignBody#���   5   	   $��Regular"�5   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	     SignupVm � DataContext# [ 5   	     MaterialDesignFont#���  5   	    � WindowStartupLocation$ CenterScreen=�5   	    � Title$ SignUpWindow��5   	   $	��450��6   $	��800��6+    � 	Resources 5      6   0QuanLiNhaHang.Converter.GenderToBooleanConverter  GenderToBooleanConverter��%   &	         5   
   6-   5      .��5      � ��5   
   �� 5        �� ImageSource$e _https://img6.thuthuatphanmem.vn/uploads/2022/03/16/background-mon-an-giau-vitamin_024947267.jpg��6   .+�5"   
   #  MaterialDesignThemes.Wpf.Card  $	��700��6   $	��350��6*   $��10q�67   .��5#      �  � ColumnDefinitions 5$      �� 5%      $��* �6'   63   �� 5&      $��* �6'   63   .+�5(      �� $��0��6   $H��Bhttps://thietkeaz.com/files/02-04-18/thiet-ke-logo-nha-hang-05.png��6(   $��Center=�6t   $��Stretch=�6�   $��0,0,0,30q�6�   $	��300��6�   $	��300��6�   6�   � 5)      $��1��6    � RowDefinitions 5*      �� 5+      $
��auto �6(   68   �� 5,      $��* �6(   65   �� 5-      $
��auto �6(   69   .+�5/      �� $��0��6    $��30(�6-   $��Center=�6;   $��Center=�6X   $��	10,10,0,0q�6s   	SIGN UP6�   �� 50      $��1��6!   $��Center=�6.   $��Stretch=�6K   $��0 10 0 0q�6g   .+�51      �� 	 �� Orientation$	 
Horizontal=�6%   $��0,5,0,5q�6>   .+�52      �� $��80��6$   $��
Full Name:��6/   �� 53      -   5        $��txtId��53   &   $��250px��63   ��6A   �� *
FullName+
 �� Mode$
 TwoWay=�54      �� 55      $	 
Horizontal=�6%   $��0,5,0,5q�6>   .+�56      �� $��80��6$   $��Email��6/   �� 57      -   5        $��txtName��57   &   $��250px��65   ��6C   �� *Email+$
 TwoWay=�58      �� 59      $	 
Horizontal=�6%   $��0,5,0,5q�6>   .+�5:      �� $��80��6$   $��Gender��6/   	� 5;      $
��Male��6*    d� 	IsChecked 69   �� *Gender+ �� 	Converter# [  �� ConverterParameter$ 1��$
 TwoWay=�6�   	� 5<      $��5 0 0 0q�6*   $��Female��6�    6;   �� *Gender+# [ $ 0��$
 TwoWay=�6�   5=      �� 5>      $	 
Horizontal=�6%   $��0,5,0,5q�6>   .+�5?      �� $��80��6$   $	��DOB��6/   (  "System.Windows.Controls.DatePicker  5@      -   5        $��dpkDob��5@   )   $��100px��67      SelectedDate 6E   �� *DateOfBirth+$
 TwoWay=�5A      �� 5K      $	 
Horizontal=�6%   .+�5L      �� $��Center=�6(   $
��Left=�6C   �� 5M      
���� �� �� Command 6)   �� *NavigateToLoginCommand+ �� CommandParameter 6T   ��  �� ElementName$ signupWindow��.�6�   .�5N   &   �� $	 
Horizontal=�61   .+�5O   *   '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowLeft=�6B   $��Center=�6S   $��0,0,5,0q�6n   �� 5P   *   $
��Back��64   $��Center=�6@   5Q   '   5R   #   5S      �� 5U      $��50 20 10 10q�6}   $	��100��6�   $��Sign up��6�    & "MaterialDesignPaperSecondaryButton#��[ 5V       � ToolTip$7 1Resource name: MaterialDesignPaperSecondaryButton��5W      ��5U   %   �� *SignUpCommand+��6G   �� $ signupWindow��{�6�   �� *DataContext.ControlsEnabled+ �� RelativeSource �� *FindAncestor+ �� AncestorType
 Window5W      5X      5Y      5]      5^      5_      5`      5a      