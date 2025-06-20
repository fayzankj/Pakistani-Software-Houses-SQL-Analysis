-- BASIC DATA ANALYSIS -----------
-- How many companies per city?
SELECT 
    city, COUNT(*) AS Total_companies
FROM
    pksoftware_houses.software_houses_pk
GROUP BY city;
-- 	How many companies have complete contact info?
SELECT 
    COUNT(*)
FROM
    pksoftware_houses.software_houses_pk
WHERE
    contact_no IS NOT NULL;
-- 	What are the top 5 services offered?
SELECT 
    services, COUNT(*) AS occurence
FROM
    pksoftware_houses.software_houses_pk
GROUP BY services
ORDER BY occurence DESC
LIMIT 6;
-- Which cities are underserved?
SELECT 
    city, COUNT(*) AS Total_companies
FROM
    pksoftware_houses.software_houses_pk
GROUP BY city
ORDER BY Total_companies
LIMIT 5;
-- How many companies are unknown/null in name or services?
SELECT 
    COUNT(*) AS Count_of_Unknown_companies
FROM
    pksoftware_houses.software_houses_pk
WHERE
    company_name IS NULL
        OR company_name IN ('unknown')
        OR services IS NULL
        OR services IN ('unknown');

