
#  PC Sales Analytics Data Warehouse

<div align="center">

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-4479A1?style=for-the-badge&logo=databricks&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SSIS](https://img.shields.io/badge/SSIS-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

![Status](https://img.shields.io/badge/Status-Active%20Development-brightgreen?style=flat-square)
![Architecture](https://img.shields.io/badge/Architecture-Star%20Schema-blueviolet?style=flat-square)
![Dimensions](https://img.shields.io/badge/Dimensions-7%20Tables-blue?style=flat-square)
![Layer](https://img.shields.io/badge/Layer-Analytics%20Ready-orange?style=flat-square)



</div>

---

## 📌 Table of Contents

- [Business Problem](#-business-problem)
- [Architecture](#-architecture)
- [Data Model](#-data-model)
- [ETL Pipeline](#-etl-pipeline)
- [Analytics Use Cases](#-analytics-use-cases)
- [Data Quality](#-data-quality-layer)
- [Tech Stack](#-tech-stack)
- [Author](#-author)

---

## 🧠 Business Problem

Retail PC sales data is typically:

- **Inconsistent** — messy dates, nulls, mixed formats
- **Fragmented** — siloed across multiple source systems
- **Not analytics-ready** — unsuitable for direct BI consumption

**Goal:** Transform raw PC sales data into a clean, scalable, and BI-ready data warehouse that enables revenue analysis, sales trend tracking, customer behavior insights, and product performance benchmarking.

---

## 🏗️ Architecture

This project implements a **Star Schema** design — a proven, industry-standard dimensional modelling approach optimised for high-performance analytical querying and BI tool compatibility.

```
        ┌──────────────────────────────────────┐
        │         SOURCE SYSTEMS               │
        │    CSV Extracts / OLTP Databases     │
        └─────────────────┬────────────────────┘
                          │
                          ▼
        ┌──────────────────────────────────────┐
        │           STAGING LAYER              │
        │  Raw data ingestion & type casting   │
        └─────────────────┬────────────────────┘
                          │
                          ▼
        ┌──────────────────────────────────────┐
        │       CLEANSED / CONFORMED LAYER     │
        │  Deduplication · Standardisation     │
        │  NULL handling · Date parsing        │
        └─────────────────┬────────────────────┘
                          │
                          ▼
        ┌──────────────────────────────────────┐
        │        STAR SCHEMA (GOLD LAYER)      │
        │  fact_pc_sales + 7 Dimension Tables  │
        └─────────────────┬────────────────────┘
                          │
                          ▼
        ┌──────────────────────────────────────┐
        │     BI TOOLS — Power BI / Tableau    │
        │  Dashboards · KPIs · Trend Reports   │
        └──────────────────────────────────────┘
```

---

## 📐 Data Model

### ⭐ Star Schema Overview

The warehouse is centred around a single fact table joined to **7 dimension tables**, enabling multi-dimensional slice-and-dice analysis across all key business entities.

```
                        ┌─────────────────┐
                        │   dim_date      │
                        └────────┬────────┘
                                 │
  ┌──────────────┐    ┌──────────┴──────────┐    ┌──────────────────┐
  │ dim_customer ├────┤                     ├────┤   dim_product    │
  └──────────────┘    │   fact_pc_sales     │    └──────────────────┘
                      │                     │
  ┌──────────────┐    │   · finace_Amount   │    ┌──────────────────┐
  │ dim_location ├────┤   · credit_score    ├────┤    dim_store     │
  └──────────────┘    │   · Discount_Amount │    └──────────────────┘
                      │   · priority        │
  ┌────────────────┐  └──────────┬──────────┘  ┌──────────────────┐
  │dim_payment_mthd├─────────────┘             │    dim_price     │
  └────────────────┘                           └──────────────────┘
```

### 🔑 Fact Table

| Table | Description |
|---|---|
| `fact_pc_sales` | Central transactional fact table capturing all sales events |

**Measures:** Sales Amount · Quantity Sold · Discount Amount · Net Revenue

### 📦 Dimension Tables

| Dimension | Description |
|---|---|
| `dim_customer` | Customer demographics and profile attributes |
| `dim_location` | Geographic hierarchy — city, region, country |
| `dim_store` | Store details — type, name, region mapping |
| `dim_product` | PC product catalogue — brand, specs, category |
| `dim_payment_method` | Payment type classification — cash, card, BNPL, etc. |
| `dim_price` | Price tiers, list price, promotional pricing |
| `dim_date` | Full date dimension — day, week, month, quarter, year, fiscal period |

---

## ⚙️ ETL Pipeline

### Data Flow Stages

**Stage 1 — Extraction**
Raw data is ingested from CSV extracts and OLTP source systems into a staging schema, preserving source fidelity with no transformation applied.

**Stage 2 — Cleansing & Standardisation**
Staged data undergoes validation and cleaning including date format standardisation using `TRY_CONVERT`, NULL imputation on critical fields, deduplication of transaction records, and data type enforcement across all columns.

**Stage 3 — Dimension Loading**
Each of the 7 dimension tables is populated via dedicated stored procedures, applying surrogate key generation and conforming attributes to the enterprise data dictionary.

**Stage 4 — Fact Table Load**
The `fact_pc_sales` fact table is loaded via a stored procedure that joins cleansed transactional data to resolved dimension surrogate keys, producing a fully joined, analytics-ready fact layer.

### Data Quality Checks Applied

- ✅ NULL validation on all foreign key columns
- ✅ Date parsing validation (`TRY_CONVERT` with fallback handling)
- ✅ Duplicate transaction detection and removal
- ✅ Referential integrity enforcement between fact and dimensions
- 🔜 Automated anomaly detection rules (Phase 2)

---

## 📊 Analytics Use Cases

The warehouse enables the following analytical workloads out of the box:

| Use Case | Dimensions Involved |
|---|---|
| 💰 Revenue by product category | `dim_product`, `dim_price` |
| 📅 Monthly & quarterly sales trends | `dim_date` |
| 👤 Customer purchase behaviour | `dim_customer`, `dim_payment_method` |
| 🖥️ PC product performance comparison | `dim_product`, `dim_price` |
| 🏪 Store-level performance | `dim_store`, `dim_location` |
| 📍 Regional revenue breakdown | `dim_location` |
| 💳 Payment method preference analysis | `dim_payment_method`, `dim_customer` |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| 🗄️ **SQL Server** | Data warehouse engine |
| 🧱 **T-SQL** | Data transformation & stored procedures |
| ⚙️ **SSIS** | ETL orchestration & batch loading |
| 📊 **Power BI** | Reporting, dashboards & KPI storytelling |
| 🔧 **Git** | Version control & project management |

---

## 🚧 Current Limitations

- Full table reload only — incremental load logic not yet implemented
- Slowly Changing Dimension (SCD) handling not yet applied
- Power BI dashboard layer still in development

---

## 📷 Visuals *(Coming Soon)*

- 🏗️ Architecture diagram
- 📐 Full star schema ERD

<img width="789" height="750" alt="image" src="https://github.com/user-attachments/assets/6e65b0c8-af24-4f49-94c7-ab599e109954" />

- 🔄 ETL data lineage map
- 📊 Power BI dashboard preview

---

## 👩🏽‍💻 Author

Letsoalo M
---

<div align="center">

