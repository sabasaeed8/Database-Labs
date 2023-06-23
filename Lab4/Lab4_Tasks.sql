USE [dublinbikes]
GO
--1. Give the list of all stations (Station Name) from where the rides were taken in year 2004.
SELECT Address AS StationName FROM dbo.Stations Where Station_ID IN 
(Select Station_ID from Bike_Rentals Where Customer_ID IN 
(Select Customer_ID from Payments Where YEAR(date_stamp) = 2004 ))
ORDER BY StationName
GO
 
--2. Give the total repairing cost of each bike. Schema should be like this. (Bike Id, Repairing Cost)
SELECT DISTINCT dbo.Bikes.Bike_ID, 
(Select SUM(dbo.Repairs.Price) from Repairs Where B_Status_ID IN 
(Select B_Status_ID From Bike_Status Where Bike_Status.Bike_ID = Bikes.Bike_ID )) AS TotalCost 
FROM Bikes,Repairs WHERE Bike_ID IN
(SELECT Bike_ID From Bike_Status Where B_Status_ID IN 
(Select B_Status_ID From Repairs)) 
GO

--3. Bikes of which station are need most repairing. Give the station name.
SELECT TOP(1) Address AS StationName
FROM Stations Where Station_ID IN 
(Select Station_ID from Bikes Where Station_ID IN 
(Select B_Status_ID from Bike_Status Where Bike_ID IN
(Select B_Status_ID from Repairs))) 
GROUP BY Stations.Address
GO

--4. How many bikes are owned by each station? Schema should be (StationName, TotalBikes)
SELECT Stations.Station_ID AS StationID, 
(Select COUNT(Bikes.Bike_ID) from Bikes Where Station_ID = Stations.Station_ID ) AS TotalBikes 
FROM Stations WHERE Stations.Station_ID IN 
(Select Station_ID from Bikes) 

--5. Given the name customers who never rented a bike. Schema is as follow. (CustomerFullName)
SELECT concat(Lname,' ',Fname) AS CustomerFullName 
FROM Customer_Details WHERE Customer_ID NOT IN
(SELECT Customer_ID FROM Bike_Rentals );

--6. Give the bike ids of those bikes who were renter after year 2016.
SELECT DISTINCT(Bikes.Bike_ID) 
FROM Bikes Where Bike_ID IN 
(Select Bike_ID From Bike_Rentals Where Customer_ID IN 
(Select Customer_ID From Payments WHERE YEAR(Date_stamp)>'2016'))

--7. Identify the customers who always pay using mastercard. Give the full name of customers.
SELECT concat(Lname,' ',Fname) AS CustomerFullName 
FROM Customer_Details WHERE Customer_ID  IN
(SELECT Customer_ID FROM Payments WHERE Method_ID=5);

--8. For which station (Station Name) the most bikes are moved using vans in year 2015.
SELECT DISTINCT Location 
FROM Stations Where Station_ID IN 
(Select Station_ID from Vans WHERE year(Vans.Date_stamp)=2015) ORDER BY Location

--9. Give the average cost of repairing that was spent on each bike. Schema includes (BikeId, AverageCost)
SELECT DISTINCT Bikes.Bike_ID, 
(Select AVG(Repairs.Price) from Repairs Where B_Status_ID IN 
(select B_Status_ID from Bike_Status Where Bike_Status.Bike_ID = Bikes.Bike_ID) ) AS AvgCost 
FROM Bikes Where Bike_ID IN 
(Select Bike_ID from Bike_Status Where B_Status_ID IN 
(Select B_Status_ID from Repairs)) 
GO 
 
--10. Give the BikeIds which were repaired in at last 5 year.
Select Bike_ID AS BikesRepairInAtLast5Years 
From Bikes Where Bike_ID IN 
(Select Bike_ID from Bike_Status Where B_Status_ID IN 
(Select B_Status_ID from Repairs Where Delivered > DATEADD(year,-5,GETDATE())))
