library(DBI)
library(dplyr)
library(ggplot2)
library(Polychrome)

setwd("~/GitHub/sentiment-visualization")

con <- dbConnect(RSQLite::SQLite(), 
                      dbname = "./data/db.sqlite")


tbl_data <- tbl(con, "content") %>%
  select(YEAR, MONTH, PLATFORM, SENTIMENT_SCORE)

monthly_summary <- tbl_data %>%
  group_by(YEAR, MONTH) %>%
  summarise(
    row_count      = n(),
    mean_sentiment = mean(SENTIMENT_SCORE, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(YEAR, MONTH) %>%
  # bring into R and create a proper Date for x‐axis
  collect() %>%
  mutate(
    month_date = as.Date(sprintf("%d-%02d-01", YEAR, MONTH))
  )

mean_of_means <- mean(monthly_summary$mean_sentiment)

ggplot(monthly_summary,
       aes(x = month_date,
           y = mean_sentiment,
           size = row_count)) +
  geom_point(alpha = .7) +
  geom_hline(yintercept = mean_of_means,
             linetype = "dashed",
             color   = "steelblue") +
  scale_y_continuous(
    name   = "Mean Sentiment",
    limits = c(
      mean_of_means - max(monthly_summary$mean_sentiment - mean_of_means),
      mean_of_means + max(monthly_summary$mean_sentiment - mean_of_means)
    ),
    expand = c(0, 0)
  ) +
  scale_x_date(
    name        = "Year",
    date_breaks = "1 year",
    date_labels = "%Y",
    expand      = expansion(add = c(0, 0))
  ) +
  scale_size_continuous(name = "Row Count") +
  labs(
    title    = "Monthly Sentiment Variation",
    subtitle = "Dashed line = mean of the monthly averages"
  ) +
  theme_minimal()

print(p)


# Sentiment by platform
monthly_summary <- tbl(con, "content") %>%
  select(YEAR, MONTH, PLATFORM, SENTIMENT_SCORE) %>%
  group_by(YEAR, MONTH, PLATFORM) %>%         # include PLATFORM
  summarise(
    row_count      = n(),
    mean_sentiment = mean(SENTIMENT_SCORE, na.rm = TRUE),
    .groups        = "drop"
  ) %>%
  arrange(YEAR, MONTH) %>%
  collect() %>%
  mutate(
    month_date = as.Date(sprintf("%d-%02d-01", YEAR, MONTH)),
    PLATFORM   = factor(PLATFORM, levels = c("Facebook","LinkedIn"))
  )

mean_of_means <- mean(monthly_summary$mean_sentiment)

p <- ggplot(monthly_summary, 
            aes(x = month_date, 
                y = mean_sentiment, 
                size = row_count, 
                colour = PLATFORM)) + 
  geom_point(alpha = .8) +
  geom_hline(yintercept = mean_of_means,
             linetype    = "dashed",
             colour      = "gray50") +
  scale_colour_manual(
    name   = "PLATFORM",
    values = c(Facebook = "#4267B2", LinkedIn = "#60AA14")
  ) +
  scale_size_continuous(range = c(2, 12), name = "Row Count") +
  scale_y_continuous(
    name   = "Mean Sentiment",
    limits = c(
      mean_of_means - max(monthly_summary$mean_sentiment - mean_of_means),
      mean_of_means + max(monthly_summary$mean_sentiment - mean_of_means)
    ),
    expand = c(0, 0)
  ) +
  scale_x_date(
    name        = "Year",
    date_breaks = "1 year",
    date_labels = "%Y",
    expand      = expansion(add = c(0, 0))
  ) +
  labs(
    title    = "Monthly Post Sentiment by Platform",
    subtitle = "Facebook vs. LinkedIn"
  ) +
  theme_minimal(base_size =14) +
  theme(
    panel.grid.minor   = element_blank(),
    panel.grid.major.y = element_line(color = "grey90"),
    panel.grid.major.x = element_line(color = "grey80"),
    legend.position = "none")

print(p)

# Begin box and whiskers 

db <- tbl(con, "content")

ggplot(db, aes(x=YEAR, y=SENTIMENT_SCORE)) + geom_point() + geom_smooth(method=lm)

ggplot(db, aes(x = SENTIMENT_SCORE, fill = factor(YEAR))) +
  geom_density(alpha = 0.5) +
  labs(title = "Sentiment Distribution by Year", x = "Sentiment Score", y = "Density")

db %>%
  group_by(YEAR, MONTH) %>%
  summarize(avg_sentiment = mean(SENTIMENT_SCORE, na.rm = TRUE)) %>%
  ggplot(aes(x = MONTH, y = avg_sentiment, color = factor(YEAR))) +
  geom_line() +
  labs(title = "Average Sentiment Over Time", x = "Month", y = "Average Sentiment")


ggplot(db, aes(x = factor(YEAR), y = SENTIMENT_SCORE)) +
  geom_boxplot() +
  labs(title = "Yearly Sentiment Distribution", x = "Year", y = "Sentiment Score")

palette_20 <- createPalette(20, seedcolors = c("#a6cee3", "#b2df8a", "#fb9a99"))

pastel_rainbow_20 <- c(
  "#FFB3BA",  # pastel red
  "#FFDFBA",  # pastel orange
  "#FFFFBA",  # pastel yellow
  "#D5FFBA",  # pastel yellow-green
  "#BAFFC9",  # pastel mint green
  "#BAE1FF",  # pastel cyan/sky blue
  "#CBA6FF",  # pastel light indigo
  "#E3BAFF",  # pastel violet
  "#FFBAED",  # pastel pink
  "#FFBACD",  # pastel rose
  "#FFCFCF",  # soft coral
  "#FFF1BA",  # light butter
  "#D0FFBA",  # lettuce green
  "#BAFFEA",  # light aqua
  "#BAD6FF",  # powder blue
  "#D9BAFF",  # dusty lavender
  "#F3BAFF",  # soft orchid
  "#FFBAF7",  # candy pink
  "#FFBAD9",  # soft raspberry
  "#FFD6BA"   # creamy orange
)


names(pastel_rainbow_20) <- c("2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026")

mean_sentiment <- db %>%
  group_by(YEAR) %>%
  summarize(mean_sentiment = mean(SENTIMENT_SCORE, na.rm = TRUE))

ggplot(db, aes(x = factor(YEAR), y = SENTIMENT_SCORE, fill = factor(YEAR))) +
  geom_boxplot(outlier.alpha = 0.3, outlier.size = 1) +
  geom_point(
    data = mean_sentiment,
    aes(x = factor(YEAR), y = mean_sentiment),
    color = "red",
    size = 3,
    shape = 18
  )+
  scale_fill_manual(values = pastel_rainbow_20) +
  labs(
    title = "Distribution of Sentiment Scores by Year",
    subtitle = "Boxplots show the median, IQR, and outliers",
    x = "Year",
    y = "Sentiment Score",
    fill = "Year"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none",  # remove legend if color isn't necessary
    panel.grid.major.y = element_line(color = "gray80")
  )

ggplot(db, aes(x = YEAR, y = SENTIMENT_SCORE)) + geom_point(aes(x=MONTH))


#  Messages over time 

ggplot(db, aes(x = YEAR, y = SENTIMENT_SCORE)) +
  geom_point(alpha = 0.2, size = 0.7, color = "steelblue") +
  geom_smooth(method = "loess", span = 0.1, color = "firebrick", linewidth = 1) +
  labs(
    x = "Date",
    y = "Sentiment Score",
    title = "Sentiment of All Messages Over Time",
    subtitle = "LOESS smoothing (span 0.1) over 17 years"
  ) +
  theme_minimal()

# Heatmap

library(lubridate)

ggplot(db, aes(y = as.factor(MONTH), x = as.factor(YEAR), fill = SENTIMENT_SCORE)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(
    low    = "firebrick",
    high   = "darkgreen",
    midpoint = 0.5
  ) +
  labs(
    x = "Year",
    y = "Month",
    fill = "Average Sentiment",
    title = "Monthly Average Sentiment Heatmap",
    subtitle = "Each tile is the average sentiment score for that month"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )


dbDisconnect(con)
