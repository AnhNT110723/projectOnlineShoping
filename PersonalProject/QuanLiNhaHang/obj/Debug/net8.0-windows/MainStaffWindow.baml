   M S B A M L   `   `   `  ����H  DQuanLiNhaHang, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:QuanLiNhaHangQuanLiNhaHang  5   	   A%clr-namespace:QuanLiNhaHang.ConverterQuanLiNhaHang.Converter  5	   	   #    QuanLiNhaHang.MainStaffWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:QuanLiNhaHang     5   	   ;	Converter%clr-namespace:QuanLiNhaHang.Converter     5	   	   _ [MaterialDesignThemes.Wpf, Version=5.1.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5
   	   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5   	   -   5        $��
mainWindow��5   	      MaterialDesignBody#���   5   	   $��Regular"�5   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	    
 MainVm � DataContext# [ 5   	     MaterialDesignFont#���  5   	   
������ � WindowStartupLocation$ CenterScreen=�5   	    � Title$ MainStaffWindow��5   	   $	��450��6!   $	��800��6.    � 	Resources 5      3   -QuanLiNhaHang.Converter.StatusToTextConverter  StatusToTextConverterA   ;QuanLiNhaHang.Converter.TabletypeIdToTabletypeNameConverter ' #TabletypeIdToTabletypeNameConverter��%:   &	       &	        5   
   6*     5   
   68   5      .  (System.Windows.Interactivity.Interaction   Triggers 5      /  )System.Windows.Interactivity.EventTrigger  5    
      	EventName$ Loaded��6   .  (System.Windows.Interactivity.TriggerBase   Actions. 5!      6  0System.Windows.Interactivity.InvokeCommandAction  	   Command	 6$   �� *LoadedWindowCommand+
   CommandParameter
 6L   ��  �� ElementName$ 
mainWindow��5"      .��5&      � .+�5(   
   �  � RowDefinitions 5)      �� 5*      $
��auto �6    60   �� 5+      6"   .+�5/      #  MaterialDesignThemes.Wpf.Card  $��5 0 5 0q�6"   65   � 50      $��0��6   .+�51      � $��Stretch=�6   $��Stretch=�65   
������  52       �� 
TargetType �� Property �� Value��%\   '��       �� 53      " ��6    .�54      ��  � ��$ 2 4 2 4q�67   6I   56      57       � ColumnDefinitions 59      �� 5:      $��2* �6+   68   �� 5;      6-   �� 5<      6-   �� 5=      6-   �� 5>      6-   �� 5?      6-   �� 5@      6-   .+�5F      (	  "MaterialDesignThemes.Wpf.ColorZone	  $��0��6/   
�������$��	16,4,15,4q�5G      $��8,4,8,4q�5H      .
  (MaterialDesignThemes.Wpf.ElevationAssist 
  	Elevation$	 Dp2=�5J       	  CornerRadius$ 2��5K       	  Mode$ Standard=�5L      .��5M      � $��1��6    5N      �� 5O   "   $
��Auto �5P      �� 5Q   "   $��* �5R      �� 5S   "   $
��Auto �5T      �� 5U   "   $
��Auto �5V      .+�5X      �� $��0��6H     MaterialDesignToolButton#��[ 6X   ��6&   �� *FilterCommand+.��5Y   "   '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ Search=�5Z       J� Opacity$	 .56Q�5[      5\      �� 5]      $��1��5^      $	��200��5_      $��8,0,0,0q�5`      $��Center=�5a      )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Build a search bar��5b      .  (MaterialDesignThemes.Wpf.TextFieldAssist   DecorationVisibility$ Hidden=�5c      $��0q�5d      ��5]   &   �� *
SearchText+5d      �� 5e      $��2��5f      #��[ 5g      .��5h   "     $��8,0,0,0q�5i      $ 
Microphone=�5j      $	 .56Q�5k      5l      �� 5n      $��4��6%   $��8,0,0,0q�5o       K� ZIndex$ 0��5p       & "MaterialDesignToolForegroundButton#��[ 5q      ��5n   5   �� *FilterCommand+.��5r   "     $
 Send=�5s      5t      5u      5w      �� 5z      $��1��6>    � ToolTip$ Create Table��6O   
���������6   �� *TableCommand+.��5{      �  5|      �� 5}   "   62   �� 5~   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Create Table6W   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ 
TableChair=�6W   5�      5�      5�      �� 5�      $��2��6=   $
 Food��6N   
���������6   �� *FoodCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   Food6O   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $
 Food=�6W   5�      5�      5�      �� 5�      $��3��6v   $ 	ViewOrder��6�   
