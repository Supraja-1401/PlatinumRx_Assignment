--------------------------------------------------
-- Q1: Total Revenue by Sales Channel
--------------------------------------------------
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel;


--------------------------------------------------
-- Q2: Monthly Revenue
--------------------------------------------------
SELECT 
    MONTH(sale_date) AS month,
    SUM(amount) AS monthly_revenue
FROM clinic_sales
GROUP BY MONTH(sale_date)
ORDER BY month;


--------------------------------------------------
-- Q3: Monthly Expenses
--------------------------------------------------
SELECT 
    MONTH(expense_date) AS month,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY MONTH(expense_date)
ORDER BY month;


--------------------------------------------------
-- Q4: Profit or Loss per Month
--------------------------------------------------
SELECT 
    s.month,
    s.total_revenue,
    e.total_expense,
    (s.total_revenue - e.total_expense) AS profit_loss
FROM
    (
        SELECT 
            MONTH(sale_date) AS month,
            SUM(amount) AS total_revenue
        FROM clinic_sales
        GROUP BY MONTH(sale_date)
    ) s
JOIN
    (
        SELECT 
            MONTH(expense_date) AS month,
            SUM(amount) AS total_expense
        FROM expenses
        GROUP BY MONTH(expense_date)
    ) e
ON s.month = e.month;


--------------------------------------------------
-- Q5: Month with Highest Profit
--------------------------------------------------
SELECT *
FROM (
    SELECT 
        s.month,
        (s.total_revenue - e.total_expense) AS profit,
        RANK() OVER (ORDER BY (s.total_revenue - e.total_expense) DESC) AS rnk
    FROM
        (
            SELECT 
                MONTH(sale_date) AS month,
                SUM(amount) AS total_revenue
            FROM clinic_sales
            GROUP BY MONTH(sale_date)
        ) s
    JOIN
        (
            SELECT 
                MONTH(expense_date) AS month,
                SUM(amount) AS total_expense
            FROM expenses
            GROUP BY MONTH(expense_date)
        ) e
    ON s.month = e.month
) t
WHERE rnk = 1;