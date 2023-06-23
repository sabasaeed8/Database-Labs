-- 2019-CE-04 (SABA) Lab3
USE [TSQL2012]
GO

--1. Give the names of customers whose orders were delayed. Your answer should have the following schema. 
--Customers(CustomerId, CustomerName) 
SELECT DISTINCT Sales.Customers.custid AS CustomerId, Sales.Customers.contactname AS CustomerName
FROM Sales.Customers JOIN Sales.Orders ON  Sales.Customers.custid = Sales.Orders.custid 
WHERE shippeddate > requireddate ORDER BY Sales.Customers.custid, Sales.Customers.contactname
GO

--2. Give the products details with its supplier company. Products(ProductName, SupplierName) 
SELECT Production.Products.productname AS ProductName, Production.Suppliers.contactname AS SupplierName
FROM Production.Products JOIN Production.Suppliers ON Production.Products.supplierid = Production.Suppliers.supplierid ORDER BY SupplierName
GO

--3. Give the name of top products which have highest sale in the year 2007. 
SELECT Production.Products.productname AS ProductsHighestSaleIn2007 
FROM Sales.Orders JOIN Sales.OrderDetails ON Sales.Orders.orderid = Sales.OrderDetails.orderid 
JOIN Production.products ON Sales.OrderDetails.productid = Production.Products.productid
WHERE Sales.OrderDetails.qty = (SELECT MAX(Sales.OrderDetails.qty) FROM Sales.OrderDetails WHERE YEAR(Sales.Orders.orderdate) = 2007)
GO

--4. Give the name of employees with its manager name. Schema should have the following schema. 
--(EmployeeName, ManagerName) 
SELECT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, CONCAT(mng.firstname,' ',mng.lastname) AS ManagerName 
FROM HR.Employees emp JOIN HR.Employees mng
ON emp.mgrid = mng.empid ORDER BY emp.firstName,emp.lastname
GO

--5. Give the full names of managers who have less than two employees. 
SELECT CONCAT(mng.firstname,' ',mng.lastname) AS ManagerNameLessThan2Employee
FROM HR.Employees emp JOIN HR.Employees mng 
ON emp.mgrid = mng.empid WHERE (SELECT COUNT(HR.Employees.mgrid) FROM HR.Employees WHERE HR.Employees.mgrid=mng.empid) < 2
GO

--6. List all the products whose price is more than average price. 
SELECT productid, productname AS ProductPriceMoreThanAvgPrice  
FROM Production.Products 
WHERE unitprice > (SELECT AVG(unitprice) FROM Production.Products)
GO

--7. Find second highest priced product without using TOP statement 
SELECT productid, productname AS SecondHighestPricedProduct 
FROM Production.Products a
WHERE (SELECT COUNT(DISTINCT unitprice) FROM Production.Products b WHERE a.unitprice<=b.unitprice) = 2
--GO

--8. Are there any employees who are elder than their managers? List that names of those employees. 
--Schema should look like this: Employees(EmployeeName,ManagerName,EmployeeAge,ManagerAge)
SELECT CONCAT(emp.firstname,' ',emp.lastname) AS EmployeeName, CONCAT(mng.firstname,' ',mng.lastname) AS ManagerName,
CONVERT(int,ROUND(DATEDIFF(hour,emp.birthdate,GETDATE())/8766.0,0)) AS EmployeeAge, CONVERT(int,ROUND(DATEDIFF(hour,mng.birthdate,GETDATE())/8766.0,0)) AS ManagerAge
FROM HR.Employees emp JOIN HR.Employees mng
ON emp.mgrid = mng.empid AND YEAR(emp.birthdate) < YEAR(mng.birthdate) 

GO
 
--9. List the names of products which were ordered on 20th August 2007.
SELECT Production.Products.productname AS ProductsOrderedOn20thAugust2007 
FROM Sales.Orders JOIN Sales.OrderDetails ON Sales.Orders.orderid = Sales.OrderDetails.orderid 
JOIN Production.products ON Sales.OrderDetails.productid = Production.Products.productid
WHERE Sales.Orders.orderdate = '20070820'
GO

--10. List the names of suppliers whose supplied products were ordered in 2007. 
SELECT DISTINCT Production.Suppliers.contactname AS SuppliersWhoseSuppliedProductsOrderedIn2007
FROM Sales.Orders JOIN Sales.OrderDetails ON Sales.Orders.orderid = Sales.OrderDetails.orderid 
JOIN Production.products ON Sales.OrderDetails.productid = Production.Products.productid 
JOIN Production.Suppliers ON Production.Products.supplierid = Production.Suppliers.supplierid
WHERE YEAR(Sales.Orders.orderdate) = 2007 ORDER BY Production.Suppliers.contactname
GO

--11. How many employees are assigned to Eastern region. Give count. 
SELECT DISTINCT COUNT(empid) AS EmployeesAssignedToIDRegion FROM Sales.Orders WHERE shipregion = 'ID'

--12. Give the name of products which were not ordered in 2007.SELECT DISTINCT Production.Products.productname AS ProductsNOTOrderedIn2007
FROM Sales.Orders JOIN Sales.OrderDetails ON Sales.Orders.orderid = Sales.OrderDetails.orderid 
JOIN Production.products ON Sales.OrderDetails.productid = Production.Products.productid
WHERE YEAR(Sales.Orders.orderdate) != 2007 ORDER BY Production.Products.productname
GO