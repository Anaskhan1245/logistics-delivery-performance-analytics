# 🚚 Logistics Delivery Performance Analytics

An end-to-end Data Analytics project focused on analyzing logistics delivery performance, identifying high-risk segments, understanding delivery delays, measuring business impact, and generating actionable recommendations.

This project demonstrates a complete analytics workflow using **Python, PostgreSQL, SQL, and Power BI**.

---

## 📌 Project Overview

The project analyzes logistics delivery data to understand how different operational factors affect delivery performance.

The analysis focuses on:

- Delivery delays
- Late delivery risk
- Shipping mode performance
- Regional performance
- Product category performance
- Customer segment performance
- Actual vs scheduled shipping time
- Shipping gaps
- Sales and profitability
- High-risk operational segments
- Business impact of delivery delays

The final outcome is an interactive **Power BI dashboard** designed to help business stakeholders identify delivery-risk areas and prioritize operational improvements.

---

## 🎯 Business Objective

The main objective is to answer key business questions:

- Which shipping modes have the highest late-delivery risk?
- Which regions are experiencing higher delivery delays?
- Which product categories have higher delivery risk?
- Which customer segments are more affected by delays?
- How much longer are shipments taking compared with their scheduled time?
- Which shipping mode and region combinations are high priority?
- What is the potential business impact of delivery delays?
- What actions can be taken to improve logistics performance?

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| Python | Data exploration and analysis |
| Pandas | Data manipulation |
| NumPy | Numerical analysis |
| Jupyter Notebook | Exploratory Data Analysis |
| PostgreSQL | Data storage and querying |
| SQL | Business analysis and KPI calculation |
| Power BI | Dashboard development and visualization |
| Excel / Power Query | Data preparation |
| GitHub | Project documentation and version control |

---

## 🔄 Project Workflow

