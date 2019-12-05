/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create a data warehouse Dimension table for the Northwind Traders CA */


/* Switch to data warehouse to create the Time dimension table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO

/*	------------------------------------------------------  	*/

/*	Create the Time Dimension Tables							    */

/*	------------------------------------------------------  	*/

CREATE TABLE dbo.dw_dimtblTimeDate (
DateKey  INT NOT NULL PRIMARY KEY,
CalendarDate  DATE NOT NULL,
FullDateDesc VARCHAR(60) NOT NULL,
DayNumber  INT NOT NULL,
WeekdayName VARCHAR(15) NOT NULL,
WeekNumber  INT NOT NULL,
CalMonthNumber  INT NOT NULL,
CalMonthName  VARCHAR (15) NOT NULL,
QuarterNumber  INT NOT NULL,
YearNumber  INT NOT NULL 
)

