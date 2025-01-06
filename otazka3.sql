-- OTAZKA 3
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	year, 
	category,
	price_value, 
	price_unit,
	ROUND (AVG (value), 2) AS price_in_CZK,
	ROUND(LAG (AVG (value)) OVER (PARTITION BY category ORDER BY year), 2) AS previous_year_price_in_CZK, 
    ROUND (((AVG (value) - LAG (AVG (value)) OVER (PARTITION BY category ORDER BY year))/(LAG (AVG (value)) OVER (PARTITION BY category ORDER BY year)))*100, 2) AS price_percentage_growth
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
GROUP BY year, category, price_value, price_unit 
ORDER BY category, year
;

