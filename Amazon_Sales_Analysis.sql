SELECT *
FROM Amazon;

-- Checking Amount Of Records 
SELECT COUNT (*) AS TotalRows
FROM Amazon;


--Checking for unique orders
SELECT COUNT (DISTINCT OrderID) AS UniqueOrders
FROM Amazon;

SELECT COUNT (DISTINCT CustomerID) AS UniqueCustomers
FROM Amazon;


--Checking for missing values
SELECT COUNT(*) AS MissingOrderDates
FROM Amazon
WHERE OrderDate is NULL;

SELECT COUNT(*) AS MissingCustomerID
FROM Amazon
WHERE CustomerID is NULL;

SELECT COUNT(*) AS MissingProductID
FROM Amazon
WHERE ProductID is NULL;

SELECT COUNT(*) AS MissinTotalAmount
FROM Amazon
WHERE TotalAmount is NULL;


--The Total Revenue
SELECT
	SUM(TotalAmount) AS TotalRevenue
FROM Amazon;


--Average Order Values
SELECT
	AVG(TotalAmount) AS AverageOrderValues
FROM Amazon;

--Checking the date range
SELECT
	MIN(OrderDate) AS FirstOrderDate,
	MAX(OrderDate) AS LastOrderDate
FROM Amazon;

--Revenue by Year
SELECT
	YEAR(OrderDate) AS SalesYear,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;


--Monthly Sales
SELECT 
	YEAR(OrderDate) AS SalesYear,
	Month(OrderDate) AS SalesMonth,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY 
	YEAR(OrderDate),
	Month(OrderDate)
ORDER BY
	SalesYear,
	SalesMonth;

SELECT 
	Month(OrderDate) AS SalesMonth,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY Month(OrderDate)
ORDER BY SalesMonth;


--Highest Revenue by Month
SELECT TOP 1
	Month(OrderDate) AS SalesMonth,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY Month(OrderDate)
ORDER BY Revenue DESC;


--Lowest Revenue by Month
SELECT TOP 1
	Month(OrderDate) AS SalesMonth,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY Month(OrderDate)
ORDER BY Revenue ASC;


--Customers Performers
SELECT TOP 10
	CustomerID,
	CustomerName,
	COUNT(*) AS NumberOfOders,
	SUM(TotalAmount) AS TotalSpent
FROM Amazon
GROUP BY 
	CustomerID,
	CustomerName
ORDER BY TotalSpent DESC;


--Customers who palced more than one order
SELECT
	COUNT (*) AS RepeatCustomers
FROM (
	SELECT CustomerID
	FROM Amazon
	GROUP BY CustomerID
	HAVING COUNT(*) > 1
) AS CustomerOrders;


SELECT
	NumbersOfOrders,
	COUNT (*) AS NumbersOfCustomers
FROM (
	SELECT 
		CustomerID,
	COUNT(*) AS NumbersOfOrders
	FROM Amazon
	GROUP BY CustomerID
) AS CustomerOrdersCounts
GROUP BY NumbersOfOrders
Order BY NumbersOfOrders;


--Product Performers
SELECT TOP 10
	ProductID,
	ProductName,
	SUM(Quantity) AS UnitSold,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY 
	ProductID,
	ProductName
ORDER BY  Revenue DESC;


--Analyzing Categories
SELECT
	Category,
	SUM(Quantity) AS UnitSold,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY Category
ORDER BY Revenue DESC; 


--Category Profitability/Average Order values
SELECT
	Category,
	SUM(Quantity) AS UnitSold,
	SUM(TotalAmount) AS Revenue,
	SUM(TotalAmount) / SUM(Quantity) AS RevenuePerUnit
FROM Amazon
GROUP BY Category
ORDER BY RevenuePerUnit;


--Sellar Performers
SELECT TOP 10
	SellerID,
	COUNT(*) AS NumberOfOrders,
	SUM(Quantity) AS UnitSold,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY SellerID
ORDER BY Revenue DESC;


--Total Number Of Sellars
SELECT 
	COUNT(DISTINCT SellerID) AS TotalSellers
FROM Amazon;


--The Percentage That Comes Out From The Top 10 Sellers
SELECT 
	SUM(Revenue) AS Top10Revenue,
	(SUM(Revenue) / (SELECT SUM(TotalAmount) FROM 
Amazon)) * 100 AS Top10RevenuePercentage
FROM (
	SELECT TOP 10
		SellerID,
		SUM(TotalAmount) AS Revenue
	FROM Amazon
	GROUP BY SellerID
	ORDER BY Revenue DESC
) AS TopSellers;


--Geographical Analysis
SELECT
	Country,
	COUNT(*) AS NumberOfOrders,
	SUM(Quantity) AS UnitSold,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY Country
ORDER BY Revenue DESC;


--Cities Generating The Most Revenue
SELECT TOP 10
	City,
	Country,
	COUNT(*) AS NumberOfOders,
	SUM(Quantity) AS UnitsSold,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY
	City,
	Country
ORDER BY Revenue DESC;


--Analyzing Payment Method
SELECT
	PaymentMethod,
	COUNT(*) AS NumberOfOrders,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY PaymentMethod
ORDER BY Revenue DESC;


-- Completed Orders
SELECT
	OrderStatus,
	COUNT(*) AS NumberOfOrders,
	SUM(TotalAmount) AS Revenue
FROM Amazon
GROUP BY OrderStatus
ORDER BY NumberOfOrders DESC;