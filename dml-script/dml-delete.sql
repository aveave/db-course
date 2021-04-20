-- Удалить записи бронирования старше заданной даты
delete from booking_schema.booking b where b.end_date < '01.06.2021';

-- Удалить все бронирования для заданного клиента
delete from booking_schema.booking b
	using booking_schema.customer c
	where c.customer_id = b.customer_id
	and c.customer_id = 1;