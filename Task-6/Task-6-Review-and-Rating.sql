-- Task VI: Review and Rating System
-- Continues from Task IV in InventoryDB

USE InventoryDB;

CREATE TABLE Review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text VARCHAR(500),
    review_date DATE NOT NULL,
    CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    rating_date DATE NOT NULL,
    CONSTRAINT fk_rating_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_rating_product FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CONSTRAINT chk_rating_value CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT uq_customer_product_rating UNIQUE (customer_id, product_id)
);

-- Review insertion
INSERT INTO Review (customer_id, product_id, review_text, review_date)
VALUES
(1, 1, 'Very good product with excellent performance.', CURRENT_DATE),
(2, 3, 'Good quality and comfortable.', CURRENT_DATE);

-- Rating insertion
INSERT INTO Rating (customer_id, product_id, rating, rating_date)
VALUES
(1, 1, 4.5, CURRENT_DATE),
(2, 3, 4.0, CURRENT_DATE);

-- Review modification
UPDATE Review
SET review_text = 'Excellent product with very good performance.'
WHERE review_id = 1;

-- Review report
SELECT
    r.review_id,
    c.customer_name,
    p.product_name,
    r.review_text,
    r.review_date
FROM Review r
JOIN Customer c ON r.customer_id = c.customer_id
JOIN Product p ON r.product_id = p.product_id
ORDER BY r.review_date DESC, r.review_id DESC;

-- Average rating report
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(rt.rating), 2) AS average_rating,
    COUNT(rt.rating_id) AS total_ratings
FROM Product p
JOIN Rating rt ON p.product_id = rt.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_rating DESC;

-- Highly rated products report
SELECT
    p.product_name,
    ROUND(AVG(rt.rating), 2) AS average_rating
FROM Product p
JOIN Rating rt ON p.product_id = rt.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(rt.rating) >= 4
ORDER BY average_rating DESC;
