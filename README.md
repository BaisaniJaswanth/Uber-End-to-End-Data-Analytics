# Uber End to End Data Engineering and Data Analytics

An end-to-end data engineering project that performs ETL pipeline on Uber trip data Built on Google Cloud Platform (GCP) using Mage for orchestration, Python for transformation, BigQuery for warehousing, and Power BI for visualization.
The goal is to transform raw Excel data into structured analytics tables and uncover meaningful insights related to trip trends, distances, categories, and user behavior.

https://www.bing.com/ck/a?!&&p=bc54902b61b1062f68e6612b3e5df0c4ab2f2b3a681d65145d02b2fb82e4245cJmltdHM9MTc1MTU4NzIwMA&ptn=3&ver=2&hsh=4&fclid=3dfe5ff1-0a54-6734-397549ff0b3666af&u=a1L2ltYWdlcy9zZWFyY2g_cT11YmVyK2ltYWdlJmlkPUVEQ0U4RENFQzVDNTgzRkVFQ0U3NEQzM0U3MEMxRDVBQzNFODI5MTYmRk9STT1JQUNGSVI&ntb=1

📌 Features
✅ ETL Pipeline built with Mage (Python-based)

✅ Deployed and run via Google Cloud Platform

✅ Cleaned Uber trip data transformed into dimensional models

✅ Data warehouse implemented in BigQuery

✅ Analytics table (tbl_analytics) built with SQL joins

✅ Interactive Power BI Dashboard for visualization

✅ Automations and reproducibility through virtual environments

🧱 Project Architecture

Uber Dataset (.xlsx) ->  [Extract] -> Mage ETL (Python/Transform) -> [Transform] -> Dimensional Modeling Fact + Dimension Tables -> [Load] -> BigQuery (Fact + Dim Tables) ->  [Analytics Join] ->  tbl_analytics (Wide Table) -> [Visualize] -> Power BI Dashboard -> Python Analysis      
              
🛠 Technologies Used
Component	    Tool
ETL Engine	    Mage
Cloud Platform	Google Cloud Platform (GCP)
Data Warehouse	BigQuery
File Storage	GCS (optionally)
Data Viz	    Power BI Desktop
Language	    Python (Pandas, DBT, OpenPyXL)

📦 Dataset
Source: UberDatasetCleaned.xlsx

Fields include: trip_id, start_date, end_date, miles, speed, purpose, category, etc.

🚀 Step-by-Step Setup
1. 🧑‍💻 Environment Setup
   
# Update and install essentials
sudo apt-get update
sudo apt-get install python3-pip python3-venv -y
python3 -m venv mage-env
source mage-env/bin/activate

# Install Mage & dependencies
pip install mage-ai
pip install openpyxl pandas dbt-core dbt-postgres
pip install google-cloud-bigquery google-cloud-bigquery-storage pandas-gbq

2. ⚙️ Start Mage Project
mage start uber_data_project
cd uber_data_project

Copy your UberDatasetCleaned.xlsx into data/

Configure your service account key: tough-access-*.json

3. 🛠 Build Mage ETL Blocks
a. Data Loader (load_uber_data.py)
Loads data from GCS or local into a Pandas DataFrame.

b. Transformers (transform.py)
Creates dimension tables:

start_date, end_date, purpose, category, start_location, end_location

Builds fact_table using joins and surrogate keys

c. Export to BigQuery
from mage_ai.io.bigquery import BigQuery
BigQuery(...).export(DataFrame(data), table_id, if_exists='replace')
Use the provided service account JSON for credentials.

4. 🧠 Build Data Model in BigQuery
📄 Create Analytics Table (analytics_query.sql)
CREATE OR REPLACE TABLE `tough-access-464904-v5.uber_data_engineering_yt.tbl_analytics` AS (
  SELECT ...
  FROM fact_table f
  LEFT JOIN start_date ...
  ...
);

5. 📊 Visualization in Power BI
Open Uber Analysis PowerBI Dashboard.pbix

Connect to BigQuery > tbl_analytics

Use filters like category, day, location, purpose

