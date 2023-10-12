-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- script :         queries.sql
-- database:        location_barque_la_vaudoise
-- contributors :   Gabor Maksay (gmy)
--                  Olivier Moullet (omt)
--                  Mahtias Oberson (mon)
-- history :        when       | ver | who | what
--                  2019-01-08 | 2.0 | mon | compliance
--                  2017-xx-xx | 1.0 | omt | creation


-- ---------------------------------------------------------------------------
-- --------------------------------------------- Classes (DaI) et Tables (BD)

-- 1. Les différents NPA des localités par ordre croissant.

select distinct(Localite.npa)
from Localite
order by(localite.Npa) ASC



-- 2. Les numéros des factures - ainsi que leur statut - supérieures à 
-- 1'000 CHF qui n'ont pas été payées.

select facture.No, Facture.statut
from facture
where facture.MontantBrut > 1000 
and Facture.Statut <> 'payée'



-- 3. Les noms des entreprises de type SA, triés par ordre alphabétique.

select*
from Entreprise
where Entreprise.Type = 'SA' 
order by Entreprise.Nom


-- 4. Les numéros de facture pour lesquelles le montant d'une ligne de facture 
-- n'est pas égal à la multiplication de la quantité par son prix unitaire, 
-- affichés sans doublon et par ordre croissant des numéros de facture.

select ligne.FactureNo
from Facture
inner join Ligne on Ligne.No = Facture.No
where Ligne.Montant <> (Ligne.Qte*Ligne.PrixUnitaire)
Order by Facture.No ASC


-- ---------------------------------------------------------------------------
-- ------------------------------- Associations (DaI) et Clés étrangères (BD)

-- 1. Les différents NPA - affichés par ordre croissant - des localités des 
-- personnes physiques ayant effectué une réservation.

select Localite.NPA as npa
from Localite
Inner join Adresse on Adresse.No = Localite.No
Inner join Entite on Entite.No = Adresse.EntiteNo
Inner join PP On PP.EntiteNo = Entite.No
Inner Join Reservation on Reservation.EntiteNo = PP.EntiteNo
Order By Localite.NPA 

--Problème dans les inner join


-- 2. Les numéros des factures ainsi que le nom et le prénom des personnes 
-- physiques destinataires de factures supérieures à 1'000 CHF et qui n'ont 

select Facture.No as FactureNO, Facture.Statut as FactureStatut, PP.Nom as DestinataireNom,PP.Prenom as DestinatairePrenom
from facture
Inner join Entite On Entite.No = Facture.EntiteNo
Inner Join PP on PP.EntiteNo = Entite.No
where facture.MontantBrut > 1000 
and Facture.Statut <> 'payée'


-- 3. Les noms des entreprises de type SA - affichées par ordre alphabétique - 
-- ainsi que les nom et prénom de leur(s) contact(s).

select Entreprise.Nom as EntrepriseNom, PP.Nom as ContactNom,PP.Prenom as ConntactPrenom
from Entreprise
Inner Join Contact On Contact.EntrepriseentiteNo= Entreprise.EntiteNo
Inner join PP on PP.EntiteNo = Contact.PPEntiteNo
where Entreprise.Type = 'SA' 
order by Entreprise.Nom

-- 4. Les numéros des factures payées qui sont destinées à une entreprise, 
-- avec le nom de l'entreprise, ainsi que le nom et le prénom du contact 
-- de cette dernière.

select Facture.No as FactureNO, Facture.Statut as FactureStatut, Entreprise.Nom as EntrepriseNom, PP.Nom as DestinataireNom,PP.Prenom as DestinatairePrenom
from Facture
Inner Join Entite on Entite.No = Facture.EntiteNo
Inner Join Entreprise on Entreprise.EntiteNo = Entite.No
Inner Join Contact On Contact.EntrepriseentiteNo= Entreprise.EntiteNo
Inner join PP on PP.EntiteNo = Contact.PPEntiteNo
Where statut = 'Payée'


