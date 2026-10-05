-- Task VIII: Database Relationship Analysis using Joins
-- Continues from Task IV, V and VII in InventoryDB

USE InventoryDB;

-- 1. INNER JOIN: Customer + Orders + Order_Details + Product + Payment
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.subtotal,
    pay.payment_mode,
    pay.amount AS payment_amount,
    pay.payment_status
FROM Customer c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Product p ON od.product_id = p.product_id
INNER JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC, o.order_id DESC;

-- 2. LEFT JOIN: Display all customers, including customers
-- who have not placed an order
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- 3. RIGHT JOIN: Display all products, including products
-- that have not appeared in any order
SELECT
    p.product_id,
    p.product_name,
    p.price,
    od.order_id,
    od.quantity,
    od.subtotal
FROM Order_Details od
RIGHT JOIN Product p ON od.product_id = p.product_id
ORDER BY p.product_id;

-- 4. Complete order details with customer, product and payment information
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.email,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.subtotal,
    o.total_amount,
    pay.payment_mode,
    pay.payment_status
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC, o.order_id DESC;

-- 5. Customer purchase history
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    od.subtotal
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
ORDER BY c.customer_id, o.order_date DESC;

-- 6. Multi-table business report: customer-wise purchase summary
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_items,
    SUM(od.subtotal) AS total_purchase_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase_amount DESC;

-- 7. Payment report connected with customer and order
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    pay.payment_mode,
    pay.amount,
    pay.payment_status
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY pay.payment_date DESC, pay.payment_id DESC;
