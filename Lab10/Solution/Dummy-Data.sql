USE [BikeStores]
GO
--Insert 20000 rows in production.brands.
Declare @count int
SET @count = 1

While @count <= 20000
BEGIN 
   INSERT INTO production.brands (brand_name) values ('brand - ' + CAST(@count as nvarchar(10)))
   SET @count = @count + 1
END

--Insert 20000 rows in production.categories.
Declare @count1 int
SET @count1 = 1

While @count1 <= 20000
BEGIN 
   INSERT INTO production.categories (category_name) values ('category - ' + CAST(@count1 as nvarchar(10)))
   SET @count1 = @count1 + 1
END

--Insert 20000 rows in production.products.
Declare @RandomBrandId int
Declare @RandomCategoryId int
Declare @RandomModelYear int
Declare @RandomListPrice int

Declare @LowerLimitForBrandId int
Declare @UpperLimitForBrandId int

Set @LowerLimitForBrandId = 1
Set @UpperLimitForBrandId = 20009


Declare @LowerLimitForCategoryId int
Declare @UpperLimitForCategoryId int

Set @LowerLimitForCategoryId = 1 
Set @UpperLimitForCategoryId = 20007 

Declare @LowerLimitForModelYear int
Declare @UpperLimitForModelYear int

Set @LowerLimitForModelYear = 2016
Set @UpperLimitForModelYear = 2020

Declare @LowerLimitForListPrice int
Declare @UpperLimitForListPrice int

Set @LowerLimitForListPrice = 200
Set @UpperLimitForListPrice = 5000


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomBrandId = Round(((@UpperLimitForBrandId - @LowerLimitForBrandId) * Rand()) + @LowerLimitForBrandId, 0)
   Select @RandomCategoryId = Round(((@UpperLimitForCategoryId - @LowerLimitForCategoryId) * Rand()) + @LowerLimitForCategoryId, 0)
   Select @RandomModelYear = Round(((@UpperLimitForModelYear - @LowerLimitForModelYear) * Rand()) + @LowerLimitForModelYear, 0)
   Select @RandomListPrice = Round(((@UpperLimitForListPrice - @LowerLimitForListPrice) * Rand()) + @LowerLimitForListPrice, 0)


   INSERT INTO production.products(product_name,brand_id,category_id,model_year,list_price)
   values ('product - ' + CAST(@count as nvarchar(10)), @RandomBrandId, @RandomCategoryId, @RandomModelYear, @RandomListPrice)
   Print @count
   Set @count = @count + 1
End

--Insert 20000 rows in sales.stores.
Declare @RandomZipCode int

Declare @LowerLimitForZipCode int
Declare @UpperLimitForZipCode int

Set @LowerLimitForZipCode = 10000
Set @UpperLimitForZipCode = 99999

Declare @count int
SET @count = 1

While @count <= 20000
BEGIN  
   Select @RandomZipCode = Round(((@UpperLimitForZipCode - @LowerLimitForZipCode) * Rand()) + @LowerLimitForZipCode, 0)
   INSERT INTO sales.stores (store_name,phone,email,street,city,state,zip_code) 
   values ('store - ' + CAST(@count as nvarchar(10)),'phone-' + CAST(@count as nvarchar(10)),'email' + CAST(@count as nvarchar(10)) + '@bikes.shop',
   'street-' + CAST(@count as nvarchar(10)),'city-' + CAST(@count as nvarchar(10)),'s-' + CAST(@count as nvarchar(10)),@RandomZipCode)
   SET @count = @count + 1
END

--Insert 20000 rows into production.stocks
Declare @RandomStoreId int
Declare @RandomProductId int
Declare @RandomQuantity int


Declare @LowerLimitForStoreId int
Declare @UpperLimitForStoreId int

Set @LowerLimitForStoreId = 1
Set @UpperLimitForStoreId = 20003


Declare @LowerLimitForProductId int
Declare @UpperLimitForProductId int

