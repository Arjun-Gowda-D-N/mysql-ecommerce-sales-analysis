---- “Customer Purchase & Sales Analysis using MySQL”
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    signup_date DATE
);
INSERT INTO customers VALUES
(1, 'John', 'USA', '2023-01-10'),
(2, 'Anna', 'Germany', '2023-02-05'),
(3, 'Rahul', 'India', '2023-02-20'),
(4, 'Sophia', 'USA', '2023-03-15'),
(5, 'Liam', 'Germany', '2023-04-01');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 800),
(102, 'Phone', 'Electronics', 500),
(103, 'Headphones', 'Accessories', 100),
(104, 'Keyboard', 'Accessories', 50);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders VALUES
(1, 1, 101, 1, '2023-05-01'),
(2, 2, 102, 2, '2023-05-03'),
(3, 3, 103, 3, '2023-05-05'),
(4, 1, 104, 2, '2023-05-06'),
(5, 4, 101, 1, '2023-05-08'),
(6, 5, 102, 1, '2023-05-10');

---- BUSINESS QUESTIONS (THIS IS THE PROJECT)

---- Total Revenue
select sum(o.quantity * p.price) as Total_Revenue
from orders o
join products p
on o.product_id = p.product_id;

---- Revenue by Country
SELECT c.country,
       SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.country;

---- Top Selling Products
SELECT p.product_name,
       SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

---- Customers with Highest Spending
SELECT c.customer_name,
       SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

---- Average Order Value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT o.order_id,
           SUM(o.quantity * p.price) AS order_total
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY o.order_id
) t;

---- Monthly Sales Trend
SELECT MONTH(order_date) AS month,
       SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY MONTH(order_date)
ORDER BY month;








