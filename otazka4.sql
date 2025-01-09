-- OTÁZKA 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

CREATE OR REPLACE VIEW v_VPolachova_o4 AS
SELECT 
	payroll_year, 
	ROUND (AVG (value_payroll)) AS avg_salary_in_CZK
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
WHERE value_type_code = 5958
GROUP BY payroll_year, unit
;

CREATE OR REPLACE VIEW v_vpolachova_o4_2 AS
SELECT 
	year, 
	ROUND (AVG (value), 1) AS avg_price_in_CZK
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
GROUP BY year
;


SELECT 
	A.payroll_year, 
	A.percentage_salary_growth,
	B.percentage_price_growth
FROM
	(SELECT 
		payroll_year, 
		avg_salary_in_CZK,
		LAG (avg_salary_in_CZK) OVER (order by payroll_year) AS previous_year_salary,
		ROUND ((avg_salary_in_CZK - (LAG (avg_salary_in_CZK) OVER (order by avg_salary_in_CZK)))/(LAG (avg_salary_in_CZK) OVER (order by avg_salary_in_CZK))*100, 2) AS percentage_salary_growth
	FROM v_vpolachova_o4 vvo
	) AS A
LEFT JOIN 
	(SELECT 
		year,
		avg_price_in_CZK,
		LAG (avg_price_in_CZK) OVER (order by year) AS previous_year_price,
		ROUND ((avg_price_in_CZK - (LAG (avg_price_in_CZK) OVER (order by year)))/(LAG (avg_price_in_CZK) OVER (order by year))*100, 2) AS percentage_price_growth
	FROM v_vpolachova_o4_2 vvo2 
	) AS B
ON A.payroll_year = B.year
;

-- jiny zpusob, bez views, kompaktneji

SELECT 
	payroll_year,
	ROUND (AVG (value_payroll)) AS avg_salary_in_CZK,
	ROUND (LAG (AVG (value_payroll)) OVER (order by payroll_year)) AS previous_year_salary,
	ROUND (AVG (value), 1) AS avg_price_in_CZK,
	ROUND (LAG (AVG (value)) OVER (order by payroll_year), 1) AS previous_year_price
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
WHERE value_type_code = 5958
GROUP BY payroll_year 
;



