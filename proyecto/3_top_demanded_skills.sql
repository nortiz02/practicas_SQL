SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS total
FROM 
    job_postings_fact
INNER JOIN
    skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    (job_title LIKE '%Data Engineer%') AND (salary_year_avg IS NOT NULL)
GROUP BY
    skills
ORDER BY
    total DESC
LIMIT
    5