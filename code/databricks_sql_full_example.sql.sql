-- Enhanced SQL Script for Databricks

-- Sample SELECT with JOINs to retrieve customer orders and items
SELECT c.CustomerID, c.Name, c.Email, o.OrderID, o.OrderDate, o.TotalAmount, oi.Product, oi.Quantity, oi.Price
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID;

-- Insert new customer
INSERT INTO Customers (Name, Email, CreatedDate)
VALUES ('John Doe', 'john.doe@example.com', CURRENT_DATE);

-- Insert a new order for the customer
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, CURRENT_DATE, 150.00);

-- Insert order items for the order
INSERT INTO OrderItems (OrderID, Product, Quantity, Price)
VALUES (1, 'Laptop', 1, 1200.00),
       (1, 'Mouse', 2, 25.00);

-- Update customer email
UPDATE Customers
SET Email = 'john.newemail@example.com'
WHERE CustomerID = 1;

-- Update order total amount
UPDATE Orders
SET TotalAmount = 1250.00
WHERE OrderID = 1;

-- Delete an order item
DELETE FROM OrderItems
WHERE OrderItemID = 2;

-- Delete an order
DELETE FROM Orders
WHERE OrderID = 1;

-- Delete a customer
DELETE FROM Customers
WHERE CustomerID = 1;
