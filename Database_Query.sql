-- 1. Create a database named Customers.

CREATE DATABASE CUSTOMERS
SELECT * FROM CUSTOMERS.dbo.flo_data_20K

-- 2. Write the Query to Return the Total Turnover.

SELECT SUM(customer_value_total_ever_offline+customer_value_total_ever_online) CIRO
FROM CUSTOMERS.dbo.flo_data_20K

-- 3. Write down the query that generates the average turnover per invoice.
-- Since there is no invoice data, it is possible to see how much the customer spends on average.

SELECT  master_id,SUM(customer_value_total_ever_offline+customer_value_total_ever_online)/SUM(order_num_total_ever_offline+order_num_total_ever_online) ORTALAMA
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id

-- 4. Write the query that will fetch the total turnover distribution of the purchases made through the last shopping platforms.


SELECT last_order_channel SONPLATFORM, 
SUM(customer_value_total_ever_offline+customer_value_total_ever_online) CIRO
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY last_order_channel

-- 5. Write the Query to Return the Total Number of Invoices Made
-- Since there is no invoice data, the total number of orders was found.

SELECT SUM(order_num_total_ever_offline+order_num_total_ever_online) TOPLAMSIPARIS
FROM CUSTOMERS.dbo.flo_data_20K

-- 6. Write the query that will fetch the distribution of the last shopping platform of the shoppers in terms of invoices. 


SELECT last_order_channel,
SUM(order_num_total_ever_offline+order_num_total_ever_online) TOPLAMSIPARIS
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY last_order_channel

 -- 7. Write the query that will bring the total product sales amount.
 -- It was answered by considering that only one product was purchased in each purchase.

SELECT SUM(order_num_total_ever_offline+order_num_total_ever_online) TOPLAMURUN
FROM CUSTOMERS.dbo.flo_data_20K

-- 8. Write the query that will bring the number of products in year breakdown.

SELECT DATEPART(YEAR,last_order_date) SIPARISYILI,
SUM(order_num_total_ever_offline+order_num_total_ever_online) URUNSAYISI
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY DATEPART(YEAR,last_order_date)

-- 9. Write the query that will bring the average number of products in the platform breakdown.
SELECT order_channel,
AVG(order_num_total_ever_offline+order_num_total_ever_online) ORTALAMAURUNSAYISI
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY order_channel

-- 10. Write a query that shows how many different people shopped.

SELECT COUNT(master_id) as "M��TER� SAYISI"
FROM CUSTOMERS.dbo.flo_data_20K

-- 11. Write the query that brings up the most popular category in the last 12 months.

SELECT TOP 1 interested_in_categories_12 as "ENCOKILGI"
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY interested_in_categories_12
ORDER BY COUNT(interested_in_categories_12) DESC

-- 12. Write the query that brings the most popular categories in the channel breakdown.

SELECT order_channel,interested_in_categories_12,
COUNT(interested_in_categories_12) ENCOKILGI
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY order_channel,interested_in_categories_12
ORDER BY order_channel,COUNT(interested_in_categories_12) DESC;

-- 13. Write the query that returns the most preferred store types.

SELECT store_type, COUNT(store_type) AS STORE_TYPE_COUNT
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY store_type
ORDER BY COUNT(store_type) DESC;

-- 14. Write the query that returns the total turnover obtained in the Store type breakdown.

SELECT store_type,
SUM(customer_value_total_ever_offline+customer_value_total_ever_online) CIRO
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY store_type

-- 15. Write the query that brings the most popular store type in channel breakdown.
SELECT TOP 4 order_channel, store_type, COUNT(store_type) AS StoreTypeCount
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY order_channel, store_type
ORDER BY COUNT(store_type) DESC;

-- 16. Write the query that returns the ID of the person who makes the most purchases.
SELECT TOP 1 master_id
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id
ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC

-- 17. Write the query that returns the average per invoice of the person who makes the most purchases.

