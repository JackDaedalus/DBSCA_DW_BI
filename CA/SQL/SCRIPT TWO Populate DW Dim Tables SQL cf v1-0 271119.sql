/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* 

SQL to populate the data warehouse Dimension tables for the Northwind Traders CA 

*/



/* Switch to data warehouse to populate the dimension tables */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO

/*	------------------------------------------------------  	*/

/*	Populate the Dimension Tables							    */

/*	------------------------------------------------------  	*/


-----------------------------------------------------------------
--				POPULATE PRODUCT DIMENSIONS					--
----------------------------------------------------------------

INSERT dw_dimtblProduct (ProductID, ProductName, CategoryName, QuantityPerUnit, UnitPrice, UnitsInStock, Discontinued)
SELECT  
ProductID,
ProductName,
CategoryName,
QuantityPerUnit,
UnitPrice,
UnitsInStock,
discontinued
FROM Northwind.dbo.Products
INNER JOIN Northwind.dbo.Categories
ON Northwind.dbo.Products.CategoryID = Northwind.dbo.Categories.CategoryID


------------------------------------------------------------------
--				POPULATE CUSTOMER DIMENSIONS				--
------------------------------------------------------------------
INSERT dw_dimtblCustomer ( CustomerID, CustomerName, CustomerCity, CustomerRegion, CustomerCountry)
SELECT
customerid,
companyname, 
city, 
region,
country
FROM Northwind.dbo.Customers



-----------------------------------------------------------------
--				POPULATE EMPLOYEE DIMENSIONS				--
-----------------------------------------------------------------
INSERT dw_dimtblEmployee (EmployeeID, EmployeeName, Title, HireDate, EmployeeCity, EmployeeRegion, EmployeeCountry)
SELECT
EmployeeID,
TitleOfCourtesy + ' ' + FirstName + ' ' + LastName AS EmployeeName, 
title,
HireDate,
city, 
region,
country
FROM Northwind.dbo.Employees


---------------------------------------------------------------------------------------
--				POPULATE DATE DIMENSIONS					--
---------------------------------------------------------------------------------------
DECLARE
@start_date_dt SMALLDATETIME, 
@end_date_dt SMALLDATETIME,
@sql_string NVARCHAR(1024), 
@DateKey INT, 
@calendar_date_dt DATE, 
@FullDateDesc VARCHAR(60), 
@WeekDayName VARCHAR(10), 
@DayNumber INT, 
@calendar_day_of_year_num INT, 
@WeekNumber INT, 
@CalMonthNumber INT, 
@CalMonthName VARCHAR(10), 
@QuarterNumber INT, 
@YearNumber INT

SET @calendar_date_dt = '1996-07-04'
SET @end_date_dt = '1998-06-11'

WHILE (@calendar_date_dt <= @end_date_dt) 
BEGIN

	SELECT
		@WeekDayName = DATENAME(WEEKDAY, @calendar_date_dt), 
		@DayNumber = DATEPART(DD, @calendar_date_dt), 
		@calendar_day_of_year_num = DATEPART(DY, @calendar_date_dt), 
		@WeekNumber = DATEPART(WK, @calendar_date_dt), 
		@CalMonthNumber = DATEPART(M, @calendar_date_dt), 
		@CalMonthName = DATENAME(MONTH, @calendar_date_dt), 
		@QuarterNumber = DATEPART(QQ, @calendar_date_dt), 
		@YearNumber = DATEPART(YYYY, @calendar_date_dt), 
		@DateKey = CAST(CAST(@YearNumber AS VARCHAR) + RIGHT('00' + CAST(@calendar_day_of_year_num AS VARCHAR), 3) AS INT),
		@FullDateDesc = @CalMonthName + ' ' + CAST(@DayNumber AS VARCHAR) + ', ' + CAST(@YearNumber AS VARCHAR)
	
	SELECT @sql_string =
		'INSERT INTO dbo.dw_dimtblTimeDate' +
		' (' +
		'DateKey, ' +
		'CalendarDate, ' +
		'FullDateDesc, ' +
		'DayNumber,' +
		'WeekDayName,' +
		'WeekNumber,' +
		'CalMonthNumber,' +
		'CalMonthName,' +
		'QuarterNumber, ' +
		'YearNumber' +
		') ' +
		'VALUES ' +
		'(' +
		CHAR(39) + CAST(@DateKey AS VARCHAR) + CHAR(39) + ',' +
		CHAR(39) + CAST(@calendar_date_dt AS VARCHAR) + CHAR(39) + ',' +
		CHAR(39) + @FullDateDesc + CHAR(39) + ',' +
		CAST(@DayNumber AS VARCHAR) + ',' +
		CHAR(39) + @WeekDayName + CHAR(39) + ',' +
		CAST(@WeekNumber AS VARCHAR) + ',' +
		CAST(@CalMonthNumber AS VARCHAR) + ',' +
		CHAR(39) + @CalMonthName + CHAR(39) + ',' +
		CAST
		(@QuarterNumber AS VARCHAR) + ',' +
		CAST(@YearNumber AS VARCHAR) + ')'

	EXEC sp_executesql @sql_string

	SET @calendar_date_dt = DATEADD(day,1,@calendar_date_dt)

END



