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


--Create Customer Dimensions
CREATE TABLE dbo.dw_dimtblCustomer (
CustomerKey INT IDENTITY(1, 1) PRIMARY KEY, 
CustomerID NCHAR(5) NOT NULL,  
CustomerName NVARCHAR(40) NOT NULL, 
CustomerCity NVARCHAR(15) NULL,
CustomerRegion NVARCHAR(15) NULL,
CustomerCountry NVARCHAR(15) NULL
)


--Create Employee Dimensions
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

--Create Date Dimensions
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
