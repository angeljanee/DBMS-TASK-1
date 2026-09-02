-- Task IV: Order Management System
-- Continues from Task II and Task III in InventoryDB

USE InventoryDB;

-- Customer table required for customer order history
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    CONSTRAINT fk_order_details_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_order_details_product FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CONSTRAINT chk_order_quantity CHECK (quantity > 0)
);

INSERT INTO Customer (customer_name, email, phone, address) VALUES
('Arun Kumar', 'arun@gmail.com', '9010000001', 'Chennai'),
('Priya Devi', 'priya@gmail.com', '9010000002', 'Coimbatore');

-- Order insertion
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES (1, CURRENT_DATE, 55000.00);

INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, 55000.00);

-- Order modification
UPDATE Order_Details
SET quantity = 2
WHERE order_detail_id = 1;

UPDATE Orders
SET total_amount = (
    SELECT SUM(subtotal)
    FROM Order_Details
    WHERE order_id = 1
)
WHERE order_id = 1;

-- Customer order history report
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.subtotal,
    o.total_amount
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
ORDER BY c.customer_id, o.order_date DESC, o.order_id DESC;