-- 5. Les numéros de factures et les numéros de sorties associés pour 
-- lesquels la quantité de la ligne de facture multiplié par son prix 
-- unitaire n'est pas égal au montant de cette ligne, affichés par ordre 
-- croissant de no de facture et sans doublon.

select Ligne.FactureNo, Sortie.No
from Facture
inner join Ligne on Ligne.No = Facture.No
inner join Sortie on Sortie.No = Facture.SortieNo
Inner join Reservation on Reservation.SortieNo = Sortie.No
where Ligne.Montant <> (Ligne.Qte*Ligne.PrixUnitaire)
Order by Facture.No ASC

--we got a problem jackson



-- ---------------------------------------------------------------------------
-- --------------------------------- Validation (DaI) et Formes normales (BD)

-- 1. Le numéro des sorties étant sous contrat, mais n'ayant pas de facture associée.

select sortie.No, Sortie.Type
from Facture
inner join Sortie on Sortie.No = Facture.SortieNo
inner join Contrat on Contrat.No = Sortie.No

Where not exists( Select Facture.No,Sortie.No
From Facture
Inner join Sortie On Sortie.No = Facture.SortieNo
Where Sortie.No = Contrat.SortieNo)

---- à revoir!

-- 2. Les numéros d'entité n'étant ni des personnes physiques ni des personnes 
-- morales (entreprises).

Select*
From Entite
Where Not exists(Select*
From Entite
Inner join Entreprise on Entreprise.EntiteNo = Entite.No
Inner join PP on PP.EntiteNo = Entite.No)

-- 3. Les numéros d'entité des entreprises qui ont une personne physique de 
-- contact, mais que celle-ci n'a pas encore signé de contrat.

select Entreprise.EntiteNo
from Entreprise

where exists(select statut
from contrat
inner join contact on Contrat.PPEntiteNo = Contact.PPEntiteNo
inner join pp on PP.EntiteNo = Contact.EntrepriseentiteNo
Where contrat.PPEntiteNo <> PP.EntiteNo)

---à revoir


-- 4. Le nom des localités qui ont été au moins une fois le port de départ 
-- ou d'arrivée d'une sortie de la barque autre que son port habituel de Lausanne.

select*
from sortie
inner join localite on localite.no = Sortie.PortDepart

select*
from sortie
inner join localite on localite.no = Sortie.PortDepart

--- à paufiner

-- 5. Les numéros d'entité pour les entités qui sont à la fois entreprise et 
-- personne physique. 
-- A COMPLETER

select Entite.No
from Entite
where not exists ( select* 
From entite 
inner join Entreprise on Entreprise.EntiteNo = Entite.No
Inner Join PP on PP.EntiteNo = Entite.No 
Where Entreprise.EntiteNo <> Pp.EntiteNo)


-- ---------------------------------------------------------
-- Chapitre Héritage et cycles

-- 1. Les adresses complètes de toutes les personnes physiques, 
-- affichées par ordre alphabétique des noms, puis prénoms.

Select PP.Nom as nom, PP.Prenom as prenom, adresse.Ligne1 as adresse, Adresse.NoRue as norue
From Adresse
Inner join Entite on Entite.no = Adresse.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No

Order by PP.Nom 

Select PP.Prenom
From Adresse
Inner join Entite on Entite.no = Adresse.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No

Order by PP.Prenom 

-- 2. Les adresses complètes de toutes les entreprises, affichées 
-- par ordre alphabétique des noms d'entreprise.

Select Entreprise.Nom, Adresse.Ligne1 as adresse, Adresse.NoRue as norue
From Adresse
Inner join Entite on Entite.no = Adresse.EntiteNo
Inner join Entreprise on Entreprise.EntiteNo = Entite.No

order by Entreprise.Nom

select* from adresse
-- 3. Le numéro de l'entité qui a réservé la sortie précédent la sortie 14.

