--------------------------------------------------
-- Q1: Find the last booked room (latest booking)
--------------------------------------------------
SELECT *
FROM bookings
ORDER BY booking_date DESC
LIMIT 1;


--------------------------------------------------
-- Q2: Total billing amount for each booking in November 2021
--------------------------------------------------
SELECT 
    b.booking_id,
    SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
WHERE b.booking_date BETWEEN '2021-11-01' AND '2021-11-30'
GROUP BY b.booking_id;


--------------------------------------------------
-- Q3: Find bookings where total bill > 1000
--------------------------------------------------
SELECT 
    b.booking_id,
    SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
GROUP BY b.booking_id
HAVING total_bill > 1000;


--------------------------------------------------
-- Q4: Most and Least ordered items per month
--------------------------------------------------

-- Step 1: Calculate total quantity per item per month
WITH item_summary AS (
    SELECT 
        MONTH(b.booking_date) AS month,
        i.item_name,
        SUM(bc.quantity) AS total_quantity
    FROM bookings b
    JOIN booking_commercials bc 
        ON b.booking_id = bc.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    GROUP BY MONTH(b.booking_date), i.item_name
),

-- Step 2: Rank items
ranked_items AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_quantity DESC) AS most_rank,
           RANK() OVER (PARTITION BY month ORDER BY total_quantity ASC) AS least_rank
    FROM item_summary
)

-- Step 3: Get most & least
SELECT *
FROM ranked_items
WHERE most_rank = 1 OR least_rank = 1;


--------------------------------------------------
-- Q5: Find 2nd highest bill amount
--------------------------------------------------
SELECT *
FROM (
    SELECT 
        b.booking_id,
        SUM(bc.quantity * i.rate) AS total_bill,
        RANK() OVER (ORDER BY SUM(bc.quantity * i.rate) DESC) AS rank_no
    FROM bookings b
    JOIN booking_commercials bc 
        ON b.booking_id = bc.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    GROUP BY b.booking_id
) ranked
WHERE rank_no = 2;