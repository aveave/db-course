# Booking data base design

Система для бронирования жилья 

## Таблицы

#### 1 Table CUSTOMER

Таблица содержит информацию о заказчике услуг booking системы.

Column  | Type
------------- | -------------
CUSTOMER_ID   | SERIAL
FIRSTNAME  	  | VARCHAR(255)
MIDDLENAME    | VARCHAR(255)
LASTNAME      | VARCHAR(255)
GENDER        | INTEGER
BIRTH_DATE    | DATE
CUSTOMER_TYPE | VARCHAR(50)
ADDRESS_ID    | BIGINT

Relationships:

Связь с таблицей ADDRESS foreign key ADDRESS_ID

Связь с таблицей BOOKING через промежуточную таблицу CUSTOMER_BOOKING

#### 2 Table BOOKING 

Таблица содержит информацию о брони, совершенной заказчиком.

Column  | Type
------------- | -------------
BOOKING_ID | SERIAL
BOOKING_STATUS  | VARCHAR(30)
START_DATE     | TIMESTAMP WITH TIME ZONE
END_DATE | TIMESTAMP WITH TIME ZONE
CUSTOMER_ID | BIGINT
ROOM_ID | BIGINT
PAYMENT_ID | BIGINT

Relationships:

Связь с таблицей CUSTOMER через промежуточную таблицу CUSTOMER_BOOKING

Связь с таблицей ROOM foreign key ROOM_ID

Связь с таблицей PAYMENT foreign key PAYMENT_ID

#### 3 Table CUSTOMER_BOOKING

Промежуточная таблица для связи между таблицами CUSTOMER и BOOKING

Column  | Type
------------- | -------------
CUSTOMER_ID  | BIGINT
BOOKING_ID  | BIGINT


#### 4 Table ADDRESS 

Таблица содержит информацию об адресе клиентов

Column  | Type
------------- | -------------
ADDRESS_ID | SERIAL
REGION  | VARCHAR(50)
CITY  | VARCHAR(50)
STREET  | VARCHAR(50)
STREET_TYPE     | INTEGER
HOUSE | VARCHAR(10)
POST_INDEX | VARCHAR(10)

#### 5 Table APARTMENT

Таблица содержит информацию о конкретном месте проживания с необходимой информацией.

Column  | Type
------------- | -------------
APARTMENT_ID | SERIAL
CONTACTS | VARCHAR(50)
APARTMENT_TYPE_ID | BIGINT
ADDRESS_ID     | BIGINT

Связь с таблицей ADDRESS foreign key ADDRESS_ID

Связь с таблицей ADDRESS foreign key APARTMENT_TYPE_ID

#### 6 Table APARTMENT_TYPE

Таблица содержит информацию о различных видах апартаментов.

Column  | Type
------------- | -------------
APARTMENT_TYPE_ID | SERIAL
APARTMENT_TYPE  | VARCHAR(50)

#### 7 Table ROOM
  
Таблица содержит информацию о номере проживания гостей.

Column  | Type
------------- | -------------
ROOM_ID | SERIAL
ROOM_FLOOR  | VARCHAR(10)
ROOM_NUMBER     | VARCHAR(10)
ROOM_TYPE_ID | BIGINT
APARTMENT_ID | BIGINT

Relationships:

Связь с таблицей ROOM_TYPE foreign key ROOM_TYPE_ID

Связь с таблицей FACILITY через промежуточную таблицу ROOM_FACILITY

Связь с таблицей APARTMENT foreign key  APARTMENT_ID

#### 8 Table ROOM_TYPE
  
Таблица содержит информацию о различных видах номеров, представленных в системе.

Column  | Type
------------- | -------------
ROOM_TYPE_ID | SERIAL
ROOM_TYPE_NAME  | VARCHAR(50)

#### 9 Table FACILITY

Таблица содержит информацию о доступных удобствах в номере

Column  | Type
------------- | -------------
FACILITY_ID | SERIAL
FACILITY_TYPE  | VARCHAR(100)

#### 10 Table ROOM_FACILITY

Промежуточная таблица для связи между таблицами ROOM и FACILITY

Column  | Type
------------- | -------------
ROOM_ID  | BIGINT
FACILITY_ID  | BIGINT

#### 11 Table PAYMENT
   
Таблица содержит информацию о совершенной оплате бронирования

Column  | Type
------------- | -------------
PAYMENT_ID | SERIAL
COST  | NUMERIC
CARD_NUMBER  | VARCHAR(20)
BANK  | VARCHAR(50)
PAYMENT_METHOD  | VARCHAR(50)

#### 12 Table ROOM_PRICE
   
