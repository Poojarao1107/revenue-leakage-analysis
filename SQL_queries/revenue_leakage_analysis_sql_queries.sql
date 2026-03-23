# QUERIES FOR EXPLORING AND UNDERSTANDING THE DATA

# total number of rows
SELECT COUNT(*) AS total_rows
FROM orders_products_final;

# price distribution summary
SELECT MIN(price) AS min_price, MAX(price) AS max_price, round(AVG(price),2) AS avg_price
FROM orders_products_final;

# shipping cost distribution summary
SELECT MIN(freight_value) AS min_shipping, MAX(freight_value) AS max_shipping, round(AVG(freight_value),2) AS avg_shipping
FROM orders_products_final;

# total revenue and total shipping cost overview
SELECT round(SUM(price),0) AS total_revenue, round(SUM(freight_value),0) AS total_shipping_cost
FROM orders_products_final;

# high shipping orders
SELECT high_shipping, COUNT(*) AS order_items
FROM orders_products_final
GROUP BY high_shipping;

# late deliveries
SELECT is_delivery_late, COUNT(*) AS order_items
FROM orders_products_final
GROUP BY is_delivery_late;

# identifying most frequent ordered product categories
SELECT product_category, COUNT(*) AS total_orders
FROM orders_products_final
GROUP BY product_category
ORDER BY total_orders DESC;

# avg shipping ratio by product categories
SELECT product_category, round(AVG(shipping_ratio) * 100, 2) AS avg_shipping_ratio_percent
FROM orders_products_final
GROUP BY product_category
ORDER BY avg_shipping_ratio_percent DESC;

# checking for missing product category values
SELECT * FROM orders_products_final
WHERE product_category IS NULL;

# checking for any invalid price values
SELECT * FROM orders_products_final
WHERE price <= 0;

# checking for invalid negative shipping cost
SELECT * FROM orders_products_final
WHERE freight_value < 0;

# top orders with highest late deliveries
SELECT * FROM orders_products_final
ORDER BY delivery_delay DESC
LIMIT 10;

# late deliveries summary
SELECT MIN(delivery_delay) AS min_delivery_delay, MAX(delivery_delay) AS max_delivery_delay, round(AVG(delivery_delay),0) AS avg_delivery_delay
FROM orders_products_final;


# REVENUE LEAKAGE ANALYSIS FOCUS QUERIES

# what percentage of orders have high shipping cost?
SELECT COUNT(DISTINCT order_id) AS total_orders,
       COUNT(DISTINCT CASE WHEN high_shipping = 1 THEN order_id END) AS high_shipping_orders,
       round(COUNT(DISTINCT CASE WHEN high_shipping = 1 THEN order_id END) / COUNT(DISTINCT order_id) * 100, 2) AS high_shipping_percentage
FROM orders_products_final;

# which product categories have highest shipping ratio?
SELECT product_category, round(AVG(shipping_ratio)*100,2) AS avg_shipping_ratio_percentage
FROM orders_products_final
GROUP BY product_category
ORDER BY avg_shipping_ratio_percentage DESC;

# how many orders are delivered late?
SELECT count(*) AS late_deliveries
FROM orders_products_final
WHERE is_delivery_late = 1;

# which product categories have most late deliveries?
SELECT product_category, count(*) AS late_deliveries
FROM orders_products_final
WHERE is_delivery_late = 1
GROUP BY product_category
ORDER BY late_deliveries DESC;

# which product categories lose most revenue to shipping cost?
SELECT product_category, 
	round(SUM(price),0) AS total_revenue, 
        round(SUM(freight_value),0) AS total_shipping_cost, 
        round(SUM(freight_value)/SUM(price)*100,2) AS shipping_cost_percentage
FROM orders_products_final
GROUP BY product_category
ORDER BY shipping_cost_percentage DESC;

# shipping cost categories
SELECT CASE
	WHEN shipping_ratio < 0.3 THEN 'low shipping cost'
    	WHEN shipping_ratio BETWEEN 0.3 AND 0.6 THEN 'moderate shipping cost'
    	ELSE 'high shipping cost'
       END AS shipping_cost_category,
       COUNT(*) AS total_orders
FROM orders_products_final
GROUP by shipping_cost_category
ORDER BY total_orders DESC;