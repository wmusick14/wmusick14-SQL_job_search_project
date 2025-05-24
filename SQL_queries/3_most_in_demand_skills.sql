--What are the top 5 in-demand skills for data analysts?

SELECT
    skills.skills AS skill_name,
    COUNT(job.job_id) AS skill_count,
    ROUND(COUNT(job.job_id) * 100.0 / SUM(COUNT(job.job_id)) OVER (), 2) AS skill_percentage
FROM
    job_postings_fact AS job
INNER JOIN
    skills_job_dim AS skills_job ON job.job_id = skills_job.job_id
INNER JOIN 
    skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job.job_title_short = 'Data Analyst'
GROUP BY
    skill_name
ORDER BY
    skill_count DESC
LIMIT 5;
