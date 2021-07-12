-- создаем полнотекстовый индекс
CREATE FULLTEXT INDEX  TITLE_DESC_INDEX
ON online_store.product(title, description);

-- индекс используется 
EXPLAIN SELECT p.id, p.name FROM online_store.product p
WHERE MATCH(title, description) AGAINST ('Acer');

-- индекс не используется 
EXPLAIN select p.id, p.name from online_store.product p 
where title LIKE '%ACER%'  and description LIKE '%1920x1080%';

-- Проанализировал существующие запросы к бд
-- Решил добавить индексы на цену и категорию продукта
CREATE INDEX PRICE_INDEX
ON online_store.product(price);

-- вывести имя клиента и название продуктов в корзине, цена которого превышает 35000
EXPLAIN SELECT c.first_name, p.name from online_store.customer as c 
JOIN online_store.cart as ca ON c.cart_id = ca.id 
JOIN online_store.cart_item as ci ON ca.id = ci.cart_id
JOIN online_store.product as p ON ci.product_id = p.id
where c.id = 1 and p.price > 35000;

-- индекс на категорию продукта
CREATE INDEX CATEGORY_INDEX 
ON online_store.category(name);

-- вывести продукты в корзине в категории 'Бытовая техника' для заданного клиента
EXPLAIN SELECT p.name, c.first_name, cat.name from online_store.customer as c 
JOIN  online_store.cart as ca ON c.cart_id = ca.id 
JOIN online_store.cart_item as ci ON c.id = ci.cart_id 
JOIN online_store.product as p ON ci.product_id = p.id 
LEFT OUTER JOIN online_store.product_has_category as pc ON p.id = pc.product_id 
LEFT OUTER JOIN online_store.category as cat ON cat.id = pc.category_id 
where c.id = 1 and cat.name = 'Бытовая техника';