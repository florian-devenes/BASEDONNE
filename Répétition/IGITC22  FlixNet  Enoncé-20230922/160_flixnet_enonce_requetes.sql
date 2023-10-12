-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Script :        FlixNet_ScriptRequetes_SQLServer.sql
-- Database:       FlixNet
-- Modif :         10.12.19 / création / gabor

USE Flixnet;

-- ----------------------------------------------------------
-- Tables

SELECT *
FROM   Acteur



SELECT *
FROM   CategorieAge;

SELECT * 
FROM   Compte;

SELECT *
FROM   Contenu;

SELECT *
FROM   Documentaire;

SELECT *
FROM   Episode;

SELECT *
FROM   Film;

SELECT *
FROM   Genre;

SELECT *
FROM   Langue;

SELECT *
FROM   Profil;

SELECT *
FROM   Review;

SELECT *
FROM   Saison;

SELECT *
FROM   SerieTV;

SELECT *
FROM   Trailer;

-- ----------------------------------------------------------
-- Chapitre Tables

-- 1.
-- Titres de contenu, sujets de revue rédigées par le pseudo
-- 'aagglione1'pour lesquels le sujet ne commence pas par 'Nul'
Select CntTitre, Sujet
From Compte

Inner join Review on CmpPseudo = Pseudo

where 
Sujet Not like 'Nul%' 
and Pseudo = 'aagglione1'


-- ----------------------------------------------------------
-- Chapitre Clés étrangères

-- 1.
-- Tranche d'âge pour laquelle le film intitulé 'Ascension' est-il recommandé ?
Select Titre, AgeDe,AgeA
From Film

inner join Contenu on CntTitre = Titre
inner join CategorieAge on Nom = CtgAgeNom

Where Titre = 'Ascension' 

-- 2.
-- Pseudos qui commencent par la lettre 'o' et  qui ont placé 
-- un review sur un contenu dont le genre est 'Fantasy'
select distinct Pseudo
from Compte

inner join Review as R on pseudo = CmpPseudo
inner Join GnrCnt as Gnr on Gnr.CntTitre = R.CntTitre
inner join Genre on Nom = GnrTitre

Where Genre.Nom = 'Fantasy' 
and Compte.Pseudo like 'o%'



-- 3.
-- Sujet de review du documentaire 'All in a Night's Work'
-- Version longue car possible de trouver la réponse avec une seule table
select distinct Re.Sujet
from Documentaire

inner join Contenu as C on CntTitre = Titre
inner join Review as Re on  Titre = Re.CntTitre

where Titre = 'All in a Night''s work'


-- Version courte dans la mesure où il n'est pas possible de créer
-- deux contenus avec le même titre et que la clé primaire de la
-- table Documentaire se trouve être la clé étrangère sur la table
-- Contenu
-- A COMPLETER

select distinct review.sujet
from review
where review.CntTitre = 'All in a Night''s Work'

-- ----------------------------------------------------------
-- Chapitre Formes normales

-- 1.
-- Titres des films tournés par l'actrice Onida Barbosa qui ne
-- soient pas de la catégorie d'âge 'No restrictions: Suitable for all ages'
select Titre
from Contenu 

Inner Join Film on Titre = CntTitre
inner Join ActFilm on FilmCntTitre = CntTitre
inner join Acteur on ActNom = Nom 
and ActPrenom = Prenom

Where Acteur.Nom = 'Barbosa' 
and CtgAgeNom <> 'No restrictions: Suitable for all ages'



-- 2.
-- Pseudos qui commencent par la lettre 'o' et  qui n'ont jamais 
-- placé un review sur un contenu dont le genre est 'Fantasy'
select distinct pseudo
from Compte

inner join Review as Re on pseudo = CmpPseudo
inner Join GnrCnt as Gnr on Re.CntTitre = Gnr.CntTitre
inner join Genre on Nom = GnrTitre

Where Genre.Nom =  'Fantasy' 
and Compte.Pseudo not like 'o%'

-- 3.
-- Episode(s) de la 1re saison de la série TV intitulée 'Black Mirror' 
-- dans le(s)quel(s) Tedie Connors n'a pas tourné
Select distinct E.No, S.No, SerieTV.CntTitre
From SerieTV

Inner Join Contenu as C on CntTitre = Titre
Inner join Saison as S on SerieTV.CntTitre = STVCntTitre
inner join Episode as E on S.No = E.ssnNo 
and STVCntTitre = EpsSsnSTVCntTitre
Inner join ActEps as Act on Act.EpsNo = E.EpsNo 
and E.EpsSsnNo = Act.EpsSsnNo 
and E.EpsSsnSTVCntTitre = Act.EpsSsnSTVCntTitre
Inner Join Acteur as A on Nom = Act.ActNom 
and A.Prenom = act.ActPrenom 

