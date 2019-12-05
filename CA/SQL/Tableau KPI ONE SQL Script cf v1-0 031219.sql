select sum(NetTotal) 
from dw_facttblSales
where [OrderDateKey] = 1996186

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

SELECT @1996_H2 as 'Total', 0 as Growth
UNION
SELECT @1997_H1 as 'Total', ((@1997_H1/@1996_H2)-1) as Growth
UNION
SELECT @1997_H2 as 'Total', ((@1997_H2/@1996_H2)-1) as Growth




select Total, Year, HalfYear, Growth  from (
	select sum(NetTotal) as Total, 1996 as 'Year', 'H2' as HalfYear, 0 as 'Growth'
	from dw_facttblSales fact, dw_dimtblTimeDate time
	where fact.OrderDateKey = time.DateKey
	and time.YearNumber = 1996
	--and time.CalMonthNumber = 7
	--and time.DayNumber = 4
	UNION
	select sum(NetTotal) as Total, 1997 as 'Year', 'H1' as HalfYear, 0 as 'Growth'
	from dw_facttblSales fact, dw_dimtblTimeDate time
	where fact.OrderDateKey = time.DateKey
	and time.YearNumber = 1997
	and time.CalMonthNumber in (1,2,3,4,5,6)
	UNION
	select sum(NetTotal) as Total, 1997 as 'Year', 'H2' as HalfYear, 0 as 'Growth'
	from dw_facttblSales fact, dw_dimtblTimeDate time
	where fact.OrderDateKey = time.DateKey
	and time.YearNumber = 1997
	and time.CalMonthNumber in (7,8,9,10,11,12)
) a


INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
VALUES (1996, 'H2', @1996_H2, 0)
INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
VALUES (1997, 'H1', @1997_H1, ((@1997_H1/@1996_H2)-1))
INSERT INTO dw_rpttblHalfYearlySales (YearNumber, HalfYearNum, NetTotalAmt, GrowthRate)
VALUES (1997, 'H2', @1997_H2, ((@1997_H2/@1996_H2)-1))


select * from dw_rpttblHalfYearlySales

