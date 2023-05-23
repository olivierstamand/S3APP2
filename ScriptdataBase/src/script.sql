drop schema if exists app2 cascade;
create schema app2;
set search_path = app2;

CREATE TABLE Fonction_Local
(
    ID_fonction VARCHAR NOT NULL,
    nom_fonction VARCHAR NOT NULL,
    PRIMARY KEY (ID_fonction)
);

CREATE TABLE Campus
(
    Id_campus VARCHAR NOT NULL,
    nom_campus VARCHAR NOT NULL,
    PRIMARY KEY (Id_campus)

);





CREATE TABLE Caractéristique_Local
(
    ID_carac VARCHAR NOT NULL,
    nom_carac VARCHAR NOT NULL,
    PRIMARY KEY (ID_carac)
);

CREATE TABLE Role
(
    ID_Role VARCHAR NOT NULL,
    nom_role VARCHAR NOT NULL,
    PRIMARY KEY (ID_Role)
);





CREATE TABLE Faculté
(
    ID_facu VARCHAR NOT NULL,
    nom_facu VARCHAR NOT NULL,
    PRIMARY KEY (ID_facu)

);
CREATE TABLE Pavillon
(
    Id_pavillon VARCHAR NOT NULL,
    nom_pavillon VARCHAR NOT NULL,
    Id_campus VARCHAR NOT NULL,
    Id_facu VARCHAR NOT NULL,
    PRIMARY KEY (Id_pavillon),
    FOREIGN KEY (Id_campus) REFERENCES Campus(Id_campus),
    FOREIGN KEY (Id_facu) REFERENCES faculté(ID_facu)
);

CREATE TABLE Local
(
    Id_local VARCHAR NOT NULL,
    Capacite INT NOT NULL,
    note VARCHAR  NULL,
    Id_pavillon VARCHAR NOT NULL,

    PRIMARY KEY (Id_pavillon,Id_local),

    FOREIGN KEY (Id_pavillon) REFERENCES Pavillon(Id_pavillon),
    FOREIGN KEY (Id_local, Id_pavillon) REFERENCES Local(Id_local, Id_pavillon)
);

CREATE TABLE Departement_
(
    ID_depart VARCHAR NOT NULL,
    nom_depart VARCHAR NOT NULL,
    ID_facu VARCHAR NOT NULL,
    PRIMARY KEY (ID_depart),
    FOREIGN KEY (ID_facu) REFERENCES Faculté(ID_facu)
);

CREATE TABLE Usager
(
    CIP VARCHAR NOT NULL,
    Nom_usager VARCHAR NOT NULL,
    courriel_usager VARCHAR NOT NULL,
    ID_depart VARCHAR NOT NULL,
    PRIMARY KEY (CIP),
    FOREIGN KEY (ID_depart) REFERENCES Departement_(ID_depart)
);

CREATE TABLE A_role
(
    CIP VARCHAR NOT NULL,
    ID_Role VARCHAR NOT NULL,
    FOREIGN KEY (CIP) REFERENCES Usager(CIP),
    FOREIGN KEY (ID_Role) REFERENCES Role(ID_Role)
);





CREATE TABLE Reservation
(
    ID_reserv VARCHAR NOT NULL,
    date_debut Timestamp without time zone not NULL,
    date_fin Timestamp without time zone NOT NULL,
    Id_local VARCHAR NOT NULL,
    Id_pavillon VARCHAR NOT NULL,
    CIP VARCHAR NOT NULL,
    PRIMARY KEY (ID_reserv),
    FOREIGN KEY (Id_local,Id_pavillon) REFERENCES Local(Id_local,Id_pavillon),
    FOREIGN KEY (CIP) REFERENCES Usager(CIP)
);



CREATE TABLE a_carac
(
    Id_local VARCHAR NOT NULL,
    ID_carac VARCHAR NOT NULL,
    Id_pavillon VARCHAR NOT NULL,
    PRIMARY KEY (Id_pavillon,Id_local,ID_carac),
    FOREIGN KEY (Id_pavillon,Id_local) REFERENCES Local(Id_pavillon, Id_local),
    FOREIGN KEY (ID_carac) REFERENCES Caractéristique_Local(ID_carac)
);

CREATE TABLE a_fonction
(
    Id_local VARCHAR NOT NULL,
    ID_fonction VARCHAR NOT NULL,
    Id_pavillon VARCHAR NOT NULL,
    PRIMARY KEY (Id_local,Id_pavillon,ID_fonction),
    FOREIGN KEY (Id_local,Id_pavillon) REFERENCES Local(Id_local, Id_pavillon),
    FOREIGN KEY (ID_fonction) REFERENCES Fonction_Local(ID_fonction)


);

