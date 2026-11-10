-- PARTITION BY
SELECT
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
        PARTITION BY
            job_title_short,
            company_id
    )
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY
    RANDOM()
LIMIT 10;

 