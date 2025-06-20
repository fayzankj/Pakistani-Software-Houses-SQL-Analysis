-- ADVANCED DATA ANALYSIS -----------
-- companies present in multiple cities 
SELECT 
    company_name, COUNT(DISTINCT (city)) AS city_count
FROM
    pksoftware_houses.software_houses_pk
GROUP BY company_name
HAVING city_count > 1;
-- companies who offers both software development & digital marketing
SELECT 
    company_name
FROM
    pksoftware_houses.software_houses_pk
WHERE
    LOWER(services) LIKE '%software development%'
        AND LOWER(services) LIKE '%digital marketing%';
-- Compare % of total companies per city
with total as (select count(*) as total_companies from  pksoftware_houses.software_houses_pk),
city_counts as (select city, count(*) as companies_in_city from  pksoftware_houses.software_houses_pk group by city)
select city, companies_in_city, ROUND((companies_in_city / total.total_companies) * 100, 2) AS percentage_of_total FROM city_counts, total ORDER BY percentage_of_total DESC;
-- •	Create a “completeness score” per company: 1 point for each of:
-- o	Contact present
-- o	Valid city
-- o	At least 1 service
-- o	Unique name
SELECT 
    company_name,
    (CASE
        WHEN
            contact_no IS NOT NULL
                AND contact_no NOT IN ('N/A' , 'unknown', '-')
        THEN
            1
        ELSE 0
    END + CASE
        WHEN
            city IS NOT NULL
                AND city NOT IN ('N/A' , 'unknown', '-')
        THEN
            1
        ELSE 0
    END + CASE
        WHEN
            company_name IS NOT NULL
                AND company_name NOT IN ('N/A' , 'unknown', '-')
        THEN
            1
        ELSE 0
    END + CASE
        WHEN
            services IS NOT NULL
                AND services NOT IN ('N/A' , 'unknown', '-')
        THEN
            1
        ELSE 0
    END) AS completeness_score
FROM
    pksoftware_houses.software_houses_pk
ORDER BY completeness_score
