   M S B A M L   `   `   `  ����H  DQuanLiNhaHang, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:QuanLiNhaHangQuanLiNhaHang  5   	   !    QuanLiNhaHang.PayBillWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:QuanLiNhaHang     5   	   _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5	   
   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5
   	   -   5        $��
BillWindow��5   	      MaterialDesignBody#���   5   	   $��Regular"�5   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	     MaterialDesignFont#���  5   	    � WindowStartupLocation$ CenterScreen=�5   	   
������ � Title$ PayBillWindow��5   	   $	��750��6   $	��800��6,   .��5      � .+�5   
   #  MaterialDesignThemes.Wpf.Card  $��10q�6   $	��700��6*   $	��800��67   .��5      �  � RowDefinitions 5      �� 5      $
��auto �6$   64   �� 5      $��2* �6$   62   �� 5      $
��auto �6$   64   �� 5      $
��auto �6$   64   �� 5      $
��auto �6$   64   �� 5      $��* �6$   61   .+�5       �� $��0��6   $��Center=�6%   $��Center=�6@   $��30(�6^   .��6l   Bill6r   � 5!      $��1��6   .+�5"      �� -   5        $��
dgvDisplay��5"       $��20q�62   ��6>   �� *List+ �� SelectedItem 6[   �� *SelectedItem+ �� Mode$ TwoWay=� �� View 5#      �� 5$      .P�5%   "   �� $��	Food Name��61    �� Width$	 140��6D   	 �� DisplayMemberBinding	 6P   �� *
FoodName+�� 5&   "   $��
Order Time��61   $	 150��6E   
 �� CellTemplate
 5'   &   �� 5(   *   .R�5)   .   �� ��68   �� *	OrderDate+5*   +   5,   #   �� 5-   "   $��Quantity��61   $	 140��6C   	 6O   �� *
Quantity+�� 5.   "   $��Price��61   $	 100��6@   	 6L   �� *Price+ �� StringFormat$ 
{0:N0} VND���� 5/   "   $��Total��61   $	 180��6@   	 6L   �� *Total+$ 
{0:N0} VND��52      54      55      � 56      $��2��6   $��5q�6%   .+�57      �� $��2 2 2 2q�6!    �� Orientation$ 
Horizontal=�62   .+�58      �� $��90��6    $��Table Number: ��6+   $��Center=�6E   6b   �� 59      $	��200��6K   )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Floating Hint��6W    % !MaterialDesignFloatingHintTextBox#��[ 6�   ��6"   �� *	TableName+$ TwoWay=�6�   5:      5<      � 5=      $��3��6   $��5q�6$   .+�5>      �� $��2 2 2 2q�6"   $ 
Horizontal=�63   .+�5?      �� $��90��6    $��Total Price: ��6+   $��Center=�6D   6a   �� 5@      $	��200��6h   $ Floating Hint��6t   #��[ 6�   ��6"   �� *TotalAmount+$ TwoWay=�$ 
{0:N0} VND��6�   5A      5C      � 5D      $��4��6   $��5q�6$   .+�5E      �� $��2 2 2 2q�6!   $ 
Horizontal=�62   .+�5F      �� $��90��6    $��Order Date: ��6+   $��Center=�6C   6`   �� 5G      $	��200��6K   $ Floating Hint��6W   #��[ 6�   ��6"   �� *	OrderDate+$ TwoWay=�6�   5H      5I      � 5K      $��5��6   $��5q�6$    � ColumnDefinitions 5L      �� 5M      $��* �6+   67   �� 5N      $��* �6+   67   �� 5O      $��* �6+   67   .+�5Q      �� 
�������$��Thanh Toán Tiền Mặt��6�   $��0��6�   $��Center=�6�   $��Center=�6�   ��6   �� *CashpaymentCommand+��6D   ��  �� ElementName$ 
BillWindow��6�   �� 5R      -   5        $��	btnUpdate��5R   �   
����  �$��Center=�6�   $��Center=�6�   $"��Thanh Toán Chuyển Khoản��6�   $��5q�6�   $��1��6  ��6   �� *TransferPaymentCommand+��6H   �� $ 
BillWindow��6  �� 5S      -   5        $��	btnDelete��5S   t   $��Center=�6�   $��Center=�6�   $��Cancel��6�   $��5q�6�   $��2��6�   ��6   �� *CancelCommand+��6?   �� $ 
BillWindow��6�   5T      5U      5V      5W      5X      