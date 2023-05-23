CREATE PROCEDURE SelectReserv (date_debut_s timestamp, Date_fin_s timestamp, type varchar(30))
AS
BEGIN
    SELECT * FROM app2.Reservation

CREATE OR REPLACE PROCEDURE example_procedure(param1 INT, param2 VARCHAR(255))
AS
BEGIN
-- Instructions à exécuter dans la procédure
-- Utilisez les paramètres passés à la procédure comme besoin

--execute SelectReserv ('2019-01-01', '2019-01-31',01)
