CREATE DATABASE lab9;

CREATE TABLE countries( -- Only continent name in country table can be left empty while data entry.
    code int NOT NULL UNIQUE,
    name varchar NOT NULL,
	continent_name   varchar UNIQUE,
	CONSTRAINT Code_PK PRIMARY KEY(code)
);
CREATE TABLE Users (  -- Email address of any user should be valid
    id int  NOT NULL UNIQUE,
    full_name varchar,
	email   varchar,
	gender varchar,
	date_of_birth varchar,
	country_code int NOT NULL,
    created_at varchar,
	CONSTRAINT uid_PK PRIMARY KEY(id),
	CONSTRAINT country_FK FOREIGN KEY (country_code) REFERENCES countries(code),
	CONSTRAINT email CHECK (email LIKE '%@gmail.com')
);

CREATE TABLE Orders(   
    id int NOT NULL UNIQUE,
    user_id int NOT NULL,
    status varchar,
    created_at varchar,
	CONSTRAINT order_id PRIMARY KEY(id),
	CONSTRAINT user_id_FK FOREIGN KEY (user_id) REFERENCES Users(id)
	
);
GO
CREATE FUNCTION dbo.Indian_merchant_banned (@country_code int)
RETURNS VARCHAR(5)
AS
BEGIN
    IF (@country_code NOT IN (SELECT code from countries where name = 'India' ))
        return 'True'
    return 'False'
END
GO

CREATE TABLE merchants (  -- Merchants from India are banned. 
    id int NOT NULL UNIQUE,
    merchant_name varchar,
	admin_id   int NOT NULL,
	country_code int NOT NULL,
    created_at varchar,
	CONSTRAINT mid_PK PRIMARY KEY(id),
	CONSTRAINT country_FK FOREIGN KEY (country_code) REFERENCES countries(code),
	CONSTRAINT uid_FK FOREIGN KEY (admin_id) REFERENCES Users(id),
    CONSTRAINT Indians_banned CHECK (dbo.indian_merchant_banned(country_code) = 'True')
);

CREATE TABLE product ( --Valid product statuses: A: Available (at least 50 items available), NA: (if less than 50 items of same 
                        -- product are available, then product cannot be sold)
    id int NOT NULL UNIQUE,
    merchant_id int NOT NULL,
	name  varchar,
	price int,
    status varchar,
	quantity int,
    created_at varchar,
	CONSTRAINT product_id_PK PRIMARY KEY(id),
	CONSTRAINT merchant_id_FK FOREIGN KEY (merchant_id) REFERENCES merchants(id),
	CONSTRAINT valid_product_status CHECK (status = case when quantity >= 50 then 'A'
	                     else 'NA' end)
);
CREATE TABLE order_item (   -- Customer cannot order less than 50 items of same product. 
    order_id int NOT NULL ,
    product_id int NOT NULL,
    quantity int,
	CONSTRAINT order_id_FK FOREIGN KEY (order_id) REFERENCES orders(id),
	CONSTRAINT product_id_FK FOREIGN KEY (product_id) REFERENCES product(id),
	CHECK (quantity >=50)

);






