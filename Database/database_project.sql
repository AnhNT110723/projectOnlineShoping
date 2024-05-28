create database project_prj






Create table Category(
cid int primary key,
cname nvarchar(50)
);

insert into Category
values(1,'Laptops'), (2, 'Smartphones'),(3, 'Cameras'),(4, 'Accessories')




select count (*) from product
where [catId] = ? and [name] like ?


SELECT [id],[name],[image],[price],[title],[description],[catId],[sellId] 
FROM product
WHERE [catId] = 1 and name LIKE '%dell%' 
ORDER BY id
OFFSET 0 ROWS
FETCH NEXT 4 ROWS ONLY; 


select	[id],
		[name],
		[image]
       ,[price]
       ,[title]
		,[description]
       ,[catId]
       ,[sellId] from product
	   where price BETWEEN ? AND ? order by id offset 12 rows fetch next 12 rows only

CREATE TABLE account (
    [uid] INT IDENTITY(1,1) PRIMARY KEY,
    [user] NVARCHAR(50),
    [password] NVARCHAR(100),
    email NVARCHAR(100),
	amount money null,
    code NVARCHAR(10),
    isSellId INT,
    isAdmin INT
);




insert into account
values('Tuan','1234','tuan@hy.com','','123445',1,1),
('Linh','123456','Linh@hy.com','','234567',1,0),
('Huyen','1234','Huyen@qo.com','','1234567',1,1),
('Hung', '12345','Hung@hb.com','','12345678',0,1)










CREATE TABLE product (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50),
    image NVARCHAR(500),
    image1 NVARCHAR(500),
    image2 NVARCHAR(500),
    image3 NVARCHAR(500),
    price money,
    title NVARCHAR(500),
    description NVARCHAR(1000),
    catId INT,
    sellId INT,
	FOREIGN KEY (catId) REFERENCES Category(cid),
    FOREIGN KEY (sellId) REFERENCES account([uid])
);

