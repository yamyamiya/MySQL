create database homework7;
use homework7;

-- 1) вывести название продукта, который чаще всего встречается в заказах 
select 
	title
from products
where id=(
select 
		productid
	from orders
    group by productid
    having count(*) = (
select 
		max(count) as max
        from(
select count(*) AS count,
productid
from orders
group by productid
Order by productid
)t1
)
);

-- 2) вывести название продукта, который покупают чаще всего (нужно посчетать общее количество купленных единиц)
select 
	title
from products
where id=(
select 
		productid
	from orders
    group by productid
    having sum(productcount) = (
select 
		max(sum) as max
        from(
select sum(productcount) AS sum,
productid
from orders
group by productid
Order by productid
)t1
)
);

-- 3) вывести общую выручку магазина. Сумма всех купленных единиц товара.
select 
sum(t1.price*t2.productcount) as total_money
from products t1
inner join orders t2
on t1.id = t2.productid;

-- 4) определить сумму выручки за онлайн продажи (online) и за продажи в магазине (direct) 
select 
sum(t1.price*t2.productcount) as total_money
from products t1
inner join orders t2
on t1.id = t2.productid
group by t2.ordertype;
 



    
    

