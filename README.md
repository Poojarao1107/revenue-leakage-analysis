# Revenue Leakage Analysis

## Project Overview

This project is based on analyzing revenue leakage in an e-commerce dataset. The main idea was to understand where money is getting **lost** due to high shipping costs, inefficient pricing, or delivery issues.

The project covers the full workflow — from raw data cleaning to building a final dashboard in Power BI.

## Objective
The analysis is driven by the following key questions:
- What percentage of orders have a high shipping cost?
- Which product categories have the highest shipping ratio?
- What percentage of orders are delivered late?
- Which product categories have the most late deliveries?
- Which product categories contribute the most to revenue leakage due to shipping?

## Dataset Used
The **Olist Brazilian E-commerce dataset** was used, focusing on the following tables:
- orders
- order_items
- products
- product_category_name_translation

After cleaning and merging, the final dataset created was: 
**orders_pruducts_final** table.

## Data Cleaning & Preparation using (Python - Pandas)

Key steps performed:
- Checked for duplicate records and handled missing values
- Merged multiple tables into a single cleaned dataset
- Translated product categories from Portuguese to English
- Fixed data types for accurate analysis
- Missing categories were labeled as **Unknown** instead of removing them

To analyze shipping and delivery inefficiency, some new columns were created:
- **shipping_ratio** = freight_value / price
- A **high_shipping** flag to identify problematic orders
- **delivery_delay** indicator using delivery timestamps
- **delivery_days** to calculate delivery duration

## Tools Used
- Python (Pandas) = Data cleaning and preparation
- MySQL = Data analysis using SQL queries
- Power BI = Dashboard and visualization
- MS-Excel = Handling raw csv files.

## Dashboard Preview

### Overview

![Dashboard](Dashboard_image/Dashboard.png)

### 🔹 Shipping & Delivery Analysis

![Shipping & Delivery Analysis](Dashboard_image/Shipping_&_Delivery_Analysis.png)

### 🔹 High Shipping Products

![Table](Dashboard_image/Top_Shipping_Product_Categories.png)

## Key Insights
- Some categories have significantly higher shipping costs compared to product price.
- A few low-cost products show very high shipping ratios.
- "Unknown" also appears in the data, which indicates missing information in source data.
- Late deliveries exist and can impact customer experience.

## Recommendations
- Optimize shipping strategy for categories with high shipping ratios
- Re-evaluate pricing for low-cost products with high shipping costs
- Improve logistics planning to reduce late deliveries
- Investigate "Unknown" category data to improve overall data quality

## Author
Pooja
