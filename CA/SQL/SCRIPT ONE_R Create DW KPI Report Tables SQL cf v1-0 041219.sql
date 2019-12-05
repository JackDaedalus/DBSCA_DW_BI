/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create tables used to stored KPI Report data for use in Tableau */


/* Switch to data warehouse to create the KPI Report table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


/*	------------------------------------------------------  	*/

/*	Create the KPI Report Table - to capture Sales report data for use in 
	Tableau Dashboards. The Employee Sales KPI data is generated using SQL
	Scripts called by the SSIS process.

	This scripts creates the tables that are populated by SQL and then 
	reads as a CustomSQL data source in Tableau.				*/

/*	------------------------------------------------------  	*/

/*
DROP TABLE dw_rpttblHalfYearlySales
*/


CREATE TABLE dw_rpttblHalfYearlySales (
HalfYearSalesID INT IDENTITY(1, 1) PRIMARY KEY,
YearNumber  INT NOT NULL,
HalfYearNum  VARCHAR (15) NOT NULL,
NetTotalAmt MONEY NOT NULL DEFAULT (0),
GrowthRate FLOAT NOT NULL
)




CREATE TABLE tmpAvgSalesByYear(
Yr int,
AvgEmpSales MONEY
)


CREATE TABLE dw_rpttblEmpSalesDiffFromAvg (
empKey int,
EmpName varchar(50),
Yr int,
NtSalesTot MONEY,
PctDiff float
)