Set @LowerLimitForProductId = 1 
Set @UpperLimitForProductId = 20321

Declare @LowerLimitForQuantity int
Declare @UpperLimitForQuantity int

Set @LowerLimitForQuantity = 0
Set @UpperLimitForQuantity = 100

Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomStoreId = Round(((@UpperLimitForStoreId - @LowerLimitForStoreId) * Rand()) + @LowerLimitForStoreId, 0)
   Select @RandomProductId = Round(((@UpperLimitForProductId - @LowerLimitForProductId) * Rand()) + @LowerLimitForProductId, 0)
   Select @RandomQuantity = Round(((@UpperLimitForQuantity - @LowerLimitForQuantity) * Rand()) + @LowerLimitForQuantity, 0)
   


   INSERT INTO production.stocks(store_id,product_id,quantity)
   values (@RandomStoreId, @RandomProductId, @RandomQuantity)
   Set @count = @count + 1
End

-- Insert 20000 rows into sales.customers.
Declare @RandomZipCode int

Declare @LowerLimitForZipCode int
Declare @UpperLimitForZipCode int

Set @LowerLimitForZipCode = 10000
Set @UpperLimitForZipCode = 99999

Declare @count int
SET @count = 1

While @count <= 20000
BEGIN  
   Select @RandomZipCode = Round(((@UpperLimitForZipCode - @LowerLimitForZipCode) * Rand()) + @LowerLimitForZipCode, 0)
   INSERT INTO sales.customers (first_name,last_name,phone,email,street,city,state,zip_code)
   values ('Fname-' + CAST(@count as nvarchar(10)),'Lname-' + CAST(@count as nvarchar(10)),'phone-' + CAST(@count as nvarchar(10)),'email' + CAST(@count as nvarchar(10)) + '@gmail.com',
   'street-' + CAST(@count as nvarchar(10)),'city-' + CAST(@count as nvarchar(10)),'s-' + CAST(@count as nvarchar(10)),@RandomZipCode)
   SET @count = @count + 1
END

-- Insert 20000 rows into sales.staffs.
Declare @RandomStoreId int
Declare @RandomManagerId int

Declare @LowerLimitForStoreId int
Declare @UpperLimitForStoreId int

Set @LowerLimitForStoreId = 1
Set @UpperLimitForStoreId = 20003

Declare @LowerLimitForManagerId int
Declare @UpperLimitForManagerId int

Set @LowerLimitForManagerId = 1
Set @UpperLimitForManagerId= 10

Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomStoreId = Round(((@UpperLimitForStoreId - @LowerLimitForStoreId) * Rand()) + @LowerLimitForStoreId, 0)
   Select @RandomManagerId = Round(((@UpperLimitForManagerId - @LowerLimitForManagerId) * Rand()) + @LowerLimitForManagerId, 0)

INSERT INTO sales.staffs(first_name,last_name,email,phone,active,store_id,manager_id)
     VALUES ('Fname-' + CAST(@count as nvarchar(10)),'Lname-' + CAST(@count as nvarchar(10)),'email' + CAST(@count as nvarchar(10)) + '@bikes.shop','phone-' + CAST(@count as nvarchar(10)),1,
	  @RandomStoreId, @RandomManagerId)
     Set @count = @count + 1
End

--Insert 20000 rows in sales.orders.
Declare @RandomCustomerId int
Declare @RandomOrderStatus int
Declare @RandomStoreId int
Declare @RandomStaffId int

Declare @LowerLimitForCustomerId int
Declare @UpperLimitForCustomerId int

Set @LowerLimitForCustomerId = 1
Set @UpperLimitForCustomerId = 21445


Declare @LowerLimitForOrderStatus int
Declare @UpperLimitForOrderStatus int

Set @LowerLimitForOrderStatus = 1 
Set @UpperLimitForOrderStatus = 5

