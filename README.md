# E-Commerce Sales SQL EDA  

## **Abstract**  
This project performs a comprehensive **Exploratory Data Analysis (EDA)** on a multi-year e-commerce sales dataset (2016–2019) using SQL.  
The analysis focuses on **data cleaning, transformation, and deriving business insights** related to sales, costs, profits, seasonal trends, top-performing products, and geographical performance.  

---

## **Problem Statement**  
E-commerce companies generate vast amounts of sales data, but without structured analysis, it is challenging to identify patterns, track performance, and make data-driven decisions.  
The aim of this project is to clean, merge, and analyze historical sales data to extract **meaningful insights** that can help drive **business growth and profitability**.  

---

## **Objectives**  
- **Data Cleaning**: Handle missing values, remove duplicates, and standardize formats.  
- **Data Integration**: Merge yearly sales datasets into a single consolidated table.  
- **Feature Engineering**: Add new columns for Year, Month, and Product Category.  
- **Sales Analysis**: Track revenue, cost, and profit trends over time.  
- **Geographical Insights**: Identify high-performing countries.  
- **Product Insights**: Discover top-performing products and categories.  
- **Trend Analysis**: Understand seasonal and yearly growth patterns.  

---

## **Tools & Technologies Used**  
- **SQL**: Data extraction, transformation, and aggregation.  
- **MySQL**: Database creation, storage, and querying.  
- **Windows/Linux Environment**: For running SQL scripts.  

---

## **Methodology**  

### 1 Database Creation  
- Created a new database **`STORE_SALES`** to store yearly sales data.  

### 2 Data Inspection  
- Queried each dataset to check for missing values and inconsistencies.  

### 3 Data Cleaning  
- Checked for **NULLs, blanks, and duplicates** across all tables.  

### 4 Data Consolidation  
- Merged all yearly sales data (**2016–2019**) into one table **`sales_table`**.  

### 5 Feature Engineering  
- Added **Year** and **Month** columns from the Date field.  
- Created a **Category** column by classifying products into *Pastries*, *Beverages*, and *Food*.  

### 6 Exploratory Analysis  
- Calculated total **Cost**, **Price**, and **Profit** by Year, Month, Country, and Product Category.  
- Identified **Top 10 Products** per Year.  
- Measured **Year-on-Year (YoY) Profit Growth**.  
- Counted **unique countries served**.  

---

## **Key Insights**  
 **Profit Trend**: Continuous YoY profit growth from 2016 to 2019.  
 **Top Country**: A few countries consistently drive the highest profits.  
 **Category Performance**: Pastries emerged as the most profitable category overall.  
 **Product Leaders**: Certain products dominated sales in multiple years.  
 **Seasonality**: Specific months recorded significantly higher profits, indicating seasonal demand.  
 **High Growth Years**: 2018 and 2019 recorded the strongest YoY profit increases.  

---

## **Recommendations**  
- **Focus on High-Performing Countries**: Increase marketing and supply chain efficiency in top markets to maximize ROI.  
- **Expand Profitable Categories**: Invest more in *Pastries* and other high-margin categories.  
- **Seasonal Promotions**: Launch targeted campaigns in peak months to leverage demand spikes.  
- **Product Portfolio Optimization**: Discontinue low-performing products and prioritize bestsellers.  
- **Market Diversification**: Explore new countries to reduce overreliance on a few markets.  
