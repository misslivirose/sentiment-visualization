---
title: "Example Visualizations"
---
## Total Monthly Mean
Graphing the mean sentiment of all messages in a monthly period with a trendline. The size of the dot corresponds to the number of messages in that period of time. Graphed using R `ggplot`.
![graph showing dots of posts with mean sentiment over 18 years](img/monthly_with_trendline.png)

## Polarity of Facebook messages
A trendline of positivity in Facebook messages and how it changes month over month. This graph was created using an earlier version of the sentiment scoring explorations and graphs relative change rather than absolute score. Graphed with ChatGPT.
![a graph showing average sentiment spikes](img/sentiment_over_time.png)

## Word Cloud
A word cloud generated with python using the `WordCloud` package, scaled with frequency of sentiment.
![heat map of sentiment across all posts](img/sentiment_wordcloud.png)
Source: [gen_wordcloud.py](https://github.com/misslivirose/data-introspection/blob/main/scripts/gen_wordcloud.py)
