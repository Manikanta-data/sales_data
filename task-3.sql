-- Create database
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Customers (first_name, last_name, email, password, phone, address, city, state, zip_code, country)
VALUES 
('John', 'Doe', 'john.doe@example.com', 'hashed_password1', '1234567890', '123 Main St', 'New York', 'NY', '10001', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', 'hashed_password2', '2345678901', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA'),
('Robert', 'Johnson', 'robert.j@example.com', 'hashed_password3', '3456789012', '789 Pine Rd', 'Chicago', 'IL', '60601', 'USA'),
('Emily', 'Williams', 'emily.w@example.com', 'hashed_password4', '4567890123', '321 Elm St', 'Houston', 'TX', '77001', 'USA'),
('Michael', 'Brown', 'michael.b@example.com', 'hashed_password5', '5678901234', '654 Maple Ave', 'Phoenix', 'AZ', '85001', 'USA');

-- Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
);

INSERT INTO Categories (name, description, parent_id)
VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel and fashion items', NULL),
('Home & Garden', 'Home improvement and garden supplies', NULL),
('Smartphones', 'Mobile phones with advanced features', 1),
('Laptops', 'Portable computers', 1),
('Men''s Clothing', 'Clothing for men', 2),
('Women''s Clothing', 'Clothing for women', 2);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url)
VALUES
('iPhone 13 Pro', 'Latest Apple smartphone with A15 Bionic chip', 999.99, 50, 4, 'https://example.com/iphone13.jpg'),
('Samsung Galaxy S21', 'Android smartphone with 120Hz display', 799.99, 75, 4, 'https://example.com/galaxys21.jpg'),
('MacBook Pro 14"', 'Apple laptop with M1 Pro chip', 1999.99, 30, 5, 'https://example.com/macbookpro.jpg'),
('Dell XPS 15', 'Windows laptop with 4K display', 1499.99, 40, 5, 'https://example.com/dellxps.jpg'),
('Men''s Casual Shirt', 'Comfortable cotton shirt for men', 29.99, 100, 6, 'https://example.com/mensshirt.jpg'),
('Women''s Summer Dress', 'Lightweight dress for summer', 39.99, 85, 7, 'https://example.com/womensdress.jpg'),
('Wireless Earbuds', 'Bluetooth earbuds with noise cancellation', 129.99, 60, 1, 'https://example.com/earbuds.jpg'),
('Smart Watch', 'Fitness tracking and notifications', 199.99, 45, 1, 'https://example.com/smartwatch.jpg');

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    shipping_address VARCHAR(255) NOT NULL,
    billing_address VARCHAR(255) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (customer_id, total_amount, status, shipping_address, billing_address, payment_method)
VALUES
(1, 999.99, 'Completed', '123 Main St, New York, NY 10001', '123 Main St, New York, NY 10001', 'Credit Card'),
(2, 79.98, 'Shipped', '456 Oak Ave, Los Angeles, CA 90001', '456 Oak Ave, Los Angeles, CA 90001', 'PayPal'),
(3, 1499.99, 'Processing', '789 Pine Rd, Chicago, IL 60601', '789 Pine Rd, Chicago, IL 60601', 'Credit Card'),
(1, 129.99, 'Pending', '123 Main St, New York, NY 10001', '123 Main St, New York, NY 10001', 'Debit Card'),
(4, 199.99, 'Completed', '321 Elm St, Houston, TX 77001', '321 Elm St, Houston, TX 77001', 'PayPal');

-- Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 999.99),
(2, 5, 1, 29.99),
(2, 6, 1, 39.99),
(3, 4, 1, 1499.99),
(4, 7, 1, 129.99),
(5, 8, 1, 199.99);

-- Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(100),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments (order_id, amount, payment_method, transaction_id, status)
VALUES
(1, 999.99, 'Credit Card', 'TXN123456789', 'Completed'),
(2, 79.98, 'PayPal', 'PAY987654321', 'Completed'),
(3, 1499.99, 'Credit Card', 'TXN456789123', 'Processing'),
(5, 199.99, 'PayPal', 'PAY321654987', 'Completed');

-- Shipping table
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    tracking_number VARCHAR(100),
    carrier VARCHAR(50),
    shipping_date TIMESTAMP,
    estimated_delivery TIMESTAMP,
    delivery_date TIMESTAMP NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Adding more shipping records to match all orders
