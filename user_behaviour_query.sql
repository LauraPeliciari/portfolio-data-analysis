
SELECT 
  CASE 
    WHEN visitNumber = 1 THEN 'First-time' ELSE 'Returning' 
    END AS visitor_type, 
  fullVisitorId as visitor_id, 
  SUM(visitNumber) AS visit_frequency, 
  TRIM (geoNetwork.country) as country, 
  channelGrouping as channel, 
  EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d', date)) AS year, 
  EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d', date)) AS month 
FROM bigquery-public-data.google_analytics_sample.ga_sessions_* 
WHERE 
  TRIM(geoNetwork.country) NOT IN ('', '(not set)') AND 
  EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d', date)) = 2017 AND 
  EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d', date)) <= 3 
GROUP BY visitor_id, country, channel, visitor_type, year, month 
ORDER BY visitor_id

