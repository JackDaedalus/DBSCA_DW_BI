/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to create the data warehouse Fact tables for the Northwind Traders CA */


/* Switch to data warehouse to create the Fact table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


/*	------------------------------------------------------  	*/

/*	Create the Fact Table - to capture Sales measurements	    */

/*	------------------------------------------------------  	*/

CREATE TABLE dw_facttblSales (
FactID INT IDENTITY(1, 1) PRIMARY KEY,
ProductKey INT NOT NULL,
CustomerKey INT NOT NULL, 
EmployeeKey INT NOT NULL, 
OrderDateKey INT NOT NULL,
OrderQuantity SMALLINT NOT NULL CONSTRAINT "SalesFact_Quantity" DEFAULT (1),
GrossTotal SMALLMONEY NOT NULL CONSTRAINT "SalesFact_GrossTotal" DEFAULT (0),
DiscountTotal SMALLMONEY NOT NULL CONSTRAINT "SalesFact_Discount" DEFAULT (0),
NetTotal SMALLMONEY NOT NULL CONSTRAINT "SalesFact_NetTotal" DEFAULT (0),
DaysToShip INT NULL,
FOREIGN KEY (ProductKey) REFERENCES dw_dimtblProduct(ProductKey),
FOREIGN KEY (CustomerKey) REFERENCES dw_dimtblCustomer(CustomerKey),
FOREIGN KEY (EmployeeKey) REFERENCES dw_dimtblEmployee(EmployeeKey),
FOREIGN KEY (OrderDateKey) REFERENCES dw_dimtblTimeDate(DateKey),
)
