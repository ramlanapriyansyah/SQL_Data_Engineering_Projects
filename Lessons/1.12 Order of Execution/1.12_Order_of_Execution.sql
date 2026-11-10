EXPLAIN ANALYZE
select c.name, count(j.*) as postings
from job_postings_fact j 
join company_dim c 
    on j.company_id = c.company_id
group by
    c.name
having postings > 3000
order by postings desc
limit 10;