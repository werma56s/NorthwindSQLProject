-- =====================================================
-- 📊 SQL Analytical Queries
-- Project: Sales Data Analysis (Northwind)
-- =====================================================

-- 1. Policz liczbę zamówień dla każdego klienta
-- EN: Count the number of orders for each customer
select 
    o.CustomerID, 
    c.CompanyName, 
    count(o.OrderID) as CountOfOrders
from Orders o
join Customers c on c.CustomerID = o.CustomerID
group by o.CustomerID, c.CompanyName;

-- 2. Policz ile produktów ma każdy dostawca
-- EN: Count the number of products for each supplier
select  
    s.SupplierID,
    s.CompanyName, 
    count(p.ProductID) as CountOfProducts
from Products p
join Suppliers s on s.SupplierID = p.SupplierID
group by s.SupplierID, s.CompanyName;

-- 3. Oblicz średnią cenę produktów w każdej kategorii
-- EN: Calculate the average price of products in each category
select 
    c.CategoryName,
    avg(p.UnitPrice) as AVGUnitPrice
from Products p
join Categories c on c.CategoryID = p.CategoryID
group by c.CategoryName;

-- 4. Znajdź klientów, którzy złożyli więcej niż 10 zamówień
-- EN: Find customers who placed more than 10 orders
select 
    c.CustomerID, 
    c.CompanyName, 
    count(o.OrderID) as SumOrder
from Orders o
join Customers c on c.CustomerID = o.CustomerID
group by c.CustomerID, c.CompanyName
having count(o.OrderID) > 10;

-- 5. Znajdź produkty, które nigdy nie zostały zamówione.
-- EN: Find products that have never been ordered.

select p.ProductID, p.ProductName
from Products p
left join [Order Details] od on od.ProductID = p.ProductID
where od.OrderID is null;
--or
select p.ProductID, count(od.OrderID) as OrderCount
from Products p
left join [Order Details] od on od.ProductID = p.ProductID
group by p.ProductID
having count(od.OrderID) = 0;

-- 6. Pokaż klientów, którzy złożyli największą liczbę zamówień.
-- EN: Show customers who placed the highest number of orders.

select top 3 
    c.CustomerID,
    count(o.OrderID) as CountOfOrders
from Customers c
left join Orders o on o.CustomerID = c.CustomerID
group by c.CustomerID
order by CountOfOrders desc;

-- 7. Znajdź dostawców, którzy dostarczają produkty droższe niż średnia cena wszystkich produktów.
-- EN: Find suppliers who provide products more expensive than the average price of all products
select distinct s.SupplierID, s.CompanyName
from Suppliers s
join Products p on p.SupplierID = s.SupplierID
where p.UnitPrice > (select avg(UnitPrice) from Products)
order by s.CompanyName;
-- or
select s.SupplierID, s.CompanyName
from Suppliers s
join Products p on p.SupplierID = s.SupplierID
group by s.SupplierID, s.CompanyName
having max(p.UnitPrice) > (select avg(UnitPrice) from Products)
order by s.CompanyName;


-- 8. Wyświetl zamówienia, w których suma (Quantity * UnitPrice) przekracza 1000.
-- EN: Display orders where the total value (Quantity * UnitPrice) exceeds 1000.

select 
    o.OrderID,
    sum(od.Quantity * od.UnitPrice) as SumOfOrder
from Orders o 
join [Order Details] od on od.OrderID = o.OrderID
group by o.OrderID
having sum(od.Quantity * od.UnitPrice) > 1000;

