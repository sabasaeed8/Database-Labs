USE [Northwind]
GO

--1. Give the names of customers whose orders were delayed. Your answer should have the following schema. 
--Customers(CustomerId, CustomerName) 
SELECT DISTINCT CustomerID,ContactName AS CustomerName
FROM Customers WHERE CustomerID IN 
(SELECT DISTINCT CustomerID from Orders WHERE ShippedDate>RequiredDate) 
ORDER BY ContactName;
GO

--2. Give the products details with its supplier company. Products(ProductName, SupplierName) 
SELECT ProductName, 
(Select ContactName from Suppliers where Products.SupplierID = Suppliers.SupplierID) AS SupplierName
FROM Products 
ORDER BY SupplierName
GO

--3. Give the name of top products which have highest sale in the year 1998. 
SELECT ProductName AS ProductsHighestSaleIn1998
FROM Products 
Where ProductID IN 
(Select ProductID from OrderDetails where OrderID IN 
(select OrderID from Orders where dbo.OrderDetails.Quantity= (SELECT MAX(OrderDetails.Quantity) FROM dbo.OrderDetails WHERE YEAR(Orders.OrderDate) = 1998))) 
GO

--4. Give the name of employees with its manager name. Schema should have the following schema. 
--(EmployeeName, ManagerName) 
SELECT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, 
(SELECT CONCAT(mng.firstname,' ',mng.lastname) from Employees mng where emp.ReportsTo= mng.EmployeeID) AS ManagerName 
FROM Employees emp,Employees mng where emp.ReportsTo= mng.EmployeeID 
ORDER BY emp.firstName,emp.lastname
GO

--5. Give the full names of managers who have less than two employees. 
SELECT CONCAT(mng.firstname,' ',mng.lastname) AS ManagerNameLessThan2Employee
FROM Employees mng Where EmployeeID IN 
(Select ReportsTo from Employees emp WHERE (SELECT COUNT(dbo.Employees.ReportsTo) FROM dbo.Employees WHERE dbo.Employees.ReportsTo=mng.EmployeeID) <2)
GO

--6. List all the products whose price is more than average price. 
SELECT productid, productname AS ProductPriceMoreThanAvgPrice  
FROM Products 
WHERE unitprice > (SELECT AVG(unitprice) FROM Products)
GO

--7. Find second highest priced product without using TOP statement 
SELECT a.productid, a.productname AS SecondHighestPricedProduct 
FROM dbo.Products a
WHERE (SELECT COUNT(DISTINCT unitprice) FROM dbo.Products b WHERE a.unitprice<=b.unitprice) = 2
GO

--8. Are there any employees who are elder than their managers? List that names of those employees. 
--Schema should look like this: Employees(EmployeeName,ManagerName,EmployeeAge,ManagerAge)
SELECT DISTINCT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, CONVERT(int,ROUND(DATEDIFF(hour,emp.birthdate,GETDATE())/8766.0,0)) AS EmployeeAge,
(Select CONCAT(mng.firstname,' ',mng.lastname) From Employees mng Where mng.EmployeeID = emp.ReportsTo AND YEAR(emp.birthdate) < YEAR(mng.birthdate) )AS ManagerName, 
(Select CONVERT(int,ROUND(DATEDIFF(hour,mng.birthdate,GETDATE())/8766.0,0)) From Employees mng Where mng.EmployeeID = emp.ReportsTo AND YEAR(emp.birthdate) < YEAR(mng.birthdate) ) AS ManagerAge
From Employees emp,Employees mng Where mng.EmployeeID = emp.ReportsTo AND YEAR(emp.birthdate) < YEAR(mng.birthdate)
GO
 
--9. List the names of products which were ordered on 8th August 1997.
SELECT ProductName AS ProductsHighestSaleIn1998
FROM Products 
Where ProductID IN 
(Select ProductID from OrderDetails where OrderID IN 
(select OrderID from Orders where dbo.Orders.orderdate = '19970808'))
GO

--10. List the names of suppliers whose supplied products were ordered in 1997. 
SELECT DISTINCT Suppliers.ContactName AS SuppliersWhoseSuppliedProductsOrderedIn1997
from Suppliers where SupplierID IN 
(Select SupplierID from Products Where ProductID IN 
(Select ProductID from OrderDetails Where orderid IN 
(Select orderid From Orders WHERE YEAR(dbo.Orders.OrderDate) = 1997)))
ORDER BY Suppliers.ContactName
GO

--11. How many employees are assigned to Eastern region. Give count. 
SELECT DISTINCT COUNT(EmployeeID) AS EmployeesAssignedToIDRegion FROM dbo.Orders WHERE shipregion = 'ID'

--12. Give the name of products which were not ordered in 1996.
SELECT DISTINCT Products.ProductName AS ProductsNOTOrderedIn1996
from Products Where productid IN 
(Select productid From OrderDetails Where orderid IN 
(Select orderid from Orders Where YEAR(orderdate) != 1996 ))
ORDER BY productname
GO