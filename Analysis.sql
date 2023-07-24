-- analyze the impact of the discount
select b.Discount, 
		SUM(Revenue) AS Total_revenue
from Orders a 
join [Order Details] b 
on a.OrderID = b.OrderID
join Products c
on b.ProductID = c.ProductID
group by 
	b.Discount
order by Total_revenue

alter table [Order Details]
add Revenue float
update [Order Details]
set Revenue = Round(((Quantity * UnitPrice) - (UnitPrice*Discount)), 2)

-- analyze product according to Revenue and Numbers of orders
select c.ProductName, c.ProductID,
		SUM(b.Revenue) AS Total_revenue,
		Count(a.OrderID) AS Total_orders
from Orders a 
join [Order Details] b 
on a.OrderID = b.OrderID
join Products c
on b.ProductID = c.ProductID
Group by 
	c.ProductName, c.ProductID
Order by c.ProductID

-- analyze the revenue by quarters

select b.OrderID, a.Order_date,
		SUM(b.Revenue) AS Revenue,
		SUM(b.OrderID) AS Orders
from Orders a 
join [Order Details] b 
on a.OrderID = b.OrderID
Group by b.OrderID, a.Order_date
order by a.Order_date

-- analyze the logistic 
select a.ShipCountry,
		ROUND(AVG(DATEDIFF(DAY, a.Order_date, a.Shipped_date)),2) AS Average_days_between_order_shipping,
		COUNT(a.OrderID) as Total_Order,
		SUM(Revenue) as Total_revenue
from Orders a
join [Order Details] b 
on a.OrderID = b.OrderID
group by a.ShipCountry
order by a.ShipCountry

--analyze revenue according to product categories
select c.CategoryID, c.CategoryName, 
		SUM(o.Revenue) AS Category_revenue
from Products p
left join Categories c
on p.CategoryID = c.CategoryID
right join [Order Details] o
on p.ProductID = o.ProductID
group by c.CategoryName, c.CategoryID
order by c.CategoryID
--analyze revenue according to product categories in July 1966
select c.CategoryID, c.CategoryName, 
		SUM(o.Revenue) AS Category_revenue
from Products p
join Categories c
on p.CategoryID = c.CategoryID
join [Order Details] o
on p.ProductID = o.ProductID
join Orders a
on o.OrderID = a.OrderID
where a.Order_date between  '1997-12-01' and '1997-12-31'
group by c.CategoryName, c.CategoryID
order by Category_revenue DESC

--analyze the performance of employees
select o.EmployeeID, 
		e.LastName,
		SUM(d.Revenue) as Revenue,
		COUNT(o.OrderID) as Total_orders
from Orders o
join Employees e
on o.EmployeeID = e.EmployeeID
join [Order Details] d
on o.OrderID = d.OrderID
group by e.LastName, o.EmployeeID
Order by o.EmployeeID

--analyze customers
select o.CustomerID, 
		c.CompanyName,
		c.ContactName,
		SUM(d.Revenue) as Revenue,
		COUNT(o.OrderID) as Total_orders
from Orders o
join Customers c
on o.CustomerID = c.CustomerID
join [Order Details] d
on o.OrderID = d.OrderID
group by o.CustomerID, 
		c.CompanyName,
		c.ContactName
Order by o.CustomerID

--Total revenue, orders, customers
select SUM(Revenue), COUNT(OrderID)
FROM [Order Details]
select COUNT (distinct CustomerID)
from Orders


