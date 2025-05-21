import sqlite3
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt

def get_sentiment_counts():
    conn = sqlite3.connect("../data/db.sqlite")
    cursor = conn.cursor()
    cursor.execute("SELECT sentiment FROM content WHERE sentiment IS NOT NULL AND sentiment != ''")
    sentiments = [row[0].strip() for row in cursor.fetchall()]
    conn.close()
    return Counter(sentiments)

def generate_wordcloud(sentiment_counts):
    wc = WordCloud(width=800, height=400, background_color="white")
    wc.generate_from_frequencies(sentiment_counts)

    plt.figure(figsize=(10, 5))
    plt.imshow(wc, interpolation="bilinear")
    plt.axis("off")
    plt.tight_layout()
    plt.savefig("sentiment_wordcloud.png")
    plt.show()

if __name__ == "__main__":
    counts = get_sentiment_counts()
    generate_wordcloud(counts)
