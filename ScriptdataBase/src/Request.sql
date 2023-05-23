CREATE PROCEDURE SelectReserv (date_debut_s timestamp, Date_fin_s timestamp, type varchar(30))
AS
BEGIN
    SELECT * FROM app2.Reservation


--execute SelectReserv ('2019-01-01', '2019-01-31',01)
