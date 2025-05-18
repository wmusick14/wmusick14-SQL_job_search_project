-- What are the top 15 skills for a data analyst based on salary? 

SELECT
    skills.skills AS skill_name,
    AVG(job.salary_year_avg) AS avg_salary
FROM
    job_postings_fact AS job
INNER JOIN 
    skills_job_dim AS skills_job ON job.job_id = skills_job.job_id
INNER JOIN  
    skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job.job_title_short = 'Data Analyst' AND
    job.salary_year_avg IS NOT NULL
GROUP BY
    skill_name
ORDER BY
    avg_salary DESC
LIMIT 15;