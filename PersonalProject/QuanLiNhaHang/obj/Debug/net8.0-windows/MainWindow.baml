   M S B A M L   `   `   `  ����H  DQuanLiNhaHang, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:QuanLiNhaHangQuanLiNhaHang  5   	   A%clr-namespace:QuanLiNhaHang.ConverterQuanLiNhaHang.Converter  5   	       QuanLiNhaHang.MainWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:QuanLiNhaHang     5   	   ;	Converter%clr-namespace:QuanLiNhaHang.Converter     5   	   _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5
   	   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5   	   -   5        $��
mainWindow��5   	      MaterialDesignBody#���   5   	   $��Regular"�5   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	    
 MainVm � DataContext# [ 5   	     MaterialDesignFont#���  5   	   
������ � WindowStartupLocation$ CenterScreen=�5   	    � Title$ 
MainWindow��5   	   $	��610��6   $	��990��6)    � 	Resources 5      3   -QuanLiNhaHang.Converter.StatusToTextConverter  StatusToTextConverterA   ;QuanLiNhaHang.Converter.TabletypeIdToTabletypeNameConverter ' #TabletypeIdToTabletypeNameConverter��%:   &	       &	        5   
   6*     5   
   68   5      .  (System.Windows.Interactivity.Interaction   Triggers 5      /  )System.Windows.Interactivity.EventTrigger  5   
      	EventName$ Loaded��6   .  (System.Windows.Interactivity.TriggerBase   Actions. 5       6  0System.Windows.Interactivity.InvokeCommandAction  	   Command	 6$   �� *LoadedWindowCommand+
   CommandParameter
 6L   ��  �� ElementName$ 
mainWindow��5!      .��5%      � .+�5'   
   �  � RowDefinitions 5(      �� 5)      $
��auto �6    60   �� 5*      6"   .+�5.      #  MaterialDesignThemes.Wpf.Card  $��5 0 5 0q�6"   65   � 5/      $��0��6   .+�50      � $��Stretch=�6   $��Stretch=�65   
������  51       �� 
TargetType �� Property �� Value��%\   '��       �� 52      " ��6    .�53      ��  � ��$ 2 4 2 4q�67   6I   55      56       � ColumnDefinitions 58      �� 59      $��2* �6+   68   �� 5:      6-   �� 5;      6-   �� 5<      6-   �� 5=      6-   �� 5>      6-   �� 5?      6-   �� 5@      6-   �� 5A      6-   .+�5G      (	  "MaterialDesignThemes.Wpf.ColorZone	  $��0��6/   
�������$��	16,4,15,4q�5H      $��8,4,8,4q�5I      .
  (MaterialDesignThemes.Wpf.ElevationAssist 
  	Elevation$	 Dp2=�5K       	  CornerRadius$ 2��5L       	  Mode$ Standard=�5M      .��5N      � $��1��6    5O      �� 5P   "   $
��Auto �5Q      �� 5R   "   $��* �5S      �� 5T   "   $
��Auto �5U      �� 5V   "   $
��Auto �5W      .+�5Y      �� $��0��6H     MaterialDesignToolButton#��[ 6X   ��6&   �� *FilterCommand+.��5Z   "   '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ Search=�5[       J� Opacity$	 .56Q�5\      5]      �� 5^      $��1��5_      $	��200��5`      $��8,0,0,0q�5a      $��Center=�5b      )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Build a search bar��5c      .  (MaterialDesignThemes.Wpf.TextFieldAssist   DecorationVisibility$ Hidden=�5d      $��0q�5e      ��5^   &   �� *
SearchText+5e      �� 5f      $��2��5g      #��[ 5h      .��5i   "     $��8,0,0,0q�5j      $ 
Microphone=�5k      $	 .56Q�5l      5m      �� 5o      $��4��6%   $��8,0,0,0q�5p       K� ZIndex$ 0��5q       & "MaterialDesignToolForegroundButton#��[ 5r      ��5o   5   �� *FilterCommand+.��5s   "     $
 Send=�5t      5u      5v      5x      �� 5z      $��1��6@    � ToolTip$ RevenueReport��6Q   
���������6   �� *RevenueCommand+.��5{      �  5|      �� 5}   "   62   �� 5~   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Revenue Report6Y   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ ChartAreaspline=�6W   5�      5�      5�      �� 5�      $��2��6>   $ Create Table��6O   
���������6   �� *TableCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Create Table6W   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ 
TableChair=�6W   5�      5�      5�      �� 5�      $��3��6=   $
 Food��6N   
���������6   �� *FoodCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Food6O   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $
 Food=�6W   5�      5�      5�      �� 5�      $��4��6t   $ Staff��6�   
���������6   �� *AccountCommand+��6@   �� $ 
mainWindow��.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Staff6P   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ AccountGroup=�6W   5�      5�      5�      �� 5�      $��5��6v   $ 	ViewOrder��6�   
���������6   �� *ViewOrderCommand+��6B   �� $ 
mainWindow��.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   
View Order6U   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ EyeArrowRightOutline=�6W   5�      5�      5�      �� 5�      $��6��6G   $ 	ViewOrder��6W   
���������6   �� *ManageActivityCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Manage Activity6Z   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ Group=�6W   5�      5�      5�      �� 5�      $��7��6B   $ Founder��6R   
���������6   �� *MyAccountCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   
My Account6U   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ HumanHandsup=�6W   5�      5�      5�      �� 5�      $��8��6   $��10q�5�      3  -MaterialDesignThemes.Wpf.ButtonProgressAssist   IsIndeterminate$
 True��5�         IsIndicatorVisible$
 True��5�         Value$ -1Q�5�      $��Logout��5�        MaterialDesignFlatButton#��[ 5�      ��5�   -   �� *LogoutCommand+��6O   �� $ 
mainWindow��{�5�      �� *DataContext.ControlsEnabled+ �� RelativeSource �� *FindAncestor+ �� AncestorType
 Window5�      5�      5�      � 5�      $��1��6   .+�5�        $��5,5,5,5q�6&   $��2��67   .��5�      � ��5�      �� 5�       �� ImageSource$\ Vhttps://spicyfoodstudio.com/wp-content/uploads/2023/03/chup-hinh-menu-nha-hang-03.jpeg��6)    5�      �� 5�      $	��20* �6/   �� 5      $
��139* �6/    5     �� 5     $
��auto �6,   �� 5     $��* �6,   .+�5     �� $��0��6$   $��5,5,5,5q�61   $��2��6B   �� 5
     $��1��6"   $��2��5  P   ��5
  /   �� *Tables+  �� SelectedItem  5     �� *SelectedItem+! �� Mode$! TwoWay=���5     �� 5  "   .R�5  &   � " � Orientation$" 
Horizontal=�60   5  #   ��5     �� 5  "   .R�5  &     $	��173��6:   $��0q�6F    ! PrimaryHueDarkForegroundBrush#���  6R   .��5  *   �  5  .   �� 5  2   $
��Auto �6@   �� 5  2   $
��Auto �6@   �� 5  2   $
��Auto �6@   .+�5  .   �� $��0��68   $��
16,16,16,4q�6E    $	  MaterialDesignHeadline5TextBlock#��[	 6Y   ��6�   �� *	TableName+�� 5  .   $��1��68     
 MaterialDesignLightSeparator#��[
 6E   �� 5  .   $��2��68   $��	16,0,16,8q�6E   $
��Left=�6X   $��Center=�6s      MaterialDesignBody2TextBlock#��[ 6�   ��5  -   �� *Status+# �� 	Converter## [ �� 5  .   $��2��68   $��	16,0,16,8q�6E   $��Right=�6X   $��Center=�6t   #��[ 6�   ��5   -   �� *TableTypeId+## [ '  !MaterialDesignThemes.Wpf.PopupBox  5"  .   $��0��6F   $��Right=�6S   $	��Top=�6o   $   PopupContent.$ 5#  2   ]� $
��True��6<   .+�5$  6   �� .+�5%  :   �� $��
Open Table��6A   $��Center=�6V   ��6s   �� *DataContext.OpenTableCommand+ ��  ListBox��6�   �� �� 5&  :   $��Choose Menu��6A   $��Center=�6W   ��6v   �� *DataContext.MenuCommand+ �� 
 Window��5'  9   �� �� 5(  :   $��
Book Table��6A   $��Center=�6V   ��6s   �� *!DataContext.BookingTableCommand+ ��  ListBox��6�   �� �� 5)  :   $��Close Table��6A   $��Center=�6W   ��6t   �� *DataContext.CloseTableCommand+ ��  ListBox��6�   �� 5*  7   5+  3   5,  /   5-  +   ��5.  *   �� 5/  .   "  64   % �� Triggers% 50  2   �� 51  6   & �� Binding& 6B   �� *Status+' �� Value' 16]   .a�52  :   ��  � ��
 ����6W   53  7   �� 54  6   & 6B   �� *Status+' 06]   .a�55  :   ��  � ��
 �����6W   56  7   �� 57  6   & 6B   �� *Status+' 26]   .a�58  :   ��  � ��
 ��ح�6W   59  7   5;  /   5=  '   5>  #   5@     5A     5B     5H     5I     5J     5K     