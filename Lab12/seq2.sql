USe Northwind
GO
DROP SEQUENCE FirstMultiplesOf10;

CREATE SEQUENCE FirstMultiplesOf10
    AS INT
    START WITH 10
    INCREMENT BY 10;

CREATE TABLE table10(
     table_ten int
);
INSERT INTO table10 values (NEXT VALUE FOR FirstMultiplesOf10);
GO 10

SELECT * from table10;