![Screenshot 2025-07-04 205137](https://github.com/user-attachments/assets/92f113e8-97de-4d41-a4d9-e3bf72202da8)

✅ Sample Output Tables
Table Name	Description
fact_table	Main transactional data
start_date, end_date	Time-based dimensions
category, purpose	Categorical dimensions
tbl_analytics	Final joined table for BI tools

🔐 Authentication & Configuration
io_config.yaml contains BigQuery credentials

GCP project ID: tough-access-464904-v5

Ensure roles:

BigQuery Admin

Storage Viewer (if GCS used)

📁 File Structure
-- UberDatasetCleaned.xlsx
-- Uber Data Pipeline.ipynb
-- Uber Analysis.ipynb
-- analytics_query.sql
-- commands.txt
-- tough-access-*.json (service account)
-- mage-env/
-- uber_data_project/

Install missing dependencies like openpyxl, db-dtypes when errors arise

Use LIMIT 1 queries in BigQuery to confirm schema before joins

📈 Future Improvements
Automate pipeline with Mage schedules

Add Airflow or Cloud Composer for orchestration

Add dbt for stronger data modeling

Stream data to BigQuery using Pub/Sub

# First make the raw column text Right‑click Start_Date ▸ Change Type ▸ Text (this removes any partial conversions) ▸ Add Column ▸ Custom Column ▸ Paste the M code ▸ Change Type of the new column to Date/Time.
'let
    usParse   = try DateTime.FromText([Start_Date], "en-US"),
    finalDate = if usParse[HasError]
                then DateTime.FromText([Start_Date], "en-GB")
                else usParse[Value]
in
    finalDate'

# First make the raw column text Right‑click End_Date ▸ Change Type ▸ Text (this removes any partial conversions).
'let
    usParse   = try DateTime.FromText([End_Date], "en-US"),
    finalDate = if usParse[HasError]
                then DateTime.FromText([End_Date], "en-GB")
                else usParse[Value]
in
    finalDate'

# To calculate duration (in minutes or hours) from Start_Hour, Start_Minute, End_Hour, End_Minute columns in Power Query.
Add Custom Column (Duration in Minutes)
'let
    startTime = #time([Start_Hour], [Start_Minute], 0),
    endTime   = #time([End_Hour], [End_Minute], 0),
    duration  = Duration.TotalMinutes(endTime - startTime)
in
    duration'

# To calculate Speed = Distance / Time in Power BI (e.g., in miles per hour).
'[Miles] / ([Duration] / 60)'

# To calculate the Day time using Start_Hour
'= Table.AddColumn(#"Inserted Day Name", "Custom", each
    if      [Start_Hour] >=  6 and [Start_Hour] <= 11 then "Morning"
    else if [Start_Hour] >= 12 and [Start_Hour] <= 17 then "Afternoon"
    else if [Start_Hour] >= 18 and [Start_Hour] <= 21 then "Evening"
    else "Night"
)'

![Screenshot 2025-07-04 110100](https://github.com/user-attachments/assets/caa05c07-7011-4882-8179-b585d2219ab4)

![Screenshot 2025-07-04 110138](https://github.com/user-attachments/assets/5ab58f49-dbe4-4f69-ae74-2aeb2e9eb1bb)

![Screenshot 2025-07-04 123314](https://github.com/user-attachments/assets/d142959e-6565-4943-a46a-9575435ceaa2)

![Screenshot 2025-07-04 123322](https://github.com/user-attachments/assets/dbd13d75-99b6-4e47-a19f-78145fdde313)

![Screenshot 2025-07-04 153938](https://github.com/user-attachments/assets/8d4712c6-1fbe-4c60-b91b-136fad900b8c)

![Screenshot 2025-07-04 161315](https://github.com/user-attachments/assets/1181b57f-1ac9-42ee-b655-f18782e2eb28)

![Screenshot 2025-07-04 161333](https://github.com/user-attachments/assets/992ba5ea-d41f-4a51-83d4-c8c65c5ed1d7)

![Screenshot 2025-07-04 162902](https://github.com/user-attachments/assets/b7fe2716-8751-40b9-9e11-4b1dd0f39aeb)

![Screenshot 2025-07-04 162915](https://github.com/user-attachments/assets/52f89ac6-2ae3-4646-a8d3-872aef213c79)

![Screenshot 2025-07-04 181037](https://github.com/user-attachments/assets/a2ddc1c2-54f1-457e-9693-926ebe8f77dd)

![Screenshot 2025-07-04 181056](https://github.com/user-attachments/assets/1d66a25c-5dd6-4de3-b5d6-57d40c38a9eb)

![Screenshot 2025-07-04 181441](https://github.com/user-attachments/assets/ac7af7e3-6f97-4252-84ff-c083ae5c2d9d)

![Screenshot 2025-07-04 181451](https://github.com/user-attachments/assets/9a17bcb7-0474-4dd4-ab9e-84a19a56afeb)

![Screenshot 2025-07-04 183220](https://github.com/user-attachments/assets/c0680279-77c2-4e2d-a9d2-aff8cb9c282f)