-- Indexes pour la table Local
CREATE INDEX idx_Local_Id_pavillon ON Local (Id_pavillon);
CREATE INDEX idx_Local_Id_local ON Local (Id_local);

-- Indexes pour la table Faculté
--CREATE INDEX idx_Faculté_Id_pavillon ON Faculté (Id_pavillon);

-- Indexes pour la table Departement_
CREATE INDEX idx_Departement_Id_facu ON Departement_ (ID_facu);

-- Indexes pour la table Usager
CREATE INDEX idx_Usager_ID_depart ON Usager (ID_depart);

-- Indexes pour la table Reservation
CREATE INDEX idx_Reservation_Id_local ON Reservation (Id_local);
CREATE INDEX idx_Reservation_CIP ON Reservation (CIP);

-- Indexes pour la table a_carac
CREATE INDEX idx_a_carac_Id_local ON a_carac (Id_local);
CREATE INDEX idx_a_carac_ID_carac ON a_carac (ID_carac);

-- Indexes pour la table a_fonction
CREATE INDEX idx_a_fonction_Id_local ON a_fonction (Id_local);
CREATE INDEX idx_a_fonction_ID_fonction ON a_fonction (ID_fonction);


INSERT INTO Faculté (ID_facu, nom_facu)
VALUES
    ('FAC1', 'Génie');

INSERT INTO Campus (Id_campus, nom_campus)
VALUES
    ('01', 'Campus A'),
    ('02', 'Campus B'),
    ('03', 'Campus C');

-- Insert mock data into the Pavillon table
INSERT INTO Pavillon (Id_pavillon, nom_pavillon, Id_campus, Id_facu)
VALUES
    ('C1', 'J.-Armard-Bombardier', '01','FAC1'),
    ('C2', 'J.-Armard-Bombardier', '01','FAC1'),
    ('D7', 'Marie-Victorin', '01','FAC1');

-- Insert mock data into the Fonction_Local table
INSERT INTO Fonction_Local (ID_fonction, nom_fonction)
VALUES
    ('0110', 'Salle de classe générale'),
    ('0111', 'Salle de classe spécialisée'),
    ('0120', 'Salle de séminaire'),
    ('0121', 'Cubicules'),
    ('0210', 'Laboratoire informatique'),
    ('0211', 'Laboratoire d’enseignement spécialisé'),
    ('0212', 'Atelier'),
    ('0213', 'Salle à dessin'),
    ('0214', 'Atelier (civil)'),
    ('0215', 'Salle de musique'),
    ('0216', 'Atelier sur 2 étages, conjoint avec autre local'),
    ('0217', 'Salle de conférence'),
    ('0372', 'Salle de réunion'),
    ('0373', 'Salle d’entrevue et de tests'),
    ('0510', 'Salle de lecture ou de consultation'),
    ('0620', 'Auditorium'),
    ('0625', 'Salle de concert'),
    ('0640', 'Salle d’audience'),
    ('0930', 'Salon du personnel'),
    ('1030', 'Studio d’enregistrement'),
    ('1260', 'Hall d’entrée');

-- Insert mock data into the Caractéristique_Local table
INSERT INTO Caractéristique_Local (ID_carac, nom_carac)
VALUES
    ('0', 'Connexion à Internet'),
    ('1', 'Tables fixes en U et chaises mobiles'),
    ('2', 'Monoplaces'),
    ('3', 'Tables fixes et chaises fixes'),
    ('6', 'Tables pour 2 ou + et chaises mobiles'),
    ('7', 'Tables mobiles et chaises mobiles'),
    ('8', 'Tables hautes et chaises hautes'),
    ('9', 'Tables fixes et chaises mobiles'),
    ('11', 'Écran'),
    ('14', 'Rétroprojecteur'),
    ('15', 'Gradins'),
    ('16', 'Fenêtres'),
    ('17', '1 piano'),
    ('18', '2 pianos'),
    ('19', 'Autres instruments'),
    ('20', 'Système de son'),
    ('21', 'Salle réservée (spéciale)'),
    ('22', 'Ordinateurs PC'),
    ('23', 'Ordinateurs SUN pour génie électrique'),
    ('24', 'Ordinateurs SUN pour génie électrique'),
    ('25', 'Ordinateurs (oscillomètre et multimètre)'),
    ('26', 'Ordinateurs modélisation des structures'),
    ('27', 'Ordinateurs PC'),
    ('28', 'Équipement pour microélectronique'),
    ('29', 'Équipement pour génie électrique'),
    ('30', 'Ordinateurs et équipement pour mécatroni'),
    ('31', 'Équipement métrologie'),
    ('32', 'Équipement de machinerie'),
    ('33', 'Équipement de géologie'),
    ('34', 'Équipement pour la caractérisation'),
    ('35', 'Équipement pour la thermodynamique'),
    ('36', 'Équipement pour génie civil'),
    ('37', 'Télévision'),
    ('38', 'VHS'),
    ('39', 'Hauts parleurs'),
    ('40', 'Micro'),
    ('41', 'Magnétophone à cassette'),
    ('42', 'Amplificateur audio'),
    ('43', 'Local barré'),
    ('44', 'Prise réseau');

