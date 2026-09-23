-- Task VII: SQL Query Implementation for E-Commerce Database
-- Continues from the E-Commerce Database tasks in InventoryDB

USE InventoryDB;

-- 1. SELECT, WHERE, ORDER BY and DISTINCT queries

-- SELECT: Retrieve all products
SELECT * FROM Product;

-- WHERE: Products priced below 5000
SELECT product_id, product_name, price, stock
FROM Product
WHERE price < 5000;

-- ORDER BY: Products from highest to lowest price
SELECT product_id, product_name, price
FROM Product
ORDER BY price DESC;

-- DISTINCT: List unique product categories
SELECT DISTINCT category_name
FROM Category
ORDER BY category_name;


-- 2. Search products based on price, category and availability

-- Products within a price range
SELECT product_id, product_name, price
FROM Product
WHERE price BETWEEN 500 AND 5000
ORDER BY price ASC;

-- Products in a specific category
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
ORDER BY p.price ASC;

-- Available products
SELECT product_id, product_name, price, stock
FROM Product
WHERE stock > 0
ORDER BY stock DESC;

-- Unavailable products
SELECT product_id, product_name, price, stock
FROM Product
WHERE stock = 0;


-- 3. Retrieve customer and product information

-- Customer information
SELECT customer_id, customer_name, email, phone, address
FROM Customer
ORDER BY customer_name;

-- Customer and purchased product information
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.subtotal
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
ORDER BY c.customer_name, p.product_name;


-- 4. Apply filtering conditions

-- Electronics products below 30000
SELECT
    p.product_name,
    c.category_name,
    p.price,
    p.stock
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
  AND p.price < 30000
  AND p.stock > 0
ORDER BY p.price ASC;

-- Products that are either unavailable or priced above 20000
SELECT product_id, product_name, price, stock
FROM Product
WHERE stock = 0 OR price > 20000
ORDER BY price DESC;


-- 5. Basic business reports

-- Product count and average price by category
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    ROUND(AVG(p.price), 2) AS average_price
FROM Category c
LEFT JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_products DESC;

-- Inventory availability report
SELECT
    COUNT(*) AS total_products,
    SUM(CASE WHEN stock > 0 THEN 1 ELSE 0 END) AS available_products,
    SUM(CASE WHEN stock = 0 THEN 1 ELSE 0 END) AS unavailable_products
FROM Product;

-- Customer order summary
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;
