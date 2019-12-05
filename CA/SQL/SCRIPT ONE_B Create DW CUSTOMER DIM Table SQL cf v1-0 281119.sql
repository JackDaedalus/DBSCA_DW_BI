/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create a data warehouse Dimension table for the Northwind Traders CA */


/* Switch to data warehouse to create the Customer dimension table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


/*	------------------------------------------------------  	*/

/*	Create the Customer Dimension Table							    */

/*	------------------------------------------------------  	*/


CREATE TABLE dbo.dw_dimtblCustomer (
CustomerKey INT IDENTITY(1, 1) PRIMARY KEY, 
CustomerID NCHAR(5) NOT NULL,  
CustomerName NVARCHAR(40) NOT NULL, 
CustomerCity NVARCHAR(15) NULL,
CustomerRegion NVARCHAR(15) NULL,
CustomerCountry NVARCHAR(15) NULL
)

