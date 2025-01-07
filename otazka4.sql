-- OTÁZKA 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT *
FROM (
	SELECT
		payroll_year,
		industry_branch_code,
		industry_branch_name,
		ROUND(AVG (value_payroll)) as avg_salary
	FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
	WHERE value_type_code = 5958
	AND industry_branch_code IS NOT NULL
	GROUP BY payroll_year, industry_branch_name, industry_branch_code
	ORDER BY industry_branch_code, `year`
	) AS A
LEFT JOIN (
	SELECT 
			payroll_year, 
			industry_branch_name, 
			AVG (value_payroll) AS avg_count, 
			unit
	FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
	WHERE value_type_code = 316
	AND industry_branch_name IS NOT NULL
	GROUP BY payroll_year, industry_branch_name, unit 
	) AS B
ON A.payroll_year = B.payroll_year
AND A.industry_branch_name = B.industry_branch_name
;