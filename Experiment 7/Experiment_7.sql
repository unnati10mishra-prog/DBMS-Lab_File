
-- 1. Creating Denormalized Table (UNF)

CREATE TABLE Sales_UNF (
    sale_id INT,
    sale_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2)
);


-- 2. Inserting Data

INSERT INTO Sales_UNF VALUES
(101, '2026-10-01', 1, 'Unnati', 201, 'Laptop', 'Electronics', 1, 50000),
(101, '2026-10-01', 2, 'Ankan', 202, 'Mouse', 'Accessories', 2, 800),
(102, '2026-10-02', 3, 'Riya', 201, 'Laptop', 'Electronics', 1, 50000),
(103, '2026-10-03', 4, 'Param', 203, 'Keyboard', 'Accessories', 1, 1500),
(104, '2026-10-04', 5, 'Illapanda', 203, 'Keyboard', 'Accessories', 2, 1500);


-- 3. Display Table

SELECT * FROM Sales_UNF;


-- 4. Converting to 1NF

CREATE TABLE Sales_1NF AS
SELECT * FROM Sales_UNF;

SELECT * FROM Sales_1NF;


-- 5. Converting to 2NF

-- Creating Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

INSERT INTO Customers
SELECT DISTINCT customer_id, customer_name
FROM Sales_UNF;


-- Creating Products Table

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

INSERT INTO Products
SELECT DISTINCT product_id, product_name, category, unit_price
FROM Sales_UNF;


-- Creating Sales Table

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE NOT NULL
);

INSERT INTO Sales
SELECT DISTINCT sale_id, sale_date
FROM Sales_UNF;


-- Creating SaleItems Table

CREATE TABLE SaleItems (
    sale_id INT,
    product_id INT,
    customer_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (sale_id, product_id),
    FOREIGN KEY (sale_id)
        REFERENCES Sales(sale_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

INSERT INTO SaleItems
SELECT sale_id, product_id, customer_id, quantity
FROM Sales_UNF;


-- 6. Converting to 3NF

-- Creating Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

INSERT INTO Customers
SELECT DISTINCT customer_id, customer_name
FROM Sales_UNF;


-- Creating Products Table

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

INSERT INTO Products
SELECT DISTINCT
    product_id, product_name, category, unit_price
FROM Sales_UNF;


-- Creating Sales Table

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE NOT NULL
);

INSERT INTO Sales
SELECT DISTINCT sale_id, sale_date
FROM Sales_UNF;


-- Creating SaleItems Table

CREATE TABLE SaleItems (
    sale_id INT,
    product_id INT,
    customer_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (sale_id, product_id),
    FOREIGN KEY (sale_id)
        REFERENCES Sales(sale_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

INSERT INTO SaleItems
SELECT
    sale_id, product_id, customer_id, quantity
FROM Sales_UNF;


-- 7. Verifying Normalized Tables

SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Sales;

SELECT * FROM SaleItems;


-- 8. Verifying Lossless Join

SELECT
    s.sale_id,
    s.sale_date,
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name,
    p.category,
    si.quantity,
    p.unit_price
FROM Sales s
JOIN SaleItems si
    ON s.sale_id = si.sale_id
JOIN Customers c
    ON si.customer_id = c.customer_id
JOIN Products p
    ON si.product_id = p.product_id
ORDER BY s.sale_id, p.product_id;


-- 9. Verifying Dependency Preservation

-- Checking customer dependency

SELECT customer_id, COUNT(DISTINCT customer_name)
FROM Customers
GROUP BY customer_id
HAVING COUNT(DISTINCT customer_name) > 1;


-- Checking product dependency

SELECT product_id
FROM Products
GROUP BY product_id
HAVING COUNT(DISTINCT product_name) > 1
    OR COUNT(DISTINCT category) > 1
    OR COUNT(DISTINCT unit_price) > 1;


-- Checking sale date dependency

SELECT sale_id
FROM Sales
GROUP BY sale_id
HAVING COUNT(DISTINCT sale_date) > 1;


-- 10. Final Table

SELECT
    s.sale_id,
    s.sale_date,
    c.customer_name,
    p.product_name,
    si.quantity,
    p.unit_price,
    si.quantity * p.unit_price AS total_amount
FROM Sales s
JOIN SaleItems si
    ON s.sale_id = si.sale_id
JOIN Customers c
    ON si.customer_id = c.customer_id
JOIN Products p
    ON si.product_id = p.product_id
ORDER BY s.sale_id, p.product_id;