-- Insert mock data into the Role table
INSERT INTO Role (ID_Role, nom_role)
VALUES
    ('R1', 'Administrateur'),
    ('R2', 'Enseignant'),
    ('R3', 'Étudiant'),
    ('R4', 'Personnel de soutien');
-- Insert mock data into the Local table
INSERT INTO Local (Id_local, Capacite, note, Id_pavillon)
VALUES
    ('1007', 21, 'Grand', 'C1'),
    ('2018', 10, 'Matériaux composites', 'C1' ),
    ('2055', 24, NULL, 'C1'),
    ('3014', 25, 'Laboratoire mécatronique', 'C1'),
    ('3027', 15, 'Petit laboratoire de élect', 'C1'),
    ('3016', 50, NULL, 'C1'),
    ('3018', 50, NULL, 'C1'),
    ('3024', 50, NULL, 'C1'),
    ('3035', 50, NULL, 'C1'),
    ('3041', 50, NULL, 'C1'),
    ('3007', 106, 'Avec console multi-média', 'C1'),
    ('3010', 30, 'Laboratoire de conception VLSI', 'C1'),
    ('4016', 91, NULL, 'C1'),
    ('4018', 10, 'Métallurgie', 'C1'),
    ('4019', 8, 'Laboratoire accessoire Atelier', 'C1'),
    ('4021', 28, NULL, 'C1'),
    ('4023', 108, NULL, 'C1'),
    ('4030', 25, 'Équipement photoélasticité', 'C1'),
    ('4028', 14, NULL, 'C1'),
    ('4008', 106, NULL, 'C1'),
    ('5012', 35, '8 cubicules', 'C1'),
    ('5026', 38, 'Ordinateurs', 'C1'),
    ('5028', 50, 'Ordinateurs', 'C1'),
    ('5001', 198, 'Avec console multi-média', 'C1'),
    ('5009', 50, 'Avec console multi-média', 'C1'),
    ('5006', 110, 'Avec console multi-média', 'C1'),
    ('0009', 100, 'Grand et équipé', 'C2'),
    ('1004', 30, 'Atelier géologie équipement', 'C2'),
    ('1015', 40, 'Laboratoire d’hydraulique', 'C2'),
    ('1042', 21, 'Laboratoire chimie-physique', 'C2'),
    ('2040', 40, 'Laboratoire sans instrument', 'C2'),
    ('251-4', 10, NULL, 'C2'),
    ('2018', 57, NULL, 'D7'),
    ('3001', 35, NULL, 'D7'),
    ('3002', 22, NULL, 'D7'),
    ('3007', 54, NULL, 'D7'),
    ('3009', 45, NULL, 'D7'),
    ('3010', 21, NULL, 'D7'),
    ('3011', 50, NULL, 'D7'),
    ('3012', 54, NULL, 'D7'),
    ('3013', 44, NULL, 'D7'),
    ('3014', 40, NULL, 'D7'),
    ('3015', 48, NULL, 'D7'),
    ('3016', 125, 'Avec console multi-média', 'D7'),
    ('3017', 45, NULL, 'D7'),
    ('3019', 48, NULL, 'D7'),
    ('3020', 35, 'Un mur est en fenêtre', 'D7');

-- Insert mock data into the Faculté table


-- Insert mock data into the Departement_ table
INSERT INTO Departement_ (ID_depart, nom_depart, ID_facu)
VALUES
    ('GI', 'Département 1', 'FAC1');

-- Insert mock data into the Usager table
INSERT INTO Usager (CIP, Nom_usager, courriel_usager, ID_depart)
VALUES
    ('U1', 'User 1', 'user1@example.com', 'GI'),
    ('U2', 'User 2', 'user2@example.com', 'GI'),
    ('U3', 'User 3', 'user3@example.com', 'GI');

-- Insert mock data into the A_role table
INSERT INTO A_role (CIP, ID_Role)
VALUES
    ('U1', 'R1'),
    ('U2', 'R2'),
    ('U3', 'R3');


-- Insert mock data into the Reservation table
INSERT INTO Reservation (ID_reserv, date_debut, date_fin, Id_local, CIP,id_pavillon)
VALUES
    ('RES1', '2023-05-23 08:00', '2023-05-25 10:45:00' , '3014','U1','C1'),
    ('RES2', '2023-05-23 08:00', '2023-05-26 08:35', '4008','U1','C1'),
    ('RES3', '2023-05-25 08:00', '2023-05-27 08:35', '4018','U1','C1'),
    ('RES4', '2023-05-22 08:00', '2023-05-23 08:35', '3016','U1','C1');

