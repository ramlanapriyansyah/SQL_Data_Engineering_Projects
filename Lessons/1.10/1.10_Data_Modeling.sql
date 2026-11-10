/*
Find the top 10 companies for posting jobs
They must have >3000 postings
*/

select * from company_dim
limit 1;

select *
from information_schema.tables
where table_catalog = 'data_jobs';

