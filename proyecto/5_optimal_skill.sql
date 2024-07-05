WITH top_paying_skills AS
(
    SELECT
        skills_dim.skill_id,
        AVG(salary_year_avg) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
        ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN
        skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        (job_title LIKE '%Data Engineer%')
        AND (salary_year_avg IS NOT NULL)
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        avg_salary DESC
),
top_demand_skills AS
(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS total_skills
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
        ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN
        skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title LIKE ('%Data Engineer%')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        total_skills DESC
)

SELECT
    top_demand_skills.skill_id,
    top_demand_skills.skills,
    top_demand_skills.total_skills,
    top_paying_skills.avg_salary

FROM
    top_demand_skills
INNER JOIN
    top_paying_skills
    ON top_paying_skills.skill_id = top_demand_skills.skill_id
ORDER BY
    total_skills DESC
LIMIT
    10
