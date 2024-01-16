create database booking_agency;
use booking_agency;

create table Hotel 
(Hotel_no varchar(10) primary key,Hotel_name char(20),city char(20));
desc Hotel;
create table Guest
(Guest_no varchar(10) primary key,Guest_name char(20),city char(20));
desc Guest;
create table Room 
(Room_no int(10) primary key,Hotel_No varchar(10),Room_Type char(10),room_price float(10),foreign key(Hotel_No) references Hotel(Hotel_No));
desc room;
create table Booking
(Hotel_No varchar(10),guest_No varchar(10),date_from date,date_to date,foreign key(Hotel_No) references Hotel(Hotel_No),foreign key(Room_No) references Room(Room_No));
desc booking;

insert into hotel values (001,'JSW','mumbai'),(002,'Novetal','Pune'),(003,'Taj','mumbai'),(004,'leela','Lonaval');
insert into guest values (1,'Unnat','Mumbai'),(2,'Kunal','Mumbai'),(3,'Mohit','Pune');
insert into room values(501,001,'Standard',5000),(302,003,'General',7000),(404,004,'VIP',4000),(502,002,'Semi-VIP',2000);
insert into booking values(001,1,'2023-08-03','2023-08-07',501),(002,2,'2023-08-05','2023-08-10',502),(003,3,'2023-07-15','2023-07-23',302);


-- 1. List full details of all hotels.
select * from hotel;

-- 2. List full details of all hotels in Mumbai.
select * from hotel where city='mumbai';

-- 3. List the names and cities of all guests, ordered according to their cities.
select guest_name,city from guest order by city;

-- 4. List all details for Standard rooms in ascending order of price.
select * from room where Room_Type='standard' order by room_price;

-- 5. List the number of hotels there are.
select count(*) from hotel;

-- 6. List the cities in which guests live. Each city should be listed only once.
select distinct(city) from guest;

-- 7. List the average price of a room.
select avg(room_price) from room;

-- 8. List hotel names, their room numbers, and the type of that room.
select hotel.hotel_name,room.room_no,room_type from hotel,room where hotel.hotel_no=room.hotel_no;

-- 9. List the hotel names, booking dates, and room numbers for all hotels in Banglore.
select hotel.hotel_name,city,booking.date_from,booking.date_to,room_no from hotel,booking where hotel.hotel_no=booking.hotel_no and city='banglore';

-- 10. What is the number of bookings that started in the month of September?
select count(*),date_from from booking where date_from between '2023-07-01' and '2023-07-31';

-- 11. List the names and cities of guests who began a stay in Mumbai in August.
select guest.guest_name,city from guest,booking where guest.guest_no = booking.guest_no in(
booking.date_from between '2023-07-01' and '2023-07-31',guest.city='mumbai');

-- 12. List the hotel names and room numbers of any hotel rooms that have not been booked.
select hotel.hotel_name,room.room_no from hotel,room where hotel.hotel_no=room.hotel_no not in(select booking.hotel_no from booking);

-- 13. List the hotel name and city of the hotel with the highest priced room.
select hotel.hotel_name,hotel.city,max(room_price)from hotel,room where hotel.hotel_no=room.hotel_no;

-- 14. List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Mumbai hotel.
select distinct(hotel.hotel_name),hotel.city,room.room_no,room.room_price from hotel, room 
where hotel.hotel_no=room.hotel_no and hotel.city='mumbai' and room.room_price<
(select max(room.room_price) from room,hotel where hotel.hotel_no=room.hotel_no and hotel.city='mumbai');

-- 15. List the average price of a room grouped by city.
select distinct(avg(room.room_price)),hotel.city from room,hotel where hotel.hotel_no=room.hotel_no group by hotel.city;


