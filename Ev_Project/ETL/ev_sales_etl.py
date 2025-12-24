"""
EV Sales ETL Pipeline

This script performs:
- Extraction of raw EV sales data from CSV
- Data cleaning and standardization
- Export of cleaned data to Excel
- Loading of cleaned data into MySQL for analysis

Designed to simulate a reusable, automated data pipeline.
"""

import pandas as pd
import mysql.connector

# =====================================================
# FILE PATHS
# =====================================================
raw_file_path = "C:/Users/Dell/OneDrive/Desktop/Ev_Project/Data/Raw Data/ev_raw_data.csv"
processed_file_path = "C:/Users/Dell/OneDrive/Desktop/Ev_Project/Data/Processed Data/ev_sales_cleaned.xlsx"

# =====================================================
# EXTRACT
# =====================================================
df = pd.read_csv(raw_file_path)
print("Raw data shape:", df.shape)
print("Original columns:", df.columns.tolist())

# =====================================================
# TRANSFORM
# =====================================================
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
)

# Remove unnamed junk columns
df = df.loc[:, ~df.columns.str.contains("^unnamed", case=False)]

# Remove duplicates
df = df.drop_duplicates()

# Clean text columns
if 'state' in df.columns:
    df['state'] = df['state'].astype(str).str.title().str.strip()

if 'ev_id' in df.columns:
    df['ev_id'] = df['ev_id'].astype(str).str.strip()

# Numeric handling
if 'year' in df.columns:
    df['year'] = pd.to_numeric(df['year'], errors='coerce').astype('Int64')

numeric_cols = ['average_price_inr', 'average_range_km', 'sales_units']
for col in numeric_cols:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce')

# Drop rows without sales
if 'sales_units' in df.columns:
    df = df.dropna(subset=['sales_units'])

print("Cleaned data shape:", df.shape)
print("Final columns:", df.columns.tolist())

# =====================================================
# LOAD TO EXCEL
# =====================================================
df.to_excel(processed_file_path, index=False)
print("Cleaned data saved to Excel.")

# =====================================================
# LOAD TO MYSQL (EXISTING TABLE)
# =====================================================
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",  # 🔴 replace
    database="ev_sales_analysis"
)

cursor = conn.cursor()

# Full refresh
cursor.execute("TRUNCATE TABLE ev_raw_data")

insert_query = """
INSERT INTO ev_raw_data (
    ev_id,
    year,
    state,
    vehicle_category,
    manufacturer,
    average_price_inr,
    average_range_km,
    sales_units
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
"""

for _, row in df.iterrows():
    cursor.execute(insert_query, (
        row['ev_id'],  # ✅ STRING, NOT INT
        int(row['year']) if pd.notna(row['year']) else None,
        row['state'],
        row['vehicle_category'],
        row['manufacturer'],
        float(row['average_price_inr']) if pd.notna(row['average_price_inr']) else None,
        float(row['average_range_km']) if pd.notna(row['average_range_km']) else None,
        int(row['sales_units'])
    ))

conn.commit()
cursor.close()
conn.close()

print("ETL completed successfully: ev_raw_data refreshed.")
