-- Обновить цену бронирования, сделать скидку 10 % всем, у кого цена превышает 50 000 (не делать дял прошедших бронирований)
update booking_schema.payment p
set cost = pay.cost * 0.9
from (select p.payment_id, p.cost from booking_schema.payment p
INNER JOIN booking_schema.booking b ON 
p.payment_id = b.payment_id AND
b.start_date > CURRENT_DATE AND
p.cost > 50000) as pay
where p.payment_id = pay.payment_id;