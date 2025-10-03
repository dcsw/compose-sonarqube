-- PostgreSQL Full Example DDL Script
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    CreatedDate DATE DEFAULT CURRENT_DATE NOT NULL
);

CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL REFERENCES Customers(CustomerID),
    OrderDate DATE DEFAULT CURRENT_DATE NOT NULL,
    TotalAmount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE OrderItems (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL REFERENCES Orders(OrderID),
    Product VARCHAR(100) NOT NULL,
    Quantity INTEGER NOT NULL,
    Price NUMERIC(10, 2) NOT NULL
);

CREATE INDEX idx_CustomerEmail ON Customers(Email);
CREATE INDEX idx_OrderDate ON Orders(OrderDate);
CREATE INDEX idx_OrderID ON OrderItems(OrderID);