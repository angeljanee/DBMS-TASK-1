-- Task III: Seller and Inventory Management System
-- Continues from Task II (InventoryDB, Category, Product)

USE InventoryDB;

CREATE TABLE Seller (
    seller_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    available_stock INT NOT NULL DEFAULT 0,
    unavailable_stock INT NOT NULL DEFAULT 0,
    last_updated DATE NOT NULL,
    CONSTRAINT fk_inventory_seller FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CONSTRAINT uq_seller_product UNIQUE (seller_id, product_id),
    CONSTRAINT chk_available_stock CHECK (available_stock >= 0),
    CONSTRAINT chk_unavailable_stock CHECK (unavailable_stock >= 0)
);

INSERT INTO Seller (seller_name, email, phone, address) VALUES
('Tech World', 'techworld@gmail.com', '9000000001', 'Chennai'),
('Fashion Store', 'fashion@gmail.com', '9000000002', 'Coimbatore'),
('Book House', 'bookhouse@gmail.com', '9000000003', 'Madurai');

INSERT INTO Inventory (seller_id, product_id, available_stock, unavailable_stock, last_updated) VALUES
(1, 1, 50, 0, CURRENT_DATE),
(1, 2, 30, 0, CURRENT_DATE),
(2, 3, 100, 0, CURRENT_DATE),
(3, 4, 40, 0, CURRENT_DATE),
(1, 5, 25, 0, CURRENT_DATE);

-- Stock modification
UPDATE Inventory
SET available_stock = 45,
    last_updated = CURRENT_DATE
WHERE seller_id = 1 AND product_id = 1;

-- Inventory status report
SELECT
    s.seller_name,
    p.product_name,
    i.available_stock,
    i.unavailable_stock,
    CASE
        WHEN i.available_stock > 0 THEN 'AVAILABLE'
        ELSE 'UNAVAILABLE'
    END AS product_status,
    i.last_updated
FROM Inventory i
JOIN Seller s ON i.seller_id = s.seller_id
JOIN Product p ON i.product_id = p.product_id
ORDER BY s.seller_name, p.product_name;
