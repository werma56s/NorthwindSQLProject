-- =====================================================
-- 📊 SQL Analytical Queries
-- Project: Order and product price trends and comparisons (Northwind)
-- =====================================================

-- =====================================================
--  1. Porownanie liczby zamowien rok do roku (YoY)
-- PL: Liczba zamowien w kazdym roku i przyrost procentowy wzgledem poprzedniego roku
-- EN: Number of orders per year and percentage growth compared to previous year
-- =====================================================
SELECT
    YEAR(o.OrderDate) AS OrderYear, -- PL: Rok zamowienia, EN: Order year
    COUNT(o.OrderID) AS OrdersPerYear, -- PL: Liczba zamowien w roku, EN: Number of orders per year
    LAG(COUNT(o.OrderID)) OVER (ORDER BY YEAR(o.OrderDate)) AS PreviousYearOrders, -- PL: Liczba zamowien w poprzednim roku, EN: Orders in previous year
    ROUND(
        CASE 
            WHEN LAG(COUNT(o.OrderID)) OVER (ORDER BY YEAR(o.OrderDate)) IS NULL THEN NULL
            ELSE (COUNT(o.OrderID) - LAG(COUNT(o.OrderID)) OVER (ORDER BY YEAR(o.OrderDate)))
                 * 100.0 / LAG(COUNT(o.OrderID)) OVER (ORDER BY YEAR(o.OrderDate))
        END, 2
    ) AS YoY_Percent -- PL: Przyrost procentowy rok do roku, EN: Year-over-Year percentage
FROM Orders o
GROUP BY YEAR(o.OrderDate)
ORDER BY OrderYear;

-- =====================================================
-- 2. Porownanie liczby zamowien miesiac do miesiaca (MoM)
-- PL: Liczba zamowien w kazdym miesiacu i przyrost procentowy wzgledem poprzedniego miesiaca
-- EN: Number of orders per month and percentage growth compared to previous month
-- =====================================================
SELECT
    FORMAT(o.OrderDate, 'yyyy-MM') AS MonthYear, -- PL: Miesiac i rok (YYYY-MM), EN: Month and Year (YYYY-MM)
    COUNT(o.OrderID) AS OrdersPerMonth, -- PL: Liczba zamowien w miesiacu, EN: Number of orders per month
    LAG(COUNT(o.OrderID)) OVER (ORDER BY FORMAT(OrderDate, 'yyyy-MM')) AS PreviousMonthOrders, -- PL: Liczba zamowien w poprzednim miesiacu, EN: Orders in previous month
    ROUND(
        CASE 
            WHEN LAG(COUNT(o.OrderID)) OVER (ORDER BY FORMAT(OrderDate, 'yyyy-MM')) IS NULL THEN NULL
            ELSE (COUNT(o.OrderID) - LAG(COUNT(o.OrderID)) OVER (ORDER BY FORMAT(OrderDate, 'yyyy-MM')))
                 * 100.0 / LAG(COUNT(o.OrderID)) OVER (ORDER BY FORMAT(OrderDate, 'yyyy-MM'))
        END, 2
    ) AS MoM_Percent -- PL: Przyrost procentowy miesiac do miesiaca, EN: Month-over-Month percentage
FROM Orders o
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY MonthYear;

-- =====================================================
-- 3. Liczba zamowien per miesiac (bez procentu)
-- PL: Liczba zamowien w kazdym miesiacu
-- EN: Number of orders per month
-- =====================================================
SELECT
    FORMAT(OrderDate, 'yyyy-MM') AS MonthYear, -- PL: Miesiac i rok, EN: Month and Year
    COUNT(OrderID) AS OrdersPerMonth -- PL: Liczba zamowien, EN: Number of orders
FROM Orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY MonthYear;

-- =====================================================
-- 4. Zmiany Srednich cen produktow w kategoriach rok do roku (YoY)
-- PL: Srednia cena produktow faktycznych i od dostawcow oraz przyrost procentowy rok do roku
-- EN: Average product prices (real and suppliers) and Year-over-Year percentage change
-- =====================================================
WITH CategoryYear AS (
    SELECT
        c.CategoryName, -- PL: Nazwa kategorii, EN: Category name
        YEAR(o.OrderDate) AS OrderYear, -- PL: Rok zamowienia, EN: Order year
        COUNT(od.ProductID) AS BoughtProductsPerYear, -- PL: Liczba sprzedanych produktow w roku, EN: Number of products sold per year
        AVG(od.UnitPrice) AS RealPriceAVG, -- PL: Srednia cena faktyczna (RealPrice), EN: Average real price
        AVG(p.UnitPrice) AS PriceFromSuppliers -- PL: Srednia cena od dostawcow, EN: Average supplier price
    FROM Orders o
    LEFT JOIN [Order Details] od ON od.OrderID = o.OrderID
    LEFT JOIN Products p ON p.ProductID = od.ProductID
    LEFT JOIN Categories c ON c.CategoryID = p.CategoryID
    GROUP BY c.CategoryName, YEAR(o.OrderDate)
)
SELECT
    CategoryName, -- PL: Nazwa kategorii, EN: Category name
    OrderYear, -- PL: Rok, EN: Year
    BoughtProductsPerYear, -- PL: Liczba sprzedanych produktow, EN: Products sold
    LAG(BoughtProductsPerYear) OVER (PARTITION BY CategoryName ORDER BY OrderYear) AS PreviousYearBought, -- PL: Sprzedaz w poprzednim roku, EN: Sales in previous year
    RealPriceAVG, -- PL: srednia cena faktyczna, EN: Average real price
    LAG(RealPriceAVG) OVER (PARTITION BY CategoryName ORDER BY OrderYear) AS PreviousYearRealPrice, -- PL: Srednia cena faktyczna w poprzednim roku, EN: Real price previous year
    -- YoY% dla sredniej ceny faktycznej (RealPrice)
    ROUND(
        CASE
            WHEN LAG(RealPriceAVG) OVER (PARTITION BY CategoryName ORDER BY OrderYear) IS NULL THEN NULL
            ELSE (RealPriceAVG - LAG(RealPriceAVG) OVER (PARTITION BY CategoryName ORDER BY OrderYear))
                 * 100.0 / LAG(RealPriceAVG) OVER (PARTITION BY CategoryName ORDER BY OrderYear)
        END, 2
    ) AS YoY_RealPricePercent, -- PL: Przyrost procentowy rok do roku (RealPrice), EN: YoY percentage for RealPrice
    PriceFromSuppliers, -- PL: srednia cena od dostawcow, EN: Average supplier price
    LAG(PriceFromSuppliers) OVER (PARTITION BY CategoryName ORDER BY OrderYear) AS PreviousYearPriceFromSuppliers, -- PL: Cena od dostawcow w poprzednim roku, EN: Supplier price previous year
    -- YoY% dla sredniej ceny od dostawcow (PriceFromSuppliers)
    ROUND(
        CASE
            WHEN LAG(PriceFromSuppliers) OVER (PARTITION BY CategoryName ORDER BY OrderYear) IS NULL THEN NULL
            ELSE (PriceFromSuppliers - LAG(PriceFromSuppliers) OVER (PARTITION BY CategoryName ORDER BY OrderYear))
                 * 100.0 / LAG(PriceFromSuppliers) OVER (PARTITION BY CategoryName ORDER BY OrderYear)
        END, 2
    ) AS YoY_PriceFromSuppliersPercent -- PL: Przyrost procentowy rok do roku (PriceFromSuppliers), EN: YoY percentage for supplier price
FROM CategoryYear
ORDER BY CategoryName, OrderYear;