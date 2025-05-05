---Question 1
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
ON
    LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY
    OrderID;


    ---Question 2
    -- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Display the resulting tables
SELECT * FROM Orders;
SELECT * FROM OrderItems;