Select Facture.EntiteNo
From sortie
Inner join Facture on Facture.SortieNo = Sortie.No
where (Sortie.Precedente  +2) = 14

--Revoir

-- 4. Le numéro, le nom et le prénom de la personne physique ayant signé 
-- un contrat pour la sortie précédent la sortie 114.

Select *
From Facture
Inner join Entite on Entite.No = facture.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No
Inner join Sortie on Facture.SortieNo = Sortie.No

where (sortie.precedente +2) = 144

--revoir l'innerjoin
-- ---------------------------------------------------------------------------
-- -------------------------------------- Contraintes d'intégrité (DaI et BD)

-- 1. CI Initiale : "Le montant brut d’une facture est égal à la somme des 
-- montants de chaque ligne qui la compose."
-- Ce qui revient à trouver
-- Le numéro de facture, le montant brut et la somme des montants des lignes 
-- pour les factures dont le montant brut est différent de la somme des montants 
-- des lignes qui les composent.

Select Distinct Facture.no,Facture.MontantBrut, Sum(Ligne.Qte*Ligne.PrixUnitaire) as TotalLigne
From Facture
Inner join Ligne on  Facture.No = Ligne.FactureNo 
Group by Facture.MontantBrut,Ligne.Qte, LIGNE.PrixUnitaire,Facture.No
having Ligne.Qte*Ligne.PrixUnitaire <> Facture.MontantBrut
Order by Facture.No



--- problème : des no factures apparaissent deux foix malgré le distinct, les no.factures ne sont pas les mêmes que dans le corrigé


-- 2. CI Initiale : "Si le type d'une sortie est égal à 'commercial', 
-- alors cette sortie est confirmée par un contrat signé par une personne physique 
-- qui effectue une réservation concernant cette sortie, ou signé par une personne 
-- physique qui représente une personne morale qui effectue une réservation concernant 
-- cette sortie.
-- Ce qui revient à trouver
-- Les sorties de type 'commercial' dont le contrat a été signé par une personne 
-- physique mais qui n'aurait pas effectué de réservation pour cette sortie ou qui 
-- a été signé par une personne physique contact d'une entreprise qui n'aurait pas 
-- effectué de réservation pour cette sortie.
Select Sortie.No
From Sortie
Where sortie.type = 'commercial'
Inner join Reservation on Reservation.SortieNo = Sortie.No
Inner join Entite on Entite.no = Reservation.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No
Inner join Contrat on Contrat.PPEntiteNo = PP.EntiteNo
Group By Contrat.Statut, PP.EntiteNo, Contrat.PPEntiteNo,Reservation.EntiteNo
Having 

-- je ne vois pas trop -> regarder corrigé, simple à comprendre


-- 3. CI Initiale : Si une sortie dont le type est ‘commercial’ fait l’objet 
-- d’une réservation qui est effectuée par une entité qui est une personne physique, 
-- alors cette sortie nécessite un contrat qui est signé par cette personne physique.
-- Ce qui revient à trouver
-- Les sorties de type 'commercial' qui font l'objet d'une réservation effectuée par 
-- une personne physique autre que celle qui a signé le contrat de cette sortie.

Select Sortie.Type
From Sortie
Inner join Reservation on Reservation.SortieNo = Sortie.No
Inner join Entite on Entite.no = Reservation.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No
Inner join Contrat on Contrat.PPEntiteNo = PP.EntiteNo
Group by  Reservation.EntiteNo, Contrat.PPEntiteNo, Sortie.Type
Having Contrat.PPEntiteNo <> Reservation.EntiteNo 
and Sortie.Type = 'Commercial'

Select* from sortie
Select* from Contrat
Select*from Reservation

-- je suis un peu perdu j''avoue

