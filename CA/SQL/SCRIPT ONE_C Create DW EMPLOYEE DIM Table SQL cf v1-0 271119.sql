/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create a data warehouse Dimension table for the Northwind Traders CA */


/* Switch to data warehouse to create the Employee dimension table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO

/*	------------------------------------------------------  	*/

/*	Create the Employee Dimension Tables							    */

/*	------------------------------------------------------  	*/


CREATE TABLE dbo.dw_dimtblEmployee (
EmployeeKey INT IDENTITY(1, 1) PRIMARY KEY,
EmployeeID INT NOT NULL,
EmployeeName NVARCHAR(85) NOT NULL, 
Title NVARCHAR(30) NULL,
HireDate DATETIME NULL ,
EmployeeCity NVARCHAR(15) NULL,
EmployeeRegion NVARCHAR(15) NULL, 
EmployeeCountry NVARCHAR(15) NULL
)
