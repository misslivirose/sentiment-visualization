import sqlite3
import requests

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL_NAME = "llama3.1:latest"  # Replace with your local model name

def get_sentiment(message):
    prompt = f"Give a one-word sentiment that best describes the following message: \"{message}\".\nRespond with only one word."
    response = requests.post(OLLAMA_URL, json={
        "model": MODEL_NAME,
        "prompt": prompt,
        "stream": False
    })
    if response.ok:
        result = response.json()["response"].strip()
        return result.split()[0]  # Enforce one-word result
    else:
        print(f"Ollama error: {response.status_code} - {response.text}")
        return "Unknown"

def main():
    conn = sqlite3.connect("./data/db.sqlite")
    cursor = conn.cursor()
    cursor.execute("PRAGMA journal_mode=WAL;")

    # Fetch all rows with ROWID so we can update them
    cursor.execute("SELECT ROWID, message FROM content")
    rows = cursor.fetchall()

    for row in rows:
        rowid, message = row
        if not message:
            sentiment = "Neutral"
        else:
            sentiment = get_sentiment(message)

        cursor.execute("UPDATE content SET sentiment = ? WHERE ROWID = ?", (sentiment, rowid))
        print(f"ROWID {rowid}: sentiment set to '{sentiment}'")

    conn.commit()
    conn.close()

if __name__ == "__main__":
    main()
