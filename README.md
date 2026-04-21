SQL Exploratory Data Analysis Project

An EDA project built on a retail Data Warehouse using SQL Server, analyzing customers, products, and sales data.

---

📁 Project Files

| File | Description |
|---|---|
| `00_init_database.sql` | Creates database, schema, tables & imports CSVs |
| `SQL_EDA_Project.sql` | All EDA queries |
| `data/gold_dim_customers.csv` | Customer data |
| `data/gold_dim_products.csv` | Product data |
| `data/gold_fact_sales.csv` | Sales data |

---

⚙️ Setup

1. Clone the repo
2. Open `Setup_SQL` and **update the 3 CSV file paths** to your local machine path
3. Run `Setup_SQL` in SSMS — this creates the database and imports all data
4. Run queries from `SQL_EDA_Project.sql`

> ⚠️ The init script **drops and recreates** `DataWarehouseAnalytics` if it already exists.

---

🔍 Analysis Covered

- Dimensions exploration (countries, categories, products)
- Date range & customer age analysis
- Key business metrics (revenue, orders, quantity, avg price)
- Magnitude analysis by country, gender, and category
- Ranking: top/bottom products & customers

---

 🛠️ Tools
SQL Server · SSMS · T-SQL

---

👤 Author
Muhammad Ibtisam  — [GitHub](https://github.com/Shk-Ibtisam) · [LinkedIn](https://www.linkedin.com/in/muhammad-ibtisam-shk/)
