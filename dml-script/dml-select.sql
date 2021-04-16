-- Queries

-- JOIN

-- Вывести все бронирования в заданном отеле
select * from booking_schema.booking b
INNER JOIN booking_schema.room r
ON b.room_id = r.room_id AND 
r.apartment_id = 1;

-- Вывести цены на номера в определенный период времени 
select rp.room_id, SUM(rp.price) / (DATE_PART('day', '20.05.2021'::date) - DATE_PART('day', '14.05.2021'::date))
from booking_schema.room as r
inner join booking_schema.room_price as rp ON
r.room_id = rp.room_id
where rp.info_date between '14.05.2021' and '20.05.2021'
group by rp.room_id;

-- Вывести доступные удобства в интересующем нас номере
select fa.facility_type from booking_schema.facility fa
INNER JOIN booking_schema.room_facility rf ON fa.facility_id = rf.facility_id 
INNER JOIN booking_schema.room r ON r.room_id = rf.room_id
where r.room_id = 1;

-- Вывести информацию по наличию кондиционера в номерах (21 - id кондиционера)
select r.room_id, fa.facility_type from booking_schema.room r 
LEFT OUTER JOIN booking_schema.room_facility rf ON rf.room_id = r.room_id and rf.facility_id = 21
LEFT OUTER JOIN booking_schema.facility fa ON fa.facility_id = rf.facility_id;



-- RegExp


-- Вывести все отели, содержащие букву А в названии улицы 
select ap.apartment_id, ad.street from booking_schema.apartment ap
INNER JOIN booking_schema.address ad
ON ap.address_id = ad.address_id AND ad.street LIKE 'Б%';

-- Вывести идентификатор и название всех отелей, не содержащие 'Resort' в названии (вне зависимости от регистра)
select ap.apartment_id, ap.name from booking_schema.apartment ap
where ap.name !~* '.*Resort.*';