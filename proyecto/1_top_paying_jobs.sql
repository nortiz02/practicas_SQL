SELECT
    Job_postings_fact.job_id,
    name AS company_name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_Schedule_type,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
LEFT JOIN
    company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title LIKE '%Data Engineer%')
    AND (salary_year_avg IS NOT NULL)
    AND (job_location LIKE '%Bogota%')
ORDER BY
    salary_year_avg DESC
LIMIT 10;