USE [MyCompany]
GO
--1.Place an order with:Order number=202217 Order Amount=2000 Advance Paid=800
-- Order date=3/17/2022 Customer code=C202217 Agent Code=A202217 Order Description=COD
BEGIN TRANSACTION
INSERT INTO [dbo].[ORDERS]([ORD_NUM],[ORD_AMOUNT],[ADVANCE_AMOUNT],[ORD_DATE],[CUST_CODE],[AGENT_CODE],[ORD_DESCRIPTION])
ALUES (202217,2000,800,'3/17/2022', 202217,'A202217','COD')
COMMIT;
GO

--2.An order with Order ID=200120 is cancelled on the last minute but it is already added in the database.
--Remove that specific entry as it is of no use
BEGIN TRANSACTION;
DELETE FROM ORDERS
WHERE ORD_NUM = 200120;
COMMIT;

--3 The Description for Order ID=200103 has changed from SOD to COD. Make changes in the database accordingly.
BEGIN TRANSACTION
UPDATE ORDERS
SET ORD_DESCRIPTION = 'COD'
WHERE ORD_NUM = 200103;
COMMIT;

--4 Customer table has the column named CUST_NAME. Break that column and make two separate columns from it.
-- CUST_FIRST_NAME CUST_LAST_NAME
BEGIN TRAN
SELECT 
    CASE WHEN CHARINDEX(' ',CUST_NAME)>0 
         THEN SUBSTRING(CUST_NAME,1,CHARINDEX(' ',CUST_NAME)-1) 
         ELSE CUST_NAME end CUST_FIRST_NAME, 
    CASE WHEN CHARINDEX(' ',CUST_NAME)>0 
         THEN SUBSTRING(CUST_NAME,CHARINDEX(' ',CUST_NAME)+1,len(CUST_NAME))  
         ELSE NULL END as CUST_LAST_NAME
FROM  dbo.CUSTOMER 
COMMIT;

--5 COMMISSION Column of AGENTS is of no use for us. Remove that column.
BEGIN TRANSACTION;
ALTER TABLE AGENTS DROP COLUMN COMMISSION;
COMMIT;

--6. Mark a transaction where agent code=A001.
BEGIN TRANSACTION improve_grade WITH MARK N'AGENT_CODE = A001';
SELECT  * From AGENTS where AGENT_CODE = 'A001'
COMMIT TRANSACTION improve_grade;

--7. Delete those records from the table which have order amount greater than 1000 
-- and then ROLLBACK the changes in the database by keeping savepoints
BEGIN TRANSACTION;
Save Transaction SP;
DELETE FROM ORDERS
WHERE ORD_AMOUNT >1000;
ROLLBACK TRANSACTION SP;
COMMIT

-- 8. Write a named transaction to improve the grade of customers who have placed advance order amount.
BEGIN TRANSACTION improve_grade
UPDATE dbo.CUSTOMER 
SET GRADE=GRADE+1 
where CUST_CODE IN (SELECT CUST_CODE from dbo.ORDERS 
where ADVANCE_AMOUNT=ORD_AMOUNT) 
COMMIT TRANSACTION improve_grade;

--9 Write a transaction to change the order description to SOD if the order amount is less than 1000 or not. 
-- If it is true, ROLLBACK the transaction; otherwise, Commit it in Select statement.
BEGIN TRAN
IF EXISTS(select [ORD_AMOUNT] from dbo.ORDERS where ORD_AMOUNT<1000 or ORD_AMOUNT<>1000 )
BEGIN
  -- If the condition is TRUE then execute the following statement
	BEGIN TRANSACTION
	SAVE TRANSACTION SP1;
	UPDATE [dbo].[ORDERS]
		SET [ORD_DESCRIPTION]='SOD'
	ROLLBACK TRAN SP1;
	COMMIT
END
COMMIT

--10 Make a named transaction to update the agent working area to Bangalore 
-- if the agent name is Mukesh and ROLLBACK the changes in the database by keeping savepoints.
BEGIN TRANSACTION;
Save Transaction SP;
UPDATE AGENTS
SET WORKING_AREA = 'Bangalore' 
where (AGENT_NAME='Mukesh')
ROLLBACK TRANSACTION SP;
COMMIT