-- Drop tables if already exist
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;

--------------------------------------------------
-- 1. CLINIC SALES TABLE
--------------------------------------------------
CREATE TABLE clinic_sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    sales_channel VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO clinic_sales (sale_id, sale_date, sales_channel, amount) VALUES
(1, '2021-11-01', 'Online', 500),
(2, '2021-11-02', 'Offline', 700),
(3, '2021-11-10', 'Online', 300),
(4, '2021-12-05', 'Offline', 900),
(5, '2021-12-15', 'Online', 400);

--------------------------------------------------
-- 2. EXPENSES TABLE
--------------------------------------------------
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    expense_date DATE,
    category VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO expenses (expense_id, expense_date, category, amount) VALUES
(1, '2021-11-01', 'Rent', 300),
(2, '2021-11-05', 'Salary', 400),
(3, '2021-12-01', 'Rent', 300),
(4, '2021-12-10', 'Salary', 500);

--------------------------------------------------
-- VERIFY DATA
--------------------------------------------------
SELECT * FROM clinic_sales;
SELECT * FROM expenses;