/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/

/* 
	SQL to populate Employee Net Sales Average KPI Report data for 
	use in Tableau. 
	
	It is easier to perform these calculations in SQL, which is invoked by 
    the SSIS process and then read the result set into Tableau for display.	
	
	This script is split over multiple 'Execute SQL Tasks' in SSIS, as this 
	makes it easier to debug.
	
	
*/

/* Switch to data warehouse to create the KPI Report table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


/* 
	This first SQL segment finds the average Net Sales amount per Seller (employee) in each year.
	
	This value is used a baseline to compare individual seller performance in each year.
	
	The logic is to display the percentage value that the seller is above (or below) the average seller 
	amount for a given year.
	
*/

INSERT INTO tmpAvgSalesByYear(
Yr,
AvgEmpSales
)
SELECT Sales_Year, avg(Total) as 'Employee Avg Across all Years' from (
	select time.YearNumber as 'Sales_Year', emp.EmployeeKey as 'EmpKey', emp.EmployeeName, sum(NetTotal) as Total
	from 
	dw_facttblSales fact, 
	dw_dimtblTimeDate time,
	dw_dimtblEmployee emp
	where fact.OrderDateKey = time.DateKey
	and emp.EmployeeKey = fact.EmployeeKey
	group by time.YearNumber, emp.EmployeeKey, emp.EmployeeName
) b
group by Sales_Year





/*
	
	Using the average for sellers in each year 1996, 1997, 1998 calculate how each seller
	has performed against this average. The dataset will be read in Tableau, through custom SQL,
	into a heat table. Variances for each seller from the average for each year will be displayed
	as a percentage.

*/

INSERT INTO dw_rpttblEmpSalesDiffFromAvg (
empKey,
EmpName,
Yr,
NtSalesTot,
PctDiff
)
	select emp.EmployeeKey as 'EmpKey', emp.EmployeeName, time.YearNumber as 'Year', sum(NetTotal) as Total, 0 as PctDiff
	from 
	dw_facttblSales fact, 
	dw_dimtblTimeDate time,
	dw_dimtblEmployee emp
	where fact.OrderDateKey = time.DateKey
	and emp.EmployeeKey = fact.EmployeeKey
	group by emp.EmployeeKey, emp.EmployeeName, time.YearNumber
	order by emp.EmployeeKey



/*

	This SQL loop goes through the table created with a record for each seller, for each year on
	their sales total and calculates a percentage for that sales amount above or below the average 
	for that year.

*/

declare @SalesYr int
declare @EmployNum int
declare @AvgYearSales Money



select @SalesYr = 1996


WHILE @SalesYr <> 1999
BEGIN
	print 'loop-de-firstloop';
	SELECT @AvgYearSales = (SELECT AvgEmpSales FROM tmpAvgSalesByYear WHERE Yr = @SalesYr)
	select @EmployNum = 1

	WHILE @EmployNum <> 10
	BEGIN
		print 'loop-de-2ndloop';
		Update dw_rpttblEmpSalesDiffFromAvg
		SET PctDiff = ((NtSalesTot / @AvgYearSales)-1)
		WHERE empKey = @EmployNum
		AND Yr = @SalesYr

		SET @EmployNum = @EmployNum + 1
	END

	SET @SalesYr = @SalesYr + 1
	
END;



