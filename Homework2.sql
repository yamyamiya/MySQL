-- TASK 1

USE hr;
-- 1) Вывести зарплату сотрудника с именем ‘Lex’ и фамилией ‘De Haan'.
SELECT 
	employee_id,
    first_name, 
    last_name,
    salary
FROM employees 
WHERE first_name LIKE 'Lex' 
AND last_name LIKE 'De Haan';

-- 2) Вывести всех сотрудников с jobid ‘FIACCOUNT’ и зарабатывающих меньше 8000.
SELECT *
FROM employees
WHERE job_id LIKE 'FI_ACCOUNT' 
AND salary<8000;

-- 3) Вывести сотрудников, у которых в фамилии в середине слова встречаются сочетания ‘kk’ или ‘ll’.
SELECT *
FROM employees
WHERE last_name LIKE '%kk%' OR last_name LIKE '%ll%';

-- 4) Вывести сотрудников с commission_pct NULL. 
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 5) Вывести всех сотрудников кроме тех, кто работает в департаментах 80 и 110.
SELECT *
FROM employees 
WHERE department_id != 80
AND department_id != 110;

-- 6) Вывести сотрудников зарабатывающих от 5000 до 7000 (включая концы). 
SELECT *
FROM employees 
WHERE salary BETWEEN 5000 AND 7000;



-- TASK 2 

USE airport;
SELECT 
DISTINCT
	model_name,
    CASE
 		WHEN range_value BETWEEN 1000 AND 2500
 			THEN 'short-haul'
 		WHEN range_value BETWEEN 2500 AND 6000
 			THEN 'medium-haul'
 		ELSE 'long-haul'
	END AS category
FROM airliners;

SELECT 
DISTINCT
	model_name,
    CASE
		WHEN range_value <=1000 OR range_value IS NULL
			THEN 'UNDEFINED'
 		WHEN range_value BETWEEN 1000 AND 2500
 			THEN 'short-haul'
 		WHEN range_value BETWEEN 2500 AND 6000
 			THEN 'medium-haul'
 		ELSE 'long-haul'
	END AS category
FROM airliners



    