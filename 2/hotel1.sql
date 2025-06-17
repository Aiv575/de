CREATE TABLE guests (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    phone varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    passport varchar(100) NOT NULL
)

CREATE TABLE rooms (
    id int(11) PRIMARY KEY AUTO_INCREMENT,
    floor int(11) NOT NULL,
    number int(11) NOT NULL,
    category varchar(100) NOT NULL,
    status ENUM('Чистый', 'Грязный','Назначен к уборке','Занят') DEFAULT 'Чистый',
    price_per_night decimal(10,2)
)

CREATE TABLE staff (
    id int(11) PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    phone varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    passport varchar(100) NOT NULL,
    position varchar(100) NOT NULL
)

CREATE TABLE cleaningschedule (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    staff_id int(11) NOT NULL,
    room_id int(11) NOT NULL,
    date date NOT NULL,
    status ENUM('Назначен', 'Выполнен') DEFAULT NULL,
    FOREIGN KEY staff_id REFERENCES staff(id),
    FOREIGN KEY room_id REFERENCES rooms(id),
)

CREATE TABLE bookings (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    price decimal(10,2) NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    room_id int(11) NOT NULL,
    guest_id int(11) NOT NULL,
    FOREIGN KEY guest_id REFERENCES guests(id),
    FOREIGN KEY room_id REFERENCES rooms(id),
)

CREATE TABLE payments (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount decimal(10,2) NOT NULL,
    payment_method varchar(50) NOT NULL,
    date date NOT NULL,
    booking_id int(11) NOT NULL,
    FOREIGN KEY booking_id REFERENCES bookings(id)
)

CREATE TABLE roomservices (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    price decimal(10,2) NOT NULL
)

CREATE TABLE bookingservices (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    roomservices_id int(11) NOT NULL,
    booking_id int(11),
    FOREIGN KEY roomservices_id REFERENCES roomservices(id),
    FOREIGN KEY booking_id REFERENCES bookings(id),
)

CREATE TABLE hotelstatistics (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date date NOT NULL,
    occupancy_rate decimal(5,2) NOT NULL,
    adr decimal(10,2) NOT NULL,
    revrap decimal(10,2) NOT NULL,
)

SELECT
    (SUM(DATEDIFF(b.check_out_date, b.check_in_date))
    /
    (SELECT COUNT(*) FROM rooms)
    )
    *
    100 AS occupancy_rate
FROM bookings b