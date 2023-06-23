DROP PROC IF EXISTS Product_quantity;GO;CREATE PROC Product_quantity @Order_id  AS int   AS   DECLARE @error_msg nvarchar(20)   IF EXISTS (SELECT Quantity FROM Northwind.dbo.OrderDetails
               WHERE OrderID = @Order_id)
    BEGIN
       SELECT OrderID, SUM(Quantity) AS Quantity FROM Northwind.dbo.OrderDetails
               WHERE OrderID = @Order_id GROUP BY OrderID
    END
    ELSE
	  BEGIN
        SET @error_msg = 'Invalid Order Id'		Select @error_msg 	  ENDGO;EXEC Product_quantity @Order_id = 10248;EXEC Product_quantity @Order_id = 1;