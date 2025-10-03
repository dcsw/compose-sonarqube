-- Full Example T-SQL DDL Script for a Database with Foreign Keys, Indexes, and Partitioning

-- Create a database
CREATE DATABASE SampleDB;
GO

USE SampleDB;
GO

-- Create a partition function
CREATE PARTITION FUNCTION pf_DateRange (DATE)
AS RANGE LEFT FOR VALUES ('2023-01-01', '2024-01-01', '2025-01-01');
GO

-- Create a partition scheme
CREATE PARTITION SCHEME ps_DateScheme
AS PARTITION pf_DateRange
ALL TO ([PRIMARY]);
GO

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    CreatedDate DATE NOT NULL DEFAULT GETDATE()
) ON ps_DateScheme (CreatedDate);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
) ON ps_DateScheme (OrderDate);
GO

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    Product NVARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create indexes
CREATE NONCLUSTERED INDEX idx_CustomerEmail ON Customers(Email);
CREATE NONCLUSTERED INDEX idx_OrderDate ON Orders(OrderDate);
CREATE NONCLUSTERED INDEX idx_OrderID ON OrderItems(OrderID);