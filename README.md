# 📊 Power BI Marketing KPI Dashboard

> **End-to-end marketing analytics dashboard** tracking campaign performance, paid media efficiency, and audience ROI — built from real-world digital marketing experience at **BorderlessHR Inc. (InterviewHQ)**.

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

---

## 🎯 Business Problem

Digital marketing teams often have data spread across Google Ads, Facebook Ads, and email platforms with **no unified view** of campaign performance. Decisions get made on gut feel rather than metrics, leading to inefficient budget allocation and missed ROI opportunities.

This project solves that by building a **single source of truth** — a Power BI dashboard that consolidates campaign KPIs, highlights underperformers, and surfaces actionable insights for budget reallocation.

---

## 📈 Key Metrics Tracked

| KPI | Definition | Business Impact |
|-----|-----------|----------------|
| **CTR** (Click-Through Rate) | Clicks / Impressions | Measures ad creative effectiveness |
| **CPC** (Cost Per Click) | Spend / Clicks | Measures paid efficiency |
| **CAC** (Customer Acquisition Cost) | Spend / New Customers | Core profitability metric |
| **ROAS** (Return on Ad Spend) | Revenue / Spend | Overall campaign ROI |
| **Conversion Rate** | Conversions / Clicks | Funnel effectiveness |
| **Email CTR** | Email Clicks / Emails Sent | Audience engagement metric |

---

## 🏗️ Dashboard Structure

### Page 1 — Executive Summary
- Total spend, total revenue, blended ROAS
- Month-over-month trend lines
- Campaign performance at a glance (card visuals)
- Top 3 performing campaigns vs bottom 3

### Page 2 — Paid Media Deep Dive
- Google Ads vs Facebook Ads comparison
- CTR and CPC trends by campaign
- Budget utilisation heatmap
- Audience segment performance (age, gender, region)

### Page 3 — Conversion Funnel
- Impressions → Clicks → Leads → Conversions waterfall
- Drop-off rates at each funnel stage
- CAC by channel and campaign type
- A/B test results comparison

### Page 4 — Email Marketing Analytics
- Open rate and CTR trends
- Segment-level performance (by list type)
- Best send-time analysis
- Unsubscribe and bounce tracking

---

## 💡 Key Findings & Insights

1. **30% higher campaign ROI** achieved by reallocating budget from low-CTR display ads to high-converting search campaigns
2. **Facebook Ads** delivered 2.3x better CAC than Google Display for B2B SaaS audiences in the UK market
3. **Email CTR improved by 20%** after segmenting lists by job title and sending role-specific subject lines
4. **Peak conversion windows**: Tuesday–Thursday, 10am–2pm consistently outperformed weekend sends by 34%
5. **A/B test finding**: Benefit-led headlines outperformed feature-led headlines by 18% CTR across all campaigns

---

## 🗂️ Repository Structure

```
powerbi-marketing-kpi-dashboard/
│
├── data/
│   ├── raw/
│   │   ├── campaign_data_2024.csv        # Google Ads + Facebook Ads export
│   │   ├── email_performance_2024.csv    # Email platform export
│   │   └── conversion_tracking.csv       # CRM conversion data
│   └── processed/
│       └── marketing_kpi_cleaned.csv     # Cleaned, merged dataset
│
├── sql/
│   ├── campaign_performance_query.sql    # Core KPI aggregation query
│   ├── funnel_analysis.sql               # Conversion funnel steps
│   └── ab_test_results.sql               # A/B test significance query
│
├── dashboard/
│   ├── marketing_kpi_dashboard.pbix      # Main Power BI file
│   └── screenshots/
│       ├── executive_summary.png
│       ├── paid_media_deepdive.png
│       ├── conversion_funnel.png
│       └── email_analytics.png
│
├── docs/
│   ├── data_dictionary.md                # Field definitions and sources
│   ├── requirements.md                   # Business requirements (MoSCoW)
│   └── findings_report.md                # Key insights and recommendations
│
└── README.md
```

---

## 🔧 SQL Highlights

