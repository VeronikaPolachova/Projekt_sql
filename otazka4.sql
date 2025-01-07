-- OTÁZKA 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

CREATE VIEW v_VPolachova_o4 AS
SELECT 
	payroll_year, 
	ROUND(avg(value_payroll)) AS avg_salary,
	unit
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
WHERE value_type_code = 5958
GROUP BY payroll_year, unit
;

SELECT 
	payroll_year, 
	avg_salary,
	LAG (avg_salary) OVER (order by avg_salary) AS previous_year_salary,
	ROUND ((avg_salary - (LAG (avg_salary) OVER (order by avg_salary)))/(LAG (avg_salary) OVER (order by avg_salary))*100, 2) AS percentage_salary_growth
FROM v_vpolachova_o4 vvo 
;