Таблица содержит информацию о ценах и доступности на номера в различный период времени

Column  | Type
------------- | -------------
ROOM_PRICE_ID | SERIAL
PRICE  | NUMERIC
INFO_DATE | DATE
IS_AVAILABLE  | BOOLEAN
ROOM_ID  | BIGINT

Relationships:

Связь с таблицей ROOM foreign key ROOM_ID


## Бизнес задачи:

1. Забронировать номер, отменить бронирование

2. Проверить какие номера доступны в определённый период времени

3. Посмотреть цены на номера в определённый период времени

4. Какие удобства доступны в интересующем нас номере

5. Вывести количество забронированных и свободных номеров на текущий момент




## Индексы:

#####  Забронировать номер, отменить бронирование

Индекс на PRIMARY KEY (BOOKING_ID) создается по умолчанию. Добавить также индексы для foreign key: CUSTOMER_ID и ROOM_ID.

##### Проверить какие номера доступны в определённый период времени
1. Первый запроса

declare @arrival_date as DATE
declare @departure_date as DATE

select * from room where room_id  not in 
(
	select room_id from booking inner join room on booking.room_id = room.room_id where (start_date <= @arrival_date and end_date >= @arrival_date) 
	OR (start_date < @departure_date and end_date >= @departure_date)
	OR (@arrival_date <= start_date and @departure_date >= start_date)
)

2. Второй вариант запроса

SELECT * FROM ROOM AS R WHERE ROOM_ID NOT IN (SELECT ROOM_ID FROM BOOKING WHERE ROOM_ID IS NOT NULL AND ROOM_ID = R.ROOM_ID AND START_DATE < @BOOKING_END_DATE AND END_DATE > @BOOKING_START_DATE);


declare @arrival_date as DATE
declare @departure_date as DATE

3. Третий вариант запроса

select room_id 
from room as r 
inner join room_price as rp 
	on r.room_id = rp.room_id  
where rp.date between @arrival_date and @departure_date
group by r.room_id
having count(*) = datediff(day, @arrival_date, @departure_date) + 1;

Вывод:
Добавить индексы на поля START_DATE и END_DATE в таблице BOOKING

#####  Посмотреть цены на номера в определённый период времени
1. Вариант запроса

declare @arrival_date as DATE
declare @departure_date as DATE

select room_id, SUM(rp.cost) / DATEDIFF(day, @arrival_date, @departure_date)
from room as r
inner join room_price as rp
	on r.room_id = rp.room_id
where rp.date between  @arrival_date and @departure_date;

Вывод:
Дополнительные индексы помимо START_DATE и END_DATE не нужны. 

#####   Какие удобства доступны в интересующем нас номере
1. Вариант запроса

declare @searched_room_id as BIGINT

select f.* 
from facility as f
INNER JOIN room_facility as rf ON f.facility_id = rf.facility_id
INNER JOIN room as r rf.room_id = r.room_id
WHERE r.room_id = searched_room_id;

Вывод:
Дополнительные индексы не нужны, все основывается на primary key, для которых postgres сам создаст индексы.

##### Вывести количество свободных номеров по категориям за определенный период времени

1. Вариант запроса

declare @arrival_date as DATE
declare @departure_date as DATE
declare @apartment_id as BIGINT

select rt.room_type_name, 
	   count(b.room_id IS NULL) as quantity
from room as r JOIN
     room_type as rt
     ON rt.room_type_id = r.room_type_id
     LEFT JOIN 
     booking as b
     ON  b.room_id = r.room_id AND 
     b.start_date <= @departure_date AND
     b.end_date >= @arrival_date
where r.apartment_id = @apartment_id
GROUP BY rt.room_type_name
ORDER BY quantity DESC;

Вывод:
Добавить индекс на поле room_type_name в таблице room_type

Итог:
1. Индексы для PRIMARY KEY создаются по умолчанию
2. Добавить индексы для foreign key: CUSTOMER_ID и ROOM_ID в таблице BOOKING.
3. Добавить индексы на поля START_DATE и END_DATE в таблице BOOKING
4. Добавить индекс на поле room_type_name в таблице ROOM_TYPE

## Constraints

1. all tables
Добавлены ограничения на обязательные поля 

2. table customer
Добавлена проверка даты рождения customer (не может быть позже текущей даты)

3. table booking 
Добавлена проверка букинг дат (дата начала не может быть позже даты выезда из номера)

4. table booking 
Добавлена проверка на цену бронирования (не может быть отрицательным числом)

5. table room_price 
Добавлена проверка на цену номера в определенный день (не может быть отрицательным числом)