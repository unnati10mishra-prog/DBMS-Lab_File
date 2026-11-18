
-- 1. Creating Employee Database

CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Department VARCHAR(30),
    City VARCHAR(30),
    Salary DECIMAL(10,2),
    Joining_Date DATE
);


-- 2. Generating 10,000 Records

DELIMITER //

CREATE PROCEDURE GenerateEmployees()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10000 DO

        INSERT INTO Employees VALUES (
            i,
            CONCAT('Employee_', i),
            ELT((i % 5) + 1, 'IT', 'HR', 'Sales', 'Finance', 'Marketing'),
            ELT((i % 4) + 1, 'Delhi', 'Mumbai', 'Lucknow', 'Pune'),
            20000 + (i % 50000),
            DATE_ADD('2020-01-01', INTERVAL (i % 2000) DAY)
        );

        SET i = i + 1;

    END WHILE;
END //

DELIMITER ;

CALL GenerateEmployees();

SELECT * FROM Employees;


-- 3. FIVE SLOW QUERIES

-- Query 1: Search by Department

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'IT';


-- Query 2: Search by City

EXPLAIN
SELECT * FROM Employees
WHERE City = 'Delhi';


-- Query 3: Salary Filtering

EXPLAIN
SELECT * FROM Employees
WHERE Salary > 50000;


-- Query 4: Multiple Conditions

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'Sales'
AND City = 'Mumbai';


-- Query 5: Sorting and Filtering

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'HR'
ORDER BY Salary DESC;


-- 4. OPTIMIZATION USING INDEXING

-- Creating Department Index

CREATE INDEX idx_department
ON Employees(Department);

-- Creating City Index

CREATE INDEX idx_city
ON Employees(City);

-- Creating Salary Index

CREATE INDEX idx_salary
ON Employees(Salary);

-- Creating Composite Index on Department and City

CREATE INDEX idx_dept_city
ON Employees(Department, City);

-- Creating Composite Index on Department and Salary

CREATE INDEX idx_dept_salary
ON Employees(Department, Salary);


-- 5. OPTIMIZED QUERIES

-- Query 1

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'IT';


-- Query 2

EXPLAIN
SELECT * FROM Employees
WHERE City = 'Delhi';


-- Query 3

EXPLAIN
SELECT * FROM Employees
WHERE Salary > 50000;


-- Query 4

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'Sales'
AND City = 'Mumbai';


-- Query 5

EXPLAIN
SELECT * FROM Employees
WHERE Department = 'HR'
ORDER BY Salary DESC;


-- 6. QUERY REWRITING EXAMPLE

-- Before Optimization

SELECT * FROM Employees
WHERE YEAR(Joining_Date) = 2022;


-- After Optimization

SELECT * FROM Employees
WHERE Joining_Date >= '2022-01-01'
AND Joining_Date < '2023-01-01';


-- 7. Index for Date Search

CREATE INDEX idx_joining_date
ON Employees(Joining_Date);


-- 8. Check Final Dataset

SELECT COUNT(*) AS Total_Records
FROM Employees;
