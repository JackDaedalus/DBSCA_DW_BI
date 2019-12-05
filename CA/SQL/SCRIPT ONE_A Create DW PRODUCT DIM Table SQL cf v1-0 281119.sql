/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create the data warehouse Dimension tables for the Northwind Traders CA */


/* Switch to data warehouse to create the dimension and fact tables */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


/*	------------------------------------------------------  	*/

/*	Create the Dimension Tables							    */

/*	------------------------------------------------------  	*/


--Create Product Dimensions
CREATE TABLE dbo.dw_dimtblProduct (
ProductKey INT IDENTITY(1, 1) PRIMARY KEY,
ProductID INT NOT NULL,  
ProductName NVARCHAR(40) NOT NULL, 
CategoryName NVARCHAR(15) NOT NULL,
QuantityPerUnit NVARCHAR(20) NULL,
UnitPrice SMALLMONEY NULL CONSTRAINT "Products_UnitPrice" DEFAULT (0),
UnitsInStock SMALLINT NULL CONSTRAINT "Products_UnitsInStock" DEFAULT (0),
Discontinued BIT NOT NULL
)

