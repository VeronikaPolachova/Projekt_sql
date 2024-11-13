-- PROJECT SQL --

-- tvorim tabulku 1

-- JOIN payroll, payroll_calculation, payroll_industry_branch, payroll_unit, payroll_value_type
SELECT 
	cp.payroll_year, 
	cp.payroll_quarter, 
	cp.calculation_code, 
	cpc.name AS calculation_code_name,
	cp.industry_branch_code, 
	cpib.name AS industry_branch_name,
	cpvt.code AS value_type_code,
	cpvt.name AS value_type,
	cp.value AS value_payroll,
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
;






	

