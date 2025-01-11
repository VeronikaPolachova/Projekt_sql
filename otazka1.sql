-- OTAZKA 1
-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH cte_avg_salary_statistics AS (
	WITH cte_salary_history AS (
		SELECT 
			payroll_year,
			industry_branch_name,
			ROUND (value_payroll) AS salary,
			ROUND (LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year)) AS previous_year_salary,
			ROUND (((AVG(value_payroll) - LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year))/ LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year))*100, 2) AS salary_interannual_growth -- mezirocni narust mezd v procentech
		FROM t_veronika_polachova_project_SQL_primary_final tvppspf
		GROUP BY payroll_year, industry_branch_name, value_payroll 
		ORDER BY industry_branch_name, payroll_year 
		)
	SELECT *,
		CASE 
				WHEN salary_interannual_growth > 0 THEN 'interannual_increase'
				WHEN salary_interannual_growth < 0 THEN 'interannual_decrease'
				WHEN salary_interannual_growth = 0 THEN 'interannual_stagnation'
				ELSE NULL
			END AS flag_interannual_salary_growth,
			CASE 
				WHEN salary_interannual_growth IS NOT NULL THEN ROUND(AVG(salary_interannual_growth) OVER (PARTITION BY industry_branch_name),2)
				ELSE NULL
			END AS avg_growth_per_industry, -- celkovy prumerny rust mezd v kazdem odetvi za celkove obdobi 
			CASE
				WHEN AVG(salary_interannual_growth) OVER (PARTITION BY industry_branch_name order by payroll_year) > 0 THEN 'avg_increase'
				WHEN AVG(salary_interannual_growth) OVER (PARTITION BY industry_branch_name order by payroll_year) < 0 THEN 'avg_decrease'
				WHEN AVG(salary_interannual_growth) OVER (PARTITION BY industry_branch_name order by payroll_year) = 0 THEN 'avg_stagnation'
				ELSE NULL
			END AS flag_avg_growth_per_industry
	FROM cte_salary_history
	ORDER BY industry_branch_name, payroll_year 
	)
SELECT 
	payroll_year, 
	industry_branch_name, 
	salary_interannual_growth,
	flag_interannual_salary_growth, 
	avg_growth_per_industry,
	flag_avg_growth_per_industry
FROM cte_avg_salary_statistics
WHERE 1=1
AND flag_interannual_salary_growth IN ('interannual_decrease', 'interannual_stagnation') -- pokud chci konkretní rok a odvetvi, kdy mezirovne nedoslo k rustu platu
-- AND flag_avg_growth_per_industry = 'avg_decrease' -- pokud chci videt, jestli a v jakych odvetvich doslo k prumernemu poklesu mezd za dane casove obdobi
ORDER BY industry_branch_name, payroll_year
;