INSERT INTO Shipping (order_id, tracking_number, carrier, shipping_date, estimated_delivery, delivery_date, status)
VALUES
(3, 'FEDEX789123456', 'FedEx', '2023-01-14 13:45:00', '2023-01-19 18:00:00', NULL, 'In Transit'),
(4, 'UPS321654987', 'UPS', '2023-01-16 11:20:00', '2023-01-21 18:00:00', NULL, 'Processing');

-- Adding some historical shipping records for analysis purposes
INSERT INTO Shipping (order_id, tracking_number, carrier, shipping_date, estimated_delivery, delivery_date, status)
VALUES
-- Historical completed shipments
(1, 'UPS123456780', 'UPS', '2022-12-05 09:30:00', '2022-12-10 18:00:00', '2022-12-09 14:15:00', 'Delivered'),
(1, 'UPS123456781', 'UPS', '2022-11-15 14:00:00', '2022-11-20 18:00:00', '2022-11-18 10:45:00', 'Delivered'),

-- Historical failed/delayed shipments
(2, 'FEDEX987654320', 'FedEx', '2022-12-12 16:20:00', '2022-12-17 18:00:00', '2022-12-20 11:30:00', 'Delivered'),
(2, 'FEDEX987654322', 'FedEx', '2022-11-22 10:45:00', '2022-11-27 18:00:00', NULL, 'Lost'),

-- International shipments
(3, 'DHL456789120', 'DHL', '2022-10-10 08:15:00', '2022-10-20 18:00:00', '2022-10-18 16:20:00', 'Delivered'),
(4, 'USPS321654980', 'USPS', '2022-09-05 13:30:00', '2022-09-15 18:00:00', '2022-09-14 09:10:00', 'Delivered'),

-- Express shipments
(5, 'FEDEX_EXP123456', 'FedEx Express', '2022-08-15 17:00:00', '2022-08-17 12:00:00', '2022-08-17 11:30:00', 'Delivered'),
(5, 'UPS_NEXTDAY789', 'UPS Next Day Air', '2022-07-20 15:45:00', '2022-07-21 10:30:00', '2022-07-21 09:15:00', 'Delivered');

-- Adding some returns information
INSERT INTO Shipping (order_id, tracking_number, carrier, shipping_date, estimated_delivery, delivery_date, status)
VALUES
(1, 'UPS_RETURN123', 'UPS', '2023-01-16 10:00:00', '2023-01-20 18:00:00', NULL, 'Return in Transit'),
(2, 'FEDEX_RETURN456', 'FedEx', '2023-01-17 14:30:00', '2023-01-22 18:00:00', '2023-01-21 15:00:00', 'Return Received'),
(4, 'USPS_RETURN789', 'USPS', '2023-01-18 11:15:00', '2023-01-25 18:00:00', NULL, 'Return Processing');

show tables;
-- 1. SELECT all products priced over $500, ordered by price descending
SELECT product_id, name, price
FROM Products
WHERE price > 500
ORDER BY price DESC;

-- 2. SELECT customers from California, ordered by last name
SELECT customer_id, first_name, last_name, city, state
FROM Customers
WHERE state = 'CA'
ORDER BY last_name;

-- 3. GROUP BY category to find average product price
SELECT c.name AS category_name, AVG(p.price) AS avg_price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_price DESC;

-- 4. COUNT orders by status
SELECT status, COUNT(*) AS order_count
FROM Orders
GROUP BY status
ORDER BY order_count DESC;

-- 5. Find products with low stock (less than 50)
SELECT product_id, name, stock_quantity
FROM Products
WHERE stock_quantity < 50
ORDER BY stock_quantity ASC;

-- 1. INNER JOIN: Orders with customer details
SELECT o.order_id, o.order_date, o.total_amount, 
       c.first_name, c.last_name, c.email
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

-- 2. LEFT JOIN: All products with their category (even if no category)
SELECT p.product_id, p.name, p.price, c.name AS category_name
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id;

-- 3. RIGHT JOIN: All categories with product count (even if no products)
SELECT c.name AS category_name, COUNT(p.product_id) AS product_count
FROM Products p
RIGHT JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY product_count DESC;

