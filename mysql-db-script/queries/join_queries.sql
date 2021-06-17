-- вывести количество заказов клиента 
SELECT COUNT(*) 
FROM online_store.customer as c 
JOIN online_store.orders as o
ON c.id = o.customer_id;

-- вывести заказы клиента со статусом 'отклонен'
SELECT o.id, os.status_name
FROM online_store.customer as c 
JOIN online_store.orders as o
ON c.id = o.customer_id 
JOIN online_store.order_status as os
ON o.order_status_id = os.id
where c.id = 1 and os.status_name = 'Declined';

-- вывести на экран заказы клиента дороже 20 000
SELECT o.id, ot.id, ot.price, p.name from online_store.orders as o
JOIN online_store.order_item as ot ON  o.id = ot.orders_id
JOIN online_store.product as p ON ot.product_id = p.id
WHERE o.customer_id = 1 and ot.price > 20000; 

-- вывести имя клиента и название продуктов в корзине, цена которого превышает 35000
SELECT c.first_name, p.name from online_store.customer as c 
JOIN online_store.cart as ca ON c.cart_id = ca.id 
JOIN online_store.cart_item as ci ON ca.id = ci.cart_id
JOIN online_store.product as p ON ci.product_id = p.id
where c.id = 1 and p.price > 35000;

-- вывести продукты в корзине в категории 'Бытовая техника' для заданного клиента
SELECT p.name, c.first_name, cat.name from online_store.customer as c 
JOIN  online_store.cart as ca ON c.cart_id = ca.id 
JOIN online_store.cart_item as ci ON c.id = ci.cart_id 
JOIN online_store.product as p ON ci.product_id = p.id 
LEFT OUTER JOIN online_store.product_has_category as pc ON p.id = pc.product_id 
LEFT OUTER JOIN online_store.category as cat ON cat.id = pc.category_id 
where c.id = 1 and cat.name = 'Бытовая техника';

-- вывести сумму продуктов в корзине по категориям у клиента
select SUM(p.price), cat.name from online_store.customer as c
JOIN online_store.cart as ca ON c.cart_id = ca.id
JOIN online_store.cart_item as ci ON ca.id = ci.cart_id
JOIN online_store.product as p ON p.id = ci.product_id
JOIN online_store.product_has_category as pc ON p.id = pc.product_id 
JOIN online_store.category as cat ON cat.id = pc.category_id
where c.id = 1
group by cat.name;
