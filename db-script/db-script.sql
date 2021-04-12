-- TABLESPACES

CREATE TABLESPACE booking_space OWNER postgres LOCATION 'C:/test';

-- DATABASE

CREATE database booking tablespace = booking_space; 


-- SCHEMA

CREATE SCHEMA IF NOT EXISTS booking_schema;


-- ROLES 

CREATE ROLE ANALYST;
GRANT SELECT ON ALL TABLES IN SCHEMA booking_schema TO ANALYST;

CREATE ROLE EMPLOYEE;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA booking_schema TO EMPLOYEE;


-- TABLES IN CREATED SCHEMA

CREATE TABLE booking_schema.address (
    address_id serial NOT NULL,
    region varchar(50),
    city varchar(50) NOT NULL,
    street varchar(50) NOT NULL,
    street_type integer NOT NULL,
    house varchar(10),
    post_index varchar(10) NOT NULL
);


CREATE TABLE booking_schema.apartment (
    apartment_id serial NOT NULL,
    contacts varchar(50),
    apartment_type_id bigint NOT NULL,
    address_id bigint
);

CREATE TABLE booking_schema.apartment_type (
    apartment_type_id serial NOT NULL,
    apartment_type varchar(50)
);


CREATE TABLE booking_schema.booking (
    booking_id serial NOT NULL,
    booking_status varchar(30),
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    customer_id bigint,
    room_id bigint,
    payment_id bigint,
    CONSTRAINT booking_dates CHECK (start_date <= end_date)
);


CREATE TABLE booking_schema.customer (
    customer_id serial NOT NULL,
    firstname varchar(255) NOT NULL,
    middlename varchar(255),
    lastname varchar(255) NOT NULL,
    gender integer NOT NULL,
    birth_date date,
    customer_type varchar(50) NOT NULL,
    address_id bigint,
    CONSTRAINT birth_date_check CHECK (birth_date <= CURRENT_DATE)
);

CREATE TABLE booking_schema.customer_booking (
    customer_id bigint NOT NULL,
    booking_id bigint NOT NULL,
    unique (customer_id, booking_id)
);

CREATE TABLE booking_schema.facility (
    facility_id serial NOT NULL,
    facility_type varchar(100)
);

CREATE TABLE booking_schema.payment (
    payment_id serial NOT NULL,
    cost numeric,
    card_number varchar(20),
    payment_method varchar(50) NOT NULL,
    bank varchar(50),
    CONSTRAINT positive_payment CHECK (cost > 0)
);

CREATE TABLE booking_schema.room (
    room_id serial NOT NULL,
    room_floor varchar(10) NOT NULL,
    room_number varchar(10) NOT NULL,
    room_type_id bigint NOT NULL,
    apartment_id bigint
);

CREATE TABLE booking_schema.room_type (
    room_type_id serial NOT NULL,
    room_type_name varchar(50)
);

CREATE TABLE booking_schema.room_facility (
    room_id bigint NOT NULL,
    facility_id bigint NOT NULL,
    unique(room_id, facility_id)
);

CREATE TABLE booking_schema.room_price (
    room_price_id serial NOT NULL,
    price numeric NOT NULL,
    info_date date NOT NULL,
    is_available boolean NOT NULL,
    room_id  bigint,
    CONSTRAINT price_positive CHECK (price > 0)  
);


-- PRIMARY KEYS

ALTER TABLE ONLY booking_schema.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


ALTER TABLE ONLY booking_schema.apartment
    ADD CONSTRAINT apartment_pkey PRIMARY KEY (apartment_id);


ALTER TABLE ONLY booking_schema.apartment_type
    ADD CONSTRAINT apartment_type_pkey PRIMARY KEY (apartment_type_id);


ALTER TABLE ONLY booking_schema.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);

ALTER TABLE ONLY booking_schema.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


ALTER TABLE ONLY booking_schema.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (facility_id);


ALTER TABLE ONLY booking_schema.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


ALTER TABLE ONLY booking_schema.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);

ALTER TABLE ONLY booking_schema.room_price
    ADD CONSTRAINT room_price_pkey PRIMARY KEY (room_price_id);



-- FOREIGN KEYS

ALTER TABLE ONLY booking_schema.customer
    ADD CONSTRAINT address_address_id_fkey FOREIGN KEY (address_id) REFERENCES booking_schema.address(address_id);


ALTER TABLE ONLY booking_schema.apartment
    ADD CONSTRAINT address_address_id_fkey FOREIGN KEY (address_id) REFERENCES booking_schema.address(address_id);


ALTER TABLE ONLY booking_schema.customer_booking
    ADD CONSTRAINT booking_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES booking_schema.booking(booking_id);

ALTER TABLE ONLY booking_schema.customer_booking
    ADD CONSTRAINT customer_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES booking_schema.customer(customer_id);


ALTER TABLE ONLY booking_schema.room_facility
    ADD CONSTRAINT facility_id_fkey FOREIGN KEY (facility_id) REFERENCES booking_schema.facility(facility_id);


ALTER TABLE ONLY booking_schema.booking
    ADD CONSTRAINT payment_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES booking_schema.payment(payment_id);


ALTER TABLE ONLY booking_schema.room_facility
    ADD CONSTRAINT room_id_fkey FOREIGN KEY (room_id) REFERENCES booking_schema.room(room_id);

ALTER TABLE ONLY booking_schema.room_price
    ADD CONSTRAINT room_id_fkey FOREIGN KEY (room_id) REFERENCES booking_schema.room(room_id);
    