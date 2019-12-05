/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/




/* SQL to validate the data warehouse contents against the the Northwind Traders DB */



/* Switch to data warehouse to validate the table counts */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


---------------------------------------------------------------------------------------
--		Count Number of Records in Order Details table
---------------------------------------------------------------------------------------
USE Northwind
SELECT count(*) as "Nbr Records"
FROM dbo.[Order Details]


---------------------------------------------------------------------------------------
--		Count Number of Records in Sales Fact table
---------------------------------------------------------------------------------------
USE dbs_dwbi_ca_cf_nthwd_dw
SELECT count(*) as "Nbr Records"
FROM dbo.dw_facttblSales


---------------------------------------------------------------------------------------
--		AGGREGATE NET TOTAL BY QUARTER IN NORTHWIND OPERATIONAL DB	  	--
---------------------------------------------------------------------------------------
USE Northwind
SELECT		DATEPART(yyyy,[OrderDate]) AS SaleYr,
		CASE WHEN MONTH([OrderDate]) In (1,2,3) Then 'Q1' 
              WHEN MONTH([OrderDate]) In (4,5,6) Then 'Q2' 
              WHEN MONTH([OrderDate]) In (7,8,9) Then 'Q3' 
              ELSE 'Q4' End AS SaleQuarter,
		Sum(dbo.[Order Subtotals].Subtotal) AS SaleAmount
FROM        dbo.Orders INNER JOIN dbo.[Order Subtotals] ON dbo.Orders.OrderID = dbo.[Order Subtotals].OrderID 
GROUP BY    DATEPART(yyyy,[OrderDate]), 
            CASE WHEN MONTH([OrderDate]) In (1,2,3) Then 'Q1' 
            WHEN MONTH([OrderDate]) In (4,5,6) Then 'Q2' 
            WHEN MONTH([OrderDate]) In (7,8,9) Then 'Q3' 
            ELSE 'Q4' End
ORDER BY	SaleYr


---------------------------------------------------------------------------------------
--		AGGREGATE NET TOTAL BY QUARTER IN NORTHWIND DATA WAREHOUSE		--
---------------------------------------------------------------------------------------
USE dbs_dwbi_ca_cf_nthwd_dw
SELECT	YearNumber, 
	QuarterNumber, 
	sum(NetTotal)
FROM	dbo.dw_facttblSales INNER JOIN dbo.dw_dimtblTimeDate ON dbo.dw_facttblSales.OrderDateKey = dbo.dw_dimtblTimeDate.DateKey
GROUP BY YearNumber, QuarterNumber
ORDER BY YearNumber, QuarterNumber
