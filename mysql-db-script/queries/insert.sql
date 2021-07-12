
insert into online_store.cart (sum, count) values (1000, 10)

insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Jens', 'Barz', '2021-5-13', 1, '6068643972', 'jbarz0@bizjournals.com', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Tobit', 'Knotton', '2020-6-10', 2, '4002079902', 'tknotton1@huffingtonpost.com', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Bekki', 'Dowbekin', '2020-8-31', 2, '0668047593', 'bdowbekin2@theatlantic.com', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Gabrila', 'Ilyasov', '2020-2-9', 1, '9053033130', 'gilyasov3@cmu.edu', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Reiko', 'Rubinowitsch', '2021-5-23', 2, '8459151840', 'rrubinowitsch4@jalbum.net', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Birk', 'Flavelle', '2020-3-7', 1, '3429781175', 'bflavelle5@g.co', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Fritz', 'Manford', '2021-4-20', 1, '0103929215', 'fmanford6@oakley.com', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Casper', 'Hartfleet', '2021-2-9', 2, '9636735336', 'chartfleet7@wsj.com', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Claire', 'Colquhoun', '2021-5-20', 1, '8188523798', 'ccolquhoun8@google.cn', 1, 1);
insert into online_store.customer (first_name, last_name, birth_date, gender, mobile_number, email, address_id, cart_id) values ('Brandtr', 'Byrom', '2021-1-7', 1, '4663437400', 'bbyrom9@virginia.edu', 1, 1);

​
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Atlanta', 'Independence', 1, '149', '31106');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Decatur', 'Thompson', 2, '51', '30089');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Columbus', 'Katie', 3, '66', '31914');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Atlanta', 'Dovetail', 1, '019', '31165');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Decatur', 'Gerald', 2, '10', '30089');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Savannah', 'Bowman', 2, '0', '31422');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Duluth', 'Erie', 1, '64', '30096');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Cumming', 'Calypso', 2, '81', '30130');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Atlanta', 'Ronald Regan', 3, '6', '30343');
insert into online_store.address (region, city, street, street_type, house_number, post_index) values ('Georgia', 'Savannah', 'Coleman', 1, '76285', '31422');

INSERT INTO online_store.orders (count,order_date,delivery_date,order_status_id,delivery_method_id,customer_id) VALUES (90,"2021-07-24","2020-07-06",1,1,3),(89,"2022-02-04","2020-10-29",1,2,4),(68,"2021-02-26","2020-11-28",1,1,4),(23,"2021-02-12","2021-01-02",2,1,4),(27,"2020-11-25","2021-08-08",1,2,7),(83,"2021-11-26","2020-07-26",1,2,6),(63,"2021-10-11","2021-01-11",1,1,8),(84,"2020-08-10","2021-08-14",2,1,2),(57,"2021-03-27","2021-03-20",1,2,3),(74,"2020-08-19","2021-01-28",2,1,5);
INSERT INTO online_store.orders (count,order_date,delivery_date,order_status_id,delivery_method_id,customer_id) VALUES (90,"2021-02-15","2020-12-06",1,1,1),(27,"2020-07-02","2021-03-09",1,2,7),(80,"2021-09-09","2021-08-14",1,2,7),(24,"2022-03-11","2022-01-18",1,2,10),(96,"2022-05-26","2021-03-19",1,2,5),(54,"2020-06-16","2020-06-27",1,2,2),(6,"2020-11-16","2021-07-09",1,1,4),(70,"2020-09-10","2022-04-08",1,2,9),(74,"2021-04-10","2021-09-16",1,1,4),(21,"2020-11-25","2020-11-10",2,2,8);
INSERT INTO online_store.orders (count,order_date,delivery_date,order_status_id,delivery_method_id,customer_id) VALUES (30,"2021-08-27","2021-09-13",1,2,1),(97,"2021-11-06","2022-01-19",1,1,3),(41,"2021-02-18","2021-05-20",1,1,3),(7,"2022-02-14","2020-09-04",1,1,1),(10,"2020-10-21","2021-02-16",1,2,4),(61,"2021-12-05","2022-05-09",2,2,6),(48,"2021-05-26","2021-11-15",2,1,2),(92,"2020-11-28","2021-08-15",2,1,9),(100,"2021-11-27","2021-03-02",2,2,7),(76,"2021-01-26","2021-12-21",2,2,9);
INSERT INTO online_store.orders (count,order_date,delivery_date,order_status_id,delivery_method_id,customer_id) VALUES (57,"2022-01-09","2020-10-11",2,2,7),(88,"2020-12-23","2021-03-31",1,2,9),(44,"2020-12-13","2020-11-09",2,2,5),(54,"2020-12-28","2020-07-29",1,1,4),(12,"2022-01-10","2022-03-07",1,1,2),(29,"2021-06-24","2022-05-23",2,2,10),(8,"2022-01-12","2021-05-16",1,1,6),(56,"2020-09-05","2021-11-13",2,2,8),(63,"2021-07-25","2020-06-21",2,2,7),(63,"2021-03-08","2022-05-15",1,2,1);
INSERT INTO online_store.orders (count,order_date,delivery_date,order_status_id,delivery_method_id,customer_id) VALUES (12,"2021-04-23","2020-07-15",2,1,10),(21,"2020-10-07","2021-10-03",1,1,8),(86,"2021-12-14","2021-02-11",1,1,3),(46,"2021-06-29","2021-05-04",2,2,5),(8,"2021-09-21","2022-04-19",2,2,7),(21,"2022-04-11","2022-02-05",2,1,5),(82,"2022-02-16","2021-11-06",2,1,3),(63,"2020-09-27","2022-06-16",2,1,6),(61,"2021-12-11","2021-06-02",2,1,8),(82,"2021-01-28","2021-07-07",2,2,10);


