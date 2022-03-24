-- create user client
create USER 'CLIENT' identified by 'password';

-- create user manager
create USER 'MANAGER' identified by 'password';

-- процедура выборки товаров по цене, категории, производителю. 
-- Сортирует по входному параметру 1 - по имени, 2 - по цене
DELIMITER //
create procedure getProducts(IN category VARCHAR(255), 
IN minPrice DECIMAL(13, 2), 
IN maxPrice DECIMAL(13, 2), 
IN producer VARCHAR(255), 
IN sortColNum INT) 
BEGIN
	select p.id, p.name, p.price, p.weight, p.title, p.description
    from online_store.product p
    JOIN online_store.product_has_category pc
    ON p.id = pc.product_id
    JOIN online_store.category c
    ON c.id = pc.category_id
    WHERE c.name = category AND
    p.price between minPrice AND maxPrice AND
    MATCH(title, description) AGAINST (producer)
    ORDER BY (case sortColNum
				when 1 then p.name
                when 2 then p.price
              end);
END //

DELIMITER ;

-- вызов процедуры
call getProducts('Аудио-видео техника', 0, 35000, 'Acer', 2)

--Предоставление прав вызова процедуры 'getProducts' для клиента
GRANT EXECUTE ON PROCEDURE getProducts TO CLIENT;


-- Процедура для отчета по продажам за определенный период времени
-- Количество товаров, купленное за время. Группировка по дате или категории товара
DELIMITER //
create procedure getOrders(IN dateFrom DATE, IN sortColNum INT) 
BEGIN 
	select SUM(p.price), 
    COUNT(oi.id), 
    case sortColNum
		when 1 then o.order_date 
        when 2 then c.name
    end as groupResult
    from online_store.orders o
    JOIN online_store.order_item oi ON
    o.id = oi.orders_id
    JOIN online_store.product p ON
    p.id = oi.product_id 
    JOIN online_store.product_has_category pc ON
    p.id = pc.product_id
    JOIN online_store.category c ON
    c.id = pc.category_id
    WHERE o.order_date BETWEEN dateFrom AND NOW()
    GROUP BY groupResult;
    
END //

DELIMITER ;

-- отчет по продажам по дате
call getOrders('2021-02-16', 1);

-- отчет по продажам по категориям
call getOrders('2021-02-16', 2);

-- Предоставление прав вызова процедуры 'getOrders' для менеджера
GRANT EXECUTE ON PROCEDURE getOrders TO MANAGER;