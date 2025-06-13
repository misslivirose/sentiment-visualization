---
title: The Data Introspection Project
hide:
  - footer
---
The Data Introspection Project is a collection of tools and ideas centered around the goal of reclaiming personal value from our online information.

![graph of post sentiment by month and platform](img/distribution-monthly-by-platform.png)
*A graph generated in R using `ggplot` to show the mean sentiment score month by month across Facebook and LinkedIn*

Data introspection is the practice of using data as a playground for personal development. Through a data introspection practice, an individual collects, analyzes, and reflects on their digital footprint in order to surface insights about their habits, preferences, patterns, growth, and well-being.

### Big Tech has warped our relationship to our information
Our digital lives are increasingly noisy, shaped by the gigabytes of information that we consume on a daily basis. The bits and bytes that make their way into our psychology via messages, articles, videos, shorts, and podcasts are algorithmically curated to latch into relevancy. Platforms that serve information to us use our attention to personalize recommendations and advertisements, leaving us in a swirling vortex of information.

Whether we realize it or not, we all house data and information in some way. Our browsing habits, social media posts, and online preferences create a trove personal data, rich with insights about who we are as individuals. Our health records, held by our doctors, or our LinkedIn profiles, our old Facebook messages – they all store information about us that can reveal more than we might expect.

This data is the lifeblood of artificial intelligence. Machine learning algorithms that power ChatGPT, Copilot, and Gemini find patterns in internet-scale pools of content that are then used as the ultimate probabilistic generator, capable of cutting through the noise that exists within our online footprints.

Today, most social media algorithms are designed to maximize attention. User interfaces prioritize easy, repeatable interactions that keep users engaged. Some apps utilize controversial dark patterns to make users feel urgency or anxiety, nudging them into actions they might not have taken if the interface were more transparent or respectful of their intent. But these defaults can be challenged, especially in a world where we make introspection a design goal of the tools we are building in this age of emergent interfaces.

### Personal AI and Data Introspection
My initial explorations into using AI for sentiment analysis began with [Archivist](https://github.com/misslivirose/archivist/), a tool that allowed me to analyze my past messages. As I began to explore my past with the help of locally running models through [Ollama](https://ollama.com), I found myself curious about the patterns that my messages might reveal about me. As I began constructing a personal data archive and database for myself, I built a pipeline to use `llama3.1` to assign a single sentiment value to every message in my archives, and then score that word on a scale of 0 (most negative sentiment) and 1 (most positive sentiment). From there, I've been analyzing and visualizing the information, growing the database with additional platforms, and - with these docs - sharing it with the world.
