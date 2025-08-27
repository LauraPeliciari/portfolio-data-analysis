# 📊 User Behaviour Analysis with Google Analytics Sample Data

## 🧠 Project Summary
This project explores how users interact with a website based on session data from the public Google Analytics sample dataset. The analysis focuses on first-time vs returning visitors, their geographic distribution (excluding the US), and the online channels they used to reach the site during Q1 of 2017.

## 🎯 Objectives
- Segment users by visit type (first-time vs returning)
- Identify top-performing countries for new user acquisition
- Analyze which marketing channels bring the most visits

## 📈 Dashboard
**👉 [View Interactive Tableau Dashboard](https://public.tableau.com/views/First-timeUserTrendAnalysis2017-Q1excl_US/First-timeUserTrendAnalysis2017-Q1excl_US?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**  

Dashboard Preview
<img width="1998" height="1598" alt="image" src="https://github.com/user-attachments/assets/0c9cd845-3c51-4456-b19d-2416b5df4adb" />


## 🛠️ Tools & Technologies
- **SQL (BigQuery)** – For querying and transforming large-scale session data  
- **Tableau Public** – For building the interactive dashboard and visualizations  
- **Google Analytics Sample Dataset** – Provided by Google via BigQuery public data

## 🔍 Key Visualizations
1. **Top Countries for First-Time Visitors (Excl. US)**  
   Highlights where new users are coming from outside the United States.

2. **Visits by Online Channel**  
   Compares traffic volume from different marketing sources (e.g., Direct, Organic Search, Referral).

3. **Monthly Breakdown: First-Time vs Returning Visitors (Q1 2017)**  
   Reveals visitor loyalty and acquisition patterns over time.

## 📂 Files Included
- `user_behavior_query.sql` – Final query used for the analysis
- `README.md` – This project summary
- `dashboard-preview.png` – Screenshot of the published dashboard

## 💡 Insights & Takeaways
- Certain international markets (excluding the US) generate strong first-time user engagement.
- Organic Search and Direct traffic are the top acquisition channels.
- Returning visitor trends show consistent retention over the first quarter of 2017.

## 📌 About This Project
This project was created as part of a personal data analytics portfolio to demonstrate the ability to:
- Clean and transform data with SQL
- Segment users and analyze engagement metrics
- Design insightful and interactive dashboards
- Translate raw data into business-relevant insights

## 🔗 Links
- ▶️ [Tableau Dashboard](https://public.tableau.com/views/First-timeUserTrendAnalysis2017-Q1excl_US/First-timeUserTrendAnalysis2017-Q1excl_US?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- 💻 [GitHub Repository](https://github.com/your-username/your-repo-name)

---





SELECT 
  CASE 
    WHEN visitNumber = 1 THEN 'First-time'
    ELSE 'Returning'
  END AS visitor_type,
  fullVisitorId as visitor_id,
  SUM(visitNumber) AS visit_frequency,
  TRIM (geoNetwork.country) as country,
  channelGrouping as channel,
  EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d', date)) AS year,
  EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d', date)) AS month
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` 
WHERE 
  TRIM(geoNetwork.country) NOT IN ('', '(not set)')
  AND EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d', date)) = 2017
  AND EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d', date)) <= 3
GROUP BY visitor_id, country, channel, visitor_type, year, month 
ORDER BY visitor_id

-- saved as 2017_Q1_eCommerceData, downloaded 117,903 rows of it. 
