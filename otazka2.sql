-- OTAZKA 2

-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	year, 
	ROUND (AVG (value), 1) AS avg_price_in_CZK,
	CONCAT (category, ' ', price_value, ' ', price_unit) AS category_and_unit,
	ROUND (AVG (value_payroll)) AS avg_salary_in_CZK,
	CONCAT (FLOOR (AVG (value_payroll)/AVG (value)), ' ', price_unit) AS affordability_index_and_unit -- zaokrouhluji dolu, na cele kusy zbozi 
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
WHERE year IN (2006, 2018)
AND category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
AND value_type_code = 5958
GROUP BY year, category,price_unit, price_value 
ORDER BY `year` 
;