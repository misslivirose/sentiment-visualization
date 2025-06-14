---
title: Using Ollama for Sentiment Analysis
---

## Sentiment Analysis
Sentiment analysis is the practice of assessing the likely attitude or opinion expressed through natural language. In machine learning, sentiment analysis is used to estimate emotion present in text/image/video, and can be used to classify postive, neutral, or negative feelings.

> Note: We would be remiss to not call out the fact that machine learning sentiment analysis is not without flaws. Using AI to label sentiment on posts introduces a level of bias and randomness. We chose to proceed given the size of our personal dataset, but take the output with caution.

## Using Ollama

The Data Introspection Project contains several scripts that use [Ollama](https://ollama.com) to create entries in your [personal database](docs/personal-database.md) that:

1. Assigns a single word `sentiment` to each row in your database
1. Assigns a `sentiment_score` to each row in the database based on the single word `sentiment` stored for each message

The [`sentiment.py`](https://github.com/misslivirose/data-introspection/blob/main/scripts/sentiment.py) script populates the sentiment string through a long series of local Ollama calls. We ran this using `llama3.1:latest`, which has 8B parameters and a context window of 128k characters. The model size is 4.9GB on disk.

The script parses through each row of the `db.sqlite` database `content` table and sends the `message` string in a request to Ollama with the prompt: "Give a one-word sentiment that best describes the following message. Respond with only one word."

For a ~200k row database, it took roughly three hours to compute the `sentiment` for the entire database for sentiment only, and another three hours to compute the `sentiment_score` on a machine with two Nvidia 4090 GPUs and 64GB of RAM. This translated to just under 30M tokens for assigning sentiment labels.

The [`sentiment_score.py`](https://github.com/misslivirose/data-introspection/blob/main/scripts/sentiment_score.py) script is essentially the exact same script, but instead of sending the message to Ollama and asking for a word describing the sentiment, it sends the sentiment and asks for a score between 0-1.

## Sample Assessment

The following shows a few examples of how llama3.1:8b assessed and scored various messages from a personal dataset of Facebook messages.

```
YEAR|MONTH|MESSAGE|PLATFORM|SENTIMENT|SENTIMENT_SCORE
2008|1|i really hate that {redacted} and i are still not talking. it makes me sad.|Facebook|Sadness|0.3
2011|4|Thanks again for talking to me yesterday :)|Facebook|Appreciative|1.0
2018|2|♥ Do you wanna hug because the sad satellite man?|Facebook|Silly|0.6

```
