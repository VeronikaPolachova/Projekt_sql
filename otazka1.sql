-- OTAZKA 1
-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


WITH cte_salary_history AS (
	SELECT 
		payroll_year,
		industry_branch_name,
		value_payroll AS salary,
		LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year) AS previous_year_salary,
		ROUND (((AVG(value_payroll) - LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year))/ LAG (AVG (value_payroll)) OVER (PARTITION BY industry_branch_name ORDER BY payroll_year))*100, 2) AS salary_annual_growth -- mezirocni narust mezd v procentech
	FROM t_veronika_polachova_project_SQL_primary_final tvppspf
	WHERE value_type_code = 5958
	GROUP BY payroll_year, industry_branch_name, value_payroll 
	ORDER BY industry_branch_name, payroll_year 
	)
SELECT *,
	CASE 
			WHEN salary_annual_growth > 0 THEN 'annual_increase'
			WHEN salary_annual_growth < 0 THEN 'annual_decrease'
			WHEN salary_annual_growth = 0 THEN 'annual_stagnation'
			ELSE NULL
		END AS flag_annual_salary_growth,
		CASE 
			WHEN salary_annual_growth IS NOT NULL THEN ROUND(AVG(salary_annual_growth) OVER (PARTITION BY industry_branch_name),2)
			ELSE NULL
		END AS overall_growth_per_industry, -- celkovy prumerny rust mezd v kazdem odetvi za celkove obdobi 
		CASE
			WHEN AVG(salary_annual_growth) OVER (PARTITION BY industry_branch_name) > 0 THEN 'overall_increase'
			WHEN AVG(salary_annual_growth) OVER (PARTITION BY industry_branch_name) < 0 THEN 'overall_decrease'
			WHEN AVG(salary_annual_growth) OVER (PARTITION BY industry_branch_name) = 0 THEN 'overall_stagnation'
			ELSE NULL
		END AS flag_overall_growth_per_industry
FROM cte_salary_history
ORDER BY industry_branch_name, payroll_year
;

