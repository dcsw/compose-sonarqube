-- Oracle SQL queries, including joins, updates, inserts, and deletes based on the provided DDL

-- Select all customers
SELECT CustomerID, Name, Email, CreatedDate
FROM Customers;

-- Insert a new customer
INSERT INTO Customers (Name, Email, CreatedDate)
VALUES ('Alice Smith', 'alice.smith@example.com', SYSDATE);

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
BEGIN
  INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
  VALUES (1, SYSDATE, 300.00);
  SELECT OrderID INTO :new_order_id FROM Orders WHERE ROWID = (SELECT MAX(ROWID) FROM Orders);
  
  INSERT INTO OrderItems (OrderID, Product, Quantity, Price)
  VALUES (:new_order_id, 'Product A', 2, 50.00),
         (:new_order_id, 'Product B', 3, 50.00);
  
  -- Update order total amount based on order items
  UPDATE Orders
  SET TotalAmount = (
    SELECT SUM(Quantity * Price)
    FROM OrderItems
    WHERE OrderID = :new_order_id
  )
  WHERE OrderID = :new_order_id;
END;

-- Delete an order and its items
BEGIN
  DELETE FROM OrderItems WHERE OrderID = :new_order_id;
  DELETE FROM Orders WHERE OrderID = :new_order_id;
END;