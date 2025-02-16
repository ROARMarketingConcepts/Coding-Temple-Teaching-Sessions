-- Retrieve the first 10 products from the Products table, ordered alphabetically by product name.

select * 
from Products
order by ProductName
Limit 10

--Find all customers who are located in the country 'Germany'.

select *
from Customers
where Country='Germany'

--List all orders that were shipped in '2016'.

select *
from Orders
where strftime('%Y', ShippedDate)='2016'

--Find the total number of products in each category.

select 
	p.CategoryID,
	CategoryName,
	count(ProductID) as num_products
from Products p
join Categories c
on p.CategoryID=c.CategoryID
group by 1,2

-- Calculate the average unit price of products in the 'Beverages' category.

select 
	avg(UnitPrice)
from Products p
join Categories c
on p.CategoryID = c.CategoryID
where CategoryName='Beverages'


--Find the total amount spent on all orders (sum of the OrderDetails table) for each customer

select 
	CustomerID,
	round(sum(Quantity*UnitPrice*Discount),2) as total
from Orders o
join OrderDetails od
ON od.OrderID=o.OrderID
group by 1

--Find the customers who have placed orders with a total value greater than $1,000.

with customer_orders_gt_1000 as 

(select 
	CustomerID,
	o.OrderID,
	round(sum(Quantity*UnitPrice*Discount),2) as total
from Orders o
join OrderDetails od
ON od.OrderID=o.OrderID
group by 1,2
having round(sum(Quantity*UnitPrice*Discount),2) > 1000)

select DISTINCT CustomerID from customer_orders_gt_1000

--Use a CTE to find the top 5 most popular products (by quantity sold) in the year 2016.

with sales_by_product as (

select 
	p.ProductID,
	p.ProductName,
	sum(Quantity)
from Products p
join OrderDetails od
on p.ProductID=od.ProductID
join Orders o 
on od.OrderID=o.OrderID
where strftime('%Y', ShippedDate)='2016'
group by 1,2
order by 3 desc
)
select ProductName
from sales_by_product
Limit 5