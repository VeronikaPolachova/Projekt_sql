-- OTAZKA 5
-- Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH cte_interannual_growth AS (
	SELECT 
		p.payroll_year,
		ROUND (AVG (p.value_payroll)) AS avg_salary,
		ROUND (LAG (AVG (p.value_payroll)) OVER (ORDER BY p.payroll_year)) AS previous_year_salary,
	 	ROUND (AVG (p.value), 1) AS avg_price,
	 	ROUND (LAG (AVG (p.value)) OVER (ORDER BY p.payroll_year), 1) AS previous_year_price,
		s.GDP,
		LAG (s.GDP) OVER (ORDER BY s.`year`) AS previous_year_GDP,
		ROUND ((((AVG (p.value_payroll)) - (LAG (AVG (p.value_payroll)) OVER (order by p.payroll_year)))/(LAG (AVG (p.value_payroll)) OVER (order by p.payroll_year))*100), 2) AS salary_percentage_growth,
		ROUND ((((AVG (p.value)) - (LAG (AVG (p.value)) OVER (order by p.payroll_year)))/(LAG (AVG (p.value)) OVER (order by p.payroll_year))*100), 2) AS price_percentage_growth,
		ROUND (((s.GDP - (LAG (s.GDP) OVER (ORDER BY s.`year`)))/(LAG (s.GDP) OVER (ORDER BY s.`year`)))*100, 2) AS GDP_percentage_growth 
	FROM t_veronika_polachova_project_SQL_primary_final p
	LEFT JOIN t_veronika_polachova_project_SQL_secondary_final s
	ON p.payroll_year = s.`year` 
	WHERE s.country = 'Czech Republic'
	GROUP BY p.payroll_year, s.GDP
	)
SELECT 
		payroll_year,
		salary_percentage_growth,
		price_percentage_growth,
		GDP_percentage_growth,
		CASE 
			WHEN salary_percentage_growth > 0 AND salary_percentage_growth < 5 THEN 'increase'
			WHEN salary_percentage_growth > 5 THEN 'significant increase'
			WHEN salary_percentage_growth < 0 THEN 'decrease'
			WHEN salary_percentage_growth = 0 THEN 'stagnation'
		END AS salary_flag,
		CASE 
			WHEN price_percentage_growth > 0 AND price_percentage_growth < 5 THEN 'increase'
			WHEN price_percentage_growth > 5 THEN 'significant increase'
			WHEN price_percentage_growth < 0 THEN 'decrease'
			WHEN price_percentage_growth = 0 THEN 'stagnation'
		END AS price_flag,
		CASE 
			WHEN GDP_percentage_growth > 0 AND GDP_percentage_growth < 5 THEN 'increase'
			WHEN GDP_percentage_growth > 5 THEN 'significant increase'
			WHEN GDP_percentage_growth < 0 THEN 'decrease'
			WHEN GDP_percentage_growth = 0 THEN 'stagnation'
		END AS GDP_flag
FROM cte_interannual_growth
;