insert into product 
values('DELL VOSTRO 15 3530','https://hanoicomputercdn.com/media/product/76745_laptop_dell_vostro_15_3530__v5i5267w1__2_.jpg',
'https://hanoicomputercdn.com/media/product/120_77188_laptop_dell_vostro_15_3530__v5i5267w1__1_.jpg',
'https://hanoicomputercdn.com/media/product/120_77188_laptop_dell_vostro_15_3530__v5i5267w1__6_.jpg',
'https://hanoicomputercdn.com/media/product/120_77188_laptop_dell_vostro_15_3530__v5i5267w1__5_.jpg',
'800', 'LAPTOP DELL VOSTRO 15 3530 (V3530-I7U085W11GRD2) (I7 1355U 8GB RAM/512GB SSD/MX550 2G/15.6 INCH FHD 120HZ/WIN11/OFFICEHS21/XÁM)', 
'Dell Vostro 15 3530 (V3530-I7U085W11GRD2) là một dòng laptop doanh nhân của Dell, được thiết kế để cung cấp hiệu suất đáng tin cậy và tính di động. Laptop này được trang bị vi xử lý Intel Core i7 1355U, 8GB RAM, và ổ cứng SSD 512GB, giúp tăng tốc độ khởi động hệ thống và thời gian phản hồi ứng dụng. Nó cũng đi kèm với card đồ họa Nvidia MX550 2GB, cung cấp hiệu suất đồ họa tốt cho các tác vụ như chỉnh sửa video và đồ họa. Màn hình 15.6 inch Full HD với tần số làm mới 120Hz mang lại trải nghiệm hình ảnh mượt mà và sống động. Laptop chạy trên hệ điều hành Windows 11 và đi kèm với bộ phần mềm Microsoft Office Home & Student 2021. Màu xám của máy tạo nên vẻ ngoài chuyên nghiệp và sang trọng.'
,1,3),
('DELL INSPIRON 3520 ', 'https://hanoicomputercdn.com/media/product/68070_laptop_dell_inspiron_3520_3.png',
'https://hanoicomputercdn.com/media/product/120_68069_laptop_dell_inspiron_3520_3.jpg',
'https://hanoicomputercdn.com/media/product/120_68069_laptop_dell_inspiron_3520_7.jpg',
'https://hanoicomputercdn.com/media/product/120_68069_laptop_dell_inspiron_3520_6.jpg',
'990','  DELL INSPIRON 3520 ' ,'Laptop Dell Latitude 3520 i5 (N5I5122W1) là chiếc laptop mang kiểu dáng đặc trưng của phân khúc học tập - văn phòng cùng hiệu năng ổn định của bộ vi xử lý đến từ nhà Intel sẽ đáp ứng tốt mọi tác vụ hàng ngày.',1,3),
('ASUS VIVOBOOK 15' ,'https://hanoicomputercdn.com/media/product/71158_a1505va_l1114w.png',
'https://hanoicomputercdn.com/media/product/120_73232_laptop_asus_vivobook_x1504va_nj070w___7_.jpg',
'https://hanoicomputercdn.com/media/product/120_73232_laptop_asus_vivobook_x1504va_nj070w___6_.jpg',
'https://hanoicomputercdn.com/media/product/120_73232_laptop_asus_vivobook_x1504va_nj070w___4_.jpg',
'700',
'LAPTOP ASUS VIVOBOOK X1504VA-NJ070W (I5 1335U/16GB RAM/512GB SSD/15.6 FHD/WIN11/XANH)','
Tỏa sáng với cả thế giới cùng ASUS Vivobook 14/15 OLED mạnh mẽ, chiếc laptop tích hợp nhiều tính năng với màn hình OLED rực rỡ, gam màu DCI-P3 đẳng cấp điện ảnh. Mọi thứ trở nên dễ dàng hơn nhờ những tiện ích thân thiện với người dùng bao gồm bản lề mở phẳng 180°, nắp che webcam vật lý và các phím chức năng chuyên dụng. Bảo vệ sức khỏe an toàn với ASUS kháng khuẩn Guard Plus trên các bề mặt thường xuyên chạm vào. Bắt đầu ngày mới đầy hứng khởi với ASUS Vivobook 14/15 OLED!',
1,1),
('LAPTOP LG GRAM','https://hanoicomputercdn.com/media/product/250_71768_laptop_lg_gram_16z90r_g_ah76a5_1.jpg',
'https://hanoicomputercdn.com/media/product/120_71768_laptop_lg_gram_16z90r_4.png',
'https://hanoicomputercdn.com/media/product/120_71768_laptop_lg_gram_16z90r_3.png',
'https://hanoicomputercdn.com/media/product/120_71768_laptop_lg_gram_16z90r_2.png',
'800','LAPTOP LG GRAM 16Z90R-G.AH76A5 (I7-1360P/16GB RAM/512GB SSD/16.0 INCH WQXGA/WIN 11/XÁM) (2023)','
Dòng laptop LG Gram 16Z90R-G.AH76A5 là một máy tính xách tay mạnh mẽ và nhẹ nhàng, với vi xử lý Intel Core i7-1360P, 16GB RAM, và ổ cứng SSD 512GB. Màn hình 16.0 inch WQXGA cho trải nghiệm xem phim và làm việc tuyệt vời. Máy chạy trên hệ điều hành Windows 11 và có màu xám sang trọng.'
,1,1),
('HP PROBOOK 450 G7','https://hanoicomputercdn.com/media/product/250_57327_hp_probook_450_g8_10.png',
'https://hanoicomputercdn.com/media/product/120_57327_hp_probook_450_g8_9.png',
'https://hanoicomputercdn.com/media/product/120_57327_hp_probook_450_g8_5.JPG',
'https://hanoicomputercdn.com/media/product/120_57327_hp_probook_450_g8_6.JPG',
'600','MÁY TÍNH XÁCH TAY HP PROBOOK 450 G7, CORE I5-10210U, CORE I5-10210U | DINHVANGCOMPUTER',
'HP ProBook 450 G7 là một dòng laptop doanh nghiệp được thiết kế để cung cấp hiệu suất ổn định và độ bền cao. Dòng này thường được trang bị các tùy chọn vi xử lý Intel Core i5 hoặc i7, RAM từ 8GB đến 16GB, và ổ cứng HDD hoặc SSD. Màn hình thường là 15.6 inch với độ phân giải Full HD. ProBook 450 G7 cung cấp các tính năng bảo mật như cảm biến vân tay và TPM, cũng như các cổng kết nối đa dạng như USB-C, HDMI và RJ-45. Đây là một lựa chọn phổ biến cho doanh nghiệp hoặc người dùng cá nhân cần một máy tính xách tay đáng tin cậy và linh hoạt.'
,1,1),
('ACER NITRO 5','https://hanoicomputercdn.com/media/product/250_63453_laptop_acer_gaming_nitro_5_tiger_13.jpeg',
'https://hanoicomputercdn.com/media/product/120_63453_laptop_acer_gaming_nitro_5_tiger_11.jpeg',
'https://hanoicomputercdn.com/media/product/120_63453_laptop_acer_gaming_nitro_5_tiger_9.JPG',
'https://hanoicomputercdn.com/media/product/120_63453_laptop_acer_gaming_nitro_5_tiger_7.JPG',
'600','LAPTOP ACER GAMING NITRO 5 TIGER AN515-58-52SP (NH.QFHSV.001) (I5 12500H/8GB RAM/512GB SSD/RTX3050 4G/15.6 INCH FHD 144HZ/WIN 11/ĐEN) (2022)','
Máy tính xách tay Acer Nitro 5 Core i5 SSD 250GB HDD 1TB GTX 1050 4GB là một lựa chọn phổ biến cho các game thủ và người dùng cần hiệu suất đồ họa cao.',1,3),
('DELL G15 5530','https://hanoicomputercdn.com/media/product/250_72527_laptop_dell_gaming_g15_5530_6.png',
'https://hanoicomputercdn.com/media/product/120_72528_laptop_dell_gaming_g15_5530_8.png',
'https://hanoicomputercdn.com/media/product/120_72528_laptop_dell_gaming_g15_5530_7.png',
'https://hanoicomputercdn.com/media/product/120_72528_laptop_dell_gaming_g15_5530_6.png',
'900','LAPTOP DELL GAMING G15 5530 (I7H165W1',
'Dell G15 2021 là một dòng laptop chơi game mới của Dell, được thiết kế để mang lại trải nghiệm gaming tốt nhất cho người dùng',1,3),

('ACER ASPIRE 5','https://hanoicomputercdn.com/media/product/250_78992_laptop_acer_aspire_5_a514_56p_562p__nx_khrsv_008_.jpg',
'https://hanoicomputercdn.com/media/product/120_76572_laptop_acer_aspire_5_a514_56p_55k5__nx_khrsv_003___7_.jpg',
'https://hanoicomputercdn.com/media/product/120_76572_laptop_acer_aspire_5_a514_56p_55k5__nx_khrsv_003___3_.jpg',
'https://hanoicomputercdn.com/media/product/120_76572_laptop_acer_aspire_5_a514_56p_55k5__nx_khrsv_003___2_.jpg',
'890','LAPTOP ACER ASPIRE 5 A514-56P-55K5 (NX.KHRSV.003) (I5 1335U/16GB RAM/512GB SSD/14.0 INCH WUXGA IPS/WIN11/XÁM) (2023)','
Acer Aspire 5 là một dòng laptop phổ thông nhưng vẫn cung cấp hiệu suất tốt và giá cả phải chăng. Dòng này thường được trang bị các vi xử lý Intel Core i3/i5/i7 hoặc AMD Ryzen, RAM từ 4GB đến 16GB, và ổ cứng HDD hoặc SSD. Màn hình thường là 15.6 inch với độ phân giải Full HD. Aspire 5 cung cấp một loạt các cổng kết nối, bao gồm USB, HDMI và cổng Ethernet, giúp bạn dễ dàng kết nối với các thiết bị khác. Đây là một lựa chọn phổ biến cho sinh viên, người làm văn phòng, hoặc những người dùng cần một laptop đáng tin cậy cho các nhu cầu hàng ngày.',
1,2),
('MacBook Pro 13','https://hanoicomputercdn.com/media/product/67347_hacom_macbook_pro_13_15.png',
'https://hanoicomputercdn.com/media/product/120_67347_hacom_macbook_pro_13_14.png',
'https://hanoicomputercdn.com/media/product/67347_hacom_macbook_pro_13_13.png',
'https://hanoicomputercdn.com/media/product/120_67347_hacom_macbook_pro_13_12.png',
'980','LAPTOP APPLE MACBOOK PRO 13 (Z16R0003V) (APPLE M2 /8C CPU/10C GPU/16GB/256GB SSD/13.3/MAC OS/XÁM)', 'MacBook Pro 13 là dòng laptop sản xuất bởi Apple. Dòng sản phẩm này thường có các phiên bản khác nhau với cấu hình và tính năng đa dạng, nhưng nổi bật với thiết kế mỏng nhẹ, màn hình chất lượng cao, hiệu suất mạnh mẽ và hệ điều hành macOS ổn định.'
,1,3),
('MACBOOK PRO 16 ','https://hanoicomputercdn.com/media/product/78401_apple_macbook_pro_14__mr7k3saa___6_.jpg',
'https://hanoicomputercdn.com/media/product/120_78398_apple_macbook_pro_14__mr7k3saa___5_.jpg',
'https://hanoicomputercdn.com/media/product/120_78398_apple_macbook_pro_14__mr7k3saa___4_.jpg',
'https://hanoicomputercdn.com/media/product/120_78398_apple_macbook_pro_14__mr7k3saa___1_.jpg',
'999','APPLE MACBOOK PRO 16 (MRW73SA/A) (APPLE M3 MAX 14 CORE CPU/30 CORE GPU/36GB RAM/1TB SSD/16.2 INCH/MAC OS/BẠC)',
'MacBook Pro 16 là một trong những dòng laptop cao cấp của Apple, được thiết kế đặc biệt cho những người làm việc sáng tạo và yêu cầu cao về hiệu suất. Dòng này thường được trang bị các vi xử lý Intel Core i9 hoặc M1 Pro/M1 Max mới nhất của Apple, RAM từ 16GB đến 64GB, và ổ cứng SSD từ 512GB đến 8TB. Màn hình Retina 16 inch với độ phân giải cao cho trải nghiệm xem phim và làm việc tuyệt vời. MacBook Pro 16 có thiết kế sang trọng và mỏng nhẹ, cung cấp các tính năng tiện ích như Touch Bar, Touch ID, và loa âm thanh chất lượng cao. Đây là một lựa chọn phổ biến cho những người dùng chuyên nghiệp trong lĩnh vực thiết kế đồ họa, phát âm nhạc và lập trình.'
,1,4)



insert into product
values(
'IPhone 15', 'https://clickbuy.com.vn//uploads/images/2023/09/iphone-15-den-1-1.png',
'https://clickbuy.com.vn//uploads/images/2023/09/iphone-15-xanh-la-1-1.png',
'https://clickbuy.com.vn//uploads/images/2023/09/iphone-15-vang-1-1.png',
'https://clickbuy.com.vn//uploads/images/2023/09/iphone-15-xanh-1-1.png',
'500', 'iPhone 15 128GB Chính Hãng VN/A', 'Khả năng thiết kế của iPhone 15 được đánh giá cao với vẻ ngoài sang trọng và cầm nắm thoải mái. Nó kế thừa những giá trị cốt lõi từ các thế hệ trước đó, với khung viền kim loại và thiết kế phẳng. Các góc cạnh được bo tròn, mặt lưng nhám mang lại cảm giác cầm nắm thoải mái cho người dùng. Màn hình của iPhone 15 có viền mỏng, tạo không gian màn hình rộng hơn để người dùng có trải nghiệm tốt hơn.'
,2,1),
('Samsung Galaxy A54','https://clickbuy.com.vn//uploads/images/2022/10/1-14.jpg',
'https://clickbuy.com.vn//uploads/images/2022/10/2-12.jpg',
'https://clickbuy.com.vn//uploads/images/2022/10/3-16.jpg',
'https://clickbuy.com.vn//uploads/images/2022/10/3-16.jpg','400', 'Samsung Galaxy A54 (5G) 8GB 128GB Chính Hãng','Samsung Galaxy A54 (5G) mang vẻ ngoài năng động và thời trang, thứ cực kỳ cuốn hút với Gen Z. Với trọng lượng nhẹ và độ mỏng linh hoạt, bạn sẽ cảm thấy thoải mái khi cầm nắm cũng như bỏ túi dễ dàng. Độ bền của Galaxy A54 còn được thể hiện qua khả năng chống bám bụi / nước đạt chuẩn IP67 cao cấp.'
,2, 3),
('IPhone 14 Pro Max','https://clickbuy.com.vn//uploads/images/2022/12/avt-iphone-14-pro-max-deep-purple.png',
'https://clickbuy.com.vn//uploads/images/2022/12/avt-iphone-14-pro-max-silver.png',
'https://clickbuy.com.vn//uploads/images/2022/12/avt-iphone-14-pro-max-space-black.png',
'https://clickbuy.com.vn//uploads/images/2022/12/avt-iphone-14-pro-max-gold.png',
'450',
'iPhone 14 Pro Max 128GB cũ đẹp 99%','Sản phẩm có trong mình một diện mạo bắt mắt với lối tạo hình vuông vức bắt trend tương tự thế hệ iPhone 13 series, đây được xem là kiểu thiết kế rất thành công trên các đời thế hệ trước khi tạo nên cơn sốt toàn cầu về kiểu dáng thiết kế điện thoại cho đến nay. Một điểm đặc biệt trên phiên bản này là màu Deep Purple (tím nhạt) mới chưa từng có trên những phiên bản trước đây, vì thế đây chắc hẳn là một đặc điểm nhận diện dễ dàng trên iPhone 14 Pro Max.',
2,3),
('Samsung Galaxy Z Flip5','https://clickbuy.com.vn//uploads/images/2023/07/ava-zflip5-mint.png',
'https://clickbuy.com.vn//uploads/images/2023/07/ava-zflip5-cream.png',
'https://clickbuy.com.vn//uploads/images/2023/07/ava-zflip5-Purrple.png',
'https://clickbuy.com.vn//uploads/images/2023/07/ava-zflip5-Black.png',
'490','Samsung Galaxy Z Flip5 8GB 512GB Chính Hãng','Galaxy Z Flip5 được cung cấp năng lượng từ viên pin 3700mAh, đây không phải là một dung lượng pin quá cao tuy nhiên được kết hợp cùng con chip Snapdragon 8 gen 2 For Galaxy được tối ưu giúp tiết kiệm pin hơn khi sử dụng. Ngoài ra sản phẩm cũng được trang bị kèm theo tính năng sạc nhanh 25w giúp hoạt động trải nghiệm của người dùng không bị gián đoạn.',
2,3),
('Samsung Galaxy S24 Plus','https://clickbuy.com.vn//uploads/pro/samsung-galaxy-s24-plus_197557.jpg',
'https://clickbuy.com.vn//uploads/pro/3_47752.png',
'https://clickbuy.com.vn//uploads/pro/3_47753.png',
'https://clickbuy.com.vn//uploads/pro/3_47754.png',
'800','Samsung Galaxy S24 Plus (5G) 12GB 256GB Chính Hãng','Samsung đã trang bị viên pin lớn giúp thời gian sử dụng được kéo dài cả dài. Với dung lượng pin lớn giúp khả năng xem video lên đến 31 giờ đồng hồ, nghe nhạc tới 92 giờ đồng hồ. Bên cạnh đó, Samsung còn hỗ trợ thêm cho Samsung Galaxy S24 Plus bộ sạc nhanh 25W giúp khả năng sạc được nhanh hơn tiết kiệm được thời gian sạc đầy, rút ngắn thời gian để người dùng không bị gián đoạn khi sử dụng.',
2,1)





drop table account
drop table Category
drop table product






 select [id],[name]
            ,[image]
            ,[price]
            ,[title]
            ,[description]
            ,[catId]
            ,[sellId] from product p
			order by id offset 0 rows fetch next 5 rows only


select  [id]
      ,[name]
      ,[image]
      ,[price]
      ,[title]
      ,[description]
      ,[catId]
      ,[sellId] from product where catID = ?

select top 5  [id]
      ,[name]
      ,[image]
      ,[price]
      ,[title]
      ,[description]
      ,[catId]
      ,[sellId] from product order by product.id desc 
	

select  [id]
      ,[name]
      ,[image]
      ,[price]
      ,[title]
      ,[description]
      ,[catId]
      ,[sellId] from product where [name] like '%2%'

	  update product 
	  set 
      [name] = ?
      ,[image] = ?
      ,[image1] = ?
      ,[image2] = ?
      ,[image3] = ?
      ,[price] = ?
      ,[title] = ?
      ,[description] = ?
      ,[catId] = ?
   where product.id = ?


   select top 4 [id]
      ,[name]
      ,[image]
      ,[price]
      ,[title]
      ,[description]
      ,[catId]
      ,[sellId] from product

drop table Category
drop table product
update product
set sellId = 1 
where product.id = 10

update product
set	   [name] = ?
      ,[image] = ?
      ,[price] = ?
      ,[title] = ?
      ,[description] = ?
      ,[catId] = ?
where product.id = ?


select * from product where sellId = 3;
select * from product where id = ?
select * from product 
where [name] like '%5%' and catId = 1
select * from account where email = ? and [password] = ?
insert into account values(?,?,?,0,0)
delete from product where id = 9
insert into account values('2','Hung', '12345','ung@hb.com',0,0)
insert into product values('maytinh','https://images.fpt.shop/unsafe/filters:quality(90)/fptshop.com.vn/uploads/images/tin-tuc/131863/Originals/EVsFtjHXkAAmAhq.jpg',
'10.000.000','Tuyet','qua ok luon',1,3)





DELETE FROM product
WHERE product.id = 1;

DELETE FROM Category
WHERE Category.cid = 5;



alter table product
alter column price nvarchar(50)

alter table product
alter column title nvarchar(255)




drop table product
	
select * from Category

drop database project_PRJ

update product
set name = 'DELL INSPIRON 15' 
where product.id = 2

update account
set isSellId = 1 
where account.id = 3

update account
set [password] = ?
where account. = 2

select top 5 * from product
order by product.id desc



create table [order] (
id int identity(1,1) primary key,
firstname nvarchar(50) null,
lastname nvarchar(50) null,
[address] nvarchar(500) null,
phone varchar(50) null,
[date] date not null,
totalmoney money not null,
cid int foreign key references account([uid])
)


create table orderDetail (
id int identity(1,1) primary key ,
oid int not null ,
pid int  null,
quantity float not null,
price float not null,
 FOREIGN KEY (oid) REFERENCES [order](id) ON DELETE CASCADE, -- Xóa tất cả các bản ghi liên quan trong orderDetail khi bản ghi tương ứng trong order bị xóa
 FOREIGN KEY (pid) REFERENCES product(id) ON DELETE SET NULL -- Đặt giá trị của cột pid trong orderDetail thành NULL khi bản ghi tương ứng trong product bị xóa
)



create table code (
id int identity(1,1) primary key,
code varchar(10),
cusId int foreign key references account([uid])
)

CREATE TABLE reviews (
    review_id INT identity(1,1)  PRIMARY KEY,
    product_id INT,
    user_name nVARCHAR(255),
    email nVARCHAR(255),
    rating INT,
    review_text TEXT,
    review_date DATETIME,
    FOREIGN KEY (product_id) REFERENCES product(id),
	accid int foreign key references account([uid])
);



