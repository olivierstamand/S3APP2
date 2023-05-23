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


