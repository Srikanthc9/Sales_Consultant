-- Sales Performance Analysis

-- Total Sales and Profits by Salesperson
SELECT 
    sm.salesman_id,
    sm.name,
    SUM(s.sale_price) AS total_sales,
    SUM(s.profit) AS total_profit
FROM 
    Sales s
JOIN 
    Salesmen sm ON s.salesman_id = sm.salesman_id
GROUP BY 
    sm.salesman_id, sm.name
ORDER BY 
    total_sales DESC;

-- Average Sale Price by Salesperson
SELECT 
    sm.salesman_id,
    sm.name,
    AVG(s.sale_price) AS avg_sale_price
FROM 
    Sales s
JOIN 
    Salesmen sm ON s.salesman_id = sm.salesman_id
GROUP BY 
    sm.salesman_id, sm.name
ORDER BY 
    avg_sale_price DESC;

-- Customer Analysis

-- Customer Demographics Analysis
SELECT 
    c.debt_to_income_ratio,
    AVG(c.credit_score) AS avg_credit_score,
    AVG(c.annual_income) AS avg_annual_income,
    COUNT(*) AS number_of_customers
FROM 
    Customers c
GROUP BY 
    c.debt_to_income_ratio
ORDER BY 
    c.debt_to_income_ratio;

-- Sales by Customer Type
SELECT 
    CASE 
        WHEN c.credit_score >= 700 THEN 'Good'
        WHEN c.credit_score BETWEEN 600 AND 699 THEN 'Fair'
        ELSE 'Poor'
    END AS credit_score_segment,
    COUNT(DISTINCT c.customer_id) AS number_of_customers,
    SUM(s.sale_price) AS total_sales
FROM 
    Customers c
JOIN 
    Sales s ON c.customer_id = s.customer_ID
GROUP BY 
    CASE 
        WHEN c.credit_score >= 700 THEN 'Good'
        WHEN c.credit_score BETWEEN 600 AND 699 THEN 'Fair'
        ELSE 'Poor'
    END
ORDER BY 
    total_sales DESC;

-- Vehicle Performance Analysis

-- Most Profitable Vehicles
SELECT 
    Make, 
    Model, 
    SUM(Profit) AS total_profit
FROM 
    Sales
GROUP BY 
    Make, Model
ORDER BY 
    total_profit DESC;

-- Average Days on Lot
SELECT 
    AVG(days_on_lot) AS average_days_on_lot
FROM 
    Sales;

-- Sales Trends Over Time

-- Monthly Sales Trends
SELECT 
    YEAR(sale_Date) AS sales_year,
    MONTH(sale_Date) AS sales_month,
    COUNT(*) AS sales_count,
    SUM(sale_Price) AS total_sales
FROM 
    Sales
GROUP BY 
    YEAR(sale_Date), MONTH(sale_Date)
ORDER BY 
    sales_year, sales_month;

-- Year-over-Year Growth
SELECT 
    YEAR(sale_Date) AS sales_year,
    COUNT(*) AS sales_count,
    SUM(sale_Price) AS total_sales
FROM 
    Sales
GROUP BY 
    YEAR(sale_Date)
ORDER BY 
    sales_year;

-- Comission Insights
SELECT 
    sm.salesman_id,
    sm.name,
    sm.base_salary,
    SUM(s.profit) * sm.commission_rate AS total_commission,
    sm.base_salary + (SUM(s.profit) * sm.commission_rate) AS projected_earnings
FROM 
    Salesmen sm
LEFT JOIN 
    Sales s ON sm.salesman_id = s.salesman_id
GROUP BY 
    sm.salesman_id, sm.name, sm.base_salary, sm.commission_rate
ORDER BY 
    projected_earnings DESC;

