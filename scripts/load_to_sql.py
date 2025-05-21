import sqlite3
import csv
from datetime import datetime

# Paths
DB_PATH = './data/db.sqlite'
CSV_FILES = [
    ('liv_erickson_messages.csv', 'Facebook'),
    ('Shares.csv', 'LinkedIn')
]

# Connect to the SQLite database
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

# Create table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS content (
        YEAR INTEGER,
        MONTH INTEGER,
        MESSAGE TEXT,
        PLATFORM TEXT,
        SENTIMENT TEXT
    )
''')

# Parse year and month based on platform-specific formats
def parse_year_month(date_str, platform):
    try:
        if platform == 'Facebook':
            dt = datetime.strptime(date_str.strip(), "%b %d, %Y %I:%M:%S %p")
        elif platform == 'LinkedIn':
            dt = datetime.strptime(date_str.strip(), "%Y-%m-%d %H:%M:%S")
        else:
            return None, None
        return dt.year, dt.month
    except Exception as e:
        print(f"⚠️ Failed to parse date '{date_str}' for {platform}: {e}")
        return None, None

# Read and insert data
for csv_file, platform in CSV_FILES:
    with open(csv_file, 'r', encoding='utf8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            date = row.get('Date', '').strip()
            message = row.get('Message', '').strip()
            if not message:
                continue  # Skip empty messages
            year, month = parse_year_month(date, platform)
            if year and month:
                cursor.execute('''
                    INSERT INTO content (YEAR, MONTH, MESSAGE, PLATFORM, SENTIMENT)
                    VALUES (?, ?, ?, ?, ?)
                ''', (year, month, message, platform, None))

# Commit and close
conn.commit()
conn.close()

print("✅ Data imported (empty messages skipped) into db.sqlite:content")
