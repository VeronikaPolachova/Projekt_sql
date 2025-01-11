-- OTÁZKA 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH cte_salary_price_differences AS (
	SELECT 
		payroll_year,
		ROUND (AVG (value_payroll)) AS avg_salary_in_CZK,
		ROUND (LAG (AVG (value_payroll)) OVER (order by payroll_year)) AS previous_year_salary,
		ROUND (AVG (value), 1) AS avg_price_in_CZK,
		ROUND (LAG (AVG (value)) OVER (order by payroll_year), 1) AS previous_year_price,
		ROUND ((((AVG (value_payroll)) - (LAG (AVG (value_payroll)) OVER (order by payroll_year)))/(LAG (AVG (value_payroll)) OVER (order by payroll_year))*100), 2) AS percentage_salary_growth,
		ROUND ((((AVG (value)) - (LAG (AVG (value)) OVER (order by payroll_year)))/(LAG (AVG (value)) OVER (order by payroll_year))*100), 2) AS percentage_price_growth
	FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
	GROUP BY payroll_year 
)
SELECT 
	payroll_year, 
	percentage_salary_growth,
	percentage_price_growth,
	ABS (percentage_price_growth - percentage_salary_growth) AS difference
FROM cte_salary_price_differences
ORDER BY difference DESC 
;



