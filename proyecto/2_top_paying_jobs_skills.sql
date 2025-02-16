WITH top_paying_jobs AS
(
    SELECT
        Job_postings_fact.job_id,
        name AS company_name,
        job_postings_fact.job_title,
        job_postings_fact.salary_year_avg
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
    LIMIT 10
)

SELECT
    skills,
    COUNT(skills) AS total
FROM top_paying_jobs
INNER JOIN
    skills_job_dim
    ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skills
ORDER BY
    total DESC
LIMIT
    5
