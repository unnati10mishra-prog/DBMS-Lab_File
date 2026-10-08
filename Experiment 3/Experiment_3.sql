-- Create Database

CREATE DATABASE EmployeeDB;

USE EmployeeDB;

-- Create Department Table

CREATE TABLE Department (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50) NOT NULL,
location VARCHAR(50)
);

-- Insert 5 Departments

INSERT INTO Department VALUES
(1, 'Computer Science Engineering', 'Block E'),
(2, 'Sciences', 'Block E'),
(3, 'Law', 'Block F'),
(4, 'Finance', 'Block F'),
(5, 'Marketing', 'Block E');

-- Create Project Table

CREATE TABLE Project (
project_id INT PRIMARY KEY,
project_name VARCHAR(100) NOT NULL,
budget DECIMAL(12,2),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Insert 8 Projects

INSERT INTO Project VALUES
(101, 'Campus Management System', 500000, 1),
(102, 'AI Chatbot', 750000, 2),
(103, 'Cyber Security Platform', 900000, 1),
(104, 'Employee Analytics', 400000, 3),
(105, 'Financial Forecasting', 650000, 4),
(106, 'Digital Marketing', 350000, 5),
(107, 'Computer Vision System', 850000, 2),
(108, 'Payroll Automation', 300000, 3);
Create Employee Table
CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100) NOT NULL,
gender VARCHAR(10),
salary DECIMAL(10,2),
hire_date DATE,
dept_id INT,
project_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- Insert 30 Employees

INSERT INTO Employee VALUES
(1, 'Aarav Sharma', 'Male', 65000, '2022-01-15', 1, 101),
(2, 'Ananya Singh', 'Female', 72000, '2021-03-20', 2, 102),
(3, 'Rohan Verma', 'Male', 58000, '2023-06-10', 1, 103),
(4, 'Priya Mehta', 'Female', 81000, '2020-08-12', 3, 104),
(5, 'Aditya Kumar', 'Male', 55000, '2024-01-05', 4, 105),
(6, 'Sneha Gupta', 'Female', 68000, '2022-11-18', 5, 106),
(7, 'Rahul Joshi', 'Male', 92000, '2019-04-25', 2, 107),
(8, 'Isha Patel', 'Female', 61000, '2023-02-14', 1, 101),
(9, 'Karan Malhotra', 'Male', 75000, '2021-07-19', 4, 105),
(10, 'Neha Kapoor', 'Female', 69000, '2022-09-01', 3, 108),
(11, 'Vikram Rao', 'Male', 88000, '2020-02-11', 2, 102),
(12, 'Meera Nair', 'Female', 57000, '2024-03-15', 5, 106),
(13, 'Arjun Das', 'Male', 63000, '2022-05-21', 1, 103),
(14, 'Kavya Shah', 'Female', 79000, '2021-10-10', 3, 104),
(15, 'Manish Yadav', 'Male', 54000, '2024-04-17', 4, 105),
(16, 'Simran Kaur', 'Female', 73000, '2020-12-05', 2, 107),
(17, 'Nikhil Jain', 'Male', 66000, '2023-01-09', 1, 101),
(18, 'Riya Sen', 'Female', 59000, '2023-08-22', 5, 106),
(19, 'Varun Sethi', 'Male', 85000, '2020-06-30', 4, 105),
(20, 'Pooja Mishra', 'Female', 71000, '2022-02-28', 3, 108),
(21, 'Yash Agarwal', 'Male', 95000, '2019-11-11', 2, 107),
(22, 'Tanya Roy', 'Female', 62000, '2023-09-05', 1, 103),
(23, 'Mohit Bansal', 'Male', 77000, '2021-01-17', 4, 105),
(24, 'Aditi Chawla', 'Female', 68000, '2022-07-07', 5, 106),
(25, 'Sahil Khan', 'Male', 56000, '2024-02-20', 3, 104),
(26, 'Nandini Iyer', 'Female', 83000, '2020-03-13', 2, 102),
(27, 'Dev Thakur', 'Male', 64000, '2023-05-16', 1, 101),
(28, 'Shreya Bose', 'Female', 74000, '2021-12-01', 3, 108),
(29, 'Akash Gupta', 'Male', 60000, '2023-10-12', 5, 106),
(30, 'Muskan Arora', 'Female', 89000, '2020-09-23', 4, 105);

--Selection

SELECT *
FROM Employee
WHERE salary > 70000;

-- Projection

SELECT emp_id, emp_name, salary
FROM Employee;
Aggregate Functions

-- Total salary

SELECT SUM(salary) AS total_salary
FROM Employee;

-- Average salary

SELECT AVG(salary) AS average_salary
FROM Employee;

-- Maximum salary

SELECT MAX(salary) AS highest_salary
FROM Employee;

-- Minimum salary

SELECT MIN(salary) AS lowest_salary
FROM Employee;

-- Number of employees

SELECT COUNT(*) AS total_employees
FROM Employee;

-- GROUP BY

SELECT dept_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY dept_id;

-- GROUP BY with HAVING

SELECT dept_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 5;

-- CASE Expression

SELECT
emp_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High Salary'
WHEN salary >= 60000 THEN 'Medium Salary'
ELSE 'Low Salary'
END AS salary_category
FROM Employee;

-- ORDER BY

SELECT emp_name, salary
FROM Employee
ORDER BY salary DESC;