SELECT * 
FROM job_postings_fact
LIMIT 10;

SELECT * 
FROM job_postings_fact
LIMIT 10;

select *
from information_schema.columns
where table_catalog = 'data_jobs'
    and table_name = 'job_postings_fact';

select *
from information_schema.columns
where table_catalog = 'data_jobs'
    and table_name = 'skills_dim';

select *
from information_schema.columns
where table_catalog = 'data_jobs'
    and table_name = 'skills_job_dim';

-- Retrieve jobs yang skill nya gak ada di skills table
SELECT *
FROM skills_dim AS src
WHERE NOT EXISTS(
    SELECT 1
    FROM skills_job_dim AS tgt
    WHERE src.skill_id = tgt.skill_id
);