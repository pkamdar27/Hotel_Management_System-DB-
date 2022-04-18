-- List all the unique countries hotels are located in.
SELECT DISTINCT a.country
FROM hotelmanagement.addresses a
JOIN hotelmanagement.hotel b
ON a.address_id = b.address_id

-- Total rooms in all the hotel ?
SELECT b.hotel_name, count(a.room_id)
FROM hotelmanagement.rooms a
RIGHT JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
GROUP BY b.hotel_name

-- How many rooms are booked in a particular hotel for given year.?
-- year 2018 and for hotel - King George Inn & Suites with id 1
SELECT SUM(total_rooms_booked) AS rooms_booked
FROM hotelmanagement.bookings
WHERE extract(year from booking_date) = 2018 -- 
AND hotel_id = 1

-- List all the hotels that have a URL available.
SELECT * 
FROM hotelmanagement.hotel
WHERE hotel_website IS NOT NULL


-- How many distinct guest have made bookings for a particular month? Consider August month
SELECT DISTINCT a.guest_id, a.guest_first_name, a.guest_last_name, a.guest_contact_number
FROM hotelmanagement.guests a
JOIN hotelmanagement.bookings b
ON a.guest_id = b.guest_id
WHERE EXTRACT(month FROM b.check_in_date) = 8

-- How many books has a customer 2 made in 2018?
SELECT count(*) AS total_bookings
FROM hotelmanagement.bookings
WHERE EXTRACT(YEAR FROM booking_date) = 2018
AND guest_id = 2

-- Display the hotel name with count of employees
SELECT b.hotel_name, COUNT(a.emp_id)
FROM hotelmanagement.employees a
RIGHT JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
GROUP BY b.hotel_name

-- Number of room_type
SELECT room_type_id, count(room_id)
FROM hotelmanagement.rooms
GROUP BY room_type_id

-- How many number of room types are there for the hotels? Display hotel_name with type of room and count
SELECT b.hotel_name, a.room_type_id, count(a.room_id)
FROM hotelmanagement.rooms a
JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
GROUP BY b.hotel_name, a.room_type_id

-- How many rooms are available in a given hotel?
SELECT b.hotel_room_capacity - sum(a.total_rooms_booked) as available_rooms
FROM hotelmanagement.bookings a
JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
WHERE a.hotel_id = 1
GROUP BY hotel_room_capacity

-- How many available rooms are in a particular hotel for a given date?
SELECT b.hotel_room_capacity - sum(a.total_rooms_booked) as available_rooms
FROM hotelmanagement.bookings a
JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
WHERE a.hotel_id = 1
GROUP BY hotel_room_capacity


-- View for knowing the room available in a hotel
create view hotelmanagement.room_available as 
SELECT b.hotel_room_capacity - sum(a.total_rooms_booked) as available_rooms, b.hotel_id
FROM hotelmanagement.bookings a
JOIN hotelmanagement.hotel b
ON a.hotel_id = b.hotel_id
GROUP BY b.hotel_id, b.hotel_room_capacity
with no schema binding;


-- List the rate for a room at a given time during the year.?
-- Top 3 customers who has booked more