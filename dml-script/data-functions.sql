-- generate random text for insert statements

CREATE OR REPLACE FUNCTION random_text_simple(length INTEGER)
    RETURNS TEXT
    LANGUAGE PLPGSQL
    AS $$
    DECLARE
        possible_chars TEXT := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        output TEXT := '';
        i INT4;
    BEGIN

        FOR i IN 1..length LOOP
            output := output || substr(possible_chars, random_range(1, length(possible_chars)), 1);
        END LOOP;

        RETURN output;
    END;
    $$;

-- generate random range in random_text_simple function

CREATE OR REPLACE FUNCTION random_range(INTEGER, INTEGER)
    RETURNS INTEGER
    LANGUAGE SQL
    AS $$
        SELECT ($1 + FLOOR(($2 - $1 + 1) * random() ))::INTEGER;
    $$;