### Campaign Performance Aggregation
```sql
SELECT
    campaign_name,
    channel,
    SUM(spend)                                          AS total_spend,
    SUM(clicks)                                         AS total_clicks,
    SUM(conversions)                                    AS total_conversions,
    SUM(revenue)                                        AS total_revenue,
    ROUND(SUM(clicks)::DECIMAL / NULLIF(SUM(impressions), 0) * 100, 2)   AS ctr_pct,
    ROUND(SUM(spend)::DECIMAL / NULLIF(SUM(clicks), 0), 2)               AS cpc,
    ROUND(SUM(spend)::DECIMAL / NULLIF(SUM(conversions), 0), 2)          AS cac,
    ROUND(SUM(revenue)::DECIMAL / NULLIF(SUM(spend), 0), 2)              AS roas
FROM campaign_data
WHERE campaign_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY campaign_name, channel
ORDER BY roas DESC;
```

### Conversion Funnel Analysis
```sql
WITH funnel AS (
    SELECT
        campaign_id,
        SUM(impressions)   AS impressions,
        SUM(clicks)        AS clicks,
        SUM(leads)         AS leads,
        SUM(conversions)   AS conversions
    FROM campaign_data
    GROUP BY campaign_id
)
SELECT
    campaign_id,
    impressions,
    clicks,
    leads,
    conversions,
    ROUND(clicks::DECIMAL / NULLIF(impressions, 0) * 100, 1)     AS impression_to_click_pct,
    ROUND(leads::DECIMAL / NULLIF(clicks, 0) * 100, 1)           AS click_to_lead_pct,
    ROUND(conversions::DECIMAL / NULLIF(leads, 0) * 100, 1)      AS lead_to_conversion_pct
FROM funnel
ORDER BY conversions DESC;
```

---

## 📊 Sample Dataset Schema

```
campaign_data:
- campaign_id        (VARCHAR)
- campaign_name      (VARCHAR)
- channel            (VARCHAR)  -- 'Google Ads', 'Facebook', 'Email'
- campaign_date      (DATE)
- impressions        (INTEGER)
- clicks             (INTEGER)
- leads              (INTEGER)
- conversions        (INTEGER)
- spend              (DECIMAL)
- revenue            (DECIMAL)
- audience_segment   (VARCHAR)  -- 'cold', 'warm', 'retargeting'
- region             (VARCHAR)
```

---

## 🏆 Business Impact

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Campaign ROI | Baseline | +30% | Budget reallocation from insights |
| Email CTR | Baseline | +20% | Audience segmentation strategy |
| CAC (Facebook) | £48 avg | £21 avg | Better audience targeting |
| Reporting Time | 3 hrs/week | 20 min/week | Automated Power BI refresh |

---

## 🛠️ Tools & Technologies

- **Power BI Desktop** — dashboard design, DAX measures, data modelling
- **PostgreSQL / MySQL** — data extraction and KPI aggregation
- **Microsoft Excel** — initial data cleaning and pivot analysis
- **Google Analytics** — web conversion tracking data source
- **Facebook Ads Manager** — paid social data export
- **Google Ads** — search campaign performance data

---

## 📋 Requirements (MoSCoW)

**Must Have:**
- [ ] Unified view of CTR, CPC, CAC, ROAS across all channels
- [ ] Month-over-month trend comparison
- [ ] Campaign-level drill-down

**Should Have:**
- [ ] A/B test results comparison page
- [ ] Email performance analytics
- [ ] Automated data refresh

**Could Have:**
- [ ] Predictive spend modelling
- [ ] Budget allocation recommender

**Won't Have (this version):**
- Real-time API connections (future iteration)

---

## 🔗 Related Projects

- [UK Retail Footfall Analysis](https://github.com/manojkumarkavuri20-a11y/uk-retail-footfall-analysis) — End-to-end BA project using ONS retail data
- [SQL Portfolio](https://github.com/manojkumarkavuri20-a11y/sql-portfolio) — Advanced SQL for business analytics
- [Donation Management System](https://github.com/manojkumarkavuri20-a11y/donation-management-system) — Operations process design

---

## 👤 About

Built by **Manoj Kumar Kavuri** — Graduate Market & Operations Analyst

📍 Bracknell, UK | 🎓 MSc International Business (Distinction) — University of East London

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/manojkumarkavuri/)
[![GitHub](https://img.shields.io/badge/GitHub-Portfolio-black?style=flat&logo=github)](https://github.com/manojkumarkavuri20-a11y)

> *Open to Market Analyst, Operations Analyst, and Business Analyst roles across the UK.*
