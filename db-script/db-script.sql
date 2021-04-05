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
    apartment_type_id bigint,
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
    payment_id bigint
);


CREATE TABLE booking_schema.customer (
    customer_id serial NOT NULL,
    firstname varchar(255),
    middlename varchar(255),
    lastname varchar(255),
    gender integer,
    birth_date date,
    customer_type varchar(50),
    address_id bigint
);

CREATE TABLE booking_schema.customer_booking (
    id serial NOT NULL,
    customer_id serial NOT NULL,
    booking_id serial NOT NULL
);

CREATE TABLE booking_schema.facility (
    facility_id serial NOT NULL,
    facility_type varchar(100)
);

CREATE TABLE booking_schema.payment (
    id serial NOT NULL,
    cost numeric,
    card_number varchar(20),
    bank varchar(50)
    CONSTRAINT positive_payment CHECK (cost > 0)
);

CREATE TABLE booking_schema.room (
    room_id serial NOT NULL,
    room_floor varchar(10),
    room_number varchar(10)
);

CREATE TABLE booking_schema.room_facility (
    id serial NOT NULL,
    room_id serial NOT NULL,
    facility_id serial NOT NULL
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


ALTER TABLE ONLY booking_schema.customer_booking
    ADD CONSTRAINT customer_booking_pkey PRIMARY KEY (id);


ALTER TABLE ONLY booking_schema.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


ALTER TABLE ONLY booking_schema.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (facility_id);


ALTER TABLE ONLY booking_schema.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


ALTER TABLE ONLY booking_schema.room_facility
    ADD CONSTRAINT room_facility_pkey PRIMARY KEY (id);


ALTER TABLE ONLY booking_schema.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);



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
    ADD CONSTRAINT payment_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES booking_schema.payment(id);


ALTER TABLE ONLY booking_schema.room_facility
    ADD CONSTRAINT room_id_fkey FOREIGN KEY (room_id) REFERENCES booking_schema.room(room_id);