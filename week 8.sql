/*
==================================================
  Student Name   : Tshegofatso Moloto
  Course         : PLP Academy - Software Engineering
  Assignment     : Complete Database Management System (Question 1)
  Database Used  : MySQL
  Submission Date: 25-09-2025
==================================================

Notes:
- This is a full-featured E-commerce Store database.
- Tables included: Customers, Products, Orders, OrderItems.
- All necessary constraints (PK, FK, UNIQUE, NOT NULL) are applied.
- Sample data is provided to test and visualize relationships.
- Comments explain each step in a clear, human-friendly way.
==================================================
*/

-- =====================================================
-- 1. Create the E-commerce database and use it
-- =====================================================
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- =====================================================
-- 2. Create Customers table
-- Stores information about each customer
-- =====================================================
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each customer
    name VARCHAR(100) NOT NULL,                  -- Customer's full name
    email VARCHAR(100) NOT NULL UNIQUE,         -- Customer's email (must be unique)
    phone VARCHAR(20)                             -- Optional phone number
);

-- Sample customers to test the table
INSERT INTO Customers (name, email, phone) VALUES
('John Doe', 'john@example.com', '0712345678'),
('Jane Smith', 'jane@example.com', '0723456789'),
('Emily Clark', 'emily@example.com', '0734567890');

-- =====================================================
-- 3. Create Products table
-- Stores information about products available for sale
-- =====================================================
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each product
    name VARCHAR(100) NOT NULL,                  -- Name of the product
    price DECIMAL(10,2) NOT NULL,               -- Price of the product
    stock INT NOT NULL                           -- Quantity available in stock
);

-- Sample products to test the table
INSERT INTO Products (name, price, stock) VALUES
('Laptop', 1200.00, 10),
('Mouse', 25.00, 50),
('Keyboard', 45.00, 40),
('Tablet', 500.00, 20),
('Phone', 800.00, 15);

-- =====================================================
-- 4. Create Orders table
-- Stores order information placed by customers
-- =====================================================
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each order
    customer_id INT NOT NULL,                   -- Links order to a customer
    order_date DATE NOT NULL,                   -- Date when order was placed
    status VARCHAR(50) DEFAULT 'Pending',       -- Current status of order
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) -- Relationship to Customers
);

-- Sample orders for testing
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2025-09-01', 'Shipped'),
(2, '2025-09-05', 'Pending'),
(3, '2025-09-07', 'Delivered');

-- =====================================================
-- 5. Create OrderItems table
-- Stores the products included in each order (Many-to-Many relationship)
-- =====================================================
CREATE TABLE OrderItems (
    order_id INT NOT NULL,                      -- Links to Orders
    product_id INT NOT NULL,                    -- Links to Products
    quantity INT NOT NULL,                      -- Number of each product in the order
    PRIMARY KEY (order_id, product_id),         -- Composite key ensures no duplicate product in same order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample data for order items
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES
(1, 1, 1),   -- John Doe bought 1 Laptop
(1, 2, 2),   -- John Doe bought 2 Mice
(2, 4, 1),   -- Jane Smith bought 1 Tablet
(2, 3, 1),   -- Jane Smith bought 1 Keyboard
(3, 5, 1);   -- Emily Clark bought 1 Phone

-- =====================================================
-- 6. Quick checks to see if everything works
-- =====================================================
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;