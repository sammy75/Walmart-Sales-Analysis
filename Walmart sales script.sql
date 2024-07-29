SELECT * FROM salesdatawalmart.walmart;


--- Add day_name column ----------------------------------
SELECT date, dayname(date) AS day
FROM walmart;

ALTER TABLE walmart ADD COLUMN day_name VARCHAR(10);


--- add time_of_day column --------------------------

SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM walmart;

ALTER TABLE walmart ADD COLUMN time_of_day VARCHAR(20);

UPDATE walmart
SET time_of_day = (
CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END);




-- add day_name---
SELECT date,
DAYNAME(date) AS week_day
FROM walmart;

ALTER TABLE walmart ADD COLUMN week_day VARCHAR(10);

UPDATE walmart
SET week_day = DAYNAME(date);

ALTER TABLE walmart
DROP COLUMN week_day;

--- add month_name-----
SELECT date, monthname(date)
FROM walmart;

ALTER TABLE walmart ADD COLUMN month_name VARCHAR(10);

UPDATE walmart
SET month_name = monthname(date);


------ EDA ----

----- GENERIC -----

--- 1 How many unique cities does the data have? -----
SELECT DISTINCT city
FROM walmart;

--- 2 in which city is each branch ---
SELECT DISTINCT branch
from walmart;

SELECT DISTINCT city, branch
FROM walmart;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
----------------------- Product ----------------------------------------------

--- 1 how many unique product lines does the data have? ---
SELECT COUNT(DISTINCT product_line)
FROM walmart;

--- 2 What is the most common payment method? ---
SELECT payment_method, COUNT(payment_method) AS cnt
FROM walmart
GROUP BY payment_method
ORDER BY cnt DESC;

--- 3 What is the most selling product line? ---
SELECT product_line, COUNT(product_line) AS cnt
FROM walmart
GROUP BY product_line
ORDER BY cnt DESC;

--- 4 What is the total revenue by month? ---
SELECT month_name AS month,
SUM(total) AS total_revenue
FROM walmart
GROUP BY month_name
ORDER BY total_revenue DESC;

--- what month had the largest COGS? ---
SELECT 
month_name AS month,
SUM(cogs) AS cogs
FROM walmart
GROUP BY month_name
ORDER BY cogs;

--- what productline has the largest revenue ---
SELECT
   product_line,
   SUM(total) AS total_revenue
   FROM walmart
   GROUP BY product_line
   ORDER BY total_revenue DESC;
   
   --- what is the city with the largest revenue ---
   SELECT
     city, branch,
     SUM(total) AS total_revenue
  FROM walmart
  GROUP BY city, branch
  ORDER BY total_revenue DESC;
  
  --- what productline has the largest VAT ---
  SELECT
  product_line,
  AVG(VAT) AS avg_tax
  FROM walmart
  GROUP BY product_line
  ORDER BY avg_tax DESC;
  
 
  
  
  --- which branch sold more products than average product sold ---
  SELECT 
   branch,
   SUM(quantity) AS qty
  FROM walmart
  GROUP BY branch
  HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmart);
  
  --- what is the most common product line by gender ---
  SELECT 
   gender,
   product_line,
   COUNT(gender) AS total_count
   FROM walmart
   GROUP BY gender, product_line
   ORDER BY total_count DESC;
   
   --- what is the average rating of each product line ---
   SELECT 
   product_line,
   AVG(rating) AS avg_rate
  FROM walmart
  GROUP BY product_line
  ORDER BY avg_rate DESC;
  
 -----------------------------------------------------------------------------
 ----------------------------------------------------------------------------          
------------------- Sales Analysis -------------------------------------------

--- Number of sales made in each time of the day per weekday ---
SELECT time_of_day,
COUNT(*) AS total_sales
FROM walmart
WHERE day_name = "Sunday"
GROUP BY time_of_day;

--- Which of the customer types brings the most revenue? ---
SELECT customer_type, SUM(total) AS total_rev
FROM walmart
GROUP BY customer_type
ORDER BY total_rev DESC;

--- Which city has the largest tax percent/ VAT (Value Added Tax)? ---
SELECT city,
AVG(VAT) AS VAT
FROM walmart
GROUP BY city
ORDER BY VAT DESC;

--- Which customer type pays the most in VAT? ---
SELECT customer_type,
AVG(VAT) AS VAT
FROM walmart
GROUP BY customer_type
ORDER BY VAT DESC;


---------------------------------------------------------
----------------- Customers-------------------------------
--- How many unique customer types does the data have? -----
SELECT DISTINCT customer_type,
COUNT(customer_type) AS cnt
FROM walmart
GROUP BY customer_type;


--- How many unique payment methods does the data have? 
SELECT DISTINCT payment_method,
count(payment_method) AS pymt
FROM walmart;

--- What is the most common customer type? ---
SELECT customer_type,
COUNT(customer_type)
FROM walmart
GROUP BY customer_type;

--- Which customer type buys the most? ---
SELECT customer_type,
COUNT(*) cstm_cnt
FROM walmart
GROUP BY customer_type;

--- What is the gender of most of the customers? ---
SELECT gender,
COUNT(*) AS gendr_cnt
FROM walmart
GROUP BY gender;

--- What is the gender distribution per branch? ---
SELECT gender,
COUNT(*) AS gendr_cnt
FROM walmart
WHERE branch = "C"
GROUP BY gender;

--- Which time of the day do customers give most ratings? ---
SELECT time_of_day,
AVG(rating) AS avg_rating
FROM walmart
GROUP BY time_of_day
ORDER BY avg_rating;

--- Which time of the day do customers give most ratings per branch? ---
SELECT time_of_day,
AVG(rating) AS avg_rating
FROM walmart
WHERE branch = "B"
GROUP BY time_of_day
ORDER BY avg_rating;

--- Which day fo the week has the best avg ratings? ---
SELECT day_name,
AVG(rating) AS avg_rating
FROM walmart
GROUP BY day_name
ORDER BY avg_rating DESC;

--- Which day of the week has the best average ratings per branch? ---
SELECT day_name,
AVG(rating) AS avg_rating
FROM walmart
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating DESC;

--- Number of products purchased by each customer type ---
SELECT customer_type, product_line, COUNT(*) AS purchase_count
FROM walmart
GROUP BY customer_type, product_line
ORDER BY customer_type, product_line desc;