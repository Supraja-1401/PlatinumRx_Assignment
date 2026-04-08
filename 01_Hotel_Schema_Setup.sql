-- Drop tables if already exist (to avoid errors)
DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS items;

--------------------------------------------------
-- 1. USERS TABLE
--------------------------------------------------
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100)
);

INSERT INTO users (user_id, user_name) VALUES
(1, 'John'),
(2, 'Alice'),
(3, 'Bob');

--------------------------------------------------
-- 2. BOOKINGS TABLE
--------------------------------------------------
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    room_no INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings (booking_id, user_id, room_no, booking_date) VALUES
(101, 1, 201, '2021-11-10'),
(102, 2, 202, '2021-11-15'),
(103, 3, 203, '2021-12-05'),
(104, 1, 204, '2021-12-20');

--------------------------------------------------
-- 3. ITEMS TABLE
--------------------------------------------------
CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    rate DECIMAL(10,2)
);

INSERT INTO items (item_id, item_name, rate) VALUES
(1, 'Food', 200),
(2, 'Laundry', 100),
(3, 'Room Service', 300);

--------------------------------------------------
-- 4. BOOKING COMMERCIALS TABLE
--------------------------------------------------
CREATE TABLE booking_commercials (
    bc_id INT PRIMARY KEY,
    booking_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials (bc_id, booking_id, item_id, quantity) VALUES
(1, 101, 1, 3),
(2, 101, 2, 2),
(3, 102, 1, 5),
(4, 103, 3, 2),
(5, 104, 1, 4),
(6, 104, 2, 1);

--------------------------------------------------
-- VERIFY DATA
--------------------------------------------------
SELECT * FROM users;
SELECT * FROM bookings;
SELECT * FROM items;
SELECT * FROM booking_commercials;