-- Insert mock data into the a_carac table
INSERT INTO a_carac (Id_pavillon,Id_local, ID_carac)
VALUES
    ('C1', '3014', '30'),
    ('C1', '3035', '21'),
    ('C1', '3041', '11'),
    ('C1', '3041', '22'),
    ('C1', '3007', '11'),
    ('C1', '3007', '14'),
    ('C1', '3007', '24'),
    ('C1', '3007', '38'),
    ('C1', '3007', '40'),
    ('C1', '4016', '11'),
    ('C1', '4016', '14'),
    ('C1', '4016', '24'),
    ('C1', '4016', '40'),
    ('C1', '4021', '22'),
    ('C1', '4023', '11'),
    ('C1', '4023', '14'),
    ('C1', '4023', '24'),
    ('C1', '4023', '38'),
    ('C1', '4023', '40'),
    ('C1', '4008', '11'),
    ('C1', '4008', '14'),
    ('C1', '4008', '24'),
    ('C1', '4008', '38'),
    ('C1', '4008', '40'),
    ('C1', '5026', '11'),
    ('C1', '5026', '14'),
    ('C1', '5026', '22'),
    ('C1', '5028', '11'),
    ('C1', '5028', '14'),
    ('C1', '5028', '22'),
    ('C1', '5001', '11'),
    ('C1', '5001', '14'),
    ('C1', '5001', '24'),
    ('C1', '5001', '38'),
    ('C1', '5001', '40'),
    ('C1', '5009', '11'),
    ('C1', '5009', '14'),
    ('C1', '5009', '24'),
    ('C1', '5009', '38'),
    ('C1', '5009', '40'),
    ('C1', '5006', '11'),
    ('C1', '5006', '14'),
    ('C1', '5006', '24'),
    ('C1', '5006', '38'),
    ('C1', '5006', '40'),
    ('C2', '1004', '33'),
    ('D7', '2018', '7'),
    ('D7', '2018', '11'),
    ('D7', '2018', '14'),
    ('D7', '2018', '43'),
    ('D7', '3001', '2'),
    ('D7', '3001', '11'),
    ('D7', '3001', '14'),
    ('D7', '3002', '2'),
    ('D7', '3002', '11'),
    ('D7', '3002', '14'),
    ('D7', '3007', '2'),
    ('D7', '3007', '11'),
    ('D7', '3009', '2'),
    ('D7', '3009', '11'),
    ('D7', '3010', '2'),
    ('D7', '3010', '11');



-- Insert mock data into the a_fonction table
INSERT INTO a_fonction (Id_pavillon,Id_local ,ID_fonction)
VALUES

    ('C1', '1007', '0212'),
    ('C1', '2018', '0212'),
    ('C1', '2055', '0211'),
    ('C1', '3014', '0211'),
    ('C1', '3027', '0211'),
    ('C1', '3016', '0211'),
    ('C1', '3018', '0211'),
    ('C1', '3024', '0211'),
    ('C1', '3035', '0210'),
    ('C1', '3041', '0210'),
    ('C1', '3007', '0620'),
    ('C1', '3010', '0211'),
    ('C1', '4016', '0620'),
    ('C1', '4018', '0212'),
    ('C1', '4019', '0212'),
    ('C1', '4021', '0210'),
    ('C1', '4023', '0620'),
    ('C1', '4030', '0211'),
    ('C1', '4028', '0210'),
    ('C1', '4008', '0620'),
    ('C1', '5012', '0121'),
    ('C1', '5026', '0210'),
    ('C1', '5028', '0210'),
    ('C1', '5001', '0620'),
    ('C1', '5009', '0111'),
    ('C1', '5006', '0620'),
    ('C2', '0009', '0214'),
    ('C2', '1004', '0212'),
    ('C2', '1015', '0211'),
    ('C2', '1042', '0211'),
    ('C2', '2040', '0211'),
    ('C2', '251-4', '0211'),
    ('D7', '2018', '0111'),
    ('D7', '3001', '0110'),
    ('D7', '3002', '0110'),
    ('D7', '3007', '0110'),
    ('D7', '3009', '0110'),
    ('D7', '3010', '0110'),
    ('D7', '3011', '0110'),
    ('D7', '3012', '0110'),
    ('D7', '3013', '0110'),
    ('D7', '3014', '0110'),
    ('D7', '3015', '0110'),
    ('D7', '3016', '0620'),
    ('D7', '3017', '0110'),
    ('D7', '3019', '0110'),
    ('D7', '3020', '0110');

