
-- 1. Creating Railway Booking Table

CREATE TABLE Railway_Booking (
    Booking_ID INT PRIMARY KEY,
    Passenger_Name VARCHAR(50),
    Train_No INT,
    Source VARCHAR(50),
    Destination VARCHAR(50),
    Journey_Date DATE,
    Seat_No INT,
    Fare DECIMAL(10,2)
);


-- 2. Inserting 5000 Records

DELIMITER //

CREATE PROCEDURE InsertBookings()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 5000 DO

        INSERT INTO Railway_Booking VALUES (
            i,
            CONCAT('Passenger_', i),
            12000 + (i % 20),
            'Delhi',
            'Lucknow',
            DATE_ADD('2026-01-01', INTERVAL (i % 365) DAY),
            i % 100,
            500 + (i % 1500)
        );

        SET i = i + 1;

    END WHILE;
END //

DELIMITER ;

CALL InsertBookings();


-- 3. Displaying Records

SELECT * FROM Railway_Booking;


-- 4. Query Before Indexing

EXPLAIN
SELECT * FROM Railway_Booking
WHERE Train_No = 12005;


-- 5. Single Column Index

CREATE INDEX idx_train
ON Railway_Booking(Train_No);

EXPLAIN
SELECT * FROM Railway_Booking
WHERE Train_No = 12005;


-- 6. Composite Index

CREATE INDEX idx_train_date
ON Railway_Booking(Train_No, Journey_Date);

EXPLAIN
SELECT * FROM Railway_Booking
WHERE Train_No = 12005
AND Journey_Date = '2026-03-15';


-- 7. Performance Comparison

SELECT * FROM Railway_Booking
WHERE Train_No = 12005;

SELECT * FROM Railway_Booking
WHERE Train_No = 12005
AND Journey_Date = '2026-03-15';
