USE Lab11
GO

DROP SEQUENCE IF EXISTS TenMultiplesof10;
CREATE SEQUENCE TenMultiplesof10
    AS INT
    START WITH 10
    INCREMENT BY 10;

--1. Create 10Multiplesof10 table using While loop instead of Go N.
DROP TABLE Multiplesof10
CREATE TABLE Multiplesof10(
     table_of_ten int
);
Declare @table_count int
SET @table_count = 1
While @table_count <= 10
-- who report to no other employee.
CASE
    WHEN ReportsTo IS NULL THEN 'Superior.'
    ELSE 'Subordinate.'
END 
FROM Northwind.dbo.Employees;
--the function to calculate tables of 1, 2, 3, 4, 5 (Do not write the same query 5 times, find a more 
-- efficient way).
AS
DECLARE @n varchar(10) = @number
print 'Table of '+@n
DECLARE @i int =1
DECLARE @ans int =1
while (@i <=10)
  BEGIN
   SET @ans = @number * @i
   SET @i = @i+1
   print @ans
  END
--each order of that ID and then displays the bills for each order.
--i.e. Use SET statement to display the variable that has the quantity of Product for Order ID 10248.
DECLARE @quantity AS varchar(10);
BEGIN TRY
SET @quantity = (SELECT QuantityPerUnit FROM Northwind.dbo.Products where ProductID IN (Select ProductID from Northwind.dbo.OrderDetails where OrderID=10248))
SELECT @quantity AS Quantity
END TRY
BEGIN CATCH
DECLARE @Message varchar(MAX) = ERROR_MESSAGE();
SELECT @Message AS Error_Msg
END CATCH

--7. Define a procedure "ErrorInfo" that displays all error information. Upon catching the error, the 
--ErrorInfo procedure should be called.
BEGIN TRY
SET @quantity = (SELECT QuantityPerUnit FROM Northwind.dbo.Products where ProductID IN (Select ProductID from Northwind.dbo.OrderDetails where OrderID=10248))
SELECT @quantity AS Quantity
END TRY
BEGIN CATCH
  DECLARE @Message NVARCHAR(MAX) = ERROR_MESSAGE();  
    DECLARE @Severity INT = ERROR_SEVERITY();  
    DECLARE @State INT = ERROR_STATE();  
  EXEC ErrorInfo @Message, @Severity, @State
END CATCH