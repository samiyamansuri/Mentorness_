SELECT * FROM corona_analysis.corona_virus_data;

SELECT * FROM corona_analysis.corona_virus_data
WHERE Province IS NULL
   OR Country IS NULL
   OR Latitude IS NULL
   OR Longitude IS NULL
   OR Date IS NULL
   OR Confirmed IS NULL
   OR Deaths IS NULL
   OR Recovered IS NULL;

UPDATE corona_analysis.corona_virus_data
SET Province = COALESCE(Province, 'Unknown'),
    Country = COALESCE(Country, 'Unknown'),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0);

SELECT COUNT(*) AS Total_Rows
FROM corona_analysis.corona_virus_data;

SELECT MIN(Date) AS Start_Date, MAX(Date) AS End_Date
FROM corona_analysis.corona_virus_data;

SELECT COUNT(DISTINCT MONTH(Date)) AS Number_Of_Months
FROM corona_analysis.corona_virus_data;

SELECT YEAR(Date) AS year, COUNT(DISTINCT MONTH(Date)) AS months_in_year
FROM corona_analysis.corona_virus_data
GROUP BY year;

SELECT DATE_FORMAT(Date, '%Y-%m') AS month, 
       AVG(Confirmed) AS Avg_Confirmed, 
       AVG(Deaths) AS Avg_Deaths, 
       AVG(Recovered) AS Avg_Recovered
FROM corona_analysis.corona_virus_data
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY month;

SELECT Month,
    MAX(Confirmed) AS MostFrequentConfirmed,
    MAX(Deaths) AS MostFrequentDeaths,
    MAX(Recovered) AS MostFrequentRecovered
FROM (
    SELECT DATE_FORMAT(Date, '%Y-%m') AS month, Confirmed, Deaths, Recovered, COUNT(*) AS frequency
    FROM corona_analysis.corona_virus_data
    GROUP BY DATE_FORMAT(Date, '%Y-%m'), Confirmed, Deaths, Recovered
) AS subquery
GROUP BY month;

SELECT YEAR(Date) AS Year, 
       MIN(Confirmed) AS Min_Confirmed, 
       MIN(Deaths) AS Min_Deaths, 
       MIN(Recovered) AS Min_Recovered
FROM corona_analysis.corona_virus_data
GROUP BY year;

SELECT YEAR(Date) AS Year, 
       MAX(Confirmed) AS Max_Confirmed, 
       MAX(Deaths) AS Max_Deaths, 
       MAX(Recovered) AS Max_Recovered
FROM corona_analysis.corona_virus_data
GROUP BY year;

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
       SUM(Confirmed) AS Total_Confirmed, 
       SUM(Deaths) AS Total_Deaths, 
       SUM(Recovered) AS Total_Recovered
FROM corona_analysis.corona_virus_data
GROUP BY Month;

SELECT COUNT(Confirmed) AS Total_Cases, 
       AVG(Confirmed) AS Average_Cases, 
       VARIANCE(Confirmed) AS Variance_Cases, 
       STDDEV(Confirmed) AS Stddev_Cases
FROM corona_analysis.corona_virus_data;

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
       COUNT(Deaths) AS Total_Deaths, 
       AVG(Deaths) AS Average_Deaths, 
       VARIANCE(Deaths) AS Variance_Deaths, 
       STDDEV(Deaths) AS Stddev_Deaths
FROM corona_analysis.corona_virus_data
GROUP BY Month;

SELECT COUNT(Recovered) AS Total_Recovered, 
       AVG(Recovered) AS Average_Recovered, 
       VARIANCE(Recovered) AS Variance_Recovered, 
       STDDEV(Recovered) AS Stddev_Recovered
FROM corona_analysis.corona_virus_data;

SELECT Country, MAX(Confirmed) AS Total_Confirmed
FROM corona_analysis.corona_virus_data
GROUP BY Country
ORDER BY Total_Confirmed DESC;

SELECT Country, MIN(Deaths) AS Total_Deaths
FROM corona_analysis.corona_virus_data
GROUP BY Country
HAVING Total_Deaths = (
    SELECT MIN(Deaths)
    FROM corona_analysis.corona_virus_data
);

SELECT Country, MAX(Recovered) AS TotalRecovered
FROM corona_analysis.corona_virus_data
GROUP BY Country
ORDER BY TotalRecovered DESC
LIMIT 5;
