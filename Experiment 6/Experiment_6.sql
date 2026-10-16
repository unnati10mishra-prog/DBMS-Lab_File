-- Stored Procedure, Triggers and Audit Logging

-- 1. Create Audit Table

CREATE TABLE Employee_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_dept_id INT,
    new_dept_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 2. Salary Validation Trigger (Before Insert)

DELIMITER //

CREATE TRIGGER validate_salary
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    IF NEW.salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than 0';
    END IF;
END//


-- 3. Salary Validation Trigger (Before Update)

CREATE TRIGGER validate_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than 0';
    END IF;
END//


-- 4. Audit Logging Trigger

CREATE TRIGGER employee_audit
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.dept_id <> NEW.dept_id
       OR OLD.salary <> NEW.salary THEN

        INSERT INTO Employee_Audit
        (
            emp_id,
            old_dept_id,
            new_dept_id,
            old_salary,
            new_salary
        )
        VALUES
        (
            OLD.emp_id,
            OLD.dept_id,
            NEW.dept_id,
            OLD.salary,
            NEW.salary
        );

    END IF;
END//


-- 5. Stored Procedure: Transfer Employee

CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE employee_exists INT DEFAULT 0;
    DECLARE department_exists INT DEFAULT 0;

    SELECT COUNT(*)
    INTO employee_exists
    FROM Employee
    WHERE emp_id = p_emp_id;

    SELECT COUNT(*)
    INTO department_exists
    FROM Department
    WHERE dept_id = p_new_dept_id;

    IF employee_exists = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee does not exist';

    ELSEIF department_exists = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist';

    ELSE

        UPDATE Employee
        SET dept_id = p_new_dept_id
        WHERE emp_id = p_emp_id;

    END IF;
END//

DELIMITER ;


-- 6. Test Stored Procedure

CALL transfer_employee(1, 5);


-- 7. Check Employee After Transfer

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 1;


-- 8. Check Audit Log

SELECT *
FROM Employee_Audit;


-- 9. Test Salary Validation with Valid Salary

UPDATE Employee
SET salary = 5000
WHERE emp_id = 1;


-- 10. Check Employee Salary

SELECT *
FROM Employee
WHERE emp_id = 1;


-- 11. Test Invalid Employee

CALL transfer_employee(999, 2);


-- 12. Test Invalid Department
-- Use an existing employee ID and a nonexistent department ID.

CALL transfer_employee(1, 99);
