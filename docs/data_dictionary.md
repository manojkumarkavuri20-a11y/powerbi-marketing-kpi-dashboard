# Data Dictionary — Power BI Marketing KPI Dashboard

This document describes the sample dataset that ships with this repository and the fuller schema the SQL query is written against.

## Table: `campaign_data` (the sample dataset)

`data/sample_campaign_data.csv` is a synthetic campaign-level summary covering 20 campaigns across three months (June to August 2025).

| Column | Data Type | Description | Example |
|---|---|---|---|
| `campaign_id` | VARCHAR | Unique campaign identifier | `CMP001` |
| `campaign_name` | VARCHAR | Descriptive campaign name | `Summer Sale Email Blast` |
| `channel` | VARCHAR | Marketing channel | `Paid Search`, `Social Media`, `Video`, `Display`, `Affiliate`, `Email` |
| `start_date` | DATE | Campaign start date | `2025-06-01` |
| `end_date` | DATE | Campaign end date | `2025-06-30` |
| `budget_gbp` | DECIMAL | Budget allocated to the campaign, in GBP | `1200.00` |
| `impressions` | INT | Ad impressions served | `82000` |
| `clicks` | INT | Clicks recorded | `4100` |
| `conversions` | INT | Conversions attributed to the campaign | `205` |
| `revenue_gbp` | DECIMAL | Revenue attributed to the campaign, in GBP | `6150.00` |

## A note on the SQL's fuller schema

`sql/campaign_performance_query.sql` is written against a slightly richer conceptual schema than the sample CSV above, using column names `spend`, `revenue`, `leads`, `audience_segment` and `region` on a table it calls `campaign_data`. In practice this represents what a merged marketing data warehouse would look like once ad-platform exports (spend, impressions, clicks) are joined with CRM data (leads, conversions, region) and an audience-segmentation tag (cold, warm, retargeting) from a CDP or ad platform audience list. The sample CSV in `data/` is the simpler, summary-level export I could put together as a synthetic dataset for this portfolio piece; it does not include a lead-stage column, an audience-segment column, or a region column, and it uses `budget_gbp` where the SQL uses `spend`.

To run the queries as written against the sample CSV, `budget_gbp` would need to be aliased or renamed to `spend`, and the `leads`, `audience_segment` and `region` columns would need to be added, either by generating additional synthetic values or by removing the parts of the queries that depend on them. I have left the SQL written against the fuller schema deliberately, since the audience-segment and funnel-stage breakdowns are the more interesting analytical logic to show in a portfolio piece, and documented the gap here rather than silently downgrading the queries to match the smaller sample file.

One functional fix worth noting: the first query originally filtered to `channel IN ('Google Ads', 'Facebook', 'Email')`, which does not match any of the six channel values actually used in `data/sample_campaign_data.csv` (`Paid Search`, `Social Media`, `Video`, `Display`, `Affiliate`, `Email`) or referenced in the rest of the file's own comments. That filter has been removed so the query returns all campaigns rather than silently dropping most of them.

## Key Business Metrics Derived

| Metric | Formula | Used In |
|---|---|---|
| **CTR** | `clicks / impressions * 100` | Campaign-level KPI aggregation |
| **CPC** | `spend / clicks` | Campaign-level KPI aggregation |
| **CAC** | `spend / conversions` | Campaign-level KPI aggregation |
| **ROAS** | `revenue / spend` | Campaign-level KPI aggregation, month-over-month trend |
| **Conversion Rate** | `conversions / clicks * 100` | Campaign-level KPI aggregation |

## Notes

All monetary values in the sample dataset are in GBP (£). Campaign dates in the sample range from 2025-06-01 to 2025-08-31. This dictionary should be updated whenever new fields or tables are introduced.

---

*Maintained by Manoj Kumar Kavuri · [GitHub](https://github.com/manojkumarkavuri20-a11y) · [LinkedIn](https://www.linkedin.com/in/manojkumarkavuri/)*
