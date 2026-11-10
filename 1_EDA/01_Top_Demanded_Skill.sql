/*
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why?
    - Retrieves the top 10 skills with the highest demand in the remote job market, providing insights into the most valuable skills for data engineers seeking remote work.
*/

SELECT
    jp.job_title_short,
    s.skills,
    COUNT(jp.*) as total_demand
FROM job_postings_fact jp
JOIN skills_job_dim sj
    ON jp.job_id = sj.job_id
JOIN skills_dim s 
    ON sj.skill_id = s.skill_id
WHERE 
    jp.job_title_short = 'Data Engineer'
    AND jp.job_country = 'Indonesia'
GROUP BY
    jp.job_title_short,
    s.skills
ORDER BY
    total_demand DESC
LIMIT 10;

select * 
from information_schema.columns
where table_catalog = 'data_jobs';

/*
┌─────────────────┬────────────┬──────────────┐
│ job_title_short │   skills   │ total_demand │
│     varchar     │  varchar   │    int64     │
├─────────────────┼────────────┼──────────────┤
│ Data Engineer   │ sql        │       233132 │
│ Data Engineer   │ python     │       224102 │
│ Data Engineer   │ aws        │       130205 │
│ Data Engineer   │ azure      │       128822 │
│ Data Engineer   │ spark      │       106904 │
│ Data Engineer   │ java       │        69657 │
│ Data Engineer   │ databricks │        63012 │
│ Data Engineer   │ snowflake  │        60379 │
│ Data Engineer   │ scala      │        57079 │
│ Data Engineer   │ kafka      │        56410 │
└─────────────────┴────────────┴──────────────┘
/*