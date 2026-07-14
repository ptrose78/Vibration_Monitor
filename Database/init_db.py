import sqlite3
import os

db_name = 'vibration_data.db'
schema_name = 'schema.sql'

try:
    # 1. Connect to the database (creates it if it doesn't exist)
    conn = sqlite3.connect(db_name)
    
    # 2. Read and execute the SQL schema script
    with open(schema_name, 'r') as f:
        schema_sql = f.read()
    
    conn.executescript(schema_sql)
    conn.commit()
    conn.close()
    
    print("[*] Database 'vibration_data.db' initialized successfully!")

except Exception as e:
    print(f"[Error] Failed to initialize database: {e}")