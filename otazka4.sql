-- OTÁZKA 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT 
	payroll_year,
	industry_branch_code,
	industry_branch_name,
	ROUND (AVG (value_payroll)) as avg_salary
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
WHERE value_type_code = 5958
AND industry_branch_code IS NOT NULL
GROUP BY payroll_year, industry_branch_name, industry_branch_code
ORDER BY industry_branch_code, `year` 
;

