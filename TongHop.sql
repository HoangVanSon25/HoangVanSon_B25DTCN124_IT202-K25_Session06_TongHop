create database hotel_management;
use hotel_management;
create table Users(
	user_id int primary key,
    user_name varchar(50)
);
create table Hotels (
	hotel_id int primary key,
    rating tinyint
);
create table Bookings(
	booking_id int primary key,
    status varchar(10),
    total_price double,
    user_id int,
    hotel_id int,
    foreign key (user_id) references Users(user_id),
    foreign key (hotel_id) references Hotels(hotel_id)
);


-- USERS
INSERT INTO Users (user_id, user_name) VALUES
(1, 'An'),
(2, 'Binh'),
(3, 'Chi'),
(4, 'Dung'),
(5, 'Huy');

-- HOTELS
INSERT INTO Hotels (hotel_id, rating) VALUES
(101, 3),
(102, 4),
(103, 5),
(104, 4),
(105, 3);

-- BOOKINGS
INSERT INTO Bookings (booking_id, status, total_price, user_id, hotel_id) VALUES
(1001, 'COMPLETED', 2500000, 1, 101),
(1002, 'CANCELLED', 3000000, 1, 102),
(1003, 'COMPLETED', 4500000, 2, 103),
(1004, 'PENDING',   1500000, 3, 101),
(1005, 'COMPLETED', 5000000, 3, 104),
(1006, 'COMPLETED', 2000000, 4, 105),
(1007, 'CANCELLED', 3500000, 5, 103),
(1008, 'COMPLETED', 4000000, 2, 102),
(1009, 'PENDING',   1800000, 4, 104),
(1010, 'COMPLETED', 6000000, 5, 103);

INSERT INTO Bookings (booking_id, status, total_price, user_id, hotel_id) VALUES
(1011, 'COMPLETED', 30000000, 5, 103),
(1012, 'COMPLETED', 6000000, 5, 102),
(1013, 'COMPLETED', 20000000, 5, 103);

select h.hotel_id as 'Mã khách sạn', u.user_name as 'Tên Khách hàng', h.rating as 'Hạng khách sạn', sum(b.total_price) as 'Tong_tien'
from Bookings as b
join Users as u on u.user_id = b.user_id
join Hotels as h on h.hotel_id = b.hotel_id
where b.status = 'COMPLETED' 
group by u.user_id, h.rating, h.hotel_id
having Tong_tien > 50000000 -- lọc hạng khách sạn có 
order by h.rating desc , Tong_tien desc


-- Bản vẽ Data Flow & Grouping
-- GROUP BY tôi sẽ nhóm id của khách hàng và hạng của khách sạn và cả id của khách sạn đấy 
-- khi nhóm như này thì id của khách hàng có thể trùng nhưng id của khách sạn thì không và hạng cx không nên vậy khi kêt hợp 3 
-- cái này lại nó sẽ độc lập nhau vì thế 1 khách hàng sẽ có thể hiện ở 2 dòng và nó sẽ phân ra hạng của khách sạn sẽ khác nhau

-- Quy trình chống bẫy:
-- Xử lý số âm 
-- nên dùng where nên lọc dữ liệu trước khi tính toan sẽ giúp nó giảm khối lượng bản ghi ộng dồn 
-- tránh sai số Tại vì khi sum tính thì nó sẽ khong cần trừ những số âm này (loại bỏ total_price < 0
