-- 2. Create another table SecondMultiplesof10 that contains the 10- 20 multiples of 10 using the same 
-- sequence that was generated in the previous question. Display the table.
USe Northwind
GO

CREATE TABLE SecondMultiplesof10(
     table_ten_twenty int
);
INSERT INTO SecondMultiplesof10 values (NEXT VALUE FOR FirstMultiplesOf10);
GO 10

SELECT * from SecondMultiplesof10;
