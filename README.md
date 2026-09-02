TASK 2

CREATE DATABASE InventoryDB;
USE InventoryDB;

 CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0 NOT NULL,
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id)
);

INSERT INTO Category (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Men and women clothing'),
('Books', 'Educational and general books'),
('Furniture', 'Home and office furniture'),
('Sports', 'Sports equipment and accessories');

SELECT * FROM Category;

INSERT INTO Product (product_name, category_id, price, stock)
VALUES
('Laptop', 1, 55000.00, 10),
('Smartphone', 1, 25000.00, 20),
('T-Shirt', 2, 799.00, 30),
('Jeans', 2, 1499.00, 15),
('Java Programming Book', 3, 599.00, 25),
('Study Table', 4, 4500.00, 8),
('Cricket Bat', 5, 2500.00, 12);

SELECT * FROM Product;


















Task 3 — Seller and Inventory Management System
Requirements
Create Seller and Inventory tables.
Establish relationships between sellers, products and stock.
Maintain seller product information.
Track available and unavailable products.
Generate inventory status reports.
SQL
The complete implementation is in seller_inventory.sql.

Tables
Seller — seller ID, name, email, phone and address.
Inventory — inventory ID, seller, product, available stock, unavailable stock and last updated date.
Operations
The SQL file includes table creation, seller/product stock relationships, inventory data and inventory availability reporting.
