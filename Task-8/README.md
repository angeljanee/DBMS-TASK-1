# Task VIII — Database Relationship Analysis using Joins

## Objective
Analyze relationships between Customer, Product, Orders, Order_Details, and Payment tables using SQL JOIN operations.

## Requirements
1. Combine Customer, Product, Order, and Payment tables.
2. Implement INNER JOIN, LEFT JOIN, and RIGHT JOIN.
3. Retrieve complete order details.
4. Display customer purchase history.
5. Generate multi-table business reports.

## SQL Implementation

The `Task-8-Database-Relationship-Analysis.sql` file contains the complete implementation.

### Joins Used

- **INNER JOIN** — Combines matching records from Customer, Orders, Order_Details, Product, and Payment.
- **LEFT JOIN** — Displays all customers, including customers without orders.
- **RIGHT JOIN** — Displays all products, including products without order records.
- **Multiple JOINs** — Retrieves complete order and payment details across several related tables.

## Reports Generated

- Complete order details
- Customer purchase history
- Customer-wise purchase summary
- Product order information
- Payment report linked with customers and orders

## Database
`InventoryDB`

## Tables Used
- Customer
- Product
- Orders
- Order_Details
- Payment

## Execution
Run the SQL file after completing the previous database tasks so that the required tables and relationships are available.
