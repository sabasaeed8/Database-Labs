Use Northwind
GO
-- 1.Store ContactTitle of Customer with Id "BERGS" in a variable using sub-query and then display it.
DECLARE @contact_tiltle AS VARCHAR(50);
SET @contact_tiltle = (SELECT ContactTitle FROM dbo.Customers where CustomerID = 'BERGS')
print 'ContactTitle: '+@contact_tiltle 
GO
-- 2. Store name, title and Address of Customer with Id "BERGS" in a variable without sub-query and 
--display it.
DECLARE @name AS VARCHAR(50);
DECLARE @title AS VARCHAR(50);
DECLARE @address AS VARCHAR(50);
SET @name= (SELECT ContactName FROM dbo.Customers where CustomerID = 'BERGS')
SET @title = (SELECT ContactTitle FROM dbo.Customers where CustomerID = 'BERGS')
SET @address = (SELECT Address FROM dbo.Customers where CustomerID = 'BERGS')
print 'Customer Name: '+@name;
print 'Customer Title: '+@title;
print 'Customer Address: '+@address
GO
-- 3. Use SET and SELECT statements to display the variable that has the quantity of Product for Order ID 10248.
DECLARE @quantity AS varchar(10);
SET @quantity = (SELECT QuantityPerUnit FROM Northwind.dbo.Products where ProductID IN (Select ProductID from Northwind.dbo.OrderDetails where OrderID=10248 and ProductID =11))
SELECT @quantity AS Quantity

-- Create a Procedure that accepts ID of customer as input and displays the details of that 
-- customer. Conduct the code properly by dropping and creating the Procedure in batches.DROP PROC IF EXISTS customer_detail;GO;CREATE PROC customer_detail @Customer_id  AS Nvarchar(10)    AS   SELECT * FROM Northwind.dbo.Customers where CustomerID= @Customer_id;GO;EXEC customer_detail @Customer_id = 'ALFKI';-- 1. Create a table called FirstMultiplesOf10 containing one integer column. Use sequence and GO N to 
-- fill the table with the first 10 multiples of 10. Display the table.
DROP SEQUENCE IF EXISTS FirstMultiplesOf10;

CREATE SEQUENCE FirstMultiplesOf10
    AS INT
    START WITH 10
    INCREMENT BY 10;

CREATE TABLE table10(
     table_ten int
);
INSERT INTO table10 values (NEXT VALUE FOR FirstMultiplesOf10);
GO 10

SELECT * from table10;
-- 2. Create another table SecondMultiplesof10 that contains the 10- 20 multiples of 10 using the same 
-- sequence that was generated in the previous question. Display the table.
CREATE TABLE SecondMultiplesof10(
     table_ten_twenty int
);
INSERT INTO SecondMultiplesof10 values (NEXT VALUE FOR FirstMultiplesOf10);
GO 10

SELECT * from SecondMultiplesof10;


-- 3. Create a table with ID and Productname using IDENTITY that is incremented by 3 for each row.
CREATE TABLE Product_id_name  
(  
 id_num int IDENTITY(1,3),  
 product_name varchar (20),    
); 
INSERT INTO Product_id_name values ('saba');
INSERT INTO Product_id_name values ('amna');
INSERT INTO Product_id_name values ('kiran');
SELECT * from Product_id_name;