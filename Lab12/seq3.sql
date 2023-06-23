USE Northwind
GO
-- Create a table with ID and Productname using IDENTITY that is incremented by 3 for each row.

CREATE TABLE Product_id_name  
(  
 id_num int IDENTITY(1,3),  
 product_name varchar (20),    
); 
INSERT INTO Product_id_name values ('saba');
INSERT INTO Product_id_name values ('amna');
INSERT INTO Product_id_name values ('kiran');
SELECT * from Product_id_name;