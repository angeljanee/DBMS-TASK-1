-- Task V: Payment Management System
-- Continues from Task IV in InventoryDB

USE InventoryDB;

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT chk_payment_mode CHECK (payment_mode IN ('UPI', 'CARD', 'NET BANKING', 'CASH')),
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('SUCCESSFUL', 'FAILED', 'PENDING')),
    CONSTRAINT chk_payment_amount CHECK (amount >= 0)
);

-- Payment insertion
INSERT INTO Payment (order_id, payment_mode, payment_date, amount, payment_status)
VALUES
(1, 'UPI', CURRENT_DATE, 110000.00, 'SUCCESSFUL');

-- Second payment record for modification demonstration
INSERT INTO Payment (order_id, payment_mode, payment_date, amount, payment_status)
VALUES
(1, 'CARD', CURRENT_DATE, 110000.00, 'PENDING');

-- Payment modification
UPDATE Payment
SET payment_status = 'SUCCESSFUL'
WHERE payment_id = 2;

-- Payment transaction report
SELECT
    payment_id,
    order_id,
    payment_mode,
    payment_date,
    amount,
    payment_status
FROM Payment
ORDER BY payment_date DESC, payment_id DESC;

-- Payment summary by payment mode
SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_mode
ORDER BY total_amount DESC;