-- 4. CI Initiale : Si une sortie dont le type est 'commercial' qui nécessite un contrat 
-- dont le statut est ‘signé’ qui est signé par une personne physique et que cette sortie 
-- fait l’objet d’une réservation qui est effectuée par une entreprise, alors elle fait 
-- l’objet d’une facture qui est adressée à la personne physique qui est personne de contact 
-- de cette entreprise et qui a signé ce contrat.
-- Ce qui revient à trouver
-- Les sorties signées par une personne physique, dont le statut de contrat est 'signé', 
-- faisant l'objet d'une réservation effectuée par une entreprise, respectivement d'une 
-- facture adressée à une personne physique contact de cette entreprise mais différente 
-- de celle qui a signé le contrat.

Select*
From Sortie
Inner join Reservation on Reservation.SortieNo = Sortie.No
Inner join Entite on Entite.no = Reservation.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No
Inner join Contrat on Contrat.PPEntiteNo = PP.EntiteNo
inner join Contact on Contact.PPEntiteNo = Contrat.PPEntiteNo
Inner join Facture on Facture.SortieNo = Sortie.no
Group By  Contrat.Statut, Sortie.Designation,Facture.EntiteNo,Contact.PPEntiteNo,Contrat.PPEntiteNo
Having Contrat.Statut = 'signé' and Sortie.Designation = 'Sortie Entreprise' 
and Facture.EntiteNo = Contact.PPEntiteNo and Contact.PPEntiteNo <> Contrat.PPEntiteNo





-- 5. CI Initiale : Si une sortie dont le type est ‘commercial’ qui nécessite un contrat 
-- dont le statut est ‘signé’ qui est signé par une personne physique et que cette sortie 
-- fait l’objet d’une réservation qui est effectuée par cette personne physique, alors elle 
-- fait l’objet d’une facture qui est adressée à cette personne physique.
-- Ce qui revient à trouver
-- Les sorties de type 'commercial' qui ont un contrat - dont le statut est 'signé' - 
-- signé par une personne physique et dont la réservation est effectuée par cette même 
-- personne physique, sorties qui auraient une facture associée à une autre personne physique.

Select Distinct Sortie.No
From Sortie
Inner join Reservation on Reservation.SortieNo = Sortie.No
Inner join Entite on Entite.no = Reservation.EntiteNo
Inner join PP on PP.EntiteNo = Entite.No
Inner join Contrat on Contrat.PPEntiteNo = PP.EntiteNo
Inner Join Facture On Facture.EntiteNo =Entite.No
Group by Sortie.Type, Sortie.No, Contrat.Statut,Reservation.EntiteNo,Contrat.PPEntiteNo,Facture.EntiteNo
Having Sortie.Type = 'Commercial' 
and Contrat.Statut = 'signé' 
and Reservation.EntiteNo = Contrat.PPEntiteNo
and Facture.EntiteNo <> Contrat.PPEntiteNo





-- 6. CI Initiale : Si une personne physique signe un contrat, alors elle est âgée 
-- de 18 ans au moins.
-- Ce qui revient à trouver
-- Les personnes physiques de moins de 18 ans qui ont signé un contrat. 

select Contrat.PPEntiteNo
from contrat 
inner join PP on PP.EntiteNo = Contrat.PPEntiteNo
group by Contrat.PPEntiteNo,PP.DateNaissance
Having  DATEDIFF(YEAR, PP.DateNaissance, GETDATE()) < 18



-- not good

-- ---------------------------------------------------------------------------
-- ------------------------------------------------- Entrepôt de données (BD)

-- 1. Les totaux des montants des factures pour chaque entité, affichés par 
-- total de manière décroissante.
-- A COMPLETER

-- 2. Le total des factures de plus d'une ligne, avec le numéro de la facture 
-- et le numéro de l'entité à qui elles sont adressées.
-- A COMPLETER

-- 3. Le nombre de sorties et le total des montants bruts des factures par 
-- désignation, pour les sorties de type commercial.
-- A COMPLETER

-- 4. Le nombre de fois qu'un bateau est rentré dans chaque port d'arrivée, 
-- affiché par nombre fois dans l'ordre décroissant.
-- A COMPLETER