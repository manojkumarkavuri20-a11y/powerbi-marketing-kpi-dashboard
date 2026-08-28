# Power BI Marketing KPI Dashboard

**Portfolio project built for learning purposes using a synthetic dataset. No employer, client or customer data is used.**

**Marketing analytics SQL layer and dashboard design** for campaign performance, channel efficiency, and audience ROI — built with a synthetic campaign dataset, modelled on digital marketing analytics workflows I practised during my internship at BorderlessHR Inc.

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

---

## Business Problem

Digital marketing teams often have data spread across search, social, video, display, affiliate and email platforms with no unified view of campaign performance. Decisions get made on gut feel rather than metrics, leading to inefficient budget allocation and missed ROI opportunities.

This project addresses that with a SQL layer that consolidates campaign KPIs, highlights underperformers, and surfaces the kind of insight a Power BI dashboard built on top of it would use to drive budget reallocation decisions.

---

## Key Metrics Tracked

| KPI | Definition | Business Impact |
|-----|-----------|----------------|
| **CTR** (Click-Through Rate) | Clicks / Impressions | Measures ad creative effectiveness |
| **CPC** (Cost Per Click) | Spend / Clicks | Measures paid efficiency |
| **CAC** (Customer Acquisition Cost) | Spend / Conversions | Core profitability metric |
| **ROAS** (Return on Ad Spend) | Revenue / Spend | Overall campaign ROI |
| **Conversion Rate** | Conversions / Clicks | Funnel effectiveness |

---

## Dashboard Design

The SQL queries in this repository are structured to feed a four-page Power BI dashboard. An executive summary page would show total spend, total revenue, blended ROAS, month-over-month trend lines, and top and bottom campaigns at a glance. A channel deep dive page would compare CTR and CPC trends across Paid Search, Social Media, Video, Display, Affiliate and Email, alongside budget utilisation by channel. A campaign drilldown page would give an individual campaign performance table with month-over-month sparklines. And a budget optimiser page would use the channel and audience-segment queries below to model what-if budget reallocation scenarios. No `.pbix` file is included in this repository; the dashboard itself was not built, and the SQL and documentation here represent the analytical layer it would sit on top of.

---

## Illustrative Findings from Synthetic Data

The queries are designed to surface insights of this kind. These are illustrative patterns generated from the synthetic dataset, not measured results from a real campaign. Reallocating budget from low-CTR display ads toward high-converting search campaigns can materially improve blended ROI. An affiliate programme can outperform larger-budget channels on CAC because of its low spend and high-intent audience. Segmenting audiences by intent (cold, warm, retargeting) rather than treating a channel as a single block can reveal very different ROAS within the same channel. And B2B-oriented channels can show a much higher revenue-per-conversion than consumer channels even at lower volume.

---

## Repository Structure

```
powerbi-marketing-kpi-dashboard/

data/
  sample_campaign_data.csv      Synthetic campaign-level dataset (20 campaigns, Jun-Aug 2025)

sql/
  campaign_performance_query.sql   KPI aggregation, channel comparison, trend and segment queries

docs/
  data_dictionary.md            Field definitions and a note on the SQL's fuller schema
  findings_report.md            Insights and recommendations derived from the sample dataset

README.md
```

---

## SQL Highlights

### Campaign-Level KPI Aggregation
```sql
SELECT
c.campaign_id,
c.campaign_name,
c.channel,
DATE_TRUNC('month', c.campaign_date) AS reporting_month,
SUM(c.impressions) AS total_impressions,
SUM(c.clicks) AS total_clicks,
ROUND(SUM(c.spend), 2) AS total_spend,
ROUND(SUM(c.revenue), 2) AS total_revenue,
ROUND(SUM(c.clicks)::DECIMAL / NULLIF(SUM(c.impressions), 0) * 100, 2) AS ctr_pct,
ROUND(SUM(c.spend)::DECIMAL / NULLIF(SUM(c.clicks), 0), 2) AS cpc,
ROUND(SUM(c.spend)::DECIMAL / NULLIF(SUM(c.conversions), 0), 2) AS cac,
ROUND(SUM(c.revenue)::DECIMAL / NULLIF(SUM(c.spend), 0), 2) AS roas
FROM campaign_data c
GROUP BY c.campaign_id, c.campaign_name, c.channel,
DATE_TRUNC('month', c.campaign_date)
ORDER BY roas DESC;
```

### Month-over-Month Trend
```sql
WITH monthly_data AS (
SELECT
DATE_TRUNC('month', campaign_date) AS month,
SUM(spend) AS total_spend,
SUM(revenue) AS total_revenue,
SUM(clicks) AS total_clicks,
SUM(impressions) AS total_impressions
FROM campaign_data
GROUP BY DATE_TRUNC('month', campaign_date)
)
SELECT
month,
total_spend,
total_revenue,
ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2) AS roas,
LAG(ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2))
OVER (ORDER BY month) AS prev_month_roas
FROM monthly_data
ORDER BY month;
```

See `sql/campaign_performance_query.sql` for the full set of five queries, including channel comparison, top-campaign, and audience-segment breakdowns.

---

## Illustrative Business Impact

This table shows the kind of before/after comparison the queries are designed to support, based on the synthetic dataset, not real, measured business results.

| Metric | Illustrative Before | Illustrative After | Improvement |
|--------|--------|-------|-------------|
| Campaign ROI | Baseline | +30% | Budget reallocation from insights |
| Reporting Time | 3 hrs/week | 20 min/week | Automated Power BI refresh (once built) |

---

## Tools & Technologies

The queries are written for plain PostgreSQL / MySQL. Power BI Desktop, DAX measures and Excel are named above as the tools I use elsewhere in this portfolio for dashboard design and initial data cleaning, and are the intended next step for this repository rather than something already built here. The schema is modelled on the shape of Google Analytics, Facebook Ads Manager and Google Ads exports, using synthetic data only with no live account connections.

---

## Requirements (MoSCoW)

| Priority | Requirement |
|---|---|
| Must have | Unified view of CTR, CPC, CAC and ROAS across all channels |
| Must have | Month-over-month trend comparison |
| Must have | Campaign-level drill-down |
| Should have | Audience-segment performance breakdown |
| Should have | Automated data refresh |
| Could have | Predictive spend modelling |
| Could have | Budget allocation recommender |
| Won't have (this version) | Real-time API connections to ad platforms |

---

## Related Projects

[UK Retail Sales & Category Performance Analysis](https://github.com/manojkumarkavuri20-a11y/uk-retail-footfall-analysis) is an end-to-end BA project using ONS retail data. [SQL Portfolio](https://github.com/manojkumarkavuri20-a11y/sql-portfolio) covers advanced SQL for business analytics. [Donation Management System](https://github.com/manojkumarkavuri20-a11y/donation-management-system) covers operations process design.

---

## About

Built by **Manoj Kumar Kavuri** — Graduate Market & Operations Analyst, based in Bracknell, UK. MSc International Business (Distinction), University of East London.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/manojkumarkavuri/)
[![GitHub](https://img.shields.io/badge/GitHub-Portfolio-black?style=flat&logo=github)](https://github.com/manojkumarkavuri20-a11y)

*Open to Market Analyst, Operations Analyst, and Business Analyst roles across the UK.*
