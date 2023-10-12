-- -----------------------------------------------------------------------------
--
-- Script de vérification de l'installation de SQL Server 2016 Developer Edition
-- Auteur : Mathias Oberson
-- Date   : 16/11/2016
--
-- Peut-être lancé tout d'un coup, ou instruction après instruction
-- -----------------------------------------------------------------------------

-- Contexte : master
USE master;

-- Création de la base de données 'verif'
CREATE DATABASE verif
GO

-- Contexte : verif
USE verif;

-- Create de la table 'install' avec 1 colonne de type BIT (= Boolean)
CREATE TABLE install (IsOK BIT NOT NULL)
GO

-- Insertion d'une ligne dans la table 'install'
INSERT INTO install VALUES (1);

-- Affichage de la table 'install'
SELECT *
FROM install;

-- Contexte : master
USE master;

-- Suppression de la base de données 'verif'
DROP DATABASE verif;