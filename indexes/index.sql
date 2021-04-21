-- 1.1  Создание индекса 

-- Заполнили таблицу тестовыми данными
insert into booking_schema.room_price (price, info_date, is_available, room_id)
select random() * 10000 + 1, NOW() + (random() * (NOW()+'-2 days' - NOW())) + '-2 days', random() < 0.01, 1
from generate_series(1, 10000);  

-- Создаем индекс 
create index date_idx ON booking_schema.room_price(info_date);

-- Анализ запроса
-- запрос "Вывести цены на номера в определенный период времени"
explain select rp.room_id, SUM(rp.price) / (DATE_PART('day', '20.05.2021'::date) - DATE_PART('day', '14.05.2021'::date))
from booking_schema.room as r
inner join booking_schema.room_price as rp ON
r.room_id = rp.room_id
where rp.info_date between '14.05.2021' and '20.05.2021'
group by rp.room_id;


-- 1.2  Создание индекса 

-- Заполнили таблицу тестовыми данными
insert into booking_schema.booking (booking_status, start_date, end_date, customer_id, room_id, payment_id)
select 'CONFIRMED', NOW() + (random() * (NOW()+'-10 days' - NOW())) + '-10 days', NOW() + (random() * (NOW()+'-2 days' - NOW())) + '-2 days', 1, 1, 202
from generate_series (1, 10000);

-- Создаем индекс 
create index start_date_rande_idx ON booking_schema.booking(start_date, end_date);
create index end_date_rande_idx ON booking_schema.booking(end_date);

-- Вывести доступные номера в заданный период времени 
explain select * from booking_schema.room r where r.room_id  not in 
(
	select b.room_id from booking_schema.booking b inner join booking_schema.room r on b.room_id = r.room_id 
	where (b.start_date <= '19.02.2022' and b.end_date >= '19.02.2022') 
	OR (b.start_date < '27.02.2022' and b.end_date >= '27.02.2022')
	OR ('19.02.2022' <= b.start_date and '27.02.2022' >= b.start_date)
)

-- Проблемы, с которыми столкнулся
--Изначально создал составной индекс на start_date, end_date. Запрос оказался очень медленным. Выбрал вариант с отдельными индексами на каждое поле.



-- 2 Полнотекстовый поиск (index gin)

-- Заполнили таблицу тестовыми данными
insert into booking_schema.room (room_floor, room_number, room_type_id, apartment_id, description) 
 values ('2', '234', 1, 1, 'Can a sheet slitter slit sheets?'), 
  ('10', '23', 1, 1, 'How many sheets could a sheet slitter slit?'),
  ('11', '67', 1, 1, 'I slit a sheet, a sheet I slit.'),
  ('54', '87', 1, 1, 'Upon a slitted sheet I sit.'), 
  ('224', '98', 1, 1, 'Whoever slit the sheets is a good sheet slitter.'), 
  ('1', '23', 1, 1, 'I am a sheet slitter.'),
  ('7', '65', 1, 1, 'I slit sheets.'),
  ('6', '76', 1, 1, 'I am the sleekest sheet slitter that ever slit sheets.'),
  ('9', '28', 1, 1, 'She slits the sheet she sits on.');

-- Создаем  индекс
create index room_desc_idx on booking_schema.room using gin(description_tsv);

update booking_schema.room set description_tsv = to_tsvector(description);

-- Анализ запроса
-- Вывести идентификаторы номеров, в описании которых встречается указанное слово
explain select r.room_id from booking_schema.room r where r.description_tsv @@ to_tsquery('slit*');



-- 3 Составной индекс на 2 поля

-- Заполнили таблицу тестовыми данными
insert into booking_schema.address (region, city, street, street_type, house, post_index) 
select 'Центральный федеральный округ', random_text_simple(10), random_text_simple(10), 1, random_text_simple(5), '666666'
from generate_series (1, 100000);

insert into booking_schema.address (region, city, street, street_type, house, post_index) 
values ('Центральный федеральный округ', 'Москва', 'Ленина',1,'123 В','399999'),
 ('Северо-Западный федеральный округ', 'Мурманск', 'Есенина',2,'321 А','177777'),
 ('Южный федеральный округ', 'Сочи', 'Белые пески',2,'13','345643'),
 ('Южный федеральный округ', 'Анапа', 'Перхоровичв',2,'16\2','123435');

-- Создаем Составной индекс
create index address_idx on booking_schema.address (street, city)
analyse booking_schema.address;

-- Анализ запроса
-- Вывести номера домов на заданной улице и городе. 
explain select a.house from booking_schema.address a
where a.street = ' Переверткина' and a.city = ' Сочи';



-- 4 Индекс на функцию
/*
Изначально задумал сделать свою функцию, использовать ее в where и сделать на нее индекс.
Первый вариант был функция, которая возвращает идентификаторы комнат 
*/

create or replace function booked_rooms_in_hotel(appart_id bigint) 
returns setof int as
$$ 
begin 
select * from booking_schema.booking b
INNER JOIN booking_schema.room r
ON b.room_id = r.room_id AND 
r.apartment_id = appart_id;
end
$$ language plpgsql;

-- Использовать не получилось, так как в where невозможно указать IN call function()
-- Соответственно индекс на функцию создавать не стал

/*
Столкнулся с тем, что многие пишут о нецелесообразности использования функции в where, так как postgres использует index scan,
а мог бы работать оптимальнее, index seek

В итоге ушел от этой идеи и решил сделать функцию, которую буду использовать в select и создать на нее индекс. Но и здесь возникли проблемы...

*/ 

-- Функция  (immmutable просит сделать при создании индекс на эту функцию)

create or replace function count_room_price(price numeric, end_date date, start_date date)
returns numeric as
$$
declare avg_sum numeric;
begin
select price / (DATE_PART('day', end_date::date) - DATE_PART('day', start_date::date)) into avg_sum;
return avg_sum;
end
$$
language 'plpgsql'
IMMUTABLE;


-- Создание индекса на функцию 
create index count_room_price_idx on booking_schema.room_price(count_room_price(price, info_date, info_date));
-- Проблемы
-- какие поля указывать в параметрах end_date, start_date (при создании индекса) не разобрался 


-- Работающий вариант
-- Сделал проще вариант с функцией lower, дабы отработать этот момент

-- Заполнили таблицу тестовыми данными
insert into booking_schema.apartment (name, contacts, apartment_type_id, address_id) 
select  random_text_simple(16), random_text_simple(50), 1, 101
from generate_series(1, 10000);

-- Создание индекса на функцию 
create index apartment_lower_idx on booking_schema.apartment(lower(name));
analyse booking_schema.apartment;

-- Анализ запроса
-- Вывести идентификатор апартаментов, в котором имя в нижнем регистре равно 'лазурный берег'
explain select a.apartment_id from booking_schema.apartment a where lower(a.name) = 'лазурный берег';