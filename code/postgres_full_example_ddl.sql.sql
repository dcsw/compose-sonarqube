-- Sample SQL queries, updates, inserts, deletes, and joins based on the provided PostgreSQL DDL

-- Select all customers
SELECT CustomerID, Name, Email, CreatedDate
FROM Customers;

-- Insert a new customer
INSERT INTO Customers (Name, Email, CreatedDate)
VALUES ('Jane Doe', 'jane.doe@example.com', CURRENT_DATE);

-- Update a customer's email
UPDATE Customers
SET Email = 'jane.newemail@example.com'
WHERE CustomerID = 1;

-- Delete a customer
DELETE FROM Customers
WHERE CustomerID = 2;

-- Join Customers with Orders to get customer order details
SELECT c.CustomerID, c.Name, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Select all orders with their order items
SELECT o.OrderID, o.OrderDate, oi.Product, oi.Quantity, oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID;

-- Insert a new order with order items
BEGIN;
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, CURRENT_DATE, 200.00);
SELECT currval('Orders_OrderID_seq') INTO TEMP new_order_id;

INSERT INTO OrderItems (OrderID, Product, Quantity, Price)
VALUES ((SELECT * FROM new_order_id), 'Product X', 3, 50.00),
       ((SELECT * FROM new_order_id), 'Product Y', 2, 50.00);
COMMIT;

-- Update order total amount based on order items
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Price)
    FROM OrderItems
    WHERE OrderID = Orders.OrderID
)
WHERE OrderID = (SELECT * FROM new_order_id);

-- Delete an order and its items
BEGIN;
DELETE FROM OrderItems WHERE OrderID = (SELECT * FROM new_order_id);
DELETE FROM Orders WHERE OrderID = (SELECT * FROM new_order_id);
COMMIT;