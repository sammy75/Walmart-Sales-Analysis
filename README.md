About the Project
The project aims to explore Walmart sales data to understand top-performing branches, best-selling products, sales trends of different products, customer behavior and mainly gain insights out of the data to understand different factors that affect sales in the various branches.

The dataset was obtained from Kaggle here;https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting . The dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows.

The data required me to carry out 3 main analysis:

1.Product Analysis
Here I conducted an analysis of the find out how various product lines are performing, which products are mostly preferred in relation to gender, the average rating for each product line, best selling product in each branch, product with the largest revenue, product with the largest VAT.

The product line ranged from electronic accessories, fashion accessories, food and beverage, health and beauty, home and lifestyle, sports and travel.

2. Sales Analysis

This analysis aimed to understand the sales trend of various products so as to help the store measure how effective the sales would be and the relevant strategies that the business would apply to increase sales.

For the Sales analysis I was interested in finding the number of sales made in each time of the day per weekday, the month with the largest cost of goods sold (COGS), the total revenue by month, city with the largest tax percent.

3. Customer Analysis

Here I tried to unravel the various customer segments, purchasing trends and the profitability of each customer segment.

The customers are divided into two categories; members and normal.

I wanted to uncover and get insights on the following about the customers; gender distribution per branch, the customer type that buys most product, gender of the most customers, customer type that bring the most revenue as well as the number of unique customers in the data.

Approach used:



1.Data Wrangling

This is where I first do my data inspection to detect Null and missing values in my data and replace them.

I then built a database in MYSQL which I used for the whole analysis.



2.Feature Engineering

For this I generated new columns from existing ones which would then help me gather more insights. I added the following columns to my database;

1.time_of_day; this was to give me insight of sales made in the morning, afternoon and evening and help me answer the question on which part of the day is most sales made.
I used the CASE statement as shown

SELECT
time,
(CASE
WHEN `time` BETWEEN “00:00:00” AND “12:00:00” THEN “Morning”
WHEN `time` BETWEEN “12:01:00” AND “16:00:00” THEN “Afternoon”
ELSE “Evening”
END) AS time_of_day
FROM walmart;

2. week_day; this contains contains extracted days of the week in which transactions took place and helps answer the question, which day of the week is busiest for every branch.
   
 3. month_name; this contains the extracted months of the year when transactions took place and helps to determine the month of the year with most sales and profits.
  

3. Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.


Business Questions To Answer

Generic Question
How many unique cities does the data have?

In which city is each branch?

Product


How many unique product lines does the data have?

What is the most common payment method?

What is the most selling product line?

What is the total revenue by month?

What month had the largest COGS?

What product line had the largest revenue?

What is the city with the largest revenue?

What product line had the largest VAT?

Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

Which branch sold more products than average product sold?

What is the most common product line by gender?

What is the average rating of each product line?


Sales



Number of sales made in each time of the day per weekday

Which of the customer types brings the most revenue?

Which city has the largest tax percent/ VAT (Value Added Tax)?

Which customer type pays the most in VAT?


Customer


How many unique customer types does the data have?

How many unique payment methods does the data have?

What is the most common customer type?

Which customer type buys the most?

What is the gender of most of the customers?

What is the gender distribution per branch?

Which time of the day do customers give most ratings?

Which time of the day do customers give most ratings per branch?

Which day fo the week has the best avg ratings?

Which day of the week has the best average ratings per branch?



Revenue And Profit Calculations
$ COGS = unitsPrice * quantity $

$ VAT = 5% * COGS $

V
A
T
 is added to the 
C
O
G
S
 and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

Example with the first row in our DB:

Data given:

$ \text{Unite Price} = 45.79 $
$ \text{Quantity} = 7 $
$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5% * COGS\= 5% 320.53 = 16.0265 $

$ total = VAT + COGS\= 16.0265 + 320.53 = 
336.5565

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\=\frac{16.0265}{336.5565} = 0.047619\\approx 4.7619% $


