-- .read Lessons/1.21/1.21_DDL_DML_pt2.sql

CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name as company_name
FROM data_jobs.job_postings_fact jpf
LEFT JOIN data_jobs.company_dim cd
    ON jpf.company_id = cd.company_id;


SELECT COUNT(*)
FROM staging.job_postings_flat;

-- VIEW
CREATE OR REPLACE VIEW main.priority_job_flat_view AS
SELECT
    jpf.*
FROM staging.job_postings_flat jpf
JOIN staging.priority_roles r 
    ON jpf.job_title_short = r.role_name
WHERE
    r.priority_lvl = 1;

SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM main.job_postings_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;

-- TEMP TABLE
CREATE TEMPORARY TABLE senior_temp_table AS
SELECT *
FROM main.priority_job_flat_view
WHERE job_title_short = 'Senior Data Engineer';

 
