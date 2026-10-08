-- Adding Manager Column

ALTER TABLE Employee
ADD manager_id INT;
ALTER TABLE Employee
ADD FOREIGN KEY (manager_id) REFERENCES Employee(emp_id);

--Setting Managers

UPDATE Employee SET manager_id = 101 WHERE emp_id IN (103,108,113,117,127);
UPDATE Employee SET manager_id = 102 WHERE emp_id IN (107,111,116,121,126);
UPDATE Employee SET manager_id = 104 WHERE emp_id IN (110,114,120,125,128);
UPDATE Employee SET manager_id = 105 WHERE emp_id IN (109,115,119,123,130);
UPDATE Employee SET manager_id = 106 WHERE emp_id IN (112,118,124,129);

-- Department Salary Summary View

CREATE VIEW Department_Salary_Summary AS
SELECT
d.dept_id,
d.dept_name,
COUNT(e.emp_id) AS employee_count,
SUM(e.salary) AS total_salary,
ROUND(AVG(e.salary), 2) AS average_salary
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;
SELECT *
FROM Department_Salary_Summary;

-- Employee Hierarchy View

CREATE VIEW Employee_Hierarchy AS
SELECT
e.emp_id,
e.emp_name,
e.manager_id,
m.emp_name AS manager_name
FROM Employee e
LEFT JOIN Employee m
ON e.manager_id = m.emp_id;
SELECT *
FROM Employee_Hierarchy;

-- Test Updatability of View

--Creating Simple View

CREATE VIEW Employee_Salary_View AS
SELECT
emp_id,
emp_name,
salary
FROM Employee;

-- Update View

UPDATE Employee_Salary_View
SET salary = 68000
WHERE emp_id = 101;

-- Check Update

SELECT *
FROM Employee_Salary_View
WHERE emp_id = 101;

-- Test Department Salary Summary View

UPDATE Department_Salary_Summary
SET average_salary = 70000
WHERE dept_id = 1;

-- Recursive CTE - Reporting Chain

WITH RECURSIVE ReportingChain AS
(
SELECT
emp_id,
emp_name,
manager_id,
0 AS level
FROM Employee
WHERE manager_id IS NULL
UNION ALL
SELECT
e.emp_id,
e.emp_name,
e.manager_id,
r.level + 1
FROM Employee e
JOIN ReportingChain r
ON e.manager_id = r.emp_id
)
SELECT
emp_id,
emp_name,
manager_id,
level
FROM ReportingChain
ORDER BY level, emp_id;