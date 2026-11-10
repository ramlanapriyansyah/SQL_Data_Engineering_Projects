/*
- Calculate the median salary for each skill required in data engineer positions.
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and deman
- Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/
select *
from information_schema.columns
where table_catalog = 'data_jobs';

SELECT
    jp.job_title_short,
    s.skills,
    MEDIAN(jp.salary_year_avg) as salary_year_avg,
    COUNT(jp.*) as frequency 
FROM
    job_postings_fact jp
JOIN
    skills_job_dim sj
    ON jp.job_id = sj.job_id
JOIN
    skills_dim s 
    ON sj.skill_id = s.skill_id
WHERE
    jp.job_country = 'Indonesia'
    AND jp.job_title_short = 'Data Engineer'
GROUP BY
    jp.job_title_short,
    s.skills
ORDER BY
    salary_year_avg DESC,
    frequency DESC
LIMIT 10;