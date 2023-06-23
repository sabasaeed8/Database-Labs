USE [BikeStores]
GO
-- Name of Products whose Price is greater than avg price.
CREATE VIEW productsHavingPriceGreaterThanAvgPrices AS
SELECT product_name, list_price
FROM production.products
WHERE list_price >(SELECT AVG(list_price) FROM production.products)
GO
-- Products quantity greater than 20.
CREATE VIEW AvailableStock AS
SELECT product_name, quantity
FROM production.products,production.stocks
WHERE production.stocks.quantity >20
GO

-- Customer name and city and phone
CREATE VIEW CustomerInfo AS
SELECT first_name,phone,city
FROM sales.customers
GO

-- Discount greater than 0.20
CREATE VIEW discount AS
SELECT product_id,list_price
FROM sales.order_items
where discount > 0.20
GO

CREATE VIEW StaffInfo AS
SELECT first_name,email,phone
FROM sales.staffs
GO
