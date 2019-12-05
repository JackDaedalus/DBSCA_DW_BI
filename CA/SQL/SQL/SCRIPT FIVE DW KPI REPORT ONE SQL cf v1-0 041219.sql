/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to populate Net Sales Growth KPI Report data for use in Tableau      */

/* This script calculates the growth in sales for each half year in 1997    */
/* Growth rates are compared against H2 in 1996								*/
/* It is easier to perform these calculations in SQL, which is invoked by 
/* the SSIS process and then read the result set into Tableau for display	*/


/* Switch to data warehouse to create the KPI Report table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO


	DECLARE
	@1996_H2 MONEY,
	@1997_H1 MONEY,
	@1997_H2 MONEY


	delete dw_rpttblHalfYearlySales

	SELECT @1996_H2 = (select sum(NetTotal) from dw_facttblSales fact, dw_dimtblTimeDate time
		where fact.OrderDateKey = time.DateKey
		and time.YearNumber = 1996)

	SELECT @1997_H1 = (select sum(NetTotal) from dw_facttblSales fact, dw_dimtblTimeDate time
		where fact.OrderDateKey = time.DateKey
		and time.YearNumber = 1997
		and time.CalMonthNumber in (1,2,3,4,5,6))

	SELECT @1997_H2 = (select sum(NetTotal) from dw_facttblSales fact, dw_dimtblTimeDate time
		where fact.OrderDateKey = time.DateKey
		and time.YearNumber = 1997
		and time.CalMonthNumber in (7,8,9,10,11,12))


	INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
	VALUES (1996, 'H2', @1996_H2, 0)
	INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
	VALUES (1997, 'H1', @1997_H1, ((@1997_H1/@1996_H2)-1))
	INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
	VALUES (1997, 'H2', @1997_H2, ((@1997_H2/@1996_H2)-1))


GO