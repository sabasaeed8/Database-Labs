-- 2019-CE-04 (SABA) Lab3
USE [Northwind]
GO

--1. Give the names of customers whose orders were delayed. Your answer should have the following schema. 
--Customers(CustomerId, CustomerName) 
SELECT DISTINCT dbo.Customers.CustomerID AS CustomerId, dbo.Customers.ContactName AS CustomerName
FROM dbo.Customers JOIN dbo.Orders ON  dbo.Customers.CustomerID = dbo.Orders.CustomerID
WHERE shippeddate > requireddate ORDER BY dbo.Customers.ContactName
GO

--2. Give the products details with its supplier company. Products(ProductName, SupplierName) 
SELECT dbo.Products.ProductName AS ProductName, dbo.Suppliers.ContactName AS SupplierName
FROM dbo.Products JOIN dbo.Suppliers ON dbo.Products.SupplierID = dbo.Suppliers.SupplierID ORDER BY SupplierName
GO

--3. Give the name of top products which have highest sale in the year 1998. 
SELECT dbo.Products.ProductName ProductsHighestSaleIn1998
FROM dbo.Orders JOIN dbo.OrderDetails ON dbo.Orders.OrderID= dbo.OrderDetails.OrderID
JOIN dbo.products ON dbo.OrderDetails.ProductID= dbo.Products.ProductID
WHERE dbo.OrderDetails.Quantity= (SELECT MAX(dbo.OrderDetails.Quantity) FROM dbo.OrderDetails WHERE YEAR(dbo.Orders.OrderDate) = 1998)
GO

--4. Give the name of employees with its manager name. Schema should have the following schema. 
--(EmployeeName, ManagerName) 
SELECT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, CONCAT(mng.firstname,' ',mng.lastname) AS ManagerName 
FROM dbo.Employees emp JOIN dbo.Employees mng
ON emp.ReportsTo= mng.EmployeeID ORDER BY emp.firstName,emp.lastname
GO

--5. Give the full names of managers who have less than two employees. 
SELECT CONCAT(mng.firstname,' ',mng.lastname) AS ManagerNameLessThan3Employee
FROM dbo.Employees emp JOIN dbo.Employees mng 
ON emp.ReportsTo = mng.EmployeeID WHERE (SELECT COUNT(dbo.Employees.ReportsTo) FROM dbo.Employees WHERE dbo.Employees.ReportsTo=mng.EmployeeID) < 3
GO

--6. List all the products whose price is more than average price. 
SELECT productid, productname AS ProductPriceMoreThanAvgPrice  
FROM dbo.Products 
WHERE unitprice > (SELECT AVG(unitprice) FROM dbo.Products)
GO

--7. Find second highest priced product without using TOP statement 
SELECT productid, productname AS SecondHighestPricedProduct 
FROM dbo.Products a
WHERE (SELECT COUNT(DISTINCT unitprice) FROM dbo.Products b WHERE a.unitprice<=b.unitprice) = 2
--GO

--8. Are there any employees who are elder than their managers? List that names of those employees. 
--Schema should look like this: Employees(EmployeeName,ManagerName,EmployeeAge,ManagerAge)
SELECT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, CONCAT(mng.firstname,' ',mng.lastname) AS ManagerName,
CONVERT(int,ROUND(DATEDIFF(hour,emp.birthdate,GETDATE())/8766.0,0)) AS EmployeeAge, CONVERT(int,ROUND(DATEDIFF(hour,mng.birthdate,GETDATE())/8766.0,0)) AS ManagerAge
FROM dbo.Employees emp JOIN dbo.Employees mng
ON emp.ReportsTo = mng.EmployeeID AND YEAR(emp.birthdate) < YEAR(mng.birthdate) 

GO
 
--9. List the names of products which were ordered on 8th August 1997.
SELECT dbo.Products.ProductName AS ProductsOrderedOn8thAugust1997 
FROM dbo.Orders JOIN dbo.OrderDetails ON dbo.Orders.OrderID = dbo.OrderDetails.OrderID
JOIN dbo.products ON dbo.OrderDetails.productid = dbo.Products.productid
WHERE dbo.Orders.orderdate = '19970808'
GO

--10. List the names of suppliers whose supplied products were ordered in 1997. 
SELECT DISTINCT dbo.Suppliers.ContactName AS SuppliersWhoseSuppliedProductsOrderedIn1997
FROM dbo.Orders JOIN dbo.OrderDetails ON dbo.Orders.orderid = dbo.OrderDetails.orderid 
JOIN dbo.products ON dbo.OrderDetails.productid = dbo.Products.ProductID
JOIN dbo.Suppliers ON dbo.Products.SupplierID = dbo.Suppliers.SupplierID
WHERE YEAR(dbo.Orders.OrderDate) = 1997 ORDER BY dbo.Suppliers.ContactName
GO

--11. How many employees are assigned to Eastern region. Give count. 
SELECT DISTINCT COUNT(EmployeeID) AS EmployeesAssignedToIDRegion FROM dbo.Orders WHERE shipregion = 'ID'

--12. Give the name of products which were not ordered in 1996.SELECT DISTINCT dbo.Products.ProductName AS ProductsNOTOrderedIn1996
FROM dbo.Orders JOIN dbo.OrderDetails ON dbo.Orders.orderid = dbo.OrderDetails.orderid 
JOIN dbo.products ON dbo.OrderDetails.productid = dbo.Products.productid
WHERE YEAR(dbo.Orders.orderdate) != 1996 ORDER BY dbo.Products.productname
GO