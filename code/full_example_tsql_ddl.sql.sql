-- Sample SQL queries, updates, inserts, deletes, and joins based on the provided DDL

-- Select all customers
SELECT CustomerID, Name, Email, CreatedDate
FROM Customers;

-- Insert a new customer
INSERT INTO Customers (Name, Email, CreatedDate)
VALUES ('John Doe', 'john.doe@example.com', GETDATE());

-- Update a customer's email
UPDATE Customers
SET Email = 'john.newemail@example.com'
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
BEGIN TRANSACTION;
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, GETDATE(), 150.00);
DECLARE @NewOrderID INT = SCOPE_IDENTITY();

INSERT INTO OrderItems (OrderID, Product, Quantity, Price)
VALUES (@NewOrderID, 'Product A', 2, 50.00),
       (@NewOrderID, 'Product B', 1, 50.00);
COMMIT TRANSACTION;

-- Update order total amount based on order items
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Price)
    FROM OrderItems
    WHERE OrderID = Orders.OrderID
)
WHERE OrderID = @NewOrderID;

-- Delete an order and its items
BEGIN TRANSACTION;
DELETE FROM OrderItems WHERE OrderID = @NewOrderID;
DELETE FROM Orders WHERE OrderID = @NewOrderID;
COMMIT TRANSACTION;