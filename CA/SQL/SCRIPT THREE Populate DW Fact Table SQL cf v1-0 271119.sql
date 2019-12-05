/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to populate the data warehouse Fact tables for the Northwind Traders CA */



/* Switch to data warehouse to populate the Fact table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO

/*	------------------------------------------------------  	*/

/*	Populate the Fact Tables							    */

/*	------------------------------------------------------  	*/

---------------------------------------------------------------------------------------
--				POPULATE SALES FACT						--
---------------------------------------------------------------------------------------
INSERT INTO dw_facttblSales
        (ProductKey
        ,CustomerKey
        ,EmployeeKey
        ,OrderDateKey
		,OrderQuantity
		,GrossTotal
        ,DiscountTotal
		,NetTotal
		,DaysToShip
		)
SELECT 	
	 d_prod.ProductKey
	,d_cust.CustomerKey 
    ,d_emp.EmployeeKey
    ,d_date.DateKey
	,odb.Quantity
	,CONVERT(money,(odb.UnitPrice*odb.Quantity))  AS GrossTotal
	,CONVERT(money,(odb.UnitPrice*odb.Quantity*(odb.Discount)/100))*100 AS DiscountTotal
	,CONVERT(money,(odb.UnitPrice*odb.Quantity*(1-odb.Discount)/100))*100 AS NetTotal
	,DATEDIFF(day,odb.OrderDate,odb.ShippedDate) AS DaysToShip

From (

SELECT  
		c.CustomerId
		,p.ProductName
		,e.EmployeeID
		,o.OrderDate
		,o.ShippedDate
		,od.UnitPrice
		,od.Quantity
		,od.Discount
	from Northwind.dbo.Products p	
	join Northwind.dbo.[order details] od on p.productid	= od.productid
	join Northwind.dbo.[orders] o	on o.orderid	= od.orderid
	join Northwind.dbo.Customers c	on c.customerid	= o.customerid
	join Northwind.dbo.Employees e	on o.employeeid = e.employeeid

 )
as odb
    join dw_dimtblCustomer d_cust 	   on d_cust.CustomerID		= odb.CustomerId
	join dw_dimtblProduct d_prod       on d_prod.ProductName   	= odb.ProductName
	join dw_dimtblEmployee d_emp       on d_emp.EmployeeID     	= odb.EmployeeID
	join dw_dimtblTimeDate d_date      on d_date.CalendarDate	= odb.OrderDate
