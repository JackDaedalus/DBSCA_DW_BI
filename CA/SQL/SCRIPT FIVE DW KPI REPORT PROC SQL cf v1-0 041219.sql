/* Ciaran Finnegan 	: Student No. 10524150									*/
/* Data Warehouse Design and Implementation : Northwind Traders CA			*/

/* B8IT104 Data Warehousing and Business Intelligence - December 2019		*/


/* SQL to populate Net Sales Growth KPI Report data for use in Tableau */


/* Switch to data warehouse to create the KPI Report table */
USE dbs_dwbi_ca_cf_nthwd_dw;  
GO

/*
CREATE PROCEDURE dw_spReadHalfYearlyKPIs
AS
*/
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


/*
	SELECT * FROM dw_rpttblHalfYearlySales
*/
GO