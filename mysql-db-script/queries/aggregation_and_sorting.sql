-- Вывести id, name и скидку для каждого продукта в зависимости от цены
select id, name, price,
case 
	when price > 20000 then '10%'
    when price > 10000 then '15%'
    else '20%'
 end PriceDiscount
 from online_store.product;  
 
 
 -- Вывести продукты из корзины со скидкой, в зависимости от возраста
 -- пробовал datediff(YY,c.birth_date,getdate()), но получаю ошибку
-- Incorrect parameter count in the call to native function 'datediff'	0.000 sec
 select p.id, p.name, p.price,
 case 
	when year(now()) - year(c.birth_date) < 20 then '10%'
    when year(now()) - year(c.birth_date) < 30 then '20%'
    else '30%'
end PriceDiscount
from online_store.product as p JOIN
online_store.cart_item as ci ON 
p.id = ci.product_id JOIN
online_store.cart as ca ON
ci.cart_id = ca.id JOIN
online_store.customer as c ON 
ca.id = c.cart_id;

-- Вывести самый дорогой товар в каждоый категории
select c.name, MAX(p.price) from online_store.product p LEFT JOIN
 online_store.product_has_category pc ON
 p.id = pc.product_id LEFT JOIN
 online_store.category c ON
 pc.category_id = c.id
 group by c.name;
 
 -- Вывести самый дешевй товар в каждой категорииalter
 select c.name, MIN(p.price) from online_store.product p JOIN
 online_store.product_has_category pc ON
 p.id = pc.product_id JOIN
 online_store.category c ON
 pc.category_id = c.id
 group by c.name;


 -- Вывести всех клиентов, у которых сумма продуктов в корзине превышает 50 000 рублей
select c.first_name, SUM(ci.price)  from online_store.customer c JOIN   
online_store.cart ca ON   c.cart_id = ca.id JOIN   
online_store.cart_item ci ON   
ca.id = ci.cart_id   
group by c.first_name   
having SUM(ci.price) > 50000;

 -- Вывести всех клиентов, у которых количество заказанных товаров больше 5
 select c.id, COUNT(oi.id) from online_store.customer c JOIN  
 online_store.orders o ON    
 c.id = o.customer_id JOIN    
 online_store.order_item oi ON   
 o.id = oi.orders_id    
 group by c.id 
 having COUNT(oi.id) > 5;

 -- Вывести сумму заказа пользователей по категориям и общую стоимость заказов
 select c.id, 
		cat.name, 
        SUM(oi.price),
        grouping(cat.name)
        from online_store.customer c JOIN
 online_store.orders o ON
 c.id = o.customer_id JOIN
 online_store.order_item oi ON
 o.id = oi.orders_id JOIN
 online_store.product p ON
 oi.product_id = p.id JOIN
 online_store.product_has_category pc ON
 p.id = pc.product_id JOIN
 online_store.category cat ON
 cat.id = pc.category_id
group by c.id, cat.name
with rollup;