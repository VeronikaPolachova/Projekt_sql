-- PROJECT SQL --
-- Discord: veronikapolachova

-- TABULKA 1 

CREATE OR REPLACE TABLE t_veronika_polachova_project_SQL_primary_final AS 
SELECT
	A.*,
	B.*
FROM (
			SELECT 
			year(cp.date_from) AS year,
			cp.value AS value,
			cpc.price_value,
			cpc.price_unit,
			cp.category_code,
			cpc.name AS category,
			cp.region_code,
			cr.name AS region
		FROM czechia_price as cp
		LEFT JOIN czechia_price_category as cpc 
			ON cp.category_code = cpc.code 
		LEFT JOIN czechia_region as cr 
		ON cp.region_code = cr.code
		) AS A
	LEFT JOIN (
			SELECT 
			cp.payroll_year, 
			cp.calculation_code, 
			cpc.name AS calculation_code_name,
			cp.industry_branch_code, 
			cpib.name AS industry_branch_name,
			cpvt.code AS value_type_code,
			cpvt.name AS value_type,
			AVG(cp.value) AS value_payroll,
			cp.unit_code AS unit_code,
			cpu.name AS unit
		FROM czechia_payroll as cp
		LEFT JOIN czechia_payroll_calculation as cpc 
			ON cp.calculation_code = cpc.code 
		LEFT JOIN czechia_payroll_industry_branch as cpib 
			ON cp.industry_branch_code = cpib.code
		LEFT JOIN czechia_payroll_unit as cpu 
			ON cp.unit_code = cpu.code 
		LEFT JOIN czechia_payroll_value_type as cpvt 
			ON cp.value_type_code = cpvt.code
		GROUP BY cp.payroll_year, cp.calculation_code, cpc.name, cp.industry_branch_code, cpib.name, cpvt.code, cpvt.name, cp.unit_code, cpu.name
			) AS B
	ON A.year = B.payroll_year
WHERE A.region_code IS NULL 
AND B.value_payroll IS NOT NULL
AND B.calculation_code = 200
AND B.industry_branch_code IS NOT NULL
AND B.value_type_code = 5958
;

SELECT *
FROM t_veronika_polachova_project_SQL_primary_final tvppspf 
;