INSERT INTO online_store.order_status (status_name) VALUES ('Shipped'), ('Pending'), ('Cancelled'), ('Completed'), ('Declined');
INSERT INTO online_store.delivery_method (name) VALUES ('pickup'), ('delivery');


INSERT INTO online_store.order_item (quantity,price,orders_id,product_id) VALUES (42,714360,33,3),(43,129882,34,4),(91,558473,50,4),(50,618515,21,6),(50,106834,44,6),(82,577755,49,1),(12,579440,25,4),(42,124887,28,6),(72,697492,35,6),(16,802825,49,5);
INSERT INTO online_store.order_item (quantity,price,orders_id,product_id) VALUES (96,169430,47,1),(13,623720,26,1),(61,138464,34,1),(29,938783,30,3),(86,901998,24,5),(98,504000,23,1),(69,31839,27,3),(60,271954,36,3),(9,257893,23,4),(32,341784,50,5);
INSERT INTO online_store.order_item (quantity,price,orders_id,product_id) VALUES (63,12796,27,5),(30,940564,40,3),(46,881454,40,1),(35,220679,34,1),(13,634265,50,5),(89,582920,27,3),(28,282833,48,5),(26,675364,48,4),(99,126245,36,6),(75,11091,39,5);
INSERT INTO online_store.order_item (quantity,price,orders_id,product_id) VALUES (100,846339,35,2),(9,734111,30,4),(5,415807,44,2),(14,462921,36,3),(44,215167,22,3),(65,68569,21,3),(75,936726,50,6),(9,713687,39,4),(81,216197,26,3),(66,70938,40,6);


--cart
INSERT INTO online_store.cart (sum, count) VALUES (1234534, 10), (54534, 3), (98743, 2);

--cart-item
INSERT INTO online_store.cart_item (quantity,price,cart_id,product_id) VALUES (1, 35000, 1, 1), (4, 150000, 1, 3), (2, 50000, 1, 2), (5, 50000, 2, 5), (2, 10000, 2, 4);

-- product
INSERT INTO online_store.product (name, price, weight, quantity, characteristics, title, description) 
VALUES ('Ноутбук Asus T570', 35000, 3, 10, '{}',
	'Ноутбук ASUS TUF Gaming A15 FX506QM-HN050 (AMD Ryzen 7 5800H/15.6"/1920x1080/16GB/512GB SSD/NVIDIA GeForce RTX 3060 6GB/Без ОС) 90NR0606-M01110, серый', 'Коротко о товаре
игровой ноутбук
экран: 15.6" (1920x1080)
матрица: IPS, 144 Гц
процессор: AMD Ryzen 7 5800H (8x3200 МГц)
оперативная память: 16 ГБ DDR4 3200 МГц
накопитель: SSD 512 ГБ
дискретная видеокарта: NVIDIA GeForce RTX 3060 (6 ГБ)
разъемы: USB 2.0 Type A, USB 3.0 Type-С, USB 3.1 Type A x 2, выход HDMI, микрофон/наушники Combo, Ethernet - RJ-45
беспроводная связь: Wi-Fi 802.11ax, Bluetooth 5.1
емкость аккумулятора: 90 Вт⋅ч
операционная система: Без ОС
pазмеры: 256x359x24 мм
вес: 2.3 кг'),
('Ноутбук Acer F20', 30000, 2, 10, '{}','Ноутбук ACER ASPIRE A315-42G-R9EB 15.6\"/RYZEN 3-3200U(2.6ГГЦ)/4ГБ/128GB SSD/RV 3 G/WIN10 ЧЕР(NX.HF8ER.02C)', 'Производитель:Acer
Тип:ноутбук
Размер экрана:15"-15.9"
Разрешение экрана:1920x1080
Сенсорный экран:нет
Линейка процессора:AMD Ryzen 3
Бренд:ACER, Диагональ Экрана:15,6", Разрешение Экрана, Пикс:1920x1080, Процессор:AMD Ryzen 3 3200U'),
('Костюм детский', 2400, 0.5, 3, '{}',
	'Карнавальный костюм для детей Вестифика Костюм на 9 мая матрос с воротником детский',
	'Костюмы и военная форма на 9 мая. Прошли те времена, когда все мальчики мечтали стать матросами. Но и теперь можно найти тех, для кого примерить на себя костюм матроса – настоящая гордость. Этот детский костюм'),
('Lego конструктор', 2000, 0.8, 5, '{}','Конструктор LEGO Classic 10698 Большая коробка творческих кирпичиков',
'Коротко о товаре
тип: классический
материал: пластик
возраст: от 4 лет
количество элементов: 790 шт.
развитие навыков: логика и мышление, моторика и ловкость
в комплекте: контейнер для хранения'),
('Чехол Samsung s6', 400, 0.1, 134, '{}','Водонепроницаемый чехол для телефона со шнурком / универсальный / зеленый / основное отделение 180х100мм', 
	'Описание
Водонепроницаемый чехол для телефонов – аксессуар, созданный для эксплуатации мобильного устройства в экстремальных и походных условиях. Полностью герметичный пак не пропускает воду, грязь и пыль.');


--category
INSERT into online_store.CATEGORY (name) values 
('Автотовары'),
('Аксессуары'),
('Аудио-видео техника'),
('Бутик-косметика'),
('Бытовая техника'),
('Бытовая химия'),
('Галантерея'),
('Гигиена'),
('Детская одежда'),
('Женская одежда'),
('Игрушки');