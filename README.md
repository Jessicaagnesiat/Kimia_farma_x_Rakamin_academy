# Kimia Farma Business Performance Analysis

## 📌 Project Overview

This project analyzes Kimia Farma's business performance using transaction data from January 2020 to December 2023. The analysis focuses on sales, profitability, product performance, regional performance, and customer and branch experience.

The project uses **Google BigQuery** for data preparation and SQL-based analysis, and **Looker Studio** to create an interactive business performance dashboard.

## 🎯 Objectives

The main objectives of this project are to:

- Evaluate overall sales and profitability performance
- Identify top-performing products
- Analyze sales and profit performance across provinces
- Evaluate the relationship between discounts and profitability
- Identify branches with high branch ratings but relatively low transaction ratings
- Analyze customer purchasing behavior

## 🗂️ Dataset

The project uses four main datasets:

- `kf_final_transaction` — transaction and customer information
- `kf_inventory` — inventory information
- `kf_kantor_cabang` — branch information
- `kf_product` — product information

The datasets were integrated into a final analysis table named:

`kf_final_transaction_clean`

## 🛠️ Tools & Technologies

- **Google BigQuery** — data storage, data preparation, SQL queries, and data transformation
- **SQL** — data integration, validation, and analysis
- **Looker Studio** — interactive dashboard and data visualization

## 🔄 Data Preparation

The datasets were combined using SQL `JOIN` operations based on relevant keys such as `product_id` and `branch_id`.

Additional calculated fields were created, including:

- Net Sales
- Net Profit
- Gross Profit Percentage

Data validation was also performed to check data quality, including duplicate records and missing values.

## 📊 Dashboard

The final analysis is presented through an interactive Looker Studio dashboard covering:

### Business Performance
- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Sales & Profit Trend

### Product & Regional Performance
- Top Products
- Sales by Province
- Profit by Province
- Product Category Performance

### Profitability & Customer Experience
- Discount vs Profit
- Top Customers
- Purchase Frequency
- Branch Rating vs Transaction Rating

## 🔍 Key Insights

The analysis identifies key patterns in Kimia Farma's business performance, including differences in product and regional contribution, profitability trends, discount impact, and customer and branch experience.

Detailed findings and business recommendations will be added after the final analysis is completed.

## 📁 Project Structure

```text
Kimia-Farma-Business-Analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_create_clean_table.sql
│   ├── 02_data_quality_check.sql
│   └── 03_business_analysis.sql
│
├── Dashboard/
│   └── dashboard_screenshot.png
│
└── Presentation/
    └── project_presentation.pdf
