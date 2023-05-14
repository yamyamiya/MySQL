use hr;
-- Task1 
-- Найти департаменты в которых есть работники, зарабатывающие больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0) 
-- (использовать метод max)
SELECT department_id, MAX(CASE WHEN salary > 10000 THEN 1 ELSE 0 END) as has_high_earners
FROM employees
GROUP BY department_id;


-- Task2
-- Найти департаменты в которых все работники зарабатывают больше 10 000.
--  В результате выборки формируются два поля (department_id и поле со значениями 1 или 0)  
--  (использовать метод min) 
SELECT department_id, MIN(CASE WHEN salary <= 10000 THEN 0 ELSE 1 END) as all_high_earners
FROM employees
GROUP BY department_id
HAVING all_high_earners = 1;


-- Task3  
-- Отсортировать сотрудников по фамилии в алфавитном порядке
SELECT *
FROM employees
ORDER BY last_name; 

-- Task4
-- Отсортировать сотрудников по зарплате - от самой большой зарплаты до самой маленькой
SELECT *
FROM employees
ORDER BY salary DESC;

-- Task5
-- Вывести сотрудников, работающих в департаментах с id 60, 90 и 110, 
-- отсортированными в алфавитном порядке по фамилии (оператор in).
SELECT *
FROM employees
WHERE department_id IN(60,90,110)
ORDER BY last_name;

-- Task6
-- Вывести сотрудников с jobid STCLERK, отсортированными по зарплате - 
-- от самой большой зарплаты до самой маленькой.
SELECT *
FROM employees
WHERE job_id="ST_CLERK"  
ORDER BY salary DESC;

-- Task7
-- Вывести сотрудников, чьи имена начинаются на букву D и отсортировать их в алфавитном порядке по фамилии 
SELECT *
FROM employees
WHERE first_name LIKE 'D%'
ORDER BY last_name;

use airport;

-- Task1
-- Выведите данные о билетах разной ценовой категории. Среди билетов экономкласса (Economy) 
-- добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. 
-- Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 до 30 000 включительно. 
-- Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000. 
-- В решении необходимо использовать оператор CASE.
-- В выборке должны присутствовать три атрибута — id, service_class, price.

SELECT 
id,
service_class,
price
FROM tickets
WHERE service_class IN ('Economy', 'PremiumEconomy', 'Business')
AND CASE
	WHEN service_class = 'Economy' AND price BETWEEN 10000 AND 11000 THEN 1
    WHEN service_class = 'PremiumEconomy' AND price BETWEEN 20000 AND 30000 THEN 1
    WHEN service_class = 'Business' AND price > 100000 THEN 1
    ELSE 0
    END = 1;
    
-- Task2
-- Разделите самолеты на три класса по возрасту. Если самолет произведен раньше 2000 года,
--  то отнесите его к классу 'Old'. Если самолет произведен между 2000 и 2010 годами включительно, 
--  то отнесите его к классу 'Mid'. Более новые самолеты отнесите к классу 'New'. 
--  Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
--  Отсортируйте выборку по классу возраста в порядке возрастания.
-- В выборке должны присутствовать два атрибута — side_number, age.  

SELECT
side_number,
CASE WHEN production_year<2000
		THEN 'Old'
    WHEN production_year BETWEEN 2000 AND 2010
		THEN 'Mid'
    ELSE 'New'
    END AS age
FROM airliners 
ORDER BY production_year DESC;

-- Task3
-- Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G.
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%,
-- а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, tripid, newprice. 
SELECT 
id,
trip_id,
CASE 
	WHEN service_class='Economy' 
		THEN price-price*0.15
	WHEN service_class='Business' 
		THEN price-price*0.10
	WHEN service_class='PremiumEconomy' 
		THEN price-price*0.20
END AS new_price
FROM tickets 
WHERE trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');

-- Task4
-- Создайте таблицу goods (id, title, quantity) 
DROP TABLE IF EXISTS goods;
CREATE TABLE goods(
	id VARCHAR(128),
	title VARCHAR(128),
	quantity INTEGER
);

-- Task5
-- Добавьте данные
-- 3*. Добавьте поле price (integer) со значением по умолчанию 0 (надо покопатся))
CREATE TABLE tmp_table AS
SELECT 
id,
trip_id,
CASE 
	WHEN service_class='Economy' 
		THEN price-price*0.15
	WHEN service_class='Business' 
		THEN price-price*0.10
	WHEN service_class='PremiumEconomy' 
		THEN price-price*0.20
END AS new_price
FROM tickets 
WHERE trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');

SELECT * FROM tmp_table;

INSERT INTO goods(id, title, quantity)
	SELECT 
    id, 
    trip_id, 
    new_price
FROM tmp_table;

ALTER TABLE goods
ADD COLUMN price INTEGER DEFAULT 0;


-- Task6
-- Проверьте содержимое таблицы.
SELECT * FROM goods;

-- Task7
-- Сделайте удаление, изменение, добавление полей в таблице
ALTER TABLE goods
DROP COLUMN price;

SET SQL_SAFE_UPDATES = 0;
UPDATE goods
SET title = 'new_trip'
WHERE title LIKE "0SE4S0HRRU";

ALTER TABLE goods
ADD COLUMN price_without_discount integer;

-- Task8
-- Удалите таблицу 
TRUNCATE TABLE goods;

-- Task9
-- Заново создайте, добавьте данные и на ее основе создайте новую таблицу 
DROP TABLE IF EXISTS goods;
CREATE TABLE goods(
	id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	title VARCHAR(128),
	quantity INTEGER
);

INSERT INTO goods(title, quantity) VALUES
	('AAA', 45),
    ('BBB', 15),
    ('CCC', 35),
    ('DDD', 25);
    
SELECT * FROM goods;

CREATE TABLE new_goods
	SELECT*
    FROM goods;
    
SELECT * FROM new_goods;
    
    

    
    