Declare @LowerLimitForStoreId int
Declare @UpperLimitForStoreId int

Set @LowerLimitForStoreId = 1
Set @UpperLimitForStoreId = 20003

Declare @LowerLimitForStaffId int
Declare @UpperLimitForStaffId int

Set @LowerLimitForStaffId = 200
Set @UpperLimitForStaffId = 5000


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomCustomerId = Round(((@UpperLimitForCustomerId - @LowerLimitForCustomerId) * Rand()) + @LowerLimitForCustomerId, 0)
   Select @RandomOrderStatus = Round(((@UpperLimitForOrderStatus - @LowerLimitForOrderStatus) * Rand()) + @LowerLimitForOrderStatus, 0)
   Select @RandomStoreId = Round(((@UpperLimitForStoreId - @LowerLimitForStoreId) * Rand()) + @LowerLimitForStoreId, 0)
   Select @RandomStaffId = Round(((@UpperLimitForStaffId - @LowerLimitForStaffId) * Rand()) + @LowerLimitForStaffId, 0)


   INSERT INTO sales.orders(customer_id,order_status,order_date,required_date,shipped_date,store_id,staff_id)
   values (@RandomCustomerId, @RandomOrderStatus, '2019-07-01', '2019-07-01',NULL, @RandomStoreId, @RandomStaffId)
   Print @count
   Set @count = @count + 1
End

--Insert 20000 rows in sales.order_items.
Declare @RandomOrderId int
Declare @RandomItemId int
Declare @RandomProductId int
Declare @RandomQuantity int
Declare @RandomListPrice int
Declare @RandomDiscount int


Declare @LowerLimitForOrderId int
Declare @UpperLimitForOrderId int

Set @LowerLimitForOrderId = 1
Set @UpperLimitForOrderId = 21616


Declare @LowerLimitForItemId int
Declare @UpperLimitForItemId int

Set @LowerLimitForItemId = 1 
Set @UpperLimitForItemId = 30

Declare @LowerLimitForProductId int
Declare @UpperLimitForProductId int

Set @LowerLimitForProductId = 1 
Set @UpperLimitForProductId = 20321

Declare @LowerLimitForQuantity int
Declare @UpperLimitForQuantity int

Set @LowerLimitForQuantity = 0
Set @UpperLimitForQuantity = 10

Declare @LowerLimitForListPrice int
Declare @UpperLimitForListPrice int

Set @LowerLimitForListPrice = 200
Set @UpperLimitForListPrice = 4000

Declare @LowerLimitForDiscount int
Declare @UpperLimitForDiscount int

Set @LowerLimitForDiscount = 0.01
Set @UpperLimitForDiscount = 0.30

Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomOrderId = Round(((@UpperLimitForOrderId - @LowerLimitForOrderId) * Rand()) + @LowerLimitForOrderId, 0)
   Select @RandomItemId = Round(((@UpperLimitForItemId - @LowerLimitForItemId) * Rand()) + @LowerLimitForItemId, 0)
   Select @RandomProductId = Round(((@UpperLimitForProductId - @LowerLimitForProductId) * Rand()) + @LowerLimitForProductId, 0)
   Select @RandomQuantity = Round(((@UpperLimitForQuantity - @LowerLimitForQuantity) * Rand()) + @LowerLimitForQuantity, 0)   
   Select @RandomListPrice = Round(((@UpperLimitForListPrice - @LowerLimitForListPrice) * Rand()) + @LowerLimitForListPrice, 0)
   Select @RandomDiscount = Round(((@UpperLimitForDiscount - @LowerLimitForDiscount) * Rand()) + @LowerLimitForDiscount, 0)
   


   INSERT INTO sales.order_items(order_id,item_id,product_id,quantity,list_price,discount)
   values (@RandomOrderId, @RandomItemId, @RandomProductId,@RandomQuantity,@RandomListPrice,@RandomDiscount)
   Set @count = @count + 1
End
