# Rankamin_finale_project

## 📌 Project Description
This project analyzes the business performance of Kimia Farma from 2020 to 2023 using BigQuery and Google Looker Studio. The goal is to transform raw data into meaningful insights such as sales trends, branch performance, and customer ratings. The data is processed using SQL in BigQuery and visualized through an interactive dashboard.

## 🎯 Objectives
 - Analyze revenue and profit trends from 2020 to 2023
 - Identify top-performing branches
 - Identify Profitable products 

## 🗂️ Dataset Information

The analysis_table column information:

The analysis_table table is actually made by merging 4 datasets

1. kf_final_transaction.csv
     - transaction_id: transaction ID
     - product_id: product ID (medicine)
     - branch_id: Kimia Farma branch ID
     - customer_name: name of the customer who made the transaction
     - date: transaction date
     - price: product price
     - discount_percentage: percentage of discount applied to the product
     - rating: customer rating for the transaction
2. kf_product.csv
3. kf_inventory.csv
4. kf_kantor_cabang.csv
