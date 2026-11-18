
-- 1. Creating Banking Table

CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY,
    Holder_Name VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- Inserting Records

INSERT INTO Accounts VALUES
(101, 'Amit', 10000),
(102, 'Rahul', 8000);

-- Displaying Account Details

SELECT * FROM Accounts;


-- 2. BEGIN AND COMMIT

START TRANSACTION;

-- Transferring Rs. 2000 from Amit to Rahul

UPDATE Accounts
SET Balance = Balance - 2000
WHERE Account_ID = 101;

UPDATE Accounts
SET Balance = Balance + 2000
WHERE Account_ID = 102;

COMMIT;


-- 3. ROLLBACK

START TRANSACTION;

-- Deducting Rs. 5000 from Amit's account

UPDATE Accounts
SET Balance = Balance - 5000
WHERE Account_ID = 101;

-- Undoing the transaction

ROLLBACK;


-- 4. SAVEPOINT

START TRANSACTION;

-- Deducting Rs. 1000 from Amit's account

UPDATE Accounts
SET Balance = Balance - 1000
WHERE Account_ID = 101;

-- Creating a savepoint

SAVEPOINT sp1;

-- Deducting Rs. 20000 from Rahul's account

UPDATE Accounts
SET Balance = Balance - 20000
WHERE Account_ID = 102;

-- Rolling back to savepoint

ROLLBACK TO SAVEPOINT sp1;

COMMIT;


-- 5. Partial Failure Simulation

START TRANSACTION;

-- Deducting Rs. 500 from Amit's account

UPDATE Accounts
SET Balance = Balance - 500
WHERE Account_ID = 101;

-- Simulated failure using invalid account ID

UPDATE Accounts
SET Balance = Balance + 500
WHERE Account_ID = 999;

-- Rolling back the transaction

ROLLBACK;


-- 6. Isolation Levels

-- Setting READ COMMITTED isolation level

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT * FROM Accounts;

COMMIT;


-- Setting REPEATABLE READ isolation level

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

SELECT * FROM Accounts;

COMMIT;


-- Setting SERIALIZABLE isolation level

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;

SELECT * FROM Accounts;

COMMIT;


-- 7. Concurrency Anomaly Demonstration

-- SESSION 1

START TRANSACTION;

-- Reading Amit's account balance

SELECT Balance
FROM Accounts
WHERE Account_ID = 101;


-- SESSION 2

START TRANSACTION;

-- Updating Amit's account balance

UPDATE Accounts
SET Balance = Balance - 500
WHERE Account_ID = 101;

COMMIT;


-- SESSION 1

-- Reading the balance again

SELECT Balance
FROM Accounts
WHERE Account_ID = 101;

COMMIT;
