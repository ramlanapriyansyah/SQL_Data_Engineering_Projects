-- Array
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table
CREATE OR REPLACE TEMP TABLE job_skill_array AS
SELECT
    jp.job_id,
    jp.job_title_short,
    jp.salary_year_avg,
    ARRAY_AGG(sd.skills) as skills_array
FROM
    job_postings_fact AS jp
LEFT JOIN 
    skills_job_dim as sjd
    ON jp.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY ALL;

-- from the data analyst perspective, analyze the median salary per skill
WITH unnest_job_skilss AS(
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_array) AS skill
    FROM job_skill_array
)
SELECT
    skill,
    MEDIAN(salary_year_avg) as median_salary
FROM unnest_job_skilss
GROUP BY skill
ORDER BY MEDIAN(salary_year_avg) DESC;

-- Array of Structs
-- Build a flat skill & type table for co-workers to access job titles, salary info, skills, and type in one table
CREATE OR REPLACE TEMP TABLE job_skill_array_struct AS
SELECT
    jp.job_id,
    jp.job_title_short,
    jp.salary_year_avg,
    ARRAY_AGG(
        STRUCT_PACK(
        skill := sd.skills,
        type := sd.type
        )
    ) as skills_array_structs
FROM
    job_postings_fact AS jp
LEFT JOIN 
    skills_job_dim as sjd
    ON jp.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY ALL;

select * from job_skill_array_struct limit 10;