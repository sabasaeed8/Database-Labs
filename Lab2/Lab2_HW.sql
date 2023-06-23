USE [Northwind]
GO

--Write a query to report orders which were delayed shipped.
SELECT * FROM [dbo].[Orders] where ShippedDate > RequiredDate
GO

--Our employees belong to how many countries. List the names.
SELECT DISTINCT Country FROM [dbo].[Employees]
GO

--Is there any employee whose is not accountable?
SELECT * FROM [dbo].[Employees] where ReportsTo IS NULL
GO

--List the names of products which have been discontinued.
SELECT ProductName FROM [dbo].[Products] where Discontinued = 1 ORDER By ProductName ASC
GO

--List the IDs the orders on which discount was not provided.
SELECT OrderID, ProductID  FROM [dbo].[OrderDetails] where Discount = 0
GO

--Enlist the names of customers who have not specified their region.SELECT ContactName As CustomersName FROM [dbo].[Customers] where Region Is NULL ORDER BY ContactName ASC
GO--Enlist the names of customers along with contact number who either belongs to UK or USA.SELECT ContactName As CustomersName, Phone As ContactNumber FROM [dbo].[Customers] where (Country='UK') OR (Country='USA') ORDER BY ContactName ASC
GO

--Report the names of companies who have provided their web page
SELECT CompanyName FROM [dbo].[Suppliers] where HomePage IS NOT NULL ORDER BY CompanyName ASC
GO

--In which countries, products were sold in year 1997.
SELECT DISTINCT ShipCountry FROM [dbo].[Orders] where YEAR(ShippedDate) = 1997 ORDER BY ShipCountry
GO

--List the ids of customers whose orders were never shipped.
SELECT CustomerID FROM [dbo].[Orders] where ShippedDate IS NULL ORDER BY CustomerID
GO
