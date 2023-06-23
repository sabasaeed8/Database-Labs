DROP PROC IF EXISTS Product_quantity;
               WHERE OrderID = @Order_id)
    BEGIN
       SELECT OrderID, SUM(Quantity) AS Quantity FROM Northwind.dbo.OrderDetails
               WHERE OrderID = @Order_id GROUP BY OrderID
    END
    ELSE
	  BEGIN
        SET @error_msg = 'Invalid Order Id'