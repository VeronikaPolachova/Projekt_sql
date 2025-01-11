-- Tabulka 2
CREATE OR REPLACE TABLE t_veronika_polachova_project_SQL_secondary_final AS
SELECT 
	c.country, 
	e.year,
	e.population,
	ROUND (e.GDP) AS GDP,
	e.gini
FROM countries c 
JOIN economies e
ON c.country = e.country
WHERE e.year BETWEEN 2006 AND 2018
AND c.continent = 'Europe'
ORDER BY country, year
;

SELECT *
FROM t_veronika_polachova_project_SQL_secondary_final tvppssf 
;