WITH
    platform_averages AS (
        SELECT
            year,
            platform,
            AVG(sentiment_score) AS avg_sentiment
        FROM
            content
        WHERE
            platform IN ('Facebook', 'LinkedIn')
        GROUP BY
            year,
            platform
    )
SELECT
    year,
    AVG(avg_sentiment) AS normalized_avg_sentiment
FROM
    platform_averages
GROUP BY
    year
ORDER BY
    year;
