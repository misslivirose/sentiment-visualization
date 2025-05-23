WITH
    total_counts AS (
        SELECT
            year,
            COUNT(*) AS total_posts
        FROM
            content
        GROUP BY
            year
    ),
    platform_counts AS (
        SELECT
            year,
            platform,
            SUM(sentiment_score) AS sentiment_sum,
            COUNT(*) AS platform_posts
        FROM
            content
        WHERE
            platform IN ('Facebook', 'LinkedIn')
        GROUP BY
            year,
            platform
    ),
    weighted_sentiment AS (
        SELECT
            p.year,
            p.platform,
            (1.0 * p.platform_posts / t.total_posts) AS weight,
            p.sentiment_sum,
            p.platform_posts
        FROM
            platform_counts p
            JOIN total_counts t ON p.year = t.year
    )
SELECT
    year,
    SUM(weight * sentiment_sum / platform_posts) AS weighted_avg_sentiment
FROM
    weighted_sentiment
GROUP BY
    year
ORDER BY
    year;
