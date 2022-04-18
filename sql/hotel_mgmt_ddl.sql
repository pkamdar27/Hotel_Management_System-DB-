CREATE TABLE IF NOT EXISTS hotelmanagement.addresses (
  address_id INT NOT NULL,
  address_line1 VARCHAR(100) NULL,
  address_line2 VARCHAR(100) NULL,
  city VARCHAR(45) NULL,
  state VARCHAR(45) NULL,
  country VARCHAR(45) NULL,
  zipcode VARCHAR(8) NULL,
  PRIMARY KEY (address_id));

CREATE TABLE IF NOT EXISTS hotelmanagement.hotel (
  hotel_id INT NOT NULL,
  hotel_name VARCHAR(45) NULL,
  hotel_contact_number VARCHAR(12) NULL,
  hotel_email_address VARCHAR(45) NULL,
  hotel_website VARCHAR(45) NULL,
  hotel_description VARCHAR(100) NULL,
  hotel_floor_count INT NULL,
  hotel_room_capacity INT NULL,
  address_id INT NOT NULL,
  check_in_time TIME NULL,
  check_out_time TIME NULL,
  PRIMARY KEY (hotel_id),
  CONSTRAINT fk_hotel_addresses
    FOREIGN KEY (address_id)
    REFERENCES hotelmanagement.addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS hotelmanagement.room_type (
  room_type_id INT NOT NULL,
  room_type_name VARCHAR(45) NULL,
  room_cost DECIMAL(10,2) NULL,
  room_type_description VARCHAR(100) NULL,
  smoke_friendly INT NULL,
  pet_friendly INT NULL,
  PRIMARY KEY (room_type_id));

CREATE TABLE IF NOT EXISTS hotelmanagement.rooms (
  room_id INT NOT NULL,
  room_number INT NOT NULL,
  room_type_id INT NOT NULL,
  hotel_id INT NOT NULL,
  PRIMARY KEY (room_id, hotel_id),
  CONSTRAINT fk_room_type1
    FOREIGN KEY (room_type_id)
    REFERENCES hotelmanagement.room_type (room_type_id),
  CONSTRAINT fk_rooms_hotel1
    FOREIGN KEY (hotel_id)
    REFERENCES hotelmanagement.hotel(hotel_id));


CREATE TABLE IF NOT EXISTS hotelmanagement.guests (
  guest_id INT NOT NULL,
  guest_first_name VARCHAR(45) NULL,
  guest_last_name VARCHAR(45) NULL,
  guest_contact_number VARCHAR(12) NULL,
  guest_email_address VARCHAR(45) NULL,
  guest_credit_card VARCHAR(45) NULL,
  guest_id_proof VARCHAR(45) NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (guest_id, address_id),
  CONSTRAINT fk_guests_addresses1
    FOREIGN KEY (address_id)
    REFERENCES hotelmanagement.addresses (address_id));


CREATE TABLE IF NOT EXISTS hotelmanagement.employees (
  emp_id INT NOT NULL,
  emp_first_name VARCHAR(45) NULL,
  emp_last_name VARCHAR(45) NULL,
  emp_designation VARCHAR(45) NULL,
  emp_contact_number VARCHAR(12) NULL,
  emp_email_address VARCHAR(45) NULL,
  address_id INT NOT NULL,
  hotel_id INT NOT NULL,
  PRIMARY KEY (emp_id,address_id,hotel_id),
  CONSTRAINT fk_employees_addresses1
    FOREIGN KEY (address_id)
    REFERENCES hotelmanagement.addresses (address_id),
  CONSTRAINT fk_employees_hotel1
    FOREIGN KEY (hotel_id)
    REFERENCES hotelmanagement.hotel (hotel_id));

  CREATE TABLE IF NOT EXISTS hotelmanagement.bookings (
  booking_id INT NOT NULL,
  booking_date DATETIME NULL,
  duration_of_stay VARCHAR(10) NULL,
  check_in_date DATETIME NULL,
  check_out_date DATETIME NULL,
  booking_payment_type VARCHAR(45) NULL,
  total_rooms_booked INT NULL,
  hotel_id INT NOT NULL,
  guest_id INT NOT NULL,
  emp_id INT NOT NULL,
  total_amount DECIMAL(10,2) NULL,
  PRIMARY KEY (booking_id, hotel_id, guest_id, emp_id),
  CONSTRAINT fk_bookings_hotel1
    FOREIGN KEY (hotel_id)
    REFERENCES hotelmanagement.hotel (hotel_id));

CREATE TABLE IF NOT EXISTS hotelmanagement.rooms_booked (
  rooms_booked_id INT NOT NULL,
  booking_id INT NOT NULL,
  room_id INT NOT NULL,
  PRIMARY KEY (rooms_booked_id, booking_id, room_id));
 