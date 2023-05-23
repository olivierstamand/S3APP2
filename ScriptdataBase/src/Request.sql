
DELETE from Reservation where ID_reserv='RES5';
INSERT INTO Reservation (ID_reserv, date_debut, date_fin, Id_local, CIP,id_pavillon)
VALUES
    ('RES5', '2023-05-25 08:00', '2023-05-25 10:45:00' , '3014','U1','C1');


CREATE OR REPLACE FUNCTION ressss(date_debut_s TIMESTAMP without time zone, date_fin_s TIMESTAMP without time zone,
                                  type VARCHAR(30))
    RETURNS VARCHAR[]
    LANGUAGE plpgsql
AS
$$
DECLARE
    local_ids VARCHAR[];
BEGIN
    SELECT ARRAY_AGG(reservation.Id_local)
    INTO local_ids
    FROM app2.Reservation, app2.a_fonction
    WHERE reservation.id_local = a_fonction.id_local
      AND type = id_fonction
      AND reservation.date_debut >= date_debut_s
      AND reservation.date_fin <= date_fin_s;

    RETURN local_ids;
END;
$$;

select *
from ressss('2023-05-20 08:00', '2023-05-26 10:45:00', '0211');




-- Function that returns a table with varying columns
CREATE OR REPLACE FUNCTION create_dynamic_table(date_debut_s TIMESTAMP without time zone, date_fin_s TIMESTAMP without time zone,
                                                type VARCHAR(30))
    RETURNS SETOF RECORD
AS
$$
DECLARE
    column_names TEXT[] := ressss(date_debut_s, date_fin_s, type);
    column_declaration TEXT := '';
    dynamic_sql TEXT;
BEGIN
    FOR i IN 1 .. array_length(column_names, 1) LOOP
            column_declaration := column_declaration || column_names[i] || ' TEXT';

            IF i < array_length(column_names, 1) THEN
                column_declaration := column_declaration || ', ';
            END IF;
        END LOOP;
    dynamic_sql := 'CREATE TEMPORARY TABLE dynamic_table (' || column_declaration || ')';
    EXECUTE dynamic_sql;
    RETURN QUERY EXECUTE 'SELECT ' || array_to_string(column_names, ', ');
END;
$$
    LANGUAGE plpgsql;

select *
from create_dynamic_table('2023-05-20 08:00', '2023-05-26 10:45:00', '0211');