-- 4. Multiple JOINs: Order details with products and customer info
SELECT o.order_id, o.order_date, 
       c.first_name, c.last_name,
       p.name AS product_name, oi.quantity, oi.unit_price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_id = 2;

-- 5. JOIN with WHERE: Find all shipped orders to New York
SELECT o.order_id, o.order_date, s.tracking_number, s.carrier
FROM Orders o
JOIN Shipping s ON o.order_id = s.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.city = 'New York' AND s.status = 'Delivered';

-- 1. Find customers who spent more than average
SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount) FROM Orders
);

-- 2. Products that have never been ordered
SELECT p.product_id, p.name
FROM Products p
WHERE p.product_id NOT IN (
    SELECT DISTINCT product_id FROM Order_Items
);

-- 3. Orders with above average item count
SELECT o.order_id, COUNT(oi.order_item_id) AS item_count
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING COUNT(oi.order_item_id) > (
    SELECT AVG(item_count) FROM (
        SELECT COUNT(*) AS item_count 
        FROM Order_Items 
        GROUP BY order_id
    ) AS avg_counts
);

-- 4. Customers who purchased the most expensive product
SELECT c.customer_id, c.first_name, c.last_name
FROM Customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = (
        SELECT product_id FROM Products ORDER BY price DESC LIMIT 1
    )
);

-- 5. Products with above average ratings
SELECT p.product_id, p.name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
HAVING AVG(r.rating) > (
    SELECT AVG(rating) FROM Reviews
);


-- 1. Total revenue by month
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_revenue
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 2. Average order value by customer
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name,
    COUNT(o.order_id) AS order_count,
    AVG(o.total_amount) AS avg_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_order_value DESC;

-- 3. Total quantity sold by product
SELECT 
    p.product_id, 
    p.name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;

-- 4. Average delivery time in days
SELECT 
    AVG(DATEDIFF(delivery_date, shipping_date)) AS avg_delivery_days
FROM Shipping
WHERE status = 'Delivered';

-- 5. Category performance (revenue and units sold)
SELECT 
    c.name AS category_name,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;


-- 1. Customer order summary view
CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

-- 2. Product performance view
CREATE VIEW ProductPerformance AS
SELECT 
    p.product_id,
    p.name,
    p.price,
    c.name AS category,
    COALESCE(SUM(oi.quantity), 0) AS units_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS revenue,
    COALESCE(AVG(r.rating), 0) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
LEFT JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name, p.price, c.name;

-- 3. Monthly sales report view
CREATE VIEW MonthlySalesReport AS
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS order_count,
    COUNT(DISTINCT o.customer_id) AS customer_count,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS avg_order_value
FROM Orders o
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

-- 4. Shipping performance view
CREATE VIEW ShippingPerformance AS
SELECT 
    carrier,
    COUNT(*) AS total_shipments,
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_count,
    SUM(CASE WHEN DATEDIFF(delivery_date, shipping_date) <= 
               DATEDIFF(estimated_delivery, shipping_date) THEN 1 ELSE 0 END) AS on_time_count,
    AVG(DATEDIFF(delivery_date, shipping_date)) AS avg_delivery_days
FROM Shipping
WHERE status = 'Delivered'
GROUP BY carrier;

-- 5. Customer lifetime value view
CREATE VIEW CustomerLifetimeValue AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent,
    SUM(o.total_amount) / NULLIF(COUNT(o.order_id), 0) AS avg_order_value,
    DATEDIFF(CURRENT_DATE, MIN(o.order_date)) AS days_as_customer,
    SUM(o.total_amount) / NULLIF(DATEDIFF(CURRENT_DATE, MIN(o.order_date)), 0) * 30 AS monthly_value
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

-- 1. Create indexes for frequently queried columns

-- 2. Optimized query using indexes (find high-value customers)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 1000
ORDER BY total_spent DESC;


-- 3. Optimized order history query
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    COUNT(oi.order_item_id) AS item_count,
    s.status AS shipping_status
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Shipping s ON o.order_id = s.order_id
WHERE o.customer_id = 1
GROUP BY o.order_id, o.order_date, o.total_amount, s.status
ORDER BY o.order_date DESC;