Where C.Titre = 'Black Mirror' 
and S.No = 1 
and A.Nom Not like 'Connors'--- à verif car pas même rep que corrigé :(



-- 4.
-- Quel acteur (ou actrice) a joué dans tous les épisodes de
-- la saison 1 de la série TV 'Black Mirror'
--
-- Acteur tel qu'il n'existe pas un épisode de la saison 1
-- de la série TV 'Black Mirror' dans lequel il n'a pas joué
Select*
From SerieTV

Inner Join Contenu on CntTitre = Titre
Inner join Saison as S on CntTitre = S.STVCntTitre
inner join Episode as E on S.No = E.ssnNo 
and STVCntTitre = EpsSsnSTVCntTitre
Inner join ActEps as Act on Act.EpsNo = E.EpsNo 
and E.EpsSsnNo = Act.EpsSsnNo 
and E.EpsSsnSTVCntTitre = Act.EpsSsnSTVCntTitre

Where Contenu.Titre = 'Black Mirror' 
and S.No = 1 
 --- faire la suite encore


-- ----------------------------------------------------------
-- Chapitre Héritage et cycles

-- 1.
-- Titre des films avec leur langue diffusion, classé par producteur 
select CntTitre, LngNom, Producteur 
from Contenu

inner join LngCnt on Titre = CntTitre
Inner join Langue on LngNom = Nom
inner join Film on Contenu.titre = Film.CntTitre

Order by Producteur


-- 2.
-- Titre de l'épisode qui suit l'épisode initulé 'White Bear'
-- de la saison 2 de la série TV 'Black Mirror'
Select Distinct(E.EpsNo), E.Titre
From SerieTV

Inner Join Contenu on CntTitre = Titre
Inner join Saison as S on CntTitre = S.STVCntTitre
inner join Episode as E on S.No = E.ssnNo 
and STVCntTitre = EpsSsnSTVCntTitre
Inner join ActEps as Act on Act.EpsNo = E.EpsNo 
and E.EpsSsnNo = Act.EpsSsnNo 
and E.EpsSsnSTVCntTitre = Act.EpsSsnSTVCntTitre

Where Contenu.Titre = 'Black Mirror' and S.No = 2 and E.no>1 
order by EpsNo
Fetch First 1 raw only


--Select Max(no) - 2 
--from Episode
--Where ssn...

-- 3.
-- Titre de l'antépénultième épisode de la saison 4 de la série TV 'Black Mirror'
-- déf. antépénultième : qui précède l'avant-dernier
Select E.Titre,E.No
From SerieTV as Se


Inner Join Contenu on CntTitre = Titre
Inner join Saison as S on CntTitre = S.STVCntTitre
Inner join Episode as E on S.No = E.ssnNo 
and STVCntTitre = EpsSsnSTVCntTitre
Inner join ActEps as Act on Act.EpsNo = E.EpsNo 
and E.EpsSsnNo = Act.EpsSsnNo 
and E.EpsSsnSTVCntTitre = Act.EpsSsnSTVCntTitre

Where Contenu.Titre like 'Black Mirror' 
and  S.No = 4  ---and E.no = E.No-1

Group by E.Titre,E.No
Order by E.No







-- ----------------------------------------------------------
-- Chapitre Contraintes

-- 1.
-- CI : La somme des durées des épisodes de la 1re saison
--      d'une série TV doit être égale à la durée de cette
--      saison pour cette série TV.
--
-- Titre des séries TV dont la durée de la saison 1 diffère
-- de la somme des durées des épisodes de cette série pour 
-- la saison 1.
--
Select S.No, S.Duree as "durée de la saison", S.STVCntTitre, SUM(Episode.Duree) as "Somme durée épisodes"
from saison as S

inner join Episode on SsnNo = S.No 
and SsnSTVCntTitre = STVCntTitre

Group by S.No,S.STVCntTitre,S.Duree
Having S.Duree <> Sum(Episode.Duree)



-- ----------------------------------------------------------
-- Chapitre Entrepôt de données

-- 1.
-- Nombre de saison(s) par titre de série TV
Select Count ( STVCntTitre), CntTitre
From Saison as Sa

Inner join SerieTV as S on Sa.STVCntTitre = S.CntTitre 

Group by S.CntTitre


-- 2.
-- Nombre de reviews par type d'abonnement
Select Count(R.NbEtoiles), C.Abonnement
From Review as R

Inner Join Compte as C on C.Pseudo = R.CmpPseudo

Group By C.Abonnement
Order by Abonnement

-- 3.
-- Nombre d'épisode(s) par saison pour chaque série TV
Select Count(E.No),E.SsnSTVCntTitre, E.SsnNo
From Episode as E

Inner Join Saison as S On S.No = E.SsnNo
and S.STVCntTitre = E.SsnSTVCntTitre
Inner join SerieTV on CntTitre = S.STVCntTitre
Group By S.No
Order By E.SsnNo-- je dois passer à coté de qqch...



