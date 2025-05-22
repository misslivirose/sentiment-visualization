import sqlite3
import requests

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL_NAME = "llama3.1:latest"  # Replace with your local model name

def get_sentiment_score(sentiment):
    prompt = f"Evaluate the sentiment's positive or negative implication on a scale of 0 (very negative) to 1 (very positive): \"{sentiment}\".\nRespond with only the single value between 0 and 1 that represents the sentiment."
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
    conn = sqlite3.connect("../data/db.sqlite")
    cursor = conn.cursor()
    cursor.execute("PRAGMA journal_mode=WAL;")

    # Fetch all rows with ROWID so we can update them
    cursor.execute("SELECT ROWID, sentiment FROM content")
    rows = cursor.fetchall()

    for row in rows:
        rowid, sentiment = row
        sentiment_score = get_sentiment_score(sentiment)

        cursor.execute("UPDATE content SET sentiment_score = ? WHERE ROWID = ?", (sentiment_score, rowid))
        print(f"ROWID {rowid}: sentiment set to '{sentiment_score}'")

    conn.commit()
    conn.close()

if __name__ == "__main__":
    main()
