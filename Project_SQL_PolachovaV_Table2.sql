-- Tabulka 2

SELECT 
	c.country, 
	c.continent,
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
