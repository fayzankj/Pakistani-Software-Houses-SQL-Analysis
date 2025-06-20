# 🇵🇰 Pakistani Software Houses – SQL Data Cleaning & Analysis

A complete SQL project built on real-world messy data from popular software development companies in Pakistan. This project demonstrates data cleaning, null and duplicate handling, and insightful analysis using SQL - perfect for showcasing practical data wrangling and reporting skills on semi-structured business data.

---

## 📁 Dataset

- **Source**: [Software Houses in Pakistan - 2023 (Kaggle)](https://www.kaggle.com/datasets/hammadjavaid/it-industry-software-houses-in-pakistan)
- Total Records: ~700
- Fields:
  - `company_name`
  - `city`
  - `address`
  - `contact_no`
  - `services`

---

## ⚙️ Data Cleaning Performed
✅ Replaced fake nulls ('N/A', 'Not Available', '-') with real NULL

✅ Cleaned garbage values (e.g., '#ERROR!' in contact_no)

✅ Removed records with missing essential fields (e.g., NULL in city)

✅ Identified and checked exact duplicates across all fields

✅ Standardized text formatting (lowercased, trimmed, normalized city/service names)

---

## 🔍 SQL Analysis Performed

### 📊 Basic Analysis

- Count of companies per city
- Count of companies with valid contact info
- Top 5 most common services
- Underserved cities (least companies)
- Unknown or missing company names or services

### 🧠 Advanced Analysis

- Companies listed in multiple cities
- Companies offering both Software Development & Digital Marketing
- Percentage share of companies by city
- **Completeness Score** per company (0–4):
  - Has contact
  - Has valid city
  - Has services
  - Has a unique company name

---

## 🛠 Skills Demonstrated

- SQL data wrangling with real-world inconsistencies
- Handling nulls, text cleaning, and format standardization
- Aggregation, grouping, filtering, CASE, and CTE usage
- Data validation logic and completeness scoring
- Analytical querying for business insights
---

# 🇵🇰 Pakistani Software Houses – SQL Data Cleaning & Analysis


![SQL](https://img.shields.io/badge/SQL-Structured%20Query%20Language-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg?logo=mysql)
![Data Cleaning](https://img.shields.io/badge/Data%20Cleaning-%E2%9C%94%EF%B8%8F-success)
![Duplicates Checked](https://img.shields.io/badge/Duplicates-Checked-lightblue)
![Fake Nulls Handled](https://img.shields.io/badge/Fake%20Nulls-Handled-orange)
![Completeness Score](https://img.shields.io/badge/Completeness%20Score-Evaluated-yellow)
![Real Dataset](https://img.shields.io/badge/Dataset-Real--World-informational)
![Rows](https://img.shields.io/badge/Total%20Rows-700-lightgrey)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

This project presents an end-to-end data cleaning and analysis workflow on a real-world dataset...

