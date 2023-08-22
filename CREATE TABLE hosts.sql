CREATE TABLE hosts(
    id_hosts int PRIMARY KEY
    host_name VARCHAR(30) NOT NULL
    rating int NOT NULL
);

CREATE TABLE guests(
    guest_id int PRIMARY KEY
    guest_name VARCHAR(30) NOT NULL
    gender VARCHAR NOT NULL
    country VARCHAR NOT NULL
);
CREATE TABLE room(
    room_id int PRIMARY KEY
    host_id int FOREIGN KEY
    refrigarator boolean NOT NULL
    ac boolean NOT NULL
    city VARCHAR NOT NULL
    amount_residents int NOT NULL
    avaliable boolean NOT NULL
);

CREATE TABLE payment(
    payment_id int PRIMARY KEY
    host_id int FOREIGN KEY
    guest_id int FOREIGN KEY
    amount int NOT NULL
    payment_date datetime NOY NULL
);

CREATE TABLE reservation(
    reservation_id int PRIMARY KEY
    room_id int FOREIGN KEY
    guest_id int FOREIGN KEY
    from_date datetime NOT NULL
    till_date datetime NOT NULL
);

CREATE TABLE review(
    review_id int PRIMARY KEY
    host_id int FOREIGN KEY
    guest_id int FOREIGN KEY
    rating int NOT NULL
);

INSERT INTO hosts VALUES (01, 'Joseph Liberman', 5), 
(02, 'Elizabet Moan', 7), 
(03, 'Felix Hosmann', 9);

INSERT INTO guests VALUES 
(101, 'Jerry Siennfield', 'male', 'USA'), 
(102, 'Julia Luis-Dreyfus', 'female', 'USA'), 
(103, 'Michael Richards', 'male', 'USA');

INSERT INTO room VALUES 
(1001, 01, true, true, 'New York', 2, true),
(1002, 02, false, true, 'London', 1, true),
(1003, 03, true, false, 'Los Angeles', 3, true);

INSERT INTO payment VALUES
(10001, 01, 1, 1000, '2023-07-21'),
(10002, 02, 3, 2000, '2023-09-22'),
(10004, 02, 3, 3000, '2023-09-24')
(10003, 03, 2, 1500, '2023-10-23');

INSERT INTO reservation VALUES
(123, 1001, 101, '2023-07-21', '2023-07-25'),
(456, 1002, 102, '2023-09-22', '2023-09-30'),
(789, 1003, 103, '2023-10-23', '2023-09-28');

INSERT INTO review VALUES
(321, 01, 101, 8),
(654, 02, 102, 7),
(987, 03, 103, 4);

SELECT guest.guest_id, guest.guest_name, COUNT(reservation_id) AS reservation_count
FROM guest.guests
JOIN reservation as res ON guest.guest_id = res.guest_id
GROUP BY guest.guest_id, guest.guest_name
ORDER BY reservation_count DESC
LIMIT 1;

SELECT hosts.id_hosts, hosts.host_name, SUM(payment.amount) AS total_earnings
FROM hosts
JOIN payment as pay ON hosts.id_hosts = pay.host_id
WHERE MONTH(pay.payment_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
AND YEAR(pay.payment_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY hosts.id_hosts, hosts.host_name
ORDER BY total_earnings DESC
LIMIT 1;

SELECT hosts.id_hosts, hosts.host_name, AVG(rating.rating) AS avg_rating
FROM hosts
LEFT JOIN review as rev ON hosts.id_hosts = rating.host_id
GROUP BY hosts.id_hosts, hosts.host_name
ORDER BY avg_rating DESC
LIMIT 1;