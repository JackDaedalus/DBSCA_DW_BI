

delete tmpSales

delete tmpEmpSales

INSERT INTO tmpSales(
Yr,
AvgEmpSales
)
SELECT Sales_Year, avg(Total) as 'Employee Avg Across all Years' from (
	select time.YearNumber as 'Sales_Year', emp.EmployeeKey as 'EmpKey', emp.EmployeeName, sum(NetTotal) as Total
	from 
	dw_facttblSales fact, 
	dw_dimtblTimeDate time,
	dw_dimtblEmployee emp
	where fact.OrderDateKey = time.DateKey
	and emp.EmployeeKey = fact.EmployeeKey
	group by time.YearNumber, emp.EmployeeKey, emp.EmployeeName
) b
group by Sales_Year

select * from tmpSales





INSERT INTO tmpEmpSales (
empKey,
EmpName,
Yr,
NtSalesTot,
PctDiff
)
	select emp.EmployeeKey as 'EmpKey', emp.EmployeeName, time.YearNumber as 'Year', sum(NetTotal) as Total, 0 as PctDiff
	from 
	dw_facttblSales fact, 
	dw_dimtblTimeDate time,
	dw_dimtblEmployee emp
	where fact.OrderDateKey = time.DateKey
	and emp.EmployeeKey = fact.EmployeeKey
	group by emp.EmployeeKey, emp.EmployeeName, time.YearNumber
	order by emp.EmployeeKey




declare @SalesYr int
declare @EmployNum int
declare @AvgYearSales Money



select @SalesYr = 1996


WHILE @SalesYr <> 1999
BEGIN
	print 'loop-de-firstloop';
	SELECT @AvgYearSales = (SELECT AvgEmpSales FROM tmpSales WHERE Yr = @SalesYr)
	select @EmployNum = 1

	WHILE @EmployNum <> 10
	BEGIN
		print 'loop-de-2ndloop';
		Update tmpEmpSales
		SET PctDiff = ((NtSalesTot / @AvgYearSales)-1)
		WHERE empKey = @EmployNum
		AND Yr = @SalesYr

		SET @EmployNum = @EmployNum + 1
	END

	SET @SalesYr = @SalesYr + 1
	
END;



