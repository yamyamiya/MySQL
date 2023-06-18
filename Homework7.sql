CREATE DATABASE homework7;
USE homework7;

-- 1) вывести название продукта, который чаще всего встречается в заказах 
SELECT
	title
FROM products
WHERE id=(
	SELECT 
		productid
	FROM orders
    GROUP BY productid
    HAVING COUNT(*) = (
			SELECT 
				MAX(count) AS max
			FROM(
				SELECT COUNT(*) AS count,
					productid
				FROM orders
				GROUP BY productid
				)t1
	)
);

-- 2) вывести название продукта, который покупают чаще всего (нужно посчетать общее количество купленных единиц)
SELECT 
	title
FROM products
WHERE id=(
	SELECT 
		productid
	FROM orders
    GROUP BY productid
    HAVING SUM(productcount) = (
		SELECT 
			MAX(sum) AS max
        FROM(
			SELECT SUM(productcount) AS sum,
				productid
			FROM orders
			GROUP BY productid
			)t1
	)
);

-- 3) вывести общую выручку магазина. Сумма всех купленных единиц товара.
SELECT 
	SUM(t1.price*t2.productcount) AS total_money
FROM products t1
INNER JOIN orders t2
ON t1.id = t2.productid;

-- 4) определить сумму выручки за онлайн продажи (online) и за продажи в магазине (direct) 
SELECT 
	SUM(t1.price*t2.productcount) AS total_money
FROM products t1
INNER JOIN orders t2
ON t1.id = t2.productid
GROUP BY t2.ordertype;
 



    
    

