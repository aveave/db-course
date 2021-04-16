-- insert test data for customer table
insert into booking_schema.customer (firstname, middlename, lastname, gender, birth_date, customer_type, address_id)
values ('Анатолий', 'Евгеньевич', 'Быстров', 1, '16.07.1983', 'GUEST', 1),
 ('Петр', 'Васильевич', 'Черданцев', 1, '6.11.1977', 'CUSTOMER', 2),
 ('Георгий', 'Алексеевич', 'Акинфеев', 1, '13.02.1980', 'CUSTOMER', 2);

-- insert test data for address table
insert into booking_schema.address (region, city, street, street_type, house, post_index) 
values ('Центральный федеральный округ', 'Москва', 'Ленина',1,'123 В','399999'),
 ('Северо-Западный федеральный округ', 'Мурманск', 'Есенина',2,'321 А','177777'),
 ('Южный федеральный округ', 'Сочи', 'Белые пески',2,'13','345643'),
 ('Южный федеральный округ', 'Анапа', 'Перхоровичв',2,'16\2','123435');

-- insert test data for room table
insert into booking_schema.room (room_floor, room_number, room_type_id, apartment_id)
values ('2', '234', 1, 1), ('10', '122', 1, 2);

-- insert test data for room_type table
insert into booking_schema.room_type (room_type_name) 
values ('номер') , ('спальное место'), ('комната');

-- insert test data for apartment table
insert into booking_schema.apartment (name, contacts, apartment_type_id, address_id) 
values ('Лазурный берег', '+7 900 800 30 30', 1, 3), 
('Времена года', '+7 435 765 12 21', 2, 4)
('REsport and SPAа', '+7 435 765 12 21', 2, 4),
('dsfdsfResort dsfdsfds', '+7 435 765 12 21', 2, 4),
('dsfdsfResortdsfdsfds', '+7 435 765 12 21', 2, 4),
('dsfdsf resOrt dsfdsfds', '+7 435 765 12 21', 2, 4);

-- insert test data for apartment_type table
insert into booking_schema.apartment_type (apartment_type)
values ('Отель'), ('Хостел'), ('Гостиница'), ('Санаторий'), ('Апартаменты')

-- insert test data for booking table
insert into booking_schema.booking (booking_status, start_date, end_date, customer_id, room_id, payment_id)
values ('TENTATIVE', '24.05.2021', '28.05.2021', 2, 2, 201),
('CONFIRMED', '24.05.2021', '30.05.2021', 3, 1, 214),
('TENTATIVE', '18.09.2021', '28.09.2021', 4, 2, 267),
('CONFIRMED', '13.06.2021', '18.07.2021', 1, 1, 257),
('CONFIRMED', '2.08.2021', '28.08.2021', 2, 2, 268),
('WAITLIST', '24.04.2021', '28.04.2021', 3, 1, null),
('TENTATIVE', '15.06.2021', '28.08.2021', 2, 1, 288),
('TENTATIVE', '24.03.2021', '28.03.2021', 2, 2, 292)
returning booking_id;

-- insert generated test data for payment table
insert into booking_schema.payment (cost, card_number, payment_method, bank)
select  random() * 100000 + 1, random_text_simple(16), random_text_simple(10), random_text_simple(40)
from generate_series(1, 100)
returning payment_id, cost;

-- insert test data for room_facility table
insert into booking_schema.room_facility (room_id, facility_id)
values (1, 21);

-- insert test data for room_price table
insert into booking_schema.room_price (price, info_date, is_available, room_id)
values (random() * 100000 + 1, '14.05.2021', true, 1),
(random() * 100000 + 1, '15.05.2021', true, 1),
(random() * 100000 + 1, '16.05.2021', true, 1),
(random() * 100000 + 1, '17.05.2021', true, 1),
(random() * 100000 + 1, '18.05.2021', true, 1),
(random() * 100000 + 1, '19.05.2021', true, 1),
(random() * 100000 + 1, '20.05.2021', true, 1),
(random() * 100000 + 1, '14.05.2021', true, 2),
(random() * 100000 + 1, '15.05.2021', true, 2),
(random() * 100000 + 1, '16.05.2021', true, 2),
(random() * 100000 + 1, '17.05.2021', true, 2),
(random() * 100000 + 1, '18.05.2021', true, 2),
(random() * 100000 + 1, '19.05.2021', true, 2),
(random() * 100000 + 1, '20.05.2021', true, 2);
