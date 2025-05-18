--What are the skills of the top 10 highest paying remote data analyst jobs, and what skills are required?

WITH top_10_jobs AS (
    SELECT 
        job_id,
        job_title,
        company.name AS comany_name,
        salary_year_avg
    FROM
        job_postings_fact AS job
    LEFT JOIN
        company_dim AS company ON job.company_id = company.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)

SELECT
    top_10_jobs.job_id,
    job_title,
    salary_year_avg,
    skills
FROM
    top_10_jobs
INNER JOIN
    skills_job_dim ON top_10_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim AS skills ON skills_job_dim.skill_id = skills.skill_id
ORDER BY
    salary_year_avg DESC;