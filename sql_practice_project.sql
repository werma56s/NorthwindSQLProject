-- =====================================================
-- 📊 SQL Analytical Queries
-- Project: Sales Data Analysis (Northwind)
-- =====================================================

-- 1. Produkty, które nigdy nie zostały zamówione

-- PL: Znajdź produkty, które nigdy nie zostały zamówione.
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

-- 2. Klienci z największą liczbą zamówień

-- PL: Pokaż klientów, którzy złożyli największą liczbę zamówień.
-- EN: Show customers who placed the highest number of orders.

select top 3 
    c.CustomerID,
    count(o.OrderID) as CountOfOrders
from Customers c
left join Orders o on o.CustomerID = c.CustomerID
group by c.CustomerID
order by CountOfOrders desc;

-- 3. Dostawcy z produktami droższymi niż średnia

-- PL: Znajdź dostawców, którzy dostarczają produkty droższe niż średnia cena wszystkich produktów.
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


-- 4. Drogie zamówienia

-- PL: Wyświetl zamówienia, w których suma (Quantity * UnitPrice) przekracza 1000.
-- EN: Display orders where the total value (Quantity * UnitPrice) exceeds 1000.

select 
    o.OrderID,
    sum(od.Quantity * od.UnitPrice) as SumOfOrder
from Orders o 
join [Order Details] od on od.OrderID = o.OrderID
group by o.OrderID
having sum(od.Quantity * od.UnitPrice) > 1000;

