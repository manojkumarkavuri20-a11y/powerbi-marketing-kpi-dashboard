# Marketing KPI Dashboard — Findings Report

**Project:** Power BI Marketing KPI Dashboard
**Author:** Manoj Kumar Kavuri
**Period Analysed:** June – August 2025
**Dataset:** 20 campaigns across 6 channels

**Portfolio project built for learning purposes using a synthetic dataset. No employer, client or customer data is used.** All figures below are calculated directly from `data/sample_campaign_data.csv` and illustrate the kind of analysis this SQL layer is designed to support, not a real advertiser's results.

---

## Executive Summary

This report summarises key performance insights derived from three months of multi-channel digital marketing campaign data. The analysis covers campaign ROI, channel efficiency, and audience conversion patterns to inform future budget allocation decisions.

---

## Key Metrics Overview

| Metric | Definition | Calculation |
|---|---|---|
| **CTR** | Click-Through Rate | `clicks / impressions * 100` |
| **CPC** | Cost Per Click | `budget / clicks` |
| **CAC** | Customer Acquisition Cost | `budget / conversions` |
| **ROAS** | Return on Ad Spend | `revenue / budget` |
| **CVR** | Conversion Rate | `conversions / clicks * 100` |

---

## Channel Performance Summary

Paid Search (Google) posts the highest ROAS of any channel, at roughly 5.1x on average, with consistent volume and conversion quality. The Affiliate Programme is close behind with a strong ROAS of around 10.5x in July, helped by low spend and a high-intent audience. LinkedIn B2B shows the highest revenue per conversion of any channel, at around £100, making it the strongest performer for B2B audience targeting.

Two channels stand out as needing optimisation. The Google Display Network generates high impressions but a conversion rate under 2%, pointing to a creative refresh as the likely fix. YouTube Pre-roll carries a large spend for only moderate conversions, suggesting shorter ad formats such as 6-second bumpers are worth testing.

---

## Key Findings

**Paid Search drives the highest volume ROI.** Google Search campaigns consistently deliver the best balance of volume and efficiency, with CPC stable at around £0.29–0.30 and conversion rates averaging roughly 5%, well above the channel average.

**The affiliate channel punches above its weight.** Despite the smallest budget allocation of any channel (£400–420 a month), the affiliate programme generated 140–165 conversions at a CAC of roughly £2.55–£2.85, the lowest across all channels.

**Social media performance is segmented rather than uniform.** Facebook Retargeting is a stable mid-tier performer, with retargeting cohorts showing an improving conversion rate month over month (+22% from June to July). TikTok, run only in August, posted the highest CTR of any campaign at 3.0%, a strong brand-awareness result for younger demographics. Instagram Stories sits in the middle and would benefit from A/B testing static against video creative.

**LinkedIn shows a premium B2B signal.** It has the highest revenue per conversion of any channel, at £100, despite relatively low conversion volumes, which supports increasing LinkedIn budget for B2B audience segments going forward.

---

## Recommendations

| Priority | Action | Expected Impact |
|---|---|---|
| High | Increase Paid Search budget by 15% | +8–12% revenue |
| High | Scale Affiliate Programme partnerships | Lower CAC portfolio-wide |
| Medium | Refresh Display creative assets | Improve CVR from <2% to 3.5%+ |
| Medium | A/B test TikTok vs. Instagram for social budget | Data-driven reallocation |
| Low | Reduce YouTube spend; shift to 6-sec bumper ads | Improve cost efficiency |

---

## Dashboard Pages (Power BI)

This report and the underlying SQL are designed to feed the four dashboard pages described in the README: an executive overview of total spend, revenue, ROAS and CAC; a channel breakdown with side-by-side comparison and slicers; a campaign drilldown table with sparklines; and a month-over-month trend view. No `.pbix` file has been built yet; these findings were produced by running the SQL queries directly against the sample dataset.

---

*Report generated from `data/sample_campaign_data.csv` · SQL queries in `sql/` folder*
*Manoj Kumar Kavuri · [LinkedIn](https://www.linkedin.com/in/manojkumarkavuri/) · [GitHub](https://github.com/manojkumarkavuri20-a11y)*
