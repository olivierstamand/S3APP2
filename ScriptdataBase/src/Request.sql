CREATE OR REPLACE FUNCTION Reserv(date_debut_s TIMESTAMP without time zone, date_fin_s TIMESTAMP without time zone,
                                  type VARCHAR(30))
    RETURNS TABLE
            (
                ID_reserv   VARCHAR,
                date_debut  Timestamp without time zone,
                date_fin    Timestamp without time zone,
                Id_local    VARCHAR,
                Id_pavillon VARCHAR,
                CIP         VARCHAR
            )
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
        SELECT reservation.id_reserv,
               reservation.date_debut::TIMESTAMP without time zone, -- Cast the column to the correct data type
               reservation.date_fin::TIMESTAMP without time zone,   -- Cast the column to the correct data type
               reservation.Id_local,
               reservation.Id_pavillon,
               reservation.CIP
        FROM app2.Reservation,
             app2.a_fonction
        where reservation.id_local = a_fonction.id_local
          and type = id_fonction
          and reservation.date_debut >= date_debut_s
          and reservation.date_fin <= date_fin_s;
END;
$$;

select *
from Reserv('2023-05-20 08:00', '2023-05-26 10:45:00', '0211');



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
