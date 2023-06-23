-- 2019-CE-04 (SABA) Lab4
USE BikeStores
GO

--1. Give the names of customers whose orders were delayed. Your answer should have the following schema. 
--Customers(CustomerId, CustomerName) 
SELECT DISTINCT customer_id,first_name AS CustomerName
FROM sales.customers WHERE customer_id IN 
(SELECT DISTINCT customer_id from sales.orders WHERE shipped_date>required_date) 
GO

--2. Give the products details with its brand name. Products(ProductName, SupplierName) 
SELECT product_name, 
(Select brand_name from production.brands where production.brands.brand_id = production.products.brand_id) AS BrandName
FROM production.products 
ORDER BY BrandName
GO

--3. Give the name of top products which have highest sale in the year 2019. 
SELECT product_name AS ProductsHighestSaleIn2019
FROM production.products 
Where product_id IN 
(Select product_id from sales.order_items where order_id IN 
(select order_iD from sales.orders where sales.order_items.quantity= (SELECT MAX(sales.order_items.quantity) FROM sales.order_items WHERE YEAR(sales.orders.order_date) = 2019))) 
GO

--4. Give the name of staff with its manager name. Schema should have the following schema. 
--(EmployeeName, ManagerName) 
SELECT TOP 50 CONCAT(emp.first_name,' ',emp.last_name) AS StaffName, 
(SELECT CONCAT(mng.first_name,' ',mng.last_name) from sales.staffs mng where emp.manager_id= mng.staff_id) AS ManagerName 
FROM sales.staffs emp,sales.staffs mng where emp.manager_id= mng.staff_id
ORDER BY emp.first_Name,emp.last_name
GO

--5. Give the full names of managers who have greater than two employees. 
SELECT CONCAT(mng.first_name,' ',mng.last_name) AS ManagerNameLessThan2Employee
FROM sales.staffs mng Where staff_id IN 
(Select manager_id from sales.staffs emp WHERE (SELECT COUNT(sales.staffs.manager_id) FROM sales.staffs WHERE sales.staffs.manager_id=mng.staff_id) > 2)
GO

--6. List all the products whose price is more than average price. 
SELECT product_id, product_name AS ProductPriceMoreThanAvgPrice  
FROM production.products 
WHERE list_price > (SELECT AVG(list_price) FROM production.products)
GO

--7. Find second highest priced product without using TOP statement 
SELECT a.product_id, a.product_name AS SecondHighestPricedProduct 
FROM production.products a
WHERE (SELECT COUNT(DISTINCT list_price) FROM production.products b WHERE a.list_price<=b.list_price) = 2
GO

 
--8. List the names of products which were ordered on 1 March 2016.
SELECT product_name AS OrderedOn1March2016
FROM production.products 
Where product_id IN 
(Select product_id from sales.order_items where order_id IN 
(select order_id from sales.orders where sales.orders.order_date = '20160103'))
GO

--9. List the names of suppliers whose supplied products were ordered in 2017. 
SELECT DISTINCT sales.staffs.first_name AS SuppliersWhoseSuppliedProductsOrderedIn2017
from sales.staffs where staff_id IN 
(Select staff_id from production.products Where product_id IN 
(Select product_id from sales.order_items Where order_id IN 
(Select order_id From sales.orders WHERE YEAR(sales.Orders.Order_Date) = 2017)))
GO

--10. Give the name of products which were not ordered in 2019.SELECT DISTINCT production.products.product_name AS ProductsNOTOrderedIn1996
from production.products Where product_id IN 
(Select product_id From sales.order_items Where order_id IN 
(Select order_id from sales.orders Where YEAR(order_date) = 2019 ))
ORDER BY product_name 
GO