���������6   �� *ViewOrderCommand+��6B   �� $ 
mainWindow��.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   
View Order6U   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ EyeArrowRightOutline=�6W   5�      5�      5�      �� 5�      $��4��6B   $ Founder��6R   
���������6   �� *MyAccountCommand+.��5�      �  5�      �� 5�   "   62   �� 5�   "   62   .+�5�      � $��0��6#   .+�5�   "   �� $��Center=�6,   
My Account6U   5�      � 5�      $��1��6#   .+�5�   "     $��Center=�6:   $ HumanHandsup=�6W   5�      5�      5�      �� 5�      $��5��6F   $ Founder��6V   
���������6   �� *ManageBookingCommand+.��5�      %  MaterialDesignThemes.Wpf.Badged     Badge 6-   �� *numOfNotification+.��5�      �  5�   "   �� 5�   &   66   �� 5�   &   66   .+�5�   "   � $��0��6'   .+�5�   &   �� $��Center=�60   Manage Booking6]   5�   #   � 5�   "   $��1��6'   .+�5�   &     $��Center=�6>   $ 
BellCircle=�6[   5�   #   5�      5�      5�      �� 5�      $��7��6   $��10q�5�      3  -MaterialDesignThemes.Wpf.ButtonProgressAssist   IsIndeterminate$
 True��5�         IsIndicatorVisible$
 True��5�         Value$ -1Q�5�      $��Logout��5�        MaterialDesignFlatButton#��[ 5�      ��5�   -   �� *LogoutCommand+��6O   �� $ 
mainWindow��{�5�      �� *DataContext.ControlsEnabled+ �� RelativeSource �� *FindAncestor+ �� AncestorType
 Window5�      5�      5�      � 5�      $��1��6    5�      �� 5�      $
��162* �6'   �� 5�      $
��643* �6'   .+�5�        $��5,5,5,5q�6&   $��2��67   .��5�      � ��5�      �� 5�        �� ImageSource$\  Vhttps://spicyfoodstudio.com/wp-content/uploads/2023/03/chup-hinh-menu-nha-hang-03.jpeg��6)    5�      �� 5�      $	��20* �6/   �� 5�      $
��139* �6/    5�      �� 5�      $
��auto �6,   �� 5�      $��* �6,   .+�5�      �� $��0��6$   $��5,5,5,5q�61   $��2��6B   �� 5�      $��1��6"   $��2��5�   M   ��5�   /   �� *Tables+! �� SelectedItem! 5�      �� *SelectedItem+" �� Mode$" TwoWay=���5�      �� 5�   "   .R�5�   &   � # � Orientation$# 
Horizontal=�60   5�   #   ��5�      �� 5�   "   .R�5�   &     $	��173��6:   $��0q�6F    ! PrimaryHueDarkForegroundBrush#���  6R   .��5�   *   �  5   .   �� 5  2   $
��Auto �6@   �� 5  2   $
��Auto �6@   �� 5  2   $
��Auto �6@   .+�5  .   �� $��0��68   $��
16,16,16,4q�6E    $	  MaterialDesignHeadline5TextBlock#��[	 6Y   ��6�   �� *	TableName+�� 5  .   $��1��68     
 MaterialDesignLightSeparator#��[
 6E   �� 5  .   $��2��68   $��	16,0,16,8q�6E   $
��Left=�6X   $��Center=�6s      MaterialDesignBody2TextBlock#��[ 6�   ��5  *   �� *Status+$ �� 	Converter#$ [ �� 5
  .   $��2��68   $��	16,0,16,8q�6E   $��Right=�6X   $��Center=�6t   #��[ 6�   ��5  *   �� *TableTypeId+#$ [ '  !MaterialDesignThemes.Wpf.PopupBox  5  .   $��0��6F   $��Right=�6S   $	��Top=�6o   %   PopupContent.% 5  2   ]� $
��True��6<   .+�5  6   �� .+�5  :   �� $��
Open Table��6A   $��Center=�6V   ��6s   �� *DataContext.OpenTableCommand+ ��  ListBox��6�   �� �� 5  :   $��Choose Menu��6A   $��Center=�6W   ��6v   �� *DataContext.MenuCommand+ �� 
 Window��5  6   �� �� 5  :   $��
Book Table��6A   $��Center=�6V   ��6s   �� *!DataContext.BookingTableCommand+ ��  ListBox��6�   �� �� 5  :   $��Close Table��6A   $��Center=�6W   ��6t   �� *DataContext.CloseTableCommand+ ��  ListBox��6�   �� 5  7   5  3   5  /   5  +   ��5  *   �� 5  .   "  64   & �� Triggers& 5  2   �� 5  6   ' �� Binding' 6B   �� *Status+( �� Value( 16]   .a�5  :   ��  � ��
 ����6W   5  7   �� 5  6   ' 6B   �� *Status+( 06]   .a�5   :   ��  � ��
 �����6W   5!  7   �� 5"  6   ' 6B   �� *Status+( 26]   .a�5#  :   ��  � ��
 ��ح�6W   5$  7   5&  /   5(  '   5)  #   5+     5,     5-     53     54     55     56     