-- copy booking data to text file
COPY booking_schema.booking (booking_id, booking_status, start_date, end_date) to 'C:\db-course\dml-script\booking_info.txt' DELIMITER ' ';

-- insert data from text file to address table
COPY booking_schema.address FROM 'C:\db-course\dml-script\address.txt' DELIMITER ',' CSV HEADER;