```text
Raw Logistics Data
        ↓
Data Understanding
        ↓
Data Quality Checks
        ↓
Python / Jupyter Analysis
        ↓
PostgreSQL Database
        ↓
SQL Business Analysis
        ↓
KPI & Risk Analysis
        ↓
Power BI Dashboard
        ↓
Root Cause Analysis
        ↓
Business Recommendations




## 📊 Key KPIs

The analysis and Power BI dashboard focus on the following KPIs:

- Total Orders
- Total Sales
- Total Profit
- Late Orders
- Late Delivery Rate
- Average Actual Shipping Days
- Average Scheduled Shipping Days
- Average Shipping Gap
- Estimated Late Orders

These KPIs provide a high-level view of overall logistics performance.

---

## 🔍 Key Analysis Areas

### 1. Delivery Performance

Analysis of actual delivery performance compared with scheduled delivery expectations.

### 2. Shipping Mode Analysis

Comparison of delivery performance across different shipping modes.

### 3. Regional Analysis

Identification of regions with higher late-delivery risk and larger shipping gaps.

### 4. Product Category Analysis

Comparison of late-delivery performance across product categories.

### 5. Customer Segment Analysis

Analysis of delivery performance across different customer segments.

### 6. Shipping Gap Analysis

Comparison between:

`Actual Shipping Days - Scheduled Shipping Days`

A positive gap indicates that actual shipping time exceeded the scheduled time.

### 7. Risk Segment Analysis

Identification of high-risk combinations using:

`Shipping Mode + Order Region`

### 8. Business Impact Analysis

Analysis of sales, profit, order volume, and delivery performance to understand the potential business impact of operational issues.

---

## 💡 Key Findings

The analysis identified several important logistics performance patterns:

- First Class and Second Class shipping modes show higher late-delivery rates compared with Standard Class.
- Several regions demonstrate elevated delivery risk.
- Actual shipping duration exceeds scheduled shipping duration across several segments.
- Higher shipping gaps are associated with increased late-delivery risk.
- Certain product categories show comparatively higher delivery risk.
- Certain customer segments demonstrate different levels of delivery performance.
- Some combinations of shipping mode and region represent high-priority operational risks.
- Delivery delays can affect operational performance as well as sales and profitability.

---

## 🚨 Root Cause Analysis

The analysis suggests that delivery delays are influenced by multiple operational dimensions rather than a single factor.

### Major areas requiring investigation:

- High-risk shipping modes
- High-risk geographic regions
- Large gaps between scheduled and actual shipping time
- Product categories with consistently higher delivery risk
- Specific shipping mode + region combinations

The analysis therefore focuses on identifying **where the problem is occurring** and then determining **which operational segment should be prioritized**.

---

## 💰 Business Impact

Delivery delays can create several business risks:

- Poor customer experience
- Missed delivery commitments
- Increased operational pressure
- Inefficient logistics planning
- Potential profitability impact
- Higher risk in specific shipping and regional segments

The dashboard helps stakeholders identify these areas and prioritize improvement efforts based on measurable performance indicators.

---

## 🎯 Business Recommendations

Based on the analysis, the following actions are recommended:

### 1. Review High-Risk Shipping Modes

Review carrier performance, SLA adherence, and operational processes for shipping modes with consistently high late-delivery rates.

### 2. Improve Regional Logistics Planning

Prioritize high-risk regions for logistics capacity planning, routing improvements, and operational monitoring.

### 3. Reduce Shipping Gaps

Investigate segments where actual shipping time consistently exceeds scheduled shipping time.

### 4. Investigate High-Risk Categories

Analyze inventory availability, warehouse processing, fulfillment time, and transportation issues for categories showing higher delivery risk.

### 5. Monitor High-Risk Segments

Create regular monitoring for combinations of:

`Shipping Mode + Order Region`

to identify emerging delivery problems early.

### 6. Improve Delivery Visibility

Use Power BI reporting and KPI monitoring to continuously track delivery performance and identify operational deviations.

---

# 📊 Power BI Dashboard

The final Power BI dashboard consists of three analytical pages.

## Page 1 — Executive Overview

Provides an executive-level summary of logistics performance.

### Key Metrics

- Total Orders
- Total Sales
- Total Profit
- Late Orders
- Late Delivery Rate
- Average Actual Shipping Days
- Average Scheduled Shipping Days
- Average Shipping Gap

### Analysis

- Monthly sales trend
- Monthly delivery trend
- Shipping mode performance
- Delivery status distribution
- Overall logistics performance

---

## Page 2 — Delivery Performance

Provides detailed analysis across major business dimensions.

### Analysis Includes

- Shipping Mode
- Order Region
- Product Category
- Customer Segment
- Late Delivery Rate
- Shipping Gap
- Sales
- Profit
- Delivery Performance

This page helps identify the segments where delivery performance is weakest.

---

## Page 3 — Root Cause Analysis & Recommendations

Converts analytical findings into business actions.

### Focus Areas

- Key delivery problems
- High-risk segments
- Root cause indicators
- Business impact
- Priority areas
- Recommended actions

The objective is to move from:

`What Happened? → Where Is It Happening? → Why Is It Happening? → What Should The Business Do?`

---

# 📸 Dashboard Preview

## Executive Overview

![Executive Overview](5-Dashboard_Screenshots/01_Executive_Overview.png)

## Delivery Performance

![Delivery Performance](5-Dashboard_Screenshots/02_Delivery_Performance.png)

## Root Cause Analysis & Recommendations

![Root Cause Analysis](5-Dashboard_Screenshots/03_Root_Cause_Recommendations.png)

---

# 🗄️ SQL Analysis

PostgreSQL and SQL were used to perform detailed business analysis.

### SQL Analysis Includes

- Data quality checks
- Total and unique order analysis
- Customer analysis
- Duplicate analysis
- Delivery status analysis
- Late delivery rate
- Shipping mode performance
- Regional performance
- Category performance
- Customer segment performance
- Market-level analysis
- Monthly trend analysis
- Shipping gap analysis
- High-risk segment ranking
- Estimated late orders
- Sales and profit analysis

### SQL Concepts Used

- `GROUP BY`
- `HAVING`
- `CASE WHEN`
- `CTE`
- `WINDOW FUNCTIONS`
- `RANK()`
- `FILTER`
- `DATE_TRUNC()`
- Aggregate Functions
- Conditional Logic

SQL queries are available in:

`3-SQL/`

---

# 🐍 Python / Jupyter Analysis

Python and Jupyter Notebook were used during the initial data exploration and analysis stage.

### Analysis Performed

- Dataset exploration
- Data structure understanding
- Data quality checks
- Missing-value checks
- Duplicate checks
- Data type analysis
- Exploratory analysis
- Delivery-related analysis
- Business insight generation

Notebook files are available in:

`4-Notebook/`
