--What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a remote data analyst? 

SELECT

    skills.skills AS skill_name,
    COUNT(job.job_id) AS demand_count,
    ROUND(AVG(job.salary_year_avg), 00) AS avg_salary
FROM
    job_postings_fact AS job
INNER JOIN
    skills_job_dim AS skills_job ON job.job_id = skills_job.job_id
INNER JOIN
    skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job.job_title_short = 'Data Analyst' AND
    job.salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills.skills
HAVING
    COUNT(job.job_id) > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;