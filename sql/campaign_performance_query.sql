-- ============================================================
-- Campaign Performance KPI Query
-- Project: Power BI Marketing KPI Dashboard
-- Author:  Manoj Kumar Kavuri
-- Description: Aggregates core marketing KPIs per campaign
--              including CTR, CPC, CAC, and ROAS
-- ============================================================

-- 1. CAMPAIGN-LEVEL KPI AGGREGATION
-- Calculates all key performance indicators per campaign and channel
SELECT
    c.campaign_id,
    c.campaign_name,
    c.channel,                           -- 'Google Ads', 'Facebook', 'Email'
    c.audience_segment,                  -- 'cold', 'warm', 'retargeting'
    c.region,
    DATE_TRUNC('month', c.campaign_date) AS reporting_month,

    -- Volume Metrics
    SUM(c.impressions)                   AS total_impressions,
    SUM(c.clicks)                        AS total_clicks,
    SUM(c.leads)                         AS total_leads,
    SUM(c.conversions)                   AS total_conversions,

    -- Financial Metrics
    ROUND(SUM(c.spend), 2)               AS total_spend,
    ROUND(SUM(c.revenue), 2)             AS total_revenue,

    -- KPI Calculations
    ROUND(
        SUM(c.clicks)::DECIMAL
        / NULLIF(SUM(c.impressions), 0) * 100, 2
    )                                    AS ctr_pct,

    ROUND(
        SUM(c.spend)::DECIMAL
        / NULLIF(SUM(c.clicks), 0), 2
    )                                    AS cpc,

    ROUND(
        SUM(c.spend)::DECIMAL
        / NULLIF(SUM(c.conversions), 0), 2
    )                                    AS cac,

    ROUND(
        SUM(c.revenue)::DECIMAL
        / NULLIF(SUM(c.spend), 0), 2
    )                                    AS roas,

    ROUND(
        SUM(c.conversions)::DECIMAL
        / NULLIF(SUM(c.clicks), 0) * 100, 2
    )                                    AS conversion_rate_pct

FROM campaign_data c
WHERE
    c.campaign_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND c.channel IN ('Google Ads', 'Facebook', 'Email')
GROUP BY
    c.campaign_id,
    c.campaign_name,
    c.channel,
    c.audience_segment,
    c.region,
    DATE_TRUNC('month', c.campaign_date)
ORDER BY roas DESC;


-- 2. CHANNEL COMPARISON SUMMARY
-- High-level channel performance for executive view
SELECT
    channel,
    COUNT(DISTINCT campaign_id)          AS num_campaigns,
    ROUND(SUM(spend), 2)                 AS total_spend,
    ROUND(SUM(revenue), 2)               AS total_revenue,
    ROUND(AVG(
        clicks::DECIMAL / NULLIF(impressions, 0) * 100
    ), 2)                                AS avg_ctr_pct,
    ROUND(SUM(spend)::DECIMAL / NULLIF(SUM(clicks), 0), 2)
                                         AS blended_cpc,
    ROUND(SUM(spend)::DECIMAL / NULLIF(SUM(conversions), 0), 2)
                                         AS blended_cac,
    ROUND(SUM(revenue)::DECIMAL / NULLIF(SUM(spend), 0), 2)
                                         AS blended_roas
FROM campaign_data
WHERE campaign_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY channel
ORDER BY blended_roas DESC;


-- 3. MONTH-OVER-MONTH TREND
-- Used to power the trend line charts in the dashboard
WITH monthly_data AS (
    SELECT
        DATE_TRUNC('month', campaign_date) AS month,
        SUM(spend)                         AS total_spend,
        SUM(revenue)                       AS total_revenue,
        SUM(clicks)                        AS total_clicks,
        SUM(impressions)                   AS total_impressions,
        SUM(conversions)                   AS total_conversions
    FROM campaign_data
    WHERE campaign_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', campaign_date)
)
SELECT
    month,
    total_spend,
    total_revenue,
    ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2)           AS roas,
    ROUND(total_clicks::DECIMAL / NULLIF(total_impressions, 0) * 100, 2) AS ctr_pct,
    ROUND(total_spend::DECIMAL / NULLIF(total_conversions, 0), 2)        AS cac,
    LAG(ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2))
        OVER (ORDER BY month)                                            AS prev_month_roas,
    ROUND(
        (ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2)
        - LAG(ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2))
            OVER (ORDER BY month))
        / NULLIF(LAG(ROUND(total_revenue::DECIMAL / NULLIF(total_spend, 0), 2))
            OVER (ORDER BY month), 0) * 100, 1
    )                                                                    AS roas_mom_change_pct
FROM monthly_data
ORDER BY month;


-- 4. TOP PERFORMING CAMPAIGNS (for Power BI card visuals)
SELECT
    campaign_name,
    channel,
    ROUND(SUM(revenue)::DECIMAL / NULLIF(SUM(spend), 0), 2)  AS roas,
    ROUND(SUM(spend), 2)                                      AS spend,
    SUM(conversions)                                          AS conversions
FROM campaign_data
WHERE campaign_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY campaign_name, channel
ORDER BY roas DESC
LIMIT 5;


-- 5. AUDIENCE SEGMENT PERFORMANCE
-- Reveals which audience type (cold/warm/retargeting) performs best per channel
SELECT
    channel,
    audience_segment,
    ROUND(SUM(spend), 2)                                              AS total_spend,
    SUM(conversions)                                                  AS total_conversions,
    ROUND(SUM(spend)::DECIMAL / NULLIF(SUM(conversions), 0), 2)       AS cac,
    ROUND(SUM(revenue)::DECIMAL / NULLIF(SUM(spend), 0), 2)           AS roas
FROM campaign_data
WHERE campaign_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY channel, audience_segment
ORDER BY channel, roas DESC;
