-- MySQL-based SQL queries, including joins, updates, inserts, and deletes, based on the provided schema

-- Select all customers
SELECT CustomerID, Name, Email, CreatedDate
FROM Customers;

-- Insert a new customer
INSERT INTO Customers (Name, Email, CreatedDate)
VALUES ('Alice Smith', 'alice.smith@example.com', NOW());

-- Update a customer's email
UPDATE Customers
SET Email = 'alice.newemail@example.com'
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
START TRANSACTION;
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, NOW(), 300.00);
SET @NewOrderID = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, Product, Quantity, Price)
VALUES (@NewOrderID, 'Product A', 2, 50.00),
       (@NewOrderID, 'Product B', 3, 50.00);
COMMIT;

-- Update order total amount based on order items
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Price)
    FROM OrderItems
    WHERE OrderID = Orders.OrderID
)
WHERE OrderID = @NewOrderID;

-- Delete an order and its items
START TRANSACTION;
DELETE FROM OrderItems WHERE OrderID = @NewOrderID;
DELETE FROM Orders WHERE OrderID = @NewOrderID;
COMMIT;