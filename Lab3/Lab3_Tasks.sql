USE [TSQL2012]
GO

--Exercise 1.1:
--Write a query that generates five copies of each employee row: Tables involved: HR.Employees and dbo.Nums
--Desired output (and some other rows):
SELECT HR.Employees.empid, HR.Employees.firstname, HR.Employees.lastname, dbo.Nums.n 
FROM HR.Employees
INNER JOIN dbo.Nums ON dbo.Nums.n <= 5
GO

--Exercise 1.2:
--Write a query that returns a row for each employee and day in the range June 12, 2016 through June 16, 2016:
--Tables involved: HR.Employees and dbo.Nums
SELECT HR.Employees.empid, DATEADD(day,1,HR.Employees.hiredate) AS dt
FROM HR.Employees
INNER JOIN dbo.Nums ON dbo.Nums.n <= 5 WHERE HR.Employees.hiredate > '2002-05-01' AND HR.Employees.hiredate < '2004-01-02' ORDER BY HR.Employees.empid, HR.Employees.hiredate
GO

--Exercise 1.3:
--Explain what’s wrong in the following query, and provide a correct alternative:
SELECT Customers.custid, Customers.companyname,Orders.orderid, Orders.orderdate
FROM Sales.Customers INNER JOIN Sales.Orders ON Customers.custid = Orders.custid 
--Exercise 4:
--Return US customers, and for each customer return the total number of orders and total quantities:
SELECT Sales.Customers.custid, COUNT(Sales.Orders.orderid) AS numorders, SUM(Sales.OrderDetails.qty) AS totalqty
FROM Sales.Customers INNER JOIN Sales.Orders ON Sales.Customers.custid = Sales.Orders.custid 
 INNER JOIN Sales.OrderDetails ON Sales.OrderDetails.orderid = Sales.Orders.orderid WHERE Sales.Customers.country = 'USA' GROUP BY Sales.Customers.custid
 GO

--Exercise 5:
--Return customers and their orders, including customers who placed no orders:
SELECT Sales.Customers.custid, Sales.Customers.companyname, Sales.Orders.orderid, Sales.Orders.orderdate 
FROM Sales.Customers LEFT OUTER JOIN Sales.Orders ON Sales.Orders.custid = Sales.Customers.custid
GO

--Exercise 6:
--Return customers who placed no orders: Tables involved: Sales.Customers and Sales.Orders
SELECT Sales.Customers.custid, Sales.Customers.companyname FROM Sales.Customers LEFT OUTER JOIN Sales.Orders 
ON Sales.Orders.custid = Sales.Customers.custid where Sales.Orders.orderdate IS NULL
GO

--Exercise 7:
--Return customers with orders placed on February 12, 2016, along with their orders: Tables involved:
--Sales.Customers and Sales.Orders
SELECT Sales.Customers.custid, Sales.Customers.companyname, Sales.Orders.orderid, Sales.Orders.orderdate
FROM Sales.Customers INNER JOIN Sales.Orders ON Sales.Orders.custid = Sales.Customers.custid WHERE Sales.Orders.orderdate = '20020102'
GO

--Exercise 8:
--Write a query that returns all customers in the output, but matches them with their respective orders only if
--they were placed on February 12, 2016: Tables involved: Sales.Customers and Sales.Orders
SELECT Sales.Customers.custid, Sales.Customers.companyname, Sales.Orders.orderid, Sales.Orders.orderdate
FROM Sales.Customers LEFT OUTER JOIN Sales.Orders ON Sales.Orders.custid = Sales.Customers.custid WHERE Sales.Orders.orderdate = '20020102' OR Sales.Orders.orderdate IS NULL
GO

--Exercise 10 (optional, advanced):
--Return all customers, and for each return a Yes/No value depending on whether the customer placed orders
--on February 12, 2016
SELECT CASE WHEN Sales.Orders.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END As HasOrderOn20020102,  Sales.Customers.custid, Sales.Customers.companyname From Sales.Customers
LEFT OUTER JOIN Sales.orders ON Sales.Orders.custid = Sales.Customers.custid AND Sales.Orders.orderdate = '20020102'
