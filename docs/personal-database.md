---
title: Building a Personal Database
---
The first step of designing an intentional data introspection practice is to begin building a personal database of information. To do this, you will want to start by archiving and downloading your content from the social media platforms where you are active.

Instructions for archiving content from different platforms can be found below.

* [Meta platforms (Facebook, Instagram, WhatsApp)](https://www.facebook.com/help/284581436192616/)
* [LinkedIn](https://www.linkedin.com/help/linkedin/answer/a1339364/downloading-your-account-data)
* [Twitter/X](https://x.com/settings/download_your_data?lang=en)

## Database Designs
The Data Introspection Project contains several scripts for extracting content from archive files and storing them in a `SQLite` database. **This is a work in progress** and the database schema is likely to change, but for now, the following schema is being used:

```
CREATE TABLE content (
    YEAR INTEGER,
    MONTH INTEGER,
    MESSAGE TEXT,
    PLATFORM TEXT,
    SENTIMENT TEXT,
    SENTIMENT_SCORE REAL default 0.5);
```

If you want to be more granular in your database, include a `DAY INTEGER` or store the timestamp from the archive in a raw format. Each platform uses a different format, so you will want to convert to a consistent format if storing all content in a single database.

> Note: You may want to use different tables in your database for each platform that you important content from. Ultimately, your database design should reflect your own preferences for archival.

## Importing Content
Basic python scripts can be used to extract information from the raw archive data and save them to your database. Converting to `.csv` as an intermediate step can be helpful to reduce the amount of re-processing if you want to change your database schema. The [load_to_sql.py](https://github.com/misslivirose/data-introspection/blob/main/scripts/load_to_sql.py) script gives an example of how to load `.csv` files into a database using the above schema.
