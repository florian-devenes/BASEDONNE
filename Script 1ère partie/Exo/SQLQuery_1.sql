-- ----------------------------------------------------------
-- ---------------------------------------------------------------------------
-- script :         schema.sql
-- database:        gestion_Chantier_metier.sql
-- contributors :   Florian DEVENES
--                  
-- history :        when       | ver | who | what
--                  2023-10-05 | 1.0 | Florian DEVENES | creation
                

-- ----------------------------------------------------------
-- ----------------------------------------------------------

USE master;

-- Cherche une BD appellée LocationBarqueLaVaudoise et la supprime le cas échéant
IF EXISTS(SELECT * FROM sys.databases WHERE NAME= 'gestion_chantier_metier')
DROP DATABASE gestion_chantier_metier;
GO

-- Crée la BD et l'utilise
CREATE DATABASE gestion_chantier_metier;
GO

USE gestion_chantier_metier;
GO





CREATE Database gestion_chantier_metier

--Création des Tables :


CREATE TABLE Ville (Nom VARCHAR(50) Not Null, Canton VARCHAR(50) not null);



CREATE TABLE Chantier (No INTEGER Not Null, VilleNom VARCHAR(50) Not Null, 
VilleCanton VARCHAR(50) Not Null, ResponsableNo INTEGER Not Null, 
ResidenceNom VARCHAR(50) not Null, Batiment VARCHAR(50) Not Null, 
Objet VARCHAR(50) Not Null );



CREATE TABLE Contrat (No Integer Not Null, ChantierNo Integer Not Null, 
Signataire VARCHAR(50) Not Null, OperationNom VARCHAR(50) Not Null, 
EntrepriseNom VARCHAR(50) Not Null, DateContrat DATE Not Null,
DateDebutTravaux DATE Not Null, DateFinTravaux DATE, 
MontantEstime REAL Not Null);




CREATE TABLE Employe ( No Integer not null, Nom VARCHAR(50) not null, 
Prenom VARCHAR(50) not null, DateDe DATE Not Null, 
DateA DATE);



CREATE TABLE Facture (No Integer not null, ContratNo Integer Not Null, 
EntrepriseNom VARCHAR(50) Not Null, DateFacturation DATE Not Null, 
MontantFacture REAL Not Null, Statut VARCHAR(50) Not Null);



CREATE TABLE Operation ( Nom VARCHAR(50) Not Null, Description VARCHAR(200) Not Null); --- à verif



CREATE TABLE Specialite ( OperationNom VARCHAR(50) Not Null, EntrepriseNom VARCHAR(50) Not Null);



CREATE TABLE Entreprise ( Nom VARCHAR(50) Not Null, Adresse VARCHAR(200) Not Null, 
NPA NUMERIC Not Null, Localite VARCHAR(50) Not Null, 
Telephone VARCHAR(50) Not Null);




--Création des clé primaires : 

Alter Table Ville 
ADD CONSTRAINT Ville_PK PRIMARY Key (Nom,Canton);

ALTER TABLE Chantier 
ADD CONSTRAINT Chantier_PK PRIMARY KEY (No);

ALTER TABLE Contrat 
ADD CONSTRAINT Contrat_PK PRIMARY KEY (No);

ALTER TABLE Employe 
ADD CONSTRAINT Employe_PK PRIMARY KEY (No);

ALTER TABLE Facture 
ADD CONSTRAINT Facture_PK PRIMARY KEY (No);

ALTER TABLE Operation 
ADD CONSTRAINT Operation_PK PRIMARY KEY (Nom);

ALTER TABLE Entreprise 
ADD CONSTRAINT Entreprise_PK PRIMARY KEY (Nom);


ALTER TABLE Specialite 
ADD CONSTRAINT Specialite_PK PRIMARY KEY (OperationNom, EntrepriseNom);





-- création des clé étrangères: 

Alter Table Chantier 
ADD CONSTRAINT Chantier_FK1 FOREIGN KEY (VilleNom,VilleCanton) REFERENCES Ville,
CONSTRAINT Chantier_FK2 FOREIGN KEY (ResponsableNo) REFERENCES Employe,
CONSTRAINT Chantier_FK3 FOREIGN KEY (ResponsableNo) REFERENCES Contrat;


Alter Table Contrat 
ADD CONSTRAINT Contrat_FK1 FOREIGN KEY (ChantierNo) REFERENCES Chantier,
CONSTRAINT Contrat_FK2 FOREIGN KEY (Signataire) REFERENCES Employe,
CONSTRAINT Contrat_FK3 FOREIGN KEY (OperationNom) REFERENCES Specialite,
CONSTRAINT Contrat_FK4 FOREIGN KEY (OperationNom) REFERENCES Operation,
CONSTRAINT Contrat_FK5 FOREIGN KEY (EntrepriseNon) REFERENCES Entreprise,
CONSTRAINT Contrat_FK5 FOREIGN KEY (EntrepriseNon) REFERENCES Specialite;


Alter Table Facture 
ADD CONSTRAINT Facture_FK1 FOREIGN KEY (ContratNo) REFERENCES Contrat,
CONSTRAINT Facture_FK2 FOREIGN KEY (EntrepriseNom) REFERENCES Specialite,
CONSTRAINT Facture_FK3 FOREIGN KEY (EntrepriseNom) REFERENCES Entreprise,
CONSTRAINT Facture_FK4 FOREIGN KEY (EntrepriseNom) REFERENCES Contrat;


Alter Table Specialite 
ADD CONSTRAINT Specialite_FK1 FOREIGN KEY (OperationNom) REFERENCES Operation,
CONSTRAINT Specialite_FK2 FOREIGN KEY (OperationNom) REFERENCES Contrat,
CONSTRAINT Specialite_FK3 FOREIGN KEY (EntrepriseNom) REFERENCES Entreprise,
CONSTRAINT Specialite_FK4 FOREIGN KEY (EntrepriseNom) REFERENCES Contrat,
CONSTRAINT Specialite_FK5 FOREIGN KEY (EntrepriseNom) REFERENCES Facture;

