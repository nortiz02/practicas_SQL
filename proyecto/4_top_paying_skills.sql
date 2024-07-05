WITH total_engineer_jobs AS
(
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM
    job_postings_fact
WHERE
    (job_title LIKE '%Data Engineer%') AND (salary_year_avg IS NOT NULL)
)

SELECT 
    skills,
    AVG(salary_year_avg) AS avg_salary
FROM 
    total_engineer_jobs
INNER JOIN
    skills_job_dim
    ON skills_job_dim.job_id = total_engineer_jobs.job_id
INNER JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT
    5

