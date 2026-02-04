# Northwind SQL Analytics Project

## 📄 Project Overview

This project contains a collection of SQL/T-SQL queries that demonstrate analytical and reporting skills using the **Northwind sample database**.  

- **SQL** – Standard SQL queries that work across most relational databases.
  - Examples: `SELECT`, `JOIN`, `GROUP BY`, `COUNT`, `AVG`
- **T-SQL** – Microsoft SQL Server specific extensions, including window functions and formatting functions.
  - Examples: `LAG() OVER(...)`, `FORMAT()`, `ROUND()`, `TOP`

The goal is to showcase the ability to:
- write complex SQL queries,
- use aggregation (`COUNT`, `SUM`, `AVG`),
- analyze trends with **window functions** (`LAG`),
- calculate **Year-over-Year (YoY)** and **Month-over-Month (MoM)** changes,
- identify top customers, suppliers, and products,
- work with joins, CTEs, and conditional calculations.

This project can be used as a portfolio example for **SQL, Data Analysis, and QA Automation**.

---

## 📂 Dataset

The project uses the **[Northwind sample database](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs)**, a classic dataset representing a small trading company with:
- Customers  
- Orders  
- Products  
- Suppliers  
- Categories  
- Order Details  

Scripts used to create and load the database:
- `instnwnd (Azure SQL Database)` – Northwind database
- `instpubs.sql` - Northwind pubs
---

## 📊 Project Structure

| SQL File                    | Description                                                                                                              |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `sql_practice_project.sql`  | Basic queries: customers, suppliers, products, average prices, top customers, never-ordered products, high-value orders. |
| `sql_trends_and_prices.sql` | Trend analysis: YoY & MoM comparisons, category price changes, product sales trends.                                     |

---

## 🔧 Queries Included

- `sql_practice_project.sql`:
1. **Count Orders per Customer** – Show total orders for each customer.  
2. **Count Products per Supplier** – Show how many products each supplier has.  
3. **Average Product Price per Category** – Compute average unit price per category.  
4. **Customers with More Than 10 Orders** – Identify highly active customers.  
5. **Products Never Ordered** – Identify products that were never purchased.  
6. **Top Customers by Orders** – Show customers with the highest number of orders.  
7. **Suppliers with Expensive Products** – Identify suppliers providing products above average price.  
8. **Orders Exceeding 1000 Total Value** – Find high-value orders.  

- `sql_trends_and_prices.sql`:
9. **Orders YoY Comparison** – Year-over-year growth in orders.  
10. **Orders MoM Comparison** – Month-over-month growth in orders.  
11. **Average Price Changes per Category (YoY)** – Real and supplier prices per category with YoY percentage.  
12. **Product Sales YoY Comparison** – Year-over-year sales for each product with difference and percentage.

---

## 🚀 How to Run

1. Install **SQL Server** and open SQL Server Management Studio (SSMS), version 20 
2. Restore or run the Northwind database script (`instnwnd.sql`) and pubs (`instpubs.sql`).  
3. Open the `.sql` file.
4. Run the queries section by section to explore results.  

---

## 💡 Skills Demonstrated

- SQL aggregation: `COUNT`, `SUM`, `AVG`  
- Joins: `INNER JOIN`, `LEFT JOIN`  
- Window functions: `LAG()`  
- Conditional logic: `CASE WHEN`  
- CTE (Common Table Expressions)  
- Data trend analysis (YoY, MoM)  
- Portfolio-ready SQL for QA Automation / Data Analysis  

---

## 📌 Notes

- All queries are fully commented in **English** and **Polish**, describing both the purpose and logic.  
- Queries are structured for clarity and readability, making them ideal for showcasing skills to recruiters or in a portfolio.  


