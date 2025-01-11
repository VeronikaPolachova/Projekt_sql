-- OTAZKA 5
-- Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

SELECT 
	p.payroll_year,
	ROUND (AVG (p.value_payroll)) AS avg_salary,
	ROUND (LAG (AVG (p.value_payroll)) OVER (ORDER BY p.payroll_year)) AS previous_year_salary,
 	ROUND (AVG (p.value), 1) AS avg_price,
 	ROUND (LAG (AVG (p.value)) OVER (ORDER BY p.payroll_year), 1) AS previous_year_price,
	s.GDP,
	LAG (s.GDP) OVER (ORDER BY s.`year`) AS previous_year_GDP
FROM t_veronika_polachova_project_SQL_primary_final p
LEFT JOIN t_veronika_polachova_project_SQL_secondary_final s
ON p.payroll_year = s.`year` 
WHERE s.country = 'Czech Republic'
GROUP BY p.payroll_year 
;

SELECT * 
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
;

SELECT *
FROM t_veronika_polachova_project_SQL_secondary_final tvppssf 
;