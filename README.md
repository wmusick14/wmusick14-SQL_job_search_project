# wmusick14-SQL_job_search_project

# SQL Job Search Project
## Introduction 
Welcome to my SQL job search portfolio project, where I investigate the data job market, focusing  on data analyst roles. Looking at data from 2023, this project identifies prior top-paying jobs, discovers the most in-demand skills, and finds the intersection of high demand with high salary in the field of data analytics.

Look at my SQL queries here: [Job_search_project queries] (/SQL_queries/). 

## Background
The project motivation developed from from my desire to comprehend the data analyst job market better, allowing me to discover which skills are the most in-demand and most well compensated, allowing me to make my future job search more effective. 

The data for this analysis came from [Luke Barousse’s SQL Course](https://www.lukebarousse.com/sql). This data includes details on job titles, salaries, locations, and required skills. 

The questions I wanted to answer through my SQL queries were:

1. What are the top-paying remote data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a data analyst looking to maximize job market value?

## Tools Used
I employed the use of three tools to conduct my analysis of this project:

- **SQL** (Structured Query Language): Allowed me to interact with the database, extract insights, and answer my key questions through queries.

- **PostgreSQL**: Used as the database management system| PostgreSQL allowed me to store, query, and manipulate the job posting data.

- **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.

- **Git & GitHub:** An essential computer program and web-based platform for used for version control of project scripts and analysis, also used to share my repository with collaborators.

## Analysis
Each query in the project was used to seek key insights of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Remote Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
    company.name AS company_name,
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
```

|Job ID|Job Title|Company Name|Average Yearly Salary|
|------|---------|------------|---------------------|
|226942|Data Analyst|Mantys|650000|
|547382|Director of Analytics|Meta|336500|
|552322|Associate Director- Data Insights|AT&T|255829.50|
|99305|Data Analyst|Pinterest|232423|
1021647|Data Analyst|Uclahealthcareers|217000|
168310|Principal Data Analyst|SmartAsset|205000|
731368|Director- Data Analyst|Inclusively|189309|
310660|Principal Data Analyst|Motional|189000|
1749593|Principal Data Analyst|SmartAsset|186000|
387860|ERM Data Analyst|Get It Recruit - Information Technology|184000|

Here are some insights found from the top data analyst jobs:

 - **Large Salary Range:** Yearly salaries from the top-paying jobs varied by a great degree, with the highest-paying data analyst position paying $650,000 anually and the tenth highest-paying $184|000 anually.

 - **Job Title Variety:** There's a vast range of data analyst titles| from Director or Analytics to Data Analyst. This reflects the importantance of specialization and the varied roles in the data induestry.

 - **Wide Range in Employment Opportunities:** There is an expansive list of companies with the need to employ data analyst roles. In this short ten example showcase, there are jobs in tech, communications, healthcare, and marketing. There is a place for everyone to find their niche in the data analysis career.

### 2. Skills for Top Paying Jobs

To discover the skills required for the top-paying jobs, I joined the job postings table with the skills data table. This helped provide insights into what skills employers value for high-compensation roles.

```sql
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
```

Here are a few insights from the skills for top-payed analysts.

- **Core Skills:** No matter the salary, there are certain skills that are highly demanded; those being SQL, MS Excel, a form of data visualization such as Tableau or MS Power BI, and a cloud platform such as AWS, Google cloud, or Azure.

- **Coding is Key:** The top data analysis jobs all seem to desire an analyst who is proficient in multiple coding languages such as R, Python, differnet Python libraries, jira, etc.

### 3. In-Demand Skills for Data Analysts

This query helped to identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```
**Results:** For this query there were 637313 qualifying jobs. The top five demanded skills in order of most demand to least demand are SQL, Excel, Python, Tableau, and Power BI. Below is a table of the total count of each of the top five skills along with their percentage of demand.

| Skills   | Skill Count | Skill Percentage|
|----------|-------------|-----------------|
| SQL      | 92628       | 14.53%          |
| Excel    | 67031       | 10.52%          |
| Python   | 57326       | 8.99%           |
| Tableau  | 46554       | 7.30%           |
| Power BI | 39468       | 6.19%           |

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT
    skills.skills AS skill_name,
    ROUND(AVG(job.salary_year_avg), 00) AS avg_salary
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
```

**Results:** Looking at the table below showing the top fifteen paying skills, most of skills are directly related to coding languages and cloud based-programs. This discovery aligned with the idea found in query two that employers highly desire employees with coding knowledge.

|Skill Name|Average Salary|
|----------|--------------|
|svn       |400000        |
|solidity  |179000        |
|couchbase |160515        |
|datarobot |155486        |
|golang    |155000        |
|mxnet     |149000        |
|dplyr     |147633        |
|vmware    |147500        |
|terraform |146734        |
|twilio    |138500        |
|gitlab    |134126        |
|kafka     |129999        |
|puppet    |129820        |
|keras     |127013        |
|pytorch   |125226        |


### 5. Most Optimal Skills to Learn

Combining demand and salary data| this query allows us to discover skills that are both in high demand and have high salaries, allowing learners insight on where to focus their skill development.

```sql
SELECT

    skills.skills AS skill_name,
    COUNT(job.job_id) AS demand_count,
    ROUND(COUNT(job.job_id) * 100.0 / SUM(COUNT(job.job_id)) OVER (), 2) AS demand_percentage,
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
```
**Results:** The results displayed in the table below show us the top twenty-five skills and the average salary of the skill. Looking at the data, SQL is by far the most in-demand skill, followed in some distance by Excel, Python, and Tableau; these are the gold standard in data processing, data visualization, and data manipulation. After come three more standout skills: r, sas, and Power BI. These are different tools used for data maipluation and data visualization. Skills eight trough twenty-five seem to be either different forms or data visualization tools a report or presentation tools, cloud-based data platforms, or coding knowledge. Their use case will vary based on company and are not standardized across the data industry as the data industry can be very niche. As for skill salary, these results are mirroed in the results from query two, where specialized coding knowledge is more highly compensated. 


|Skill Name|Demand Count|Demand Percentage|Average Salary|
|----------|------------|-----------------|--------------|
|sql       |398         |17.99%           |97237         |
|excel     |256         |11.57%           |87288         |
|python    |236         |10.67%           |101397        |
|tableau   |230         |10.40%           |99288         |
|r         |148         |6.69%            |100499        |
|sas       |126         |5.70%            |98902         |
|power bi  |110         |4.97%            |97431         |
|powerpoint|58          |2.62%            |88701         |
|looker    |49          |2.22%            |103795        |
|word      |48          |2.17%            |82576         |
|snowflake |37          |1.67%            |112948        |
|oracle    |37          |1.67%            |104534        |    
|sql server|35          |1.58%            |97786         |
|azure     |34          |1.54%            |111225        |
|aws       |32          |1.45%            |108317        |
|sheets    |32          |1.45%            |86088         |
|flow      |28          |1.27%            |97200         |
|go        |27          |1.22%            |115320        |
|spss      |24          |1.08%            |92170         |
|vba       |24          |1.08%            |88783         | 
|hadoop    |22          |0.99%            |113193        |
|jira      |20          |0.90%            |104918        |
|javascript|20          |0.90%            |97587         |
|sharepoint|18          |0.81%            |81634         |
|java      |17          |0.77%            |106906        |


Overall, these queries helped me to answer a specific questions related to the data industry job market as well as to improve my understanding of SQL and database analysis. Through this project, I learned how important it is to empole SQL's powerful data manipulation capabilities and found to extract meaningful insights from the datasets.

### **What I Learned**

Throughout this project, I enhanced several key SQL techniques and skills:

- **Complex Query Construction**: Learning to build advanced SQL queries that combine multiple tables and employ functions like **`WITH`** clauses for temporary tables.
- **Data Aggregation**: Utilizing **`GROUP BY`** and aggregate functions like **`COUNT()`** and **`AVG()`** to summarize data effectively.
- **Analytical Thinking**: Developing the ability to translate real-world questions into actionable SQL queries that got insightful answers.

### **Insights**

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries| with the highest paying $650,000.
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### **Conclusion**

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. This will allow me focus on high-demand, high-salary skills to better position myself in a competitive job market.
