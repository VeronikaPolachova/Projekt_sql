-- OTAZKA 3
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	year, 
	ROUND (AVG (value), 2) AS price,
	category,
	price_value, 
	price_unit
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
GROUP BY year, category, price_value, price_unit 
ORDER BY category, year
;