SELECT TOP 1 master_id,
SUM(customer_value_total_ever_offline+customer_value_total_ever_online)/SUM(order_num_total_ever_offline+order_num_total_ever_online) ORTALAMA
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id
ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC

-- 18. Write the query that returns the average number of shopping days of the person who makes the most purchases.
-- It is found how many purchases the user makes per day.

SELECT TOP 1 master_id,
SUM(order_num_total_ever_online + order_num_total_ever_offline)/(DATEDIFF(DAY,first_order_date,last_order_date)+0.01) GUN_ORTALAMASI
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id,DATEDIFF(DAY,first_order_date,last_order_date)
ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC

-- 19. Write the query that returns the average shopping day of the first 100 people (in terms of turnover) who shopped the most.
SELECT TOP 100 master_id,
SUM(order_num_total_ever_online + order_num_total_ever_offline)/(DATEDIFF(DAY,first_order_date,last_order_date)+0.01) GUN_ORTALAMASI
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id,DATEDIFF(DAY,first_order_date,last_order_date)
ORDER BY SUM(customer_value_total_ever_offline+customer_value_total_ever_online) DESC

-- 20. Write the query that brings the most shoppers in the platform breakdown.

SELECT TOP (1) master_id,order_channel,
SUM(order_num_total_ever_online + order_num_total_ever_offline) EN_COK_ALISVERIS
FROM CUSTOMERS.dbo.flo_data_20K
GROUP BY master_id, order_channel
ORDER BY SUM(order_num_total_ever_online + order_num_total_ever_offline) DESC

-- 21. Write the query that returns the ID of the last shopper. (There is more than one shopper ID on the max deadline. Bring them too.)

SELECT master_id 
FROM CUSTOMERS.dbo.flo_data_20K 
WHERE last_order_date = (SELECT MAX(last_order_date) 
FROM CUSTOMERS.dbo.flo_data_20K) 

-- 22. Write the query that returns the average day of shopping of the last shopper.

SELECT TOP 1 master_id , last_order_date,
SUM(order_num_total_ever_online + order_num_total_ever_offline)/(DATEDIFF(DAY, first_order_date, last_order_date)+0.01) GUN_ORT
FROM CUSTOMERS.dbo.flo_data_20K 
WHERE last_order_date = (SELECT MAX(last_order_date) 
FROM CUSTOMERS.dbo.flo_data_20K)
GROUP BY master_id, last_order_date,(DATEDIFF(DAY, first_order_date, last_order_date))
ORDER BY GUN_ORT DESC

-- 23. Write the query that returns the average of the last shoppers per invoice in the platform breakdown.

SELECT master_id , order_channel,last_order_date,
SUM(customer_value_total_ever_offline+customer_value_total_ever_online)/SUM(order_num_total_ever_online + order_num_total_ever_offline) FATURA_ORT
FROM CUSTOMERS.dbo.flo_data_20K 
WHERE last_order_date = (SELECT MAX(last_order_date) 
FROM CUSTOMERS.dbo.flo_data_20K)
GROUP BY master_id, order_channel,last_order_date
ORDER BY FATURA_ORT DESC

-- 24. Write the query that returns the ID of the person who made the first purchase.

SELECT master_id, first_order_date FROM CUSTOMERS.dbo.flo_data_20K
WHERE first_order_date = (SELECT MIN(first_order_date) FROM CUSTOMERS.dbo.flo_data_20K)

-- 25. Write the query that returns the average shopping day of the first shopper.

SELECT master_id, first_order_date,
SUM(order_num_total_ever_online + order_num_total_ever_offline)/(DATEDIFF(DAY, first_order_date, last_order_date)+0.01) GUN_ORT 
FROM CUSTOMERS.dbo.flo_data_20K
WHERE first_order_date = (SELECT MIN(first_order_date) 
FROM CUSTOMERS.dbo.flo_data_20K)
GROUP BY master_id, first_order_date,(DATEDIFF(DAY, first_order_date, last_order_date))
ORDER BY GUN_ORT DESC