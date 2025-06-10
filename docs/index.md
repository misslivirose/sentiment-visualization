---
title: The Data Introspection Project
hide:
  - footer
---
The Data Introspection Project is a collection of tools and ideas centered around the goal of reclaiming personal value from our online information.

![graph of post sentiment by month and platform](img/distribution-monthly-by-platform.png)
*A graph generated in R using `ggplot` to show the mean sentiment score month by month across Facebook and LinkedIn*

## What is data introspection?
Data introspection is the practice of using data as a playground for personal development. Through a data introspection practice, an individual collects, analyzes, and reflects on their digital footprint in order to surface insights about their habits, preferences, patterns, growth, and well-being.

![heat map of sentiment across all posts](img/sentiment_wordcloud.png)
*A word cloud generated with python using the `WordCloud` package, scaled with frequency of sentiment*

## About the Project
My initial explorations into using AI for sentiment analysis began with [Archivist](https://github.com/misslivirose/archivist/), a tool that allowed me to analyze my past messages. As I began to explore my past with the help of locally running models through [Ollama](https://ollama.com), I found myself curious about the patterns that my messages might reveal about me. As I began constructing a personal data archive and database for myself, I built a pipeline to use `llama3.1` to assign a single sentiment value to every message in my archives, and then score that word on a scale of 0 (most negative sentiment) and 1 (most positive sentiment). From there, I've been analyzing and visualizing the information, growing the database with additional platforms, and - with these docs - sharing it with the world.
