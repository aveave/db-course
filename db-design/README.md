# Booking data base design

Система для бронирования жилья 

## Таблицы

#### 1 Table CUSTOMER

Таблица содержит информацию о заказчике услуг booking системы.

Column  | Type
------------- | -------------
ID | BIGINT
FIRSTNAME  | VARCHAR(50)
LASTNAME   | VARCHAR(50)
BIRTH_DATE | DATE
ADDRESS_ID | BIGINT

Relationships:

Связь с таблицей ADDRESS foreign key address_id

#### 2 Table GUEST
   
Таблица содержит информацию о клиентах системы, для которых был забронирован один из предложенных апартаментов.

Column  | Type
------------- | -------------
ID | BIGINT
FIRSTNAME  | VARCHAR(50)
LASTNAME   | VARCHAR(50)
BIRTH_DATE | DATE
ADDRESS_ID | BIGINT

Relationships:

Связь с таблицей ADDRESS foreign key address_id

#### 3 Table ADDRESS 

Таблица содержит информацию об адресе клиентов

Column  | Type
------------- | -------------
ID | BIGINT
COUNTRY  | VARCHAR(50)
CITY     | VARCHAR(50)
HOUSE_NUMBER | VARCHAR(50)
COUNTRY_CODE | VARCHAR(50)

#### 4 Table APARTMENT

Таблица содержит информацию о конкретном месте проживания с необходимой информацией.

Column  | Type
------------- | -------------
ID | BIGINT
NAME  | VARCHAR(50)
ADDRESS     | VARCHAR(50)
CONTACTS | VARCHAR(50)
APARTMENT_TYPE_ID | BIGINT

#### 5 Table APARTMENT_TYPE

Таблица содержит информацию о различных видах апартаментов.

Column  | Type
------------- | -------------
ID | BIGINT
APARTMENT_TYPE  | VARCHAR(50)

#### 6 Table ROOM
  
Таблица содержит информацию о номере проживания гостей.

Column  | Type
------------- | -------------
ID | BIGINT
ROOM_FLOOR  | INT
ROOM_NUMBER     | INT
ROOM_TYPE_ID | BIGINT
APARTMENT_ID | BIGINT
FACILITY_ID | BIGINT

Relationships:

Связь с таблицей ROOM_TYPE foreign key room_type_id

Связь с таблицей FACILITY  foreign key facility_id

Связь с таблицей APARTMENT foreign key  apartment_id

#### 7 Table ROOM_TYPE
  
Таблица содержит информацию о различных видах номеров, представленных в системе.

Column  | Type
------------- | -------------
ID | BIGINT
ROOM_TYPE  | VARCHAR(50)

#### 8 Table FACILITY

Таблица содержит информацию о доступных удобствах в номере

Column  | Type
------------- | -------------
ID | BIGINT
FACILITY_TYPE  | VARCHAR(50)

#### 9 Table BOOKING 

Таблица содержит информацию о брони, совершенной заказчиком.

Column  | Type
------------- | -------------
ID | BIGINT
BOOKING_STATUS  | VARCHAR(50)
START_DATE     | DATE
END_DATE | DATE
COST | INT
CUSTOMER_ID | BIGINT
GUEST_ID | BIGINT
ROOM_ID | BIGINT
PAYMENT_ID | BIGINT

Relationships:

Связь с таблицей CUSTOMER foreign key customer_id

Связь с таблицей GUEST foreign key guest_id

Связь с таблицей ROOM foreign key room_id

Связь с таблицей PAYMENTS foreign key payments_id

#### 10 Table PAYMENTS
   
Таблица содержит информацию о доступных способах оплаты

Column  | Type
------------- | -------------
ID | BIGINT
PAYMENT_METHOD  | VARCHAR(50)


## Бизнес задачи:

1. Забронировать номер, отменить бронирование

2. Проверить какие номера доступны в определённый период времени

3. Какие удобства доступны в интересующем нас номере

4. Вывести количество забронированных и свободных номеров на текущий момент












