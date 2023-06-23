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
While @table_count <= 10BEGINBEGIN TRANSACTION  INSERT INTO Multiplesof10 values (NEXT VALUE FOR TenMultiplesof10);  SET @table_count = @table_count + 1COMMITENDSelect * from Multiplesof10--2. Display the names of the first 50 Products that have available Stock (Not 0 in quantity in Stock) using While.BEGINDECLARE @product_name varchar(100)DECLARE csr CURSOR FOR SELECT TOP 50 ProductName FROM Northwind.dbo.Products where UnitsInStock != 0print 'Names of the first 50 Products that have available Stock.'Open csr;  --To generatr resultFETCH NEXT FROM csr into @product_name --First record is fetchedWhile (@@FETCH_STATUS = 0) -- successfully got	BEGIN	    print @product_name		FETCH NEXT FROM csr into @product_name --to move forward	END	CLOSE csr    DEALLOCATE csr  -- To make cursor unusableEND--3. Use Case to display "Subordinate" for the employees that report to someone and "Superior" for those 
-- who report to no other employee.BEGIN TRANSELECT EmployeeID, ReportsTo,
CASE
    WHEN ReportsTo IS NULL THEN 'Superior.'
    ELSE 'Subordinate.'
END 
FROM Northwind.dbo.Employees;COMMIT-- 4. Create a function that takes a number as input and calculates and displays its first 10 multiples. Use 
--the function to calculate tables of 1, 2, 3, 4, 5 (Do not write the same query 5 times, find a more 
-- efficient way).DROP PROC IF EXISTS TenMultiplesGOCREATE OR ALTER PROC TenMultiples @number int
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
  ENDGODECLARE @i int SET @i = 1while (@i <=5)BEGIN  EXEC TenMultiples @number = @i;  SET @i = @i+1END --5. Create both, a Procedure and a function that takes order ID as input and calculates the total bill for 
--each order of that ID and then displays the bills for each order.DROP FUNCTION IF EXISTS Total_bill_func;GOCREATE FUNCTION Total_bill_func (@Order_id int)RETURNS intAS BEGIN   DECLARE @TBill int   SET @TBill = SELECT SUM(UnitPrice) AS Total_Bill from Northwind.dbo.OrderDetails Where OrderID =@Order_id   GROUP BY OrderID;   RETURN @TBill   END-- SELECT statements inside a function that return data to the function caller is not allowed.-- If you need to return result sets to the client, you have to use a stored procedure and not -- a function for this purposeDROP PROC IF EXISTS Total_bill_proc;GO;CREATE OR ALTER PROC Total_bill_proc @Order_id  AS int   AS   SELECT OrderID, SUM(UnitPrice) AS Total_Bill from Northwind.dbo.OrderDetails Where OrderID =@Order_id   GROUP BY OrderID;   GO;EXEC Total_bill_proc @Order_id = 10248;--6. Use error handling to catch the error from the third question in the variables section using SET 
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
--ErrorInfo procedure should be called.DROP PROC IF EXISTS ErrorInfo;GO;CREATE OR ALTER PROC ErrorInfo @Message varchar(MAX), @Severity int, @State smallint   AS   DECLARE @Svty varchar(MAX) = @severity   DECLARE @St varchar(MAX) = @State   print 'ErrorMsg: '+@Message   print 'ErrorSeverity: '+@Svty   print 'ErrorState: '+@St GO;-- Test Output DECLARE @quantity AS varchar(10);
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