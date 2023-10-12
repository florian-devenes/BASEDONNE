-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Script :        FlixNet_ScriptSchema.sql
-- Database:       FlixNet
-- Date de maj :   14 nov. 2019
-- Version :       2.0
-- Auteur :        Mathias Oberson (MON)
-- Contributeurs : Gabor Maksay (GMY), Arthur Verdon (AVD)
-- Modif :         Création du fichier / MON
--                 Ajout compatibilité SQL Server avec les GO
--                 Extrait contraintes dans propre fichier
--				   Modification des colonnes dans Trailer

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Création de la BD sur SQLServer
USE master;

-- Cherche une BD appellée FlixNet et la supprime le cas échéant
IF EXISTS(SELECT * FROM sys.databases WHERE NAME='FlixNet')
DROP DATABASE FlixNet;
GO

-- Crée la BD et l'utilise
CREATE DATABASE FlixNet;
GO

USE FlixNet;
GO

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Création des tables

-- Table Langue
CREATE TABLE Langue (
  Nom VARCHAR(50) NOT NULL
);
GO

-- Table Langue-Contenu
CREATE TABLE LngCnt (
  LngNom VARCHAR(50) NOT NULL,
  CntTitre VARCHAR(140) NOT NULL
);
GO

-- Table Genre-Contenu
CREATE TABLE GnrCnt (
  GnrTitre VARCHAR(50) NOT NULL,
  CntTitre VARCHAR(140) NOT NULL
);
GO

-- Table Genre
CREATE TABLE Genre (
  Nom VARCHAR(50) NOT NULL
);
GO

-- Table Review
CREATE TABLE Review (
  Sujet VARCHAR(255) NOT NULL,
  CntTitre VARCHAR(140) NOT NULL,
  CmpPseudo VARCHAR(50) NOT NULL,
  Texte TEXT NOT NULL,
  NbEtoiles INTEGER NOT NULL, -- Entre 1 et 5
  DatePublication DATE NOT NULL
);
GO

-- Table Contenu
CREATE TABLE Contenu (
  Titre VARCHAR(140) NOT NULL,
  Descriptif VARCHAR(255) NOT NULL,
  Realisateur VARCHAR(140) NOT NULL,
  Producteur VARCHAR(140) NOT NULL,
  CtgAgeNom VARCHAR(50) NOT NULL
);
GO

-- Table Documentaire
CREATE TABLE Documentaire (
  CntTitre VARCHAR(140) NOT NULL,
  Type VARCHAR(20) NOT NULL, -- nature, musique, politique et social
  DateAjout DATE NOT NULL
);
GO

-- Table Compte
CREATE TABLE Compte (
  Pseudo VARCHAR(50) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  MotDePasse VARCHAR(255) NOT NULL,
  Abonnement VARCHAR(20) NOT NULL, -- light, premium ou gold
  NbEcransSimultanes INTEGER NOT NULL -- Supérieur à 0
);

-- Table SerieTV
CREATE TABLE SerieTV (
  CntTitre VARCHAR(140) NOT NULL
);

-- Table Film
CREATE TABLE Film (
  CntTitre VARCHAR(140) NOT NULL,
  DateAjout DATE NOT NULL  
);
GO

-- Table Acteur-Film
CREATE TABLE ActFilm (
  FilmCntTitre VARCHAR(140) NOT NULL,
  ActNom VARCHAR(50) NOT NULL,
  ActPrenom VARCHAR(50) NOT NULL
);
GO

-- Table Acteur
CREATE TABLE Acteur (
  Nom VARCHAR(50) NOT NULL,
  Prenom VARCHAR(50) NOT NULL
);

-- Table Profil
CREATE TABLE Profil (
  Nom VARCHAR(50) NOT NULL,
  CtgAgeNom VARCHAR(50) NOT NULL,
  Langue VARCHAR(50) NOT NULL,
  Enfant BIT,
  CmpPseudo VARCHAR(50) NOT NULL
);
GO

-- Table Saison
CREATE TABLE Saison (
  No INTEGER NOT NULL,
  STVCntTitre VARCHAR(140) NOT NULL,
  Duree INTEGER NOT NULL -- En nombre de secondes, supérieur à 0
);
GO

-- Table Trailer
CREATE TABLE Trailer (
  Titre VARCHAR(140) NOT NULL,
  Langue VARCHAR(50) NOT NULL,
  Duree INTEGER NOT NULL, -- En nombre de secondes, supérieur à 0
  FilmCntTitre VARCHAR(140) ,
  SsnNo INTEGER,
  SsnSTVCntTitre VARCHAR(140)
);
GO

-- Table CategorieAge
CREATE TABLE CategorieAge (
  Nom VARCHAR(50) NOT NULL,
  AgeDe INTEGER NOT NULL, -- Supérieur à 0
  AgeA INTEGER NOT NULL -- Supérieur à AgeDe
);
GO

-- Table Episode
CREATE TABLE Episode (
  No INTEGER NOT NULL,
  SsnNo INTEGER NOT NULL,
  SsnSTVCntTitre VARCHAR(140) NOT NULL,
  Titre VARCHAR(140) NOT NULL,
  Duree INTEGER NOT NULL, -- En nombre de secondes, supérieur à 0
  DateAjout DATE NOT NULL,
  EpsNo INTEGER,
  EpsSsnNo INTEGER,
  EpsSsnSTVCntTitre VARCHAR(140)
);
GO

-- Table Acteur-Episode
CREATE TABLE ActEps (
  EpsNo INTEGER NOT NULL,
  EpsSsnNo INTEGER NOT NULL,
  EpsSsnSTVCntTitre VARCHAR(140) NOT NULL,
  ActNom VARCHAR(50) NOT NULL,
  ActPrenom VARCHAR(50) NOT NULL
);
GO

-- ----------------------------------------------------------
-- Cles primaires

ALTER TABLE Langue ADD
  CONSTRAINT langue_pk PRIMARY KEY (Nom);
GO

ALTER TABLE LngCnt ADD
  CONSTRAINT langue_contenu_pk PRIMARY KEY (LngNom, CntTitre);
GO

ALTER TABLE GnrCnt ADD
  CONSTRAINT genre_contenu_pk PRIMARY KEY (GnrTitre, CntTitre);
GO

ALTER TABLE Genre ADD
  CONSTRAINT genre_pk PRIMARY KEY (Nom);
GO

ALTER TABLE Review ADD
  CONSTRAINT review_pk PRIMARY KEY (Sujet, CntTitre, CmpPseudo);
GO

ALTER TABLE Contenu ADD
  CONSTRAINT contenu_pk PRIMARY KEY (Titre);
GO

ALTER TABLE Documentaire ADD
  CONSTRAINT documentaire_pk PRIMARY KEY (CntTitre);
GO

ALTER TABLE Compte ADD
  CONSTRAINT compte_pk PRIMARY KEY (Pseudo);
GO

ALTER TABLE SerieTV ADD
  CONSTRAINT serie_tv_pk PRIMARY KEY (CntTitre);
GO

ALTER TABLE Film ADD
  CONSTRAINT film_pk PRIMARY KEY (CntTitre);
GO

ALTER TABLE ActFilm ADD
  CONSTRAINT acteur_film_pk PRIMARY KEY (FilmCntTitre, ActNom, ActPrenom);
GO

ALTER TABLE Acteur ADD
  CONSTRAINT acteur_pk PRIMARY KEY (Nom, Prenom);
GO

ALTER TABLE Profil ADD
  CONSTRAINT profil_pk PRIMARY KEY (Nom, CtgAgeNom, CmpPseudo);
GO

ALTER TABLE Saison ADD
  CONSTRAINT saison_pk PRIMARY KEY (No, STVCntTitre);
GO

ALTER TABLE Trailer ADD
  CONSTRAINT trailer_pk PRIMARY KEY (Titre);
GO

ALTER TABLE CategorieAge ADD
  CONSTRAINT categorie_age_pk PRIMARY KEY (Nom);
GO

ALTER TABLE Episode ADD
  CONSTRAINT episode_pk PRIMARY KEY (No, SsnNo, SsnSTVCntTitre);
GO

ALTER TABLE ActEps ADD
  CONSTRAINT acteur_episode_pk PRIMARY KEY (EpsNo, EpsSsnNo, EpsSsnSTVCntTitre, ActNom, ActPrenom);
GO

-- ----------------------------------------------------------
-- Création des clés étrangères

ALTER TABLE Contenu ADD
  CONSTRAINT contenu_categorie_age_fk FOREIGN KEY (CtgAgeNom) REFERENCES CategorieAge;
GO

ALTER TABLE LngCnt ADD
  CONSTRAINT lngcnt_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu,
  CONSTRAINT lngcnt_langue_fk FOREIGN KEY (LngNom) REFERENCES Langue;
GO  

ALTER TABLE GnrCnt ADD
  CONSTRAINT gnrcnt_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu,
  CONSTRAINT gnrcnt_genre_fk FOREIGN KEY (GnrTitre) REFERENCES Genre;
GO  

ALTER TABLE Documentaire ADD
  CONSTRAINT documentaire_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu;
GO  

ALTER TABLE SerieTV ADD
  CONSTRAINT serie_tv_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu;
GO  

ALTER TABLE Film ADD
  CONSTRAINT film_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu;
GO  

ALTER TABLE Review ADD
  CONSTRAINT review_contenu_fk FOREIGN KEY (CntTitre) REFERENCES Contenu,
  CONSTRAINT review_compte_fk FOREIGN KEY (CmpPseudo) REFERENCES Compte;
GO  

ALTER TABLE Profil ADD
  CONSTRAINT profil_compte_fk FOREIGN KEY (CmpPseudo) REFERENCES Compte,
  CONSTRAINT profil_categorie_age_fk FOREIGN KEY (CtgAgeNom) REFERENCES CategorieAge;
GO  

ALTER TABLE ActFilm ADD
  CONSTRAINT actfilm_acteur_fk FOREIGN KEY (ActNom, ActPrenom) REFERENCES Acteur,
  CONSTRAINT actfilm_film_fk FOREIGN KEY (FilmCntTitre) REFERENCES Film;
GO  

ALTER TABLE Saison ADD
  CONSTRAINT saison_serie_tv_fk FOREIGN KEY (STVCntTitre) REFERENCES SerieTV;
GO  

ALTER TABLE Trailer ADD
  CONSTRAINT trailer_saison_fk FOREIGN KEY (SsnNo, SsnSTVCntTitre) REFERENCES Saison,
  CONSTRAINT trailer_film_fk FOREIGN KEY (FilmCntTitre) REFERENCES Film;
GO  

ALTER TABLE Episode ADD
  CONSTRAINT episode_saison_fk FOREIGN KEY (SsnNo, SsnSTVCntTitre) REFERENCES Saison,
  CONSTRAINT episode_precedent_fk FOREIGN KEY (EpsNo, EpsSsnNo, EpsSsnSTVCntTitre) REFERENCES Episode;
GO  

ALTER TABLE ActEps ADD
  CONSTRAINT acteps_acteur_fk FOREIGN KEY (ActNom, ActPrenom) REFERENCES Acteur,
  CONSTRAINT acteps_episode_fk FOREIGN KEY (EpsNo, EpsSsnNo, EpsSsnSTVCntTitre) REFERENCES Episode;
GO  
