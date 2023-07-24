-- convert to date type data
select Order_date, Required_date, Shipped_date
from Orders

alter table Orders
add Order_date date, Required_date date, Shipped_date date;


update Orders
set Order_Date = CONVERT(DATE, OrderDate)
set Required_date = CONVERT(DATE, Requireddate)
set Shipped_date = CONVERT(DATE, Shippeddate)

-- update null variables
select RequiredDate, ShippedDate, Required_date, Shipped_date,
		isnull(ShippedDate, RequiredDate),
		isnull(Shipped_date, Required_date)
from Orders
where shippedDate is null

update Orders
set ShippedDate = isnull(ShippedDate, RequiredDate)
from Orders
Where ShippedDate is null

update Orders
set Shipped_Date = isnull(Shipped_Date, Required_Date)
from Orders
Where Shipped_Date is null

-- capitalize name
select Orders.ShipName, Customers.CompanyName
from Orders
join Customers
on Orders.CustomerID = Customers.CustomerID

update Orders
set ShipName = dbo.fn_capitalize(ShipName)

update Customers
set CompanyName = dbo.fn_capitalize(CompanyName)

-- create functions for capitalize 
CREATE FUNCTION dbo.fn_capitalize
(
@str AS nvarchar(100)
)
RETURNS nvarchar(100)
AS
BEGIN

DECLARE
@ret_str AS NVARCHAR(100),
@pos AS int,
@len AS int

SELECT
@ret_str = N' ' + LOWER(@str),
@pos = 1,
@len = LEN(@str) + 1

WHILE @pos > 0 AND @pos < @len
BEGIN
SET @ret_str = STUFF(@ret_str,
@pos + 1,
1,
UPPER(SUBSTRING(@ret_str,@pos + 1, 1)))
SET @pos = CHARINDEX(N' ', @ret_str, @pos + 1)
END

RETURN RIGHT(@ret_str, @len - 1)

END

alter table Employees
add FullName text;
update Employees
set FullName = CONCAT(FirstName,' ', LastName)

--check duplicate
SELECT OrderID, COUNT(OrderID)
FROM Orders
GROUP BY OrderID
HAVING COUNT(OrderID) > 1
