-- create database PKsoftware_houses;
-- Record Audit
-- 	check Total rows
SELECT 
    COUNT(*)
FROM
    pksoftware_houses.software_houses_pk;

-- 	check Nulls or garbage ('N/A', 'Not Available', '-')
-- ** Finding & updating fake-nulls('N/A', 'Not Available', '-') with Real NULL
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN company_name IN ('N/A' , 'Not Available', '-') THEN 1
        ELSE 0
    END) AS fake_null_company_name,
    SUM(CASE
        WHEN city IN ('N/A' , 'Not Available', '-') THEN 1
        ELSE 0
    END) AS fake_null_city,
    SUM(CASE
        WHEN address IN ('N/A' , 'Not Available', '-') THEN 1
        ELSE 0
    END) AS fake_null_address,
    SUM(CASE
        WHEN contact_no IN ('N/A' , 'Not Available', '-') THEN 1
        ELSE 0
    END) AS fake_null_contact,
    SUM(CASE
        WHEN services IN ('N/A' , 'Not Available', '-') THEN 1
        ELSE 0
    END) AS fake_null_services
FROM
    pksoftware_houses.software_houses_pk;

-- Replacing fake nulls ('N/A', 'Not Available', '-') in address, contact_no, and services with actual NULLs for accurate missing data handling.
UPDATE pksoftware_houses.software_houses_pk 
SET 
    address = NULL
WHERE
    address IN ('N/A' , 'Not Available', '-');
UPDATE pksoftware_houses.software_houses_pk 
SET 
    contact_no = NULL
WHERE
    contact_no IN ('N/A' , 'Not Available', '-');
UPDATE pksoftware_houses.software_houses_pk 
SET 
    services = NULL
WHERE
    services IN ('N/A' , 'Not Available', '-');

-- ** Finding & updating Null with appropriate Data
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN company_name IS NULL THEN 1
        ELSE 0
    END) AS null_company_name,
    SUM(CASE
        WHEN city IS NULL THEN 1
        ELSE 0
    END) AS null_city,
    SUM(CASE
        WHEN address IS NULL THEN 1
        ELSE 0
    END) AS null_address,
    SUM(CASE
        WHEN contact_no IS NULL THEN 1
        ELSE 0
    END) AS null_contact_no,
    SUM(CASE
        WHEN services IS NULL THEN 1
        ELSE 0
    END) AS null_services
FROM
    pksoftware_houses.software_houses_pk;
-- updating null in services with missing 
UPDATE pksoftware_houses.software_houses_pk 
SET 
    services = 'Unknown'
WHERE
    services IS NULL;
-- update ERROR in contact column with Null 
UPDATE pksoftware_houses.software_houses_pk 
SET 
    contact_no = NULL
WHERE
    contact_no = '#ERROR!';
DELETE FROM pksoftware_houses.software_houses_pk 
WHERE
    city IS NULL;
-- check out duplicates 
SELECT 
    company_name,
    city,
    address,
    contact_no,
    services,
    COUNT(*) AS duplicate_count
FROM
    pksoftware_houses.software_houses_pk
GROUP BY company_name , city , address , contact_no , services
HAVING COUNT(*) > 1;

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
