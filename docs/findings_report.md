# Marketing KPI Dashboard — Findings Report

**Project:** Power BI Marketing KPI Dashboard  
**Author:** Manoj Kumar Kavuri  
**Period Analysed:** June – August 2025  
**Dataset:** 20 campaigns across 6 channels

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

### Top Performers by ROAS
1. **Paid Search (Google)** — Highest ROAS (~5.1x average). Consistent volume and conversion quality.
2. **Affiliate Programme** — Strong ROAS (~10.5x in July). Low spend, high-intent audience.
3. **LinkedIn B2B** — High revenue per conversion (~£100). Best for B2B audience targeting.

### Channels Requiring Optimisation
- **Google Display Network** — High impressions but low CVR (<2%). Recommend creative refresh.
- **YouTube Pre-roll** — Large spend, moderate conversions. Test shorter ad formats (6-second bumpers).

---

## Key Findings

### Finding 1: Paid Search Drives Highest Volume ROI
Google Search campaigns consistently delivered the best balance of volume and efficiency. CPC remained stable (~£0.29–0.30) while conversion rates averaged ~5%, significantly above the channel average.

### Finding 2: Affiliate Channel Punches Above Its Weight
Despite the smallest budget allocation (£400–420/month), the affiliate programme generated 140–165 conversions at a CAC of ~£2.55–£2.85 — the lowest across all channels.

### Finding 3: Social Media Performance is Segmented
- **Facebook Retargeting**: Stable mid-tier performer. Retargeting cohorts show improving CVR month-over-month (+22% Jun→Jul).
- **TikTok (Aug)**: Highest CTR (3.0%) of any campaign run. Strong brand awareness play for younger demographics.
- **Instagram Stories**: Moderate performance; consider A/B testing static vs. video creatives.

### Finding 4: LinkedIn Shows Premium B2B Signal
Highest revenue per conversion (£100) despite relatively low conversion volumes. Recommend increasing LinkedIn budget for B2B audience segments in Q4.

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

1. **Executive Overview** — Total spend, revenue, ROAS, CAC at a glance
2. **Channel Breakdown** — Side-by-side channel comparison with slicers
3. **Campaign Drilldown** — Individual campaign performance table with sparklines
4. **Trend Analysis** — Month-over-month KPI trends
5. **Budget Optimiser** — What-if parameter analysis for budget reallocation

---

*Report generated from `data/sample_campaign_data.csv` · SQL queries in `sql/` folder*  
*Manoj Kumar Kavuri · [LinkedIn](https://www.linkedin.com/in/manojkumarkavuri/) · [GitHub](https://github.com/manojkumarkavuri20-a11y)*
