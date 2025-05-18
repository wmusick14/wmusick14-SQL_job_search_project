--What are the top 10 highest paying remote data analyst roles.

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
LIMIT 10;
