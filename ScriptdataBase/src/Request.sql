select * from app2.a_carac;

CREATE OR REPLACE PROCEDURE SelectReserv (IN date_debut_s TIMESTAMP, IN date_fin_s TIMESTAMP, IN type VARCHAR(30))
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM app2.Reservation;
END;
$$;

