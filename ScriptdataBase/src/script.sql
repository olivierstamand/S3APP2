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

CREATE TABLE Pavillon
(
    Id_pavillon VARCHAR NOT NULL,
    nom_pavillon VARCHAR NOT NULL,
    Id_campus VARCHAR NOT NULL,
    PRIMARY KEY (Id_pavillon),
    FOREIGN KEY (Id_campus) REFERENCES Campus(Id_campus)
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



CREATE TABLE Local
(
    Id_local VARCHAR NOT NULL,
    Capacite INT NOT NULL,
    note VARCHAR  NULL,
    Id_pavillon VARCHAR NOT NULL,
    sous_local VARCHAR NULL,

    PRIMARY KEY (Id_local),
    FOREIGN KEY (Id_pavillon) REFERENCES Pavillon(Id_pavillon),
    FOREIGN KEY (sous_local) REFERENCES Local(Id_local)
);

CREATE TABLE Faculté
(
    ID_facu VARCHAR NOT NULL,
    nom_facu VARCHAR NOT NULL,
    Id_pavillon VARCHAR NOT NULL,
    PRIMARY KEY (ID_facu),
    FOREIGN KEY (Id_pavillon) REFERENCES Pavillon(Id_pavillon)
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



CREATE TABLE Cubicule
(
    Id_cubicule VARCHAR NOT NULL,
    Id_local VARCHAR NOT NULL,
    PRIMARY KEY (Id_cubicule),
    FOREIGN KEY (Id_local) REFERENCES Local(Id_local)
);

CREATE TABLE Reservation
(
    ID_reserv VARCHAR NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    Id_local VARCHAR NOT NULL,
    CIP VARCHAR NOT NULL,
    PRIMARY KEY (ID_reserv),
    FOREIGN KEY (Id_local) REFERENCES Local(Id_local),
    FOREIGN KEY (CIP) REFERENCES Usager(CIP)
);



CREATE TABLE a_carac
(
    Id_local VARCHAR NOT NULL,
    ID_carac VARCHAR NOT NULL,
    FOREIGN KEY (Id_local) REFERENCES Local(Id_local),
    FOREIGN KEY (ID_carac) REFERENCES Caractéristique_Local(ID_carac)
);

CREATE TABLE a_fonction
(
    Id_local VARCHAR NOT NULL,
    ID_fonction VARCHAR NOT NULL,
    FOREIGN KEY (Id_local) REFERENCES Local(Id_local),
    FOREIGN KEY (ID_fonction) REFERENCES Fonction_Local(ID_fonction)
);


INSERT INTO Campus (Id_campus, nom_campus)
VALUES
    ('C1', 'Campus A'),
    ('C2', 'Campus B'),
    ('C3', 'Campus C');

-- Insert mock data into the Pavillon table
INSERT INTO Pavillon (Id_pavillon, nom_pavillon, Id_campus)
VALUES
    (1, 'Pavillon 1', 'C1'),
    (2, 'Pavillon 2', 'C1'),
    (3, 'Pavillon 3', 'C2'),
    (4, 'Pavillon 4', 'C2'),
    (5, 'Pavillon 5', 'C3');

-- Insert mock data into the Fonction_Local table
INSERT INTO Fonction_Local (ID_fonction, nom_fonction)
VALUES
    ('F1', 'Fonction 1'),
    ('F2', 'Fonction 2'),
    ('F3', 'Fonction 3');

-- Insert mock data into the Caractéristique_Local table
INSERT INTO Caractéristique_Local (ID_carac, nom_carac)
VALUES
    ('C1', 'Caractéristique 1'),
    ('C2', 'Caractéristique 2'),
    ('C3', 'Caractéristique 3');

-- Insert mock data into the Role table
INSERT INTO Role (ID_Role, nom_role)
VALUES
    ('R1', 'Role 1'),
    ('R2', 'Role 2'),
    ('R3', 'Role 3');

-- Insert mock data into the Local table
INSERT INTO Local (Id_local, Capacite, note, Id_pavillon)
VALUES
    ('L1', 100, 'Note 1', 1),
    ('L2', 150, 'Note 2', 2),
    ('L3', 200, 'Note 3', 3);

-- Insert mock data into the Faculté table
INSERT INTO Faculté (ID_facu, nom_facu, Id_pavillon)
VALUES
    ('FAC1', 'Faculté 1', 1),
    ('FAC2', 'Faculté 2', 2),
    ('FAC3', 'Faculté 3', 3);

-- Insert mock data into the Departement_ table
INSERT INTO Departement_ (ID_depart, nom_depart, ID_facu)
VALUES
    ('D1', 'Département 1', 'FAC1'),
    ('D2', 'Département 2', 'FAC1'),
    ('D3', 'Département 3', 'FAC2');

-- Insert mock data into the Usager table
INSERT INTO Usager (CIP, Nom_usager, courriel_usager, ID_depart)
VALUES
    ('U1', 'User 1', 'user1@example.com', 'D1'),
    ('U2', 'User 2', 'user2@example.com', 'D1'),
    ('U3', 'User 3', 'user3@example.com', 'D2');

-- Insert mock data into the A_role table
INSERT INTO A_role (CIP, ID_Role)
VALUES
    ('U1', 'R1'),
    ('U2', 'R2'),
    ('U3', 'R3');

-- Insert mock data into the Cubicule table
INSERT INTO Cubicule (Id_cubicule, Id_local)
VALUES
    ('CUB1', 'L1'),
    ('CUB2', 'L2'),
    ('CUB3', 'L3');

-- Insert mock data into the Reservation table
INSERT INTO Reservation (ID_reserv, date_debut, date_fin, Id_local, CIP)
VALUES
    ('RES1', '2023-05-23', '2023-05-25', 'L1', 'U1'),
    ('RES2', '2023-05-24', '2023-05-26', 'L2', 'U2'),
    ('RES3', '2023-05-25', '2023-05-27', 'L3', 'U3');

-- Insert mock data into the a_carac table
INSERT INTO a_carac (Id_local, ID_carac)
VALUES
    ('L1', 'C1'),
    ('L2', 'C2'),
    ('L3', 'C3');

-- Insert mock data into the a_fonction table
INSERT INTO a_fonction (Id_local, ID_fonction)
VALUES
    ('L1', 'F1'),
    ('L2', 'F2'),
    ('L3', 'F3');
