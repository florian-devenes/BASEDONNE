-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- script :        data.sql
-- database:       gestion chantier
-- contributors :  Gabor Maksay (gmy)
--                 Samuel Nguyen (snn)
-- history :       when       | ver | who | what
--                 2022-07-26 | 2.0 | gmy | adapted to postgres
--                 2021-11-10 | 1.0 | snn | creation

-- ---------------------------------------------------------------------------
-- ------------------------------------------------------------------- how to
-- to change from postgresql to sqlserver and vice-versa
-- replace 
-- '-- postgresql /*' by '/* postgresql'
-- '-- postgresql */' by 'postgresql */'
-- '/* sqlserver' by '-- sqlserver /*'
-- 'sqlserver */' by '-- sqlserver */'

-- sqlserver /*
USE gestion_chantier_metier;
-- sqlserver */

DELETE FROM Facture;
DELETE FROM Contrat;
DELETE FROM Specialite;
DELETE FROM Chantier;
DELETE FROM Employe;
DELETE FROM Ville;
DELETE FROM Operation;
DELETE FROM Entreprise;

-- sqlserver /*
GO
-- sqlserver */

-- ---------------------------------------------------------------------------
-- --------------------------------------------------------------------- data

INSERT INTO Ville (Nom, Canton) VALUES 
	('Blonay', 'Vaud'),
	('Brent', 'Vaud'),
	('Jongny', 'Vaud'),
	('Chatel-Saint-Denis', 'Fribourg'),
	('Chardonne', 'Vaud'),
	('La Tour-de-Peilz', 'Vaud'),
	('Vevey', 'Vaud'),
	('Attalens', 'Fribourg');

-- sqlserver /*
GO
-- sqlserver */

INSERT INTO Employe (No, Nom, Prenom, DateDe, DateA) VALUES 
	( 1, 'Egli', 'Aurelien', '2019-09-30', NULL),
	( 2, 'Favre', 'Laura', '2019-09-30', NULL),
	( 3, 'Arnold', 'Arthur', '2019-09-30', NULL),
	( 4, 'Pfister', 'Alexandre', '2019-09-30', '2020-08-31'),
	( 5, 'Schweizer', 'Noemie', '2019-09-30', NULL),
	( 6, 'Wuthrich', 'Aline', '2019-11-04', '2021-08-27'),
	( 7, 'Fuchs', 'Aline', '2019-11-04', NULL),
	( 8, 'Martin', 'Vanessa', '2019-11-04', NULL),
	( 9, 'Stalder', 'David', '2020-06-01', NULL),
	(10, 'Gasser', 'Guillaume', '2020-06-01', '2020-12-31'),
	(11, 'Peter', 'Julien', '2020-06-29', '2021-09-30'),
	(12, 'Kohler', 'Patrick', '2020-06-22', NULL),
	(13, 'Maurer', 'Marine', '2020-11-02', NULL),
	(14, 'Koller', 'Jerôme', '2021-07-05', NULL),
	(15, 'Wenger', 'Lea', '2021-07-05', NULL);

-- sqlserver /*
GO
-- sqlserver */

INSERT INTO Operation (Nom, Description) VALUES 
	('Demolition', 'Demolition de l"ancienne structure si existante'),
	('Terrassements', 'Le terrassement est le travail consistant a deplacer...'),
	('Gros-oeuvre', 'Le gros oeuvre est l"ensemble des elements de construction...'),
	('Parement de facade', 'Couche superficielle exterieure d"un batiment'),
	('Charpente', 'Assemblage de bois ou de metal, servant a soutenir ou couvrir...'),
	('Bardage', 'Le bardage est, en architecture et en construction, constitue par...'),
	('Couverture / Zingu.', 'Le couvreur-zingueur complete la mise hors d"eau du batiment...'),
	('Etancheite', 'En construction, l"etancheite est un principe constructif d"une paroi...'),
	('Menuiseries Ext. Alu', ''),
	('Menuiseries Ext. Pvc', ''),
	('Echafaudages', 'Construction temporaire, passerelles, plates-formes soutenues par une charpente...'),
	('Enduits Ext.', 'Faire un enduit de facade consiste a appliquer une ou plusieurs...'),
	('Sanitaire - Plomberie', 'La plomberie sanitaire et la technique du batiment relative...'),
	('Chauffage Mazout', ''),
	('Chauffage Gaz', ''),
	('Chauffage Bois', ''),
	('V.M.C.', 'La plomberie sanitaire et la technique du Batiment relative aux installations...'),
	('Electricite', ''),
	('Ascenseur', ''),
	('Cloison Mobile', 'On entend par cloisons mobiles encore appelees cloisons mobiles,...'),
	('Platrerie', 'Pour changer d''interieur dans sa maison, dans son bureau, ou dans son local...'),
	('Menuiserie Int.', ''),
	('Chapes', 'Dans le batiment, la chape est une etape technique liee au gros oeuvre...'),
	('Carrelage', ''),
	('Revetements Sols', ''),
	('Peinture Int.', ''),
	('Portes Garages', ''),
	('Serrurerie', ''),
	('Amenagt. Ext. - Voirie', ''),
	('Assainissement', ''),
	('Espaces Verts', ''),
	('Garages', ''),
	('Clotures', ''),
	('Nettoyage Chantier', ''),
	('Fondations Speciales', ''),
	('Puits de Captage', 'Le puits de collecte est un ouvrage dans lequel l"eau de source est captee...'),
	('Photovolaique', '');

-- sqlserver /*
GO
-- sqlserver */

INSERT INTO Entreprise (Nom, Adresse, NPA, Localite, Telephone) VALUES 
	('AF-Couvertures', 'Impasse Gantz', '1631', 'Bulle (Fribourg)', '+41219758883'),
	('Aurora Sarl', 'Place Joannes Ambre', '1667', 'Enney', '+41219691832'),
	('AutoSilo SA', 'Rue de la Mignonne', '1031', 'Mex (Vaud)', '+41279822753'),
	('AX Espaces verts', 'Chemin de Serin', '1705', 'Fribourg', '+41224699211'),
	('Bayer', 'Place Jacques Elmaleh', '3210', 'Chietres', '+41207199631'),
	('BCD SA', 'Avenue David Ben Gourion', '1791', 'Courtaman', '+41268264848'),
	('Bixa Sarl', 'Allee des Pavillons', '1665', 'Estavannens-Dessus', '+41212030432'),
	('BR Buildings', 'Place Abbe Larue', '1043', 'Sugnens', '+41214380388'),
	('Cardano SA', 'Impasse Gentil', '1691', 'La Folliaz', '+41274414977'),
	('C-Concepts', 'Petite Rue Saint-Eusebe', '1011', 'Lausanne', '+41235909661'),
	('Cellar SA', 'Rue Elie Paris', '1020', 'Chavannes-pres-Renens', '+41279238090'),
	('Charpentes Infini', 'Place Jules Hottin', '1654', 'Cerniat', '+41278177919'),
	('Chiliz SA', 'Place Deperet', '1376', 'Eclagnens', '+41219164552'),
	('Cleanser SA', 'Rue de la Quarantaine', '1144', 'Ballens', '+41207253745'),
	('Cortex SA', 'Rue Andre Philip', '1510', 'Moudon', '+41229694322'),
	('Crepi Max', 'Rue Emile Combes', '1740', 'Neyruz', '+41278484029'),
	('Dash Sarl', 'Rue Antoine Barbier', '1408', 'Prahins', '+41212610006'),
	('Demoz SA', 'Impasse Ferret', '1634', 'La Roche (Fribourg)', '+41202451212'),
	('DMM Paysages', 'Avenue du Pont Pasteur', '1188', 'Gimel (Vaud)', '+41267227080'),
	('Doge SA', 'Rue Neuve', '1196', 'Gland (Vaud)', '+41254904474'),
	('Dotana SA', 'Rue Dumont d"Urville', '1884', 'Villars-sur-Ollon', '+41244736615'),
	('EJX Energies', 'Impasse Claude Jourdan', '1513', 'Rossenges', '+41218817224'),
	('Espaces Calorie SA', 'Rue de la Poulaillerie', '1554', 'Sodeilles', '+41240746026'),
	('Espaces Wend Sarl', 'Rue Octavio Mey', '1453', 'Bullet', '+41212386237'),
	('Firo Constructions Sarl', 'Place Joannes Ambre', '1063', 'Chapelle', '+41273508953'),
	('FMS', 'Place Jules Ferry', '1416', 'Pailly (Vaud)', '+41250297770'),
	('ForestPlus SA', 'Rue Amedee Lambert', '1001', 'Lausanne', '+41251538910'),
	('Giessen', 'Impasse de Bellefontaine', '1054', 'Morrens', '+41253854340'),
	('Glassdoor', 'Impasse Chardonnet', '1096', 'Cully (Vaud)', '+41267885771'),
	('GXChain SA', 'Chemin Ferrand', '1308', 'La Chaux (Cossonay)', '+41240757664'),
	('HF- Charpente', 'Rue de la Part-Dieu', '1084', 'Carrouge', '+41231739854'),
	('IC Sanitaire', 'Impasse Chomel', '1083', 'Mezieres (Vaud)', '+41234004395'),
	('ICM Shapes', 'Impasse Pitiot', '1704', 'Fribourg', '+41255237523'),
	('InsidePaint SA', 'Avenue du Marechal de Saxe', '1865', 'Les Diablerets (village)', '+41264008568'),
	('Insolar Volta SA', 'Impasse Gorge de Loup', '1509', 'Vucherens', '+41263190908'),
	('Itos Sarl', 'Allee des Troenes', '1611', 'Le Cret', '+41266775437'),
	('JFG SERVICES', 'Rue Amedee Bonnet', '1002', 'Lausanne', '+41232097377'),
	('Kambria Sarl', 'Impasse des Chalets', '1375', 'Penthereaz', '+41243427219'),
	('La petite menuiserie SNC', 'Cours de Verdun Gensoul', '1058', 'Villars-Tiercelin', '+41220865185'),
	('Link Ampere SA', 'Pont Georges Clemenceau', '1882', 'Taveyanne', '+41238857512'),
	('Luxx SA', 'Place Jean Jaures', '1017', 'Lausanne', '+41228555352'),
	('Mast Elec Sarl', 'Rue Dumont', '1723', 'Marly', '+41241413308'),
	('Maxi Lifts', 'Impasse Saint-Gervais', '1699', 'Porsel', '+41220074479'),
	('MultiVAC SA', 'Pont Kitchener-Marchand', '1544', 'Gletterens', '+41237234797'),
	('Neo Flex', 'Pont Kitchener-Marchand', '1528', 'Surpierre', '+41236590455'),
	('Neo Sarl', 'Pont Masaryk', '1612', 'Ecoteaux', '+41218030606'),
	('Ontology SA', 'Rue Andre', '1482', 'Cugy (Fribourg)', '+41208350543'),
	('OXT Carrelages', 'Place Jean Mermoz', '1005', 'Lausanne', '+41215121184'),
	('Pundix SA', 'Rue de la Sauvagere', '1006', 'Lausanne', '+41239539473'),
	('Q-tum Sarl', 'Rue Edith Piaf', '1018', 'Lausanne', '+41237990571'),
	('Quick Cleaner SA', 'Impasse Saint-Isidore', '1273', 'Arzier-Le Muids', '+41268018968'),
	('Reef SA', 'Impasse d"Ypres', '1669', 'Lessoc', '+41221653329'),
	('Rieder Etancheite', 'Avenue Cabias', '1700', 'Fribourg', '+41233108756'),
	('Ripple Sarl', 'Place de Sathonay', '1730', 'Ecuvillens', '+41210772987'),
	('Safemoon', 'Rue Nicolas Sicard', '1443', 'Champvent', '+41203539460'),
	('Shiba Sarl', 'Allee des Villas', '1174', 'Pizy', '+41266656596'),
	('Solana Sarl', 'Rue Notre-Dame', '1015', 'Lausanne', '+41266808836'),
	('Tezer SA', 'Rue Duphot', '1170', 'Aubonne (Vaud)', '+41215351448'),
	('Vet SA', 'Rue Nicolas', '1098', 'Epesses', '+41224249332'),
	('Vss Global', 'Place Ampere', '1003', 'Lausanne', '+41240367649'),
	('Wing SA', 'Rue de la Ruche', '1338', 'Ballaigues', '+41204867131'),
	('Zil Energies', 'Rue Anselme', '1541', 'Bussy (Fribourg)', '+41205375928');

-- sqlserver /*
GO
-- sqlserver */

INSERT INTO Specialite (EntrepriseNom, OperationNom) VALUES 
	('AF-Couvertures', 'Couverture / Zingu.'),
	('Aurora Sarl', 'Serrurerie'),
	('AutoSilo SA', 'Garages'),
	('AX Espaces verts', 'Amenagt. Ext. - Voirie'),
	('AX Espaces verts', 'Espaces Verts'),
	('Bayer', 'Menuiserie Int.'),
	('Bayer', 'Assainissement'),
	('BCD SA', 'Echafaudages'),
	('Bixa Sarl', 'Revetements Sols'),
	('BR Buildings', 'Menuiserie Int.'),	
	('Cardano SA', 'Demolition'),
	('Cardano SA', 'Terrassements'),
	('Cardano SA', 'Amenagt. Ext. - Voirie'),
	('Cardano SA', 'Assainissement'),
	('Cardano SA', 'Espaces Verts'),	
	('C-Concepts', 'Couverture / Zingu.'),
	('C-Concepts', 'Echafaudages'),
	('Cellar SA', 'Fondations Speciales'),
	('Charpentes Infini', 'Charpente'),
	('Chiliz SA', 'Gros-oeuvre'),	
	('Chiliz SA', 'Parement de facade'),
	('Chiliz SA', 'Echafaudages'),
	('Chiliz SA', 'Enduits Ext.'),
	('Cleanser SA', 'Nettoyage Chantier'),
	('Cortex SA', 'Couverture / Zingu.'),	
	('Cortex SA', 'Etancheite'),
	('Crepi Max', 'Enduits Ext.'),
	('Dash Sarl', 'Bardage'),
	('Dash Sarl', 'Revetements Sols'),
	('Demoz SA', 'Chapes'),	
	('DMM Paysages', 'Amenagt. Ext. - Voirie'),
	('Doge SA', 'Sanitaire - Plomberie'),
	('Doge SA', 'Chauffage Mazout'),
	('Doge SA', 'V.M.C.'),
	('Doge SA', 'Electricite'),	
	('Dotana SA', 'Carrelage'),
	('EJX Energies', 'Chauffage Mazout'),
	('EJX Energies', 'V.M.C.'),
	('Espaces Calorie SA', 'Chauffage Mazout'),
	('Espaces Calorie SA', 'Chauffage Gaz'),	
	('Espaces Calorie SA', 'Chauffage Bois'),
	('Espaces Wend Sarl', 'Sanitaire - Plomberie'),
	('Firo Constructions Sarl', 'Menuiseries Ext. Pvc'),
	('FMS', 'Menuiseries Ext. Pvc'),
	('ForestPlus SA', 'Bardage'), 	
	('ForestPlus SA', 'Couverture / Zingu.'),
	('ForestPlus SA', 'Etancheite'),
	('Giessen', 'Charpente'),
	('Glassdoor', 'Clotures'),
	('GXChain SA', 'Enduits Ext.'),	
	('HF- Charpente', 'Charpente'),
	('IC Sanitaire', 'Sanitaire - Plomberie'),
	('ICM Shapes', 'Chapes'),
	('InsidePaint SA', 'Peinture Int.'),
	('Insolar Volta SA', 'Photovolaique'),	
	('Itos Sarl', 'Ascenseur'),
	('JFG SERVICES', 'Menuiseries Ext. Alu'),
	('Kambria Sarl', 'Chapes'),
	('La petite menuiserie SNC', 'Menuiserie Int.'),
	('Link Ampere SA', 'V.M.C.'),	
	('Link Ampere SA', 'Electricite'),
	('Luxx SA', 'Etancheite'),
	('Mast Elec Sarl', 'V.M.C.'),
	('Mast Elec Sarl', 'Electricite'),
	('Maxi Lifts', 'Ascenseur'),	
	('MultiVAC SA', 'Assainissement'),
	('Neo Flex', 'Cloison Mobile'),
	('Neo Sarl', 'Platrerie'),
	('Ontology SA', 'Platrerie'),
	('Ontology SA', 'Carrelage'),	
	('OXT Carrelages', 'Chapes'),
	('OXT Carrelages', 'Carrelage'),
	('Pundix SA', 'Portes Garages'),
	('Q-tum Sarl', 'Gros-oeuvre'),
	('Quick Cleaner SA', 'Nettoyage Chantier'),	
	('Reef SA', 'Carrelage'),
	('Rieder Etancheite', 'Etancheite'),
	('Ripple Sarl', 'Terrassements'),
	('Ripple Sarl', 'Amenagt. Ext. - Voirie'),
	('Ripple Sarl', 'Assainissement'),	
	('Safemoon', 'Revetements Sols'),
	('Safemoon', 'Peinture Int.'),
	('Shiba Sarl', 'Serrurerie'),
	('Solana Sarl', 'Revetements Sols'),
	('Tezer SA', 'Peinture Int.'),	
	('Vet SA', 'Platrerie'),
	('Vss Global', 'Gros-oeuvre'),
	('Wing SA', 'Gros-oeuvre'),
	('Zil Energies', 'Chauffage Mazout');

-- sqlserver /*
GO
-- sqlserver */

INSERT INTO Chantier (No, VilleNom, VilleCanton, ResidenceNom, Batiment, Objet, ResponsableNo) VALUES 
	( 1, 'Blonay', 'Vaud', 'Le Jouvence', 'Bat A+B+Pavillon / Bat C', '40 logements et un local commercial', 5),
	( 2, 'Brent', 'Vaud', 'Le Clos des Remparts', 'Bat D, E, F', '29 logements', 1),
	( 3, 'Jongny', 'Vaud', 'La Parenthese', 'Batiment B3', '12 logements', 3),
	( 4, 'Chatel-Saint-Denis', 'Fribourg', 'Domaine de la Chenaie', 'A1, A2, A3, C1 et C2', '35 logements', 5),
	( 5, 'Chardonne', 'Vaud', 'Les Prairies du Canal', 'Batiment 8', '31 logements', 7),
	( 6, 'La Tour-de-Peilz', 'Vaud', 'La Pommeraie', 'Batiment 4 et 5', '19 logements', 7),
	( 7, 'Jongny', 'Vaud', 'La Parenthese', 'B1 et B2', '31 logements', 9),
	( 8, 'Vevey', 'Vaud', 'Les Botalies', 'A et B', '21 logements', 2),
	( 9, 'Attalens', 'Fribourg', 'Le Synergy', 'Batiment 4', '18 logements', 1),
	(10, 'La Tour-de-Peilz', 'Vaud', 'La Pommeraie', 'Batiment 6', '11 logements', 8);

-- sqlserver /*
GO
-- sqlserver */

-- Table Contrat
-- (No, OperationNom, ChantierNo, EntrepriseNom, DateContrat, Signataire, DateDebutTravaux, DateFinTravaux, MontantEstime)

INSERT INTO Contrat VALUES (1, 'Terrassements', 6, 'Ripple Sarl', '2019-10-15', 5, '2019-11-05', '2020-01-09', 50200);
INSERT INTO Contrat VALUES (2, 'Terrassements', 7, 'Cardano SA', '2019-10-22', 5, '2019-11-12', '2019-12-29', 44700);
INSERT INTO Contrat VALUES (3, 'Terrassements', 10, 'Ripple Sarl', '2019-10-26', 1, '2019-11-16', '2020-01-11', 45300);
INSERT INTO Contrat VALUES (4, 'Gros-oeuvre', 7, 'Q-tum Sarl', '2019-10-27', 3, '2019-11-17', '2019-12-18', 161100);
INSERT INTO Contrat VALUES (5, 'Terrassements', 3, 'Cardano SA', '2019-10-29', 5, '2019-11-19', '2020-01-24', 55800);
INSERT INTO Contrat VALUES (6, 'Gros-oeuvre', 6, 'Vss Global', '2019-11-03', 4, '2019-11-24', '2020-01-04', 92900);
INSERT INTO Contrat VALUES (7, 'Parement de facade', 7, 'Chiliz SA', '2019-11-03', 1, '2019-11-24', '2020-01-24', 12000);
INSERT INTO Contrat VALUES (8, 'Terrassements', 2, 'Cardano SA', '2019-11-04', 6, '2019-11-25', '2020-01-23', 46500);
INSERT INTO Contrat VALUES (9, 'Terrassements', 5, 'Cardano SA', '2019-11-04', 2, '2019-11-25', '2020-01-04', 50600);
INSERT INTO Contrat VALUES (10, 'Gros-oeuvre', 3, 'Q-tum Sarl', '2019-11-05', 8, '2019-11-26', '2020-01-24', 83700);
INSERT INTO Contrat VALUES (11, 'Demolition', 8, 'Cardano SA', '2019-11-06', 8, '2019-11-27', '2020-01-24', 95000);
INSERT INTO Contrat VALUES (12, 'Charpente', 3, 'Charpentes Infini', '2019-11-08', 3, '2019-11-29', '2020-01-04', 5200);
INSERT INTO Contrat VALUES (13, 'Bardage', 6, 'Dash Sarl', '2019-11-15', 3, '2019-12-06', '2020-01-15', 3500);
INSERT INTO Contrat VALUES (14, 'Terrassements', 1, 'Cardano SA', '2019-11-17', 5, '2019-12-08', '2020-02-03', 52200);
INSERT INTO Contrat VALUES (15, 'Gros-oeuvre', 1, 'Chiliz SA', '2019-11-18', 4, '2019-12-09', '2020-01-09', 148900);
INSERT INTO Contrat VALUES (16, 'Etancheite', 3, 'Luxx SA', '2019-11-19', 3, '2019-12-10', '2020-01-26', 16600);
INSERT INTO Contrat VALUES (17, 'Gros-oeuvre', 2, 'Q-tum Sarl', '2019-11-21', 2, '2019-12-12', '2020-01-27', 141600);
INSERT INTO Contrat VALUES (18, 'Charpente', 2, 'Giessen', '2019-11-23', 4, '2019-12-14', '2020-01-16', 10100);
INSERT INTO Contrat VALUES (19, 'Gros-oeuvre', 5, 'Q-tum Sarl', '2019-11-25', 4, '2019-12-16', '2020-01-20', 98200);
INSERT INTO Contrat VALUES (20, 'Etancheite', 6, 'ForestPlus SA', '2019-11-25', 6, '2019-12-16', '2020-01-17', 18900);
INSERT INTO Contrat VALUES (21, 'Couverture / Zingu.', 2, 'AF-Couvertures', '2019-11-26', 3, '2019-12-17', '2020-02-05', 16000);
INSERT INTO Contrat VALUES (22, 'Terrassements', 8, 'Cardano SA', '2019-11-26', 4, '2019-12-17', '2020-01-23', 43600);
INSERT INTO Contrat VALUES (23, 'Charpente', 5, 'Giessen', '2019-11-30', 2, '2019-12-21', '2020-01-29', 18700);
INSERT INTO Contrat VALUES (24, 'Terrassements', 4, 'Cardano SA', '2019-12-02', 5, '2019-12-23', '2020-01-23', 47700);
INSERT INTO Contrat VALUES (25, 'Menuiseries Ext. Pvc', 3, 'Firo Constructions Sarl', '2019-12-08', 6, '2019-12-29', '2020-02-05', 13200);
INSERT INTO Contrat VALUES (26, 'Charpente', 7, 'HF- Charpente', '2019-12-08', 4, '2019-12-29', '2020-02-24', 18800);
INSERT INTO Contrat VALUES (27, 'Etancheite', 2, 'Rieder Etancheite', '2019-12-15', 2, '2020-01-05', '2020-02-08', 13500);
INSERT INTO Contrat VALUES (28, 'Menuiseries Ext. Pvc', 6, 'Firo Constructions Sarl', '2019-12-18', 3, '2020-01-08', '2020-02-21', 14600);
INSERT INTO Contrat VALUES (29, 'Bardage', 1, 'Dash Sarl', '2019-12-21', 4, '2020-01-11', '2020-02-24', 3300);
INSERT INTO Contrat VALUES (30, 'Menuiseries Ext. Pvc', 2, 'Firo Constructions Sarl', '2019-12-24', 1, '2020-01-14', '2020-03-22', 22300);
INSERT INTO Contrat VALUES (31, 'Etancheite', 7, 'Luxx SA', '2019-12-25', 1, '2020-01-15', '2020-03-15', 11400);
INSERT INTO Contrat VALUES (32, 'Couverture / Zingu.', 1, 'Cortex SA', '2019-12-29', 4, '2020-01-19', '2020-03-15', 12600);
INSERT INTO Contrat VALUES (33, 'Echafaudages', 3, 'Chiliz SA', '2020-01-02', 7, '2020-01-23', '2020-03-15', 13200);
INSERT INTO Contrat VALUES (34, 'Enduits Ext.', 3, 'Chiliz SA', '2020-01-03', 1, '2020-01-24', '2020-03-23', 15800);
INSERT INTO Contrat VALUES (35, 'Sanitaire - Plomberie', 3, 'IC Sanitaire', '2020-01-10', 4, '2020-01-31', '2020-03-24', 4900);
INSERT INTO Contrat VALUES (36, 'Couverture / Zingu.', 5, 'ForestPlus SA', '2020-01-18', 4, '2020-02-08', '2020-03-17', 11800);
INSERT INTO Contrat VALUES (37, 'Gros-oeuvre', 10, 'Vss Global', '2020-01-18', 1, '2020-02-08', '2020-03-23', 94400);
INSERT INTO Contrat VALUES (38, 'Menuiseries Ext. Pvc', 7, 'Firo Constructions Sarl', '2020-01-19', 8, '2020-02-09', '2020-04-02', 14500);
INSERT INTO Contrat VALUES (39, 'Echafaudages', 6, 'BCD SA', '2020-01-20', 4, '2020-02-10', '2020-03-18', 13500);
INSERT INTO Contrat VALUES (40, 'Echafaudages', 7, 'Chiliz SA', '2020-01-22', 8, '2020-02-12', '2020-03-18', 15700);
INSERT INTO Contrat VALUES (41, 'Gros-oeuvre', 8, 'Wing SA', '2020-01-22', 5, '2020-02-12', '2020-03-22', 219900);
INSERT INTO Contrat VALUES (42, 'Chauffage Bois', 3, 'Espaces Calorie SA', '2020-01-25', 7, '2020-02-15', '2020-03-24', 20500);
INSERT INTO Contrat VALUES (43, 'Bardage', 10, 'Dash Sarl', '2020-01-25', 3, '2020-02-15', '2020-03-23', 3900);
INSERT INTO Contrat VALUES (44, 'Echafaudages', 2, 'Chiliz SA', '2020-01-29', 7, '2020-02-19', '2020-04-02', 29800);
INSERT INTO Contrat VALUES (45, 'Enduits Ext.', 7, 'Chiliz SA', '2020-01-30', 6, '2020-02-20', '2020-04-22', 15700);
INSERT INTO Contrat VALUES (46, 'Enduits Ext.', 6, 'GXChain SA', '2020-02-03', 8, '2020-02-24', '2020-04-11', 23500);
INSERT INTO Contrat VALUES (47, 'Charpente', 8, 'Giessen', '2020-02-03', 2, '2020-02-24', '2020-03-31', 6500);
INSERT INTO Contrat VALUES (48, 'Etancheite', 1, 'Cortex SA', '2020-02-06', 6, '2020-02-27', '2020-04-10', 22600);
INSERT INTO Contrat VALUES (49, 'Etancheite', 10, 'Cortex SA', '2020-02-10', 7, '2020-03-02', '2020-04-19', 10000);
INSERT INTO Contrat VALUES (50, 'Etancheite', 5, 'Cortex SA', '2020-02-17', 2, '2020-03-09', '2020-04-28', 12000);
INSERT INTO Contrat VALUES (51, 'Menuiseries Ext. Alu', 5, 'JFG SERVICES', '2020-02-17', 1, '2020-03-09', '2020-05-08', 21200);
INSERT INTO Contrat VALUES (52, 'Terrassements', 9, 'Cardano SA', '2020-02-17', 5, '2020-03-09', '2020-04-16', 56500);
INSERT INTO Contrat VALUES (53, 'Echafaudages', 5, 'BCD SA', '2020-02-18', 6, '2020-03-10', '2020-05-13', 16500);
INSERT INTO Contrat VALUES (54, 'Couverture / Zingu.', 8, 'C-Concepts', '2020-02-19', 4, '2020-03-11', '2020-04-10', 18500);
INSERT INTO Contrat VALUES (55, 'Gros-oeuvre', 9, 'Q-tum Sarl', '2020-02-20', 1, '2020-03-12', '2020-04-23', 187900);
INSERT INTO Contrat VALUES (56, 'Menuiseries Ext. Pvc', 1, 'Firo Constructions Sarl', '2020-02-23', 8, '2020-03-15', '2020-05-12', 18200);
INSERT INTO Contrat VALUES (57, 'Menuiseries Ext. Pvc', 10, 'Firo Constructions Sarl', '2020-02-23', 6, '2020-03-15', '2020-05-19', 15900);
INSERT INTO Contrat VALUES (58, 'Etancheite', 8, 'Luxx SA', '2020-02-28', 7, '2020-03-20', '2020-05-20', 11000);
INSERT INTO Contrat VALUES (59, 'Enduits Ext.', 2, 'Chiliz SA', '2020-03-01', 8, '2020-03-22', '2020-05-14', 20400);
INSERT INTO Contrat VALUES (60, 'Sanitaire - Plomberie', 2, 'Doge SA', '2020-03-01', 5, '2020-03-22', '2020-05-25', 3800);
INSERT INTO Contrat VALUES (61, 'Bardage', 9, 'ForestPlus SA', '2020-03-01', 4, '2020-03-22', '2020-04-28', 6000);
INSERT INTO Contrat VALUES (62, 'V.M.C.', 3, 'Mast Elec Sarl', '2020-03-02', 1, '2020-03-23', '2020-04-28', 18400);
INSERT INTO Contrat VALUES (63, 'Menuiseries Ext. Pvc', 8, 'FMS', '2020-03-05', 4, '2020-03-26', '2020-05-28', 24800);
INSERT INTO Contrat VALUES (64, 'Gros-oeuvre', 4, 'Q-tum Sarl', '2020-03-07', 8, '2020-03-28', '2020-04-30', 190200);
INSERT INTO Contrat VALUES (65, 'Echafaudages', 1, 'BCD SA', '2020-03-08', 3, '2020-03-29', '2020-05-20', 23500);
INSERT INTO Contrat VALUES (66, 'Electricite', 3, 'Mast Elec Sarl', '2020-03-11', 2, '2020-04-01', '2020-05-17', 3300);
INSERT INTO Contrat VALUES (67, 'Enduits Ext.', 5, 'GXChain SA', '2020-03-13', 4, '2020-04-03', '2020-05-20', 20000);
INSERT INTO Contrat VALUES (68, 'Enduits Ext.', 1, 'GXChain SA', '2020-03-16', 6, '2020-04-06', '2020-05-21', 18700);
INSERT INTO Contrat VALUES (69, 'Sanitaire - Plomberie', 1, 'IC Sanitaire', '2020-03-19', 2, '2020-04-09', '2020-06-14', 2900);
INSERT INTO Contrat VALUES (70, 'Sanitaire - Plomberie', 6, 'IC Sanitaire', '2020-03-21', 4, '2020-04-11', '2020-06-13', 2800);
INSERT INTO Contrat VALUES (71, 'Chauffage Mazout', 6, 'Zil Energies', '2020-03-21', 7, '2020-04-11', '2020-06-16', 23300);
INSERT INTO Contrat VALUES (72, 'Echafaudages', 10, 'BCD SA', '2020-03-21', 7, '2020-04-11', '2020-05-27', 17900);
INSERT INTO Contrat VALUES (73, 'Echafaudages', 8, 'C-Concepts', '2020-03-26', 3, '2020-04-16', '2020-06-22', 22400);
INSERT INTO Contrat VALUES (74, 'V.M.C.', 6, 'Mast Elec Sarl', '2020-03-27', 3, '2020-04-17', '2020-05-29', 15700);
INSERT INTO Contrat VALUES (75, 'Enduits Ext.', 10, 'GXChain SA', '2020-03-28', 5, '2020-04-18', '2020-06-16', 25700);
INSERT INTO Contrat VALUES (76, 'Platrerie', 3, 'Vet SA', '2020-03-30', 3, '2020-04-20', '2020-05-29', 5000);
INSERT INTO Contrat VALUES (77, 'Menuiserie Int.', 3, 'La petite menuiserie SNC', '2020-04-03', 3, '2020-04-24', '2020-06-30', 4700);
INSERT INTO Contrat VALUES (78, 'Electricite', 6, 'Mast Elec Sarl', '2020-04-07', 3, '2020-04-28', '2020-06-02', 4600);
INSERT INTO Contrat VALUES (79, 'Charpente', 4, 'Giessen', '2020-04-08', 5, '2020-04-29', '2020-06-28', 13700);
INSERT INTO Contrat VALUES (80, 'Couverture / Zingu.', 4, 'ForestPlus SA', '2020-04-10', 3, '2020-05-01', '2020-06-07', 15200);
INSERT INTO Contrat VALUES (81, 'Chauffage Mazout', 2, 'Doge SA', '2020-04-15', 1, '2020-05-06', '2020-07-06', 8000);
INSERT INTO Contrat VALUES (82, 'V.M.C.', 2, 'Doge SA', '2020-04-15', 2, '2020-05-06', '2020-06-23', 17900);
INSERT INTO Contrat VALUES (83, 'Electricite', 2, 'Doge SA', '2020-04-19', 2, '2020-05-10', '2020-06-27', 5200);
INSERT INTO Contrat VALUES (84, 'Sanitaire - Plomberie', 7, 'IC Sanitaire', '2020-04-19', 7, '2020-05-10', '2020-06-29', 2200);
INSERT INTO Contrat VALUES (85, 'Sanitaire - Plomberie', 5, 'IC Sanitaire', '2020-04-21', 1, '2020-05-12', '2020-06-23', 4600);
INSERT INTO Contrat VALUES (86, 'Chauffage Mazout', 5, 'Zil Energies', '2020-04-26', 2, '2020-05-17', '2020-06-25', 10600);
INSERT INTO Contrat VALUES (87, 'Chapes', 3, 'Kambria Sarl', '2020-05-01', 6, '2020-05-22', '2020-06-28', 3800);
INSERT INTO Contrat VALUES (88, 'Sanitaire - Plomberie', 10, 'Doge SA', '2020-05-04', 1, '2020-05-25', '2020-06-28', 5500);
INSERT INTO Contrat VALUES (89, 'Chauffage Mazout', 10, 'Zil Energies', '2020-05-04', 5, '2020-05-25', '2020-06-29', 19100);
INSERT INTO Contrat VALUES (90, 'V.M.C.', 10, 'Mast Elec Sarl', '2020-05-05', 7, '2020-05-26', '2020-07-31', 11100);
INSERT INTO Contrat VALUES (91, 'Etancheite', 4, 'Luxx SA', '2020-05-06', 3, '2020-05-27', '2020-08-03', 12500);
INSERT INTO Contrat VALUES (92, 'Enduits Ext.', 8, 'Crepi Max', '2020-05-06', 1, '2020-05-27', '2020-07-29', 25500);
INSERT INTO Contrat VALUES (93, 'Chauffage Gaz', 7, 'Espaces Calorie SA', '2020-05-07', 5, '2020-05-28', '2020-07-19', 11000);
INSERT INTO Contrat VALUES (94, 'Ascenseur', 6, 'Itos Sarl', '2020-05-11', 5, '2020-06-01', '2020-07-13', 50000);
INSERT INTO Contrat VALUES (95, 'Electricite', 10, 'Mast Elec Sarl', '2020-05-14', 1, '2020-06-04', '2020-08-06', 3300);
INSERT INTO Contrat VALUES (96, 'V.M.C.', 7, 'Mast Elec Sarl', '2020-05-16', 8, '2020-06-06', '2020-08-10', 6500);
INSERT INTO Contrat VALUES (97, 'Ascenseur', 2, 'Itos Sarl', '2020-05-19', 8, '2020-06-09', '2020-07-29', 26500);
INSERT INTO Contrat VALUES (98, 'Electricite', 7, 'Mast Elec Sarl', '2020-05-20', 1, '2020-06-10', '2020-07-19', 3500);
INSERT INTO Contrat VALUES (99, 'Ascenseur', 7, 'Maxi Lifts', '2020-05-22', 5, '2020-06-12', '2020-07-31', 63300);
INSERT INTO Contrat VALUES (100, 'Sanitaire - Plomberie', 8, 'IC Sanitaire', '2020-05-22', 5, '2020-06-12', '2020-08-18', 1300);
INSERT INTO Contrat VALUES (101, 'Etancheite', 9, 'Cortex SA', '2020-05-24', 4, '2020-06-14', '2020-08-04', 24400);
INSERT INTO Contrat VALUES (102, 'Carrelage', 3, 'OXT Carrelages', '2020-05-25', 5, '2020-06-15', '2020-07-22', 5000);
INSERT INTO Contrat VALUES (103, 'Menuiseries Ext. Pvc', 4, 'Firo Constructions Sarl', '2020-05-25', 7, '2020-06-15', '2020-08-17', 23800);
INSERT INTO Contrat VALUES (104, 'Chauffage Mazout', 1, 'EJX Energies', '2020-05-28', 2, '2020-06-18', '2020-08-09', 21600);
INSERT INTO Contrat VALUES (105, 'Menuiseries Ext. Pvc', 9, 'Firo Constructions Sarl', '2020-05-30', 1, '2020-06-20', '2020-08-10', 16900);
INSERT INTO Contrat VALUES (106, 'Chauffage Mazout', 8, 'Espaces Calorie SA', '2020-06-01', 3, '2020-06-22', '2020-08-30', 11400);
INSERT INTO Contrat VALUES (107, 'Echafaudages', 9, 'BCD SA', '2020-06-02', 7, '2020-06-23', '2020-08-06', 23600);
INSERT INTO Contrat VALUES (108, 'V.M.C.', 5, 'Link Ampere SA', '2020-06-04', 2, '2020-06-25', '2020-08-10', 17700);
INSERT INTO Contrat VALUES (109, 'Platrerie', 10, 'Vet SA', '2020-06-04', 9, '2020-06-25', '2020-08-15', 3500);
INSERT INTO Contrat VALUES (110, 'Revetements Sols', 3, 'Solana Sarl', '2020-06-06', 4, '2020-06-27', '2020-08-10', 2400);
INSERT INTO Contrat VALUES (111, 'Echafaudages', 4, 'Chiliz SA', '2020-06-08', 1, '2020-06-29', '2020-07-29', 18600);
INSERT INTO Contrat VALUES (112, 'Peinture Int.', 3, 'Safemoon', '2020-06-16', 8, '2020-07-07', '2020-09-07', 2700);
INSERT INTO Contrat VALUES (113, 'Platrerie', 7, 'Vet SA', '2020-06-18', 3, '2020-07-09', '2020-08-31', 8500);
INSERT INTO Contrat VALUES (114, 'Electricite', 5, 'Link Ampere SA', '2020-06-19', 9, '2020-07-10', '2020-09-17', 1600);
INSERT INTO Contrat VALUES (115, 'Enduits Ext.', 9, 'Crepi Max', '2020-06-20', 4, '2020-07-11', '2020-09-10', 22900);
INSERT INTO Contrat VALUES (116, 'Menuiserie Int.', 7, 'La petite menuiserie SNC', '2020-06-25', 6, '2020-07-16', '2020-09-20', 1900);
INSERT INTO Contrat VALUES (117, 'Menuiserie Int.', 10, 'La petite menuiserie SNC', '2020-06-26', 3, '2020-07-17', '2020-09-22', 5300);
INSERT INTO Contrat VALUES (118, 'Chapes', 7, 'Kambria Sarl', '2020-06-28', 8, '2020-07-19', '2020-09-19', 1500);
INSERT INTO Contrat VALUES (119, 'Portes Garages', 3, 'Pundix SA', '2020-07-01', 6, '2020-07-22', '2020-09-22', 2900);
INSERT INTO Contrat VALUES (120, 'Platrerie', 6, 'Vet SA', '2020-07-03', 3, '2020-07-24', '2020-09-01', 1400);
INSERT INTO Contrat VALUES (121, 'Carrelage', 7, 'OXT Carrelages', '2020-07-04', 6, '2020-07-25', '2020-09-08', 4900);
INSERT INTO Contrat VALUES (122, 'Chapes', 10, 'Kambria Sarl', '2020-07-08', 9, '2020-07-29', '2020-09-23', 4600);
INSERT INTO Contrat VALUES (123, 'Sanitaire - Plomberie', 9, 'Doge SA', '2020-07-12', 11, '2020-08-02', '2020-10-05', 4500);
INSERT INTO Contrat VALUES (124, 'Platrerie', 2, 'Neo Sarl', '2020-07-15', 7, '2020-08-05', '2020-10-01', 4000);
INSERT INTO Contrat VALUES (125, 'Serrurerie', 3, 'Aurora Sarl', '2020-07-15', 10, '2020-08-05', '2020-10-10', 2500);
INSERT INTO Contrat VALUES (126, 'Chauffage Mazout', 9, 'Doge SA', '2020-07-19', 1, '2020-08-09', '2020-10-07', 7000);
INSERT INTO Contrat VALUES (127, 'Revetements Sols', 7, 'Solana Sarl', '2020-07-22', 9, '2020-08-12', '2020-10-01', 2700);
INSERT INTO Contrat VALUES (128, 'Enduits Ext.', 4, 'Chiliz SA', '2020-07-28', 5, '2020-08-18', '2020-09-25', 23300);
INSERT INTO Contrat VALUES (129, 'Sanitaire - Plomberie', 4, 'Espaces Wend Sarl', '2020-08-15', 2, '2020-09-05', '2020-10-19', 4000);
INSERT INTO Contrat VALUES (130, 'Menuiserie Int.', 2, 'BR Buildings', '2020-08-21', 12, '2020-09-11', '2020-10-20', 7600);
INSERT INTO Contrat VALUES (131, 'V.M.C.', 8, 'Doge SA', '2020-08-22', 10, '2020-09-12', '2020-10-27', 19200);
INSERT INTO Contrat VALUES (132, 'Menuiserie Int.', 6, 'La petite menuiserie SNC', '2020-08-25', 10, '2020-09-15', '2020-10-30', 7600);
INSERT INTO Contrat VALUES (133, 'Ascenseur', 5, 'Maxi Lifts', '2020-08-28', 12, '2020-09-18', '2020-10-22', 50100);
INSERT INTO Contrat VALUES (134, 'Chapes', 2, 'OXT Carrelages', '2020-08-31', 5, '2020-09-21', '2020-11-12', 4400);
INSERT INTO Contrat VALUES (135, 'Chauffage Mazout', 4, 'Zil Energies', '2020-09-01', 5, '2020-09-22', '2020-10-31', 17700);
INSERT INTO Contrat VALUES (136, 'V.M.C.', 4, 'Link Ampere SA', '2020-09-01', 3, '2020-09-22', '2020-10-24', 14400);
INSERT INTO Contrat VALUES (137, 'Carrelage', 10, 'Reef SA', '2020-09-08', 3, '2020-09-29', '2020-11-01', 1400);
INSERT INTO Contrat VALUES (138, 'Revetements Sols', 10, 'Solana Sarl', '2020-09-08', 8, '2020-09-29', '2020-11-29', 3900);
INSERT INTO Contrat VALUES (139, 'Electricite', 4, 'Link Ampere SA', '2020-09-10', 12, '2020-10-01', '2020-11-10', 2400);
INSERT INTO Contrat VALUES (140, 'Chapes', 6, 'Kambria Sarl', '2020-09-11', 9, '2020-10-02', '2020-12-07', 3300);
INSERT INTO Contrat VALUES (141, 'V.M.C.', 1, 'EJX Energies', '2020-09-12', 3, '2020-10-03', '2020-12-11', 13300);
INSERT INTO Contrat VALUES (142, 'Carrelage', 2, 'Dotana SA', '2020-09-12', 8, '2020-10-03', '2020-12-07', 4600);
INSERT INTO Contrat VALUES (143, 'Electricite', 8, 'Doge SA', '2020-09-14', 2, '2020-10-05', '2020-11-25', 2700);
INSERT INTO Contrat VALUES (144, 'Electricite', 1, 'Link Ampere SA', '2020-09-15', 1, '2020-10-06', '2020-12-02', 3700);
INSERT INTO Contrat VALUES (145, 'Amenagt. Ext. - Voirie', 3, 'DMM Paysages', '2020-09-15', 10, '2020-10-06', '2020-11-21', 3100);
INSERT INTO Contrat VALUES (146, 'V.M.C.', 9, 'Doge SA', '2020-09-16', 6, '2020-10-07', '2020-11-23', 18000);
INSERT INTO Contrat VALUES (147, 'Platrerie', 5, 'Vet SA', '2020-09-23', 5, '2020-10-14', '2020-12-03', 2100);
INSERT INTO Contrat VALUES (148, 'Peinture Int.', 10, 'Safemoon', '2020-09-25', 1, '2020-10-16', '2020-12-06', 2400);
INSERT INTO Contrat VALUES (149, 'Menuiserie Int.', 5, 'La petite menuiserie SNC', '2020-09-26', 11, '2020-10-17', '2020-11-24', 4400);
INSERT INTO Contrat VALUES (150, 'Ascenseur', 1, 'Itos Sarl', '2020-10-02', 1, '2020-10-23', '2020-12-11', 15200);
INSERT INTO Contrat VALUES (151, 'Electricite', 9, 'Doge SA', '2020-10-03', 3, '2020-10-24', '2020-11-25', 3600);
INSERT INTO Contrat VALUES (152, 'Chapes', 5, 'ICM Shapes', '2020-10-04', 11, '2020-10-25', '2020-12-22', 3100);
INSERT INTO Contrat VALUES (153, 'Revetements Sols', 2, 'Solana Sarl', '2020-10-05', 2, '2020-10-26', '2020-11-26', 5000);
INSERT INTO Contrat VALUES (154, 'Peinture Int.', 7, 'Safemoon', '2020-10-07', 2, '2020-10-28', '2020-11-30', 2800);
INSERT INTO Contrat VALUES (155, 'Cloison Mobile', 1, 'Neo Flex', '2020-10-10', 2, '2020-10-31', '2020-12-14', 55500);
INSERT INTO Contrat VALUES (156, 'Platrerie', 9, 'Neo Sarl', '2020-10-10', 7, '2020-10-31', '2020-12-26', 2100);
INSERT INTO Contrat VALUES (157, 'Carrelage', 6, 'Reef SA', '2020-10-11', 9, '2020-11-01', '2020-12-09', 4700);
INSERT INTO Contrat VALUES (158, 'Revetements Sols', 6, 'Solana Sarl', '2020-10-11', 12, '2020-11-01', '2020-12-02', 2500);
INSERT INTO Contrat VALUES (159, 'Peinture Int.', 6, 'Safemoon', '2020-10-13', 5, '2020-11-03', '2020-12-06', 4600);
INSERT INTO Contrat VALUES (160, 'Portes Garages', 7, 'Pundix SA', '2020-10-29', 12, '2020-11-19', '2021-01-06', 2500);
INSERT INTO Contrat VALUES (161, 'Assainissement', 3, 'Bayer', '2020-11-06', 5, '2020-11-27', '2021-01-17', 2600);
INSERT INTO Contrat VALUES (162, 'Ascenseur', 8, 'Maxi Lifts', '2020-11-06', 13, '2020-11-27', '2021-01-01', 48600);
INSERT INTO Contrat VALUES (163, 'Carrelage', 5, 'OXT Carrelages', '2020-11-07', 12, '2020-11-28', '2021-01-31', 3400);
INSERT INTO Contrat VALUES (164, 'Platrerie', 1, 'Ontology SA', '2020-11-09', 5, '2020-11-30', '2021-01-09', 3300);
INSERT INTO Contrat VALUES (165, 'Serrurerie', 10, 'Aurora Sarl', '2020-11-09', 3, '2020-11-30', '2021-01-10', 3300);
INSERT INTO Contrat VALUES (166, 'Platrerie', 8, 'Vet SA', '2020-11-11', 13, '2020-12-02', '2021-02-06', 6500);
INSERT INTO Contrat VALUES (167, 'Menuiserie Int.', 8, 'Bayer', '2020-11-15', 1, '2020-12-06', '2021-01-16', 7000);
INSERT INTO Contrat VALUES (168, 'Menuiserie Int.', 9, 'La petite menuiserie SNC', '2020-11-17', 1, '2020-12-08', '2021-02-11', 3500);
INSERT INTO Contrat VALUES (169, 'Menuiserie Int.', 1, 'Bayer', '2020-11-19', 13, '2020-12-10', '2021-02-08', 6000);
INSERT INTO Contrat VALUES (170, 'Chapes', 9, 'Kambria Sarl', '2020-11-19', 6, '2020-12-10', '2021-01-30', 4000);
INSERT INTO Contrat VALUES (171, 'Chapes', 8, 'Kambria Sarl', '2020-11-20', 1, '2020-12-11', '2021-02-12', 3900);
INSERT INTO Contrat VALUES (172, 'Chapes', 1, 'Demoz SA', '2020-11-23', 6, '2020-12-14', '2021-02-06', 4800);
INSERT INTO Contrat VALUES (173, 'Peinture Int.', 2, 'Tezer SA', '2020-11-24', 7, '2020-12-15', '2021-01-14', 2200);
INSERT INTO Contrat VALUES (174, 'Portes Garages', 2, 'Pundix SA', '2020-11-28', 1, '2020-12-19', '2021-01-18', 4000);
INSERT INTO Contrat VALUES (175, 'Carrelage', 8, 'OXT Carrelages', '2020-11-28', 6, '2020-12-19', '2021-02-15', 3500);
INSERT INTO Contrat VALUES (176, 'Serrurerie', 2, 'Aurora Sarl', '2020-12-03', 6, '2020-12-24', '2021-02-14', 1500);
INSERT INTO Contrat VALUES (177, 'Carrelage', 1, 'Ontology SA', '2020-12-04', 7, '2020-12-25', '2021-02-23', 2600);
INSERT INTO Contrat VALUES (178, 'Revetements Sols', 1, 'Dash Sarl', '2020-12-04', 10, '2020-12-25', '2021-02-07', 4100);
INSERT INTO Contrat VALUES (179, 'Portes Garages', 6, 'Pundix SA', '2020-12-05', 10, '2020-12-26', '2021-02-14', 1400);
INSERT INTO Contrat VALUES (180, 'Platrerie', 4, 'Neo Sarl', '2020-12-07', 8, '2020-12-28', '2021-02-02', 4400);
INSERT INTO Contrat VALUES (181, 'Peinture Int.', 1, 'InsidePaint SA', '2020-12-08', 2, '2020-12-29', '2021-02-05', 2500);
INSERT INTO Contrat VALUES (182, 'Espaces Verts', 3, 'AX Espaces verts', '2020-12-10', 13, '2020-12-31', '2021-02-19', 3700);
INSERT INTO Contrat VALUES (183, 'Serrurerie', 7, 'Aurora Sarl', '2020-12-10', 1, '2020-12-31', '2021-02-21', 4700);
INSERT INTO Contrat VALUES (184, 'Amenagt. Ext. - Voirie', 7, 'DMM Paysages', '2020-12-14', 1, '2021-01-04', '2021-02-13', 1500);
INSERT INTO Contrat VALUES (185, 'Revetements Sols', 5, 'Bixa Sarl', '2020-12-16', 12, '2021-01-06', '2021-02-17', 4000);
INSERT INTO Contrat VALUES (186, 'Carrelage', 9, 'Dotana SA', '2020-12-16', 1, '2021-01-06', '2021-02-19', 1800);
INSERT INTO Contrat VALUES (187, 'Revetements Sols', 9, 'Dash Sarl', '2020-12-17', 7, '2021-01-07', '2021-02-12', 4100);
INSERT INTO Contrat VALUES (188, 'Portes Garages', 1, 'Pundix SA', '2020-12-19', 11, '2021-01-09', '2021-02-13', 2200);
INSERT INTO Contrat VALUES (189, 'Serrurerie', 1, 'Shiba Sarl', '2020-12-22', 5, '2021-01-12', '2021-03-13', 2400);
INSERT INTO Contrat VALUES (190, 'Garages', 3, 'AutoSilo SA', '2020-12-29', 5, '2021-01-19', '2021-03-28', 4800);
INSERT INTO Contrat VALUES (191, 'Peinture Int.', 5, 'Safemoon', '2021-01-03', 2, '2021-01-24', '2021-03-27', 3900);
INSERT INTO Contrat VALUES (192, 'Serrurerie', 5, 'Aurora Sarl', '2021-01-07', 3, '2021-01-28', '2021-03-30', 3100);
INSERT INTO Contrat VALUES (193, 'Amenagt. Ext. - Voirie', 2, 'DMM Paysages', '2021-01-08', 3, '2021-01-29', '2021-03-31', 4300);
INSERT INTO Contrat VALUES (194, 'Nettoyage Chantier', 3, 'Cleanser SA', '2021-01-08', 11, '2021-01-29', '2021-03-30', 3000);
INSERT INTO Contrat VALUES (195, 'Menuiserie Int.', 4, 'BR Buildings', '2021-01-08', 6, '2021-01-29', '2021-03-31', 6100);
INSERT INTO Contrat VALUES (196, 'Amenagt. Ext. - Voirie', 10, 'Ripple Sarl', '2021-01-11', 12, '2021-02-01', '2021-03-10', 4500);
INSERT INTO Contrat VALUES (197, 'Assainissement', 10, 'Ripple Sarl', '2021-01-20', 1, '2021-02-10', '2021-04-11', 3100);
INSERT INTO Contrat VALUES (198, 'Peinture Int.', 9, 'Safemoon', '2021-01-21', 5, '2021-02-11', '2021-04-21', 1900);
INSERT INTO Contrat VALUES (199, 'Amenagt. Ext. - Voirie', 1, 'AX Espaces verts', '2021-01-30', 7, '2021-02-20', '2021-04-22', 3500);
INSERT INTO Contrat VALUES (200, 'Serrurerie', 6, 'Aurora Sarl', '2021-02-02', 7, '2021-02-23', '2021-04-30', 1600);
INSERT INTO Contrat VALUES (201, 'Portes Garages', 9, 'Pundix SA', '2021-02-03', 7, '2021-02-24', '2021-04-02', 2200);
INSERT INTO Contrat VALUES (202, 'Serrurerie', 9, 'Aurora Sarl', '2021-02-04', 6, '2021-02-25', '2021-04-23', 2900);
INSERT INTO Contrat VALUES (203, 'Amenagt. Ext. - Voirie', 6, 'Ripple Sarl', '2021-02-05', 9, '2021-02-26', NULL, 1400);
INSERT INTO Contrat VALUES (204, 'Assainissement', 1, 'Bayer', '2021-02-06', 2, '2021-02-27', '2021-04-30', 3200);
INSERT INTO Contrat VALUES (205, 'Espaces Verts', 1, 'AX Espaces verts', '2021-02-12', 7, '2021-03-05', '2021-04-04', 1200);
INSERT INTO Contrat VALUES (206, 'Chapes', 4, 'Demoz SA', '2021-02-14', 6, '2021-03-07', '2021-04-16', 2700);
INSERT INTO Contrat VALUES (207, 'Revetements Sols', 8, 'Safemoon', '2021-02-14', 12, '2021-03-07', '2021-04-16', 3100);
INSERT INTO Contrat VALUES (208, 'Carrelage', 4, 'Dotana SA', '2021-02-17', 5, '2021-03-10', '2021-04-27', 2300);
INSERT INTO Contrat VALUES (209, 'Espaces Verts', 10, 'AX Espaces verts', '2021-02-18', 8, '2021-03-11', '2021-05-01', 3100);
INSERT INTO Contrat VALUES (210, 'Garages', 1, 'AutoSilo SA', '2021-02-24', 1, '2021-03-17', '2021-05-12', 4000);
INSERT INTO Contrat VALUES (211, 'Assainissement', 7, 'Bayer', '2021-02-24', 3, '2021-03-17', '2021-04-19', 4100);
INSERT INTO Contrat VALUES (212, 'Espaces Verts', 7, 'AX Espaces verts', '2021-02-26', 2, '2021-03-19', NULL, 2800);
INSERT INTO Contrat VALUES (213, 'Fondations Speciales', 3, 'Cellar SA', '2021-03-04', 3, '2021-03-25', '2021-05-02', 11000);
INSERT INTO Contrat VALUES (214, 'Amenagt. Ext. - Voirie', 5, 'AX Espaces verts', '2021-03-07', 13, '2021-03-28', '2021-06-01', 2900);
INSERT INTO Contrat VALUES (215, 'Peinture Int.', 8, 'Safemoon', '2021-03-07', 3, '2021-03-28', '2021-05-09', 4300);
INSERT INTO Contrat VALUES (216, 'Assainissement', 2, 'Bayer', '2021-03-08', 7, '2021-03-29', '2021-05-04', 4400);
INSERT INTO Contrat VALUES (217, 'Serrurerie', 8, 'Aurora Sarl', '2021-03-09', 3, '2021-03-30', '2021-04-30', 1200);
INSERT INTO Contrat VALUES (218, 'Clotures', 10, 'Glassdoor', '2021-03-10', 3, '2021-03-31', '2021-05-17', 2700);
INSERT INTO Contrat VALUES (219, 'Nettoyage Chantier', 1, 'Cleanser SA', '2021-03-12', 7, '2021-04-02', '2021-06-05', 4300);
INSERT INTO Contrat VALUES (220, 'Assainissement', 6, 'Ripple Sarl', '2021-03-14', 2, '2021-04-04', '2021-05-16', 3200);
INSERT INTO Contrat VALUES (221, 'Revetements Sols', 4, 'Solana Sarl', '2021-03-17', 9, '2021-04-07', '2021-05-27', 2500);
INSERT INTO Contrat VALUES (222, 'Nettoyage Chantier', 10, 'Cleanser SA', '2021-03-21', 2, '2021-04-11', '2021-05-24', 2600);
INSERT INTO Contrat VALUES (223, 'Fondations Speciales', 1, 'Cellar SA', '2021-03-22', 9, '2021-04-12', '2021-06-13', 11500);
INSERT INTO Contrat VALUES (224, 'Peinture Int.', 4, 'Safemoon', '2021-03-22', 5, '2021-04-12', '2021-06-12', 2700);
INSERT INTO Contrat VALUES (225, 'Amenagt. Ext. - Voirie', 9, 'Cardano SA', '2021-03-23', 3, '2021-04-13', '2021-06-06', 4300);
INSERT INTO Contrat VALUES (226, 'Espaces Verts', 6, 'AX Espaces verts', '2021-03-28', 8, '2021-04-18', '2021-05-23', 1400);
INSERT INTO Contrat VALUES (227, 'Portes Garages', 4, 'Pundix SA', '2021-03-30', 13, '2021-04-20', NULL, 1100);
INSERT INTO Contrat VALUES (228, 'Amenagt. Ext. - Voirie', 8, 'Cardano SA', '2021-04-04', 1, '2021-04-25', NULL, 2600);
INSERT INTO Contrat VALUES (229, 'Garages', 7, 'AutoSilo SA', '2021-04-05', 9, '2021-04-26', NULL, 3300);
INSERT INTO Contrat VALUES (230, 'Assainissement', 8, 'Cardano SA', '2021-04-06', 1, '2021-04-27', '2021-06-14', 2000);
INSERT INTO Contrat VALUES (231, 'Clotures', 6, 'Glassdoor', '2021-04-09', 12, '2021-04-30', '2021-06-24', 2400);
INSERT INTO Contrat VALUES (232, 'Nettoyage Chantier', 7, 'Cleanser SA', '2021-04-13', 3, '2021-05-04', '2021-06-08', 3600);
INSERT INTO Contrat VALUES (233, 'Serrurerie', 4, 'Aurora Sarl', '2021-04-18', 1, '2021-05-09', '2021-06-27', 2800);
INSERT INTO Contrat VALUES (234, 'Amenagt. Ext. - Voirie', 4, 'Cardano SA', '2021-04-19', 1, '2021-05-10', '2021-06-23', 4800);
INSERT INTO Contrat VALUES (235, 'Assainissement', 5, 'Cardano SA', '2021-04-22', 8, '2021-05-13', '2021-06-17', 4200);
INSERT INTO Contrat VALUES (236, 'Garages', 5, 'AutoSilo SA', '2021-04-26', 8, '2021-05-17', NULL, 2000);
INSERT INTO Contrat VALUES (237, 'Espaces Verts', 8, 'AX Espaces verts', '2021-04-29', 5, '2021-05-20', '2021-07-07', 3800);
INSERT INTO Contrat VALUES (238, 'Fondations Speciales', 7, 'Cellar SA', '2021-05-03', 9, '2021-05-24', '2021-07-17', 14700);
INSERT INTO Contrat VALUES (239, 'Photovolaique', 1, 'Insolar Volta SA', '2021-05-05', 1, '2021-05-26', '2021-07-22', 16000);
INSERT INTO Contrat VALUES (240, 'Garages', 2, 'AutoSilo SA', '2021-05-10', 9, '2021-05-31', '2021-07-07', 4400);
INSERT INTO Contrat VALUES (241, 'Clotures', 8, 'Glassdoor', '2021-05-10', 9, '2021-05-31', NULL, 3300);
INSERT INTO Contrat VALUES (242, 'Assainissement', 9, 'MultiVAC SA', '2021-05-12', 2, '2021-06-02', NULL, 2200);
INSERT INTO Contrat VALUES (243, 'Nettoyage Chantier', 6, 'Cleanser SA', '2021-05-17', 1, '2021-06-07', '2021-08-03', 3800);
INSERT INTO Contrat VALUES (244, 'Assainissement', 4, 'Cardano SA', '2021-05-18', 6, '2021-06-08', '2021-08-01', 4400);
INSERT INTO Contrat VALUES (245, 'Photovolaique', 3, 'Insolar Volta SA', '2021-05-19', 5, '2021-06-09', '2021-07-17', 18500);
INSERT INTO Contrat VALUES (246, 'Photovolaique', 10, 'Insolar Volta SA', '2021-05-20', 8, '2021-06-10', '2021-07-15', 9500);
INSERT INTO Contrat VALUES (247, 'Nettoyage Chantier', 5, 'Quick Cleaner SA', '2021-05-23', 6, '2021-06-13', NULL, 4200);
INSERT INTO Contrat VALUES (248, 'Nettoyage Chantier', 8, 'Cleanser SA', '2021-05-23', 2, '2021-06-13', NULL, 3200);
INSERT INTO Contrat VALUES (249, 'Espaces Verts', 9, 'Cardano SA', '2021-05-23', 2, '2021-06-13', '2021-07-18', 4700);
INSERT INTO Contrat VALUES (250, 'Nettoyage Chantier', 2, 'Cleanser SA', '2021-05-26', 11, '2021-06-16', '2021-08-20', 4500);
INSERT INTO Contrat VALUES (251, 'Photovolaique', 7, 'Insolar Volta SA', '2021-05-26', 2, '2021-06-16', '2021-08-01', 25100);
INSERT INTO Contrat VALUES (252, 'Photovolaique', 6, 'Insolar Volta SA', '2021-05-27', 5, '2021-06-17', '2021-07-17', 15000);
INSERT INTO Contrat VALUES (253, 'Espaces Verts', 4, 'AX Espaces verts', '2021-06-07', 3, '2021-06-28', '2021-08-17', 3200);
INSERT INTO Contrat VALUES (254, 'Nettoyage Chantier', 4, 'Cleanser SA', '2021-06-08', 9, '2021-06-29', '2021-08-30', 4000);
INSERT INTO Contrat VALUES (255, 'Nettoyage Chantier', 9, 'Cleanser SA', '2021-06-13', 6, '2021-07-04', '2021-09-07', 3300);
INSERT INTO Contrat VALUES (256, 'Fondations Speciales', 9, 'Cellar SA', '2021-06-23', 5, '2021-07-14', '2021-09-19', 15300);

-- sqlserver /*
GO
-- sqlserver */

-- Table Facture
-- (No, ContratNo, EntrepriseNom, DateFacturation, MontantFacture, Statut)
INSERT INTO Facture VALUES (1, 2, 'Cardano SA', '2019-11-23', 48700, 'Paye');
INSERT INTO Facture VALUES (2, 3, 'Ripple Sarl', '2019-11-29', 56600, 'Refuse');
INSERT INTO Facture VALUES (3, 13, 'Dash Sarl', '2019-12-12', 2700, 'Paye');
INSERT INTO Facture VALUES (4, 3, 'Ripple Sarl', '2019-12-15', 53000, 'Paye');
INSERT INTO Facture VALUES (5, 135, 'Zil Energies', '2019-12-20', 20500, 'Paye');
INSERT INTO Facture VALUES (6, 12, 'Charpentes Infini', '2019-12-21', 4300, 'Paye');
INSERT INTO Facture VALUES (7, 8, 'Cardano SA', '2019-12-24', 41900, 'Paye');
INSERT INTO Facture VALUES (8, 17, 'Q-tum Sarl', '2019-12-28', 134500, 'Paye');
INSERT INTO Facture VALUES (9, 26, 'HF- Charpente', '2020-01-01', 22700, 'Paye');
INSERT INTO Facture VALUES (10, 23, 'Giessen', '2020-01-04', 24500, 'Paye');
INSERT INTO Facture VALUES (11, 24, 'Cardano SA', '2020-01-04', 33900, 'Paye');
INSERT INTO Facture VALUES (12, 6, 'Vss Global', '2020-01-05', 84500, 'Paye');
INSERT INTO Facture VALUES (13, 7, 'Chiliz SA', '2020-01-05', 8400, 'Paye');
INSERT INTO Facture VALUES (14, 18, 'Giessen', '2020-01-17', 8900, 'Paye');
INSERT INTO Facture VALUES (15, 4, 'Q-tum Sarl', '2020-01-19', 206200, 'Paye');
INSERT INTO Facture VALUES (16, 15, 'Chiliz SA', '2020-01-27', 138500, 'Paye');
INSERT INTO Facture VALUES (17, 1, 'Ripple Sarl', '2020-01-28', 45200, 'Paye');
INSERT INTO Facture VALUES (18, 20, 'ForestPlus SA', '2020-01-29', 18700, 'Paye');
INSERT INTO Facture VALUES (19, 9, 'Cardano SA', '2020-01-30', 67800, 'Paye');
INSERT INTO Facture VALUES (20, 10, 'Q-tum Sarl', '2020-02-02', 101300, 'Paye');
INSERT INTO Facture VALUES (21, 28, 'Firo Constructions Sarl', '2020-02-06', 14600, 'Paye');
INSERT INTO Facture VALUES (22, 5, 'Cardano SA', '2020-02-08', 75300, 'Paye');
INSERT INTO Facture VALUES (23, 31, 'Luxx SA', '2020-02-09', 13800, 'Paye');
INSERT INTO Facture VALUES (24, 37, 'Vss Global', '2020-02-09', 86800, 'Paye');
INSERT INTO Facture VALUES (25, 39, 'BCD SA', '2020-02-13', 18400, 'Paye');
INSERT INTO Facture VALUES (26, 35, 'IC Sanitaire', '2020-02-16', 3900, 'Paye');
INSERT INTO Facture VALUES (27, 30, 'Firo Constructions Sarl', '2020-02-17', 23000, 'Paye');
INSERT INTO Facture VALUES (28, 11, 'Cardano SA', '2020-02-18', 100700, 'Paye');
INSERT INTO Facture VALUES (29, 25, 'Firo Constructions Sarl', '2020-02-20', 9800, 'Paye');
INSERT INTO Facture VALUES (30, 27, 'Rieder Etancheite', '2020-02-22', 14400, 'Paye');
INSERT INTO Facture VALUES (31, 14, 'Cardano SA', '2020-02-24', 48500, 'Paye');
INSERT INTO Facture VALUES (32, 22, 'Cardano SA', '2020-02-24', 39200, 'Paye');
INSERT INTO Facture VALUES (33, 40, 'Chiliz SA', '2020-02-24', 17000, 'Paye');
INSERT INTO Facture VALUES (34, 48, 'Cortex SA', '2020-02-28', 27300, 'Paye');
INSERT INTO Facture VALUES (35, 16, 'Luxx SA', '2020-03-02', 19300, 'Paye');
INSERT INTO Facture VALUES (36, 19, 'Q-tum Sarl', '2020-03-03', 90300, 'Paye');
INSERT INTO Facture VALUES (37, 47, 'Giessen', '2020-03-03', 5900, 'Paye');
INSERT INTO Facture VALUES (38, 36, 'ForestPlus SA', '2020-03-08', 10300, 'Paye');
INSERT INTO Facture VALUES (39, 38, 'Firo Constructions Sarl', '2020-03-12', 14400, 'Paye');
INSERT INTO Facture VALUES (40, 21, 'AF-Couvertures', '2020-03-13', 21100, 'Paye');
INSERT INTO Facture VALUES (41, 34, 'Chiliz SA', '2020-03-15', 12200, 'Paye');
INSERT INTO Facture VALUES (42, 53, 'BCD SA', '2020-03-17', 18500, 'Paye');
INSERT INTO Facture VALUES (43, 45, 'Chiliz SA', '2020-03-18', 21400, 'Paye');
INSERT INTO Facture VALUES (44, 50, 'Cortex SA', '2020-03-29', 10700, 'Paye');
INSERT INTO Facture VALUES (45, 55, 'Q-tum Sarl', '2020-03-31', 131500, 'Paye');
INSERT INTO Facture VALUES (46, 33, 'Chiliz SA', '2020-04-02', 16400, 'Paye');
INSERT INTO Facture VALUES (47, 29, 'Dash Sarl', '2020-04-07', 2500, 'Paye');
INSERT INTO Facture VALUES (48, 41, 'Wing SA', '2020-04-07', 281500, 'Paye');
INSERT INTO Facture VALUES (49, 63, 'FMS', '2020-04-07', 27500, 'Paye');
INSERT INTO Facture VALUES (50, 32, 'Cortex SA', '2020-04-08', 9700, 'Paye');
INSERT INTO Facture VALUES (51, 43, 'Dash Sarl', '2020-04-09', 5000, 'Paye');
INSERT INTO Facture VALUES (52, 70, 'IC Sanitaire', '2020-04-15', 3200, 'Paye');
INSERT INTO Facture VALUES (53, 67, 'GXChain SA', '2020-04-16', 23400, 'Refuse');
INSERT INTO Facture VALUES (54, 49, 'Cortex SA', '2020-04-19', 9100, 'Paye');
INSERT INTO Facture VALUES (55, 44, 'Chiliz SA', '2020-04-24', 31000, 'Paye');
INSERT INTO Facture VALUES (56, 67, 'GXChain SA', '2020-04-24', 19500, 'Paye');
INSERT INTO Facture VALUES (57, 54, 'C-Concepts', '2020-04-27', 18500, 'Paye');
INSERT INTO Facture VALUES (58, 61, 'ForestPlus SA', '2020-05-04', 5600, 'Paye');
INSERT INTO Facture VALUES (59, 52, 'Cardano SA', '2020-05-07', 78000, 'Paye');
INSERT INTO Facture VALUES (60, 58, 'Luxx SA', '2020-05-07', 9100, 'Paye');
INSERT INTO Facture VALUES (61, 51, 'JFG SERVICES', '2020-05-10', 19300, 'Paye');
INSERT INTO Facture VALUES (62, 42, 'Espaces Calorie SA', '2020-05-11', 25200, 'Paye');
INSERT INTO Facture VALUES (63, 57, 'Firo Constructions Sarl', '2020-05-14', 17000, 'Paye');
INSERT INTO Facture VALUES (64, 60, 'Doge SA', '2020-05-14', 2700, 'Paye');
INSERT INTO Facture VALUES (65, 79, 'Giessen', '2020-05-16', 19000, 'Paye');
INSERT INTO Facture VALUES (66, 71, 'Zil Energies', '2020-05-19', 17700, 'Paye');
INSERT INTO Facture VALUES (67, 85, 'IC Sanitaire', '2020-05-19', 5600, 'Paye');
INSERT INTO Facture VALUES (68, 46, 'GXChain SA', '2020-05-22', 24200, 'Paye');
INSERT INTO Facture VALUES (69, 75, 'GXChain SA', '2020-05-22', 19000, 'Paye');
INSERT INTO Facture VALUES (70, 78, 'Mast Elec Sarl', '2020-05-22', 6400, 'Paye');
INSERT INTO Facture VALUES (71, 56, 'Firo Constructions Sarl', '2020-05-24', 22400, 'Paye');
INSERT INTO Facture VALUES (72, 59, 'Chiliz SA', '2020-05-24', 27700, 'Paye');
INSERT INTO Facture VALUES (73, 65, 'BCD SA', '2020-05-24', 22300, 'Paye');
INSERT INTO Facture VALUES (74, 72, 'BCD SA', '2020-05-25', 20800, 'Paye');
INSERT INTO Facture VALUES (75, 64, 'Q-tum Sarl', '2020-05-31', 220600, 'Refuse');
INSERT INTO Facture VALUES (76, 76, 'Vet SA', '2020-06-02', 6000, 'Paye');
INSERT INTO Facture VALUES (77, 94, 'Itos Sarl', '2020-06-02', 58500, 'Paye');
INSERT INTO Facture VALUES (78, 77, 'La petite menuiserie SNC', '2020-06-05', 5000, 'Paye');
INSERT INTO Facture VALUES (79, 81, 'Doge SA', '2020-06-11', 5800, 'Paye');
INSERT INTO Facture VALUES (80, 90, 'Mast Elec Sarl', '2020-06-11', 8200, 'Paye');
INSERT INTO Facture VALUES (81, 82, 'Doge SA', '2020-06-12', 14700, 'Paye');
INSERT INTO Facture VALUES (82, 66, 'Mast Elec Sarl', '2020-06-13', 4600, 'Paye');
INSERT INTO Facture VALUES (83, 97, 'Itos Sarl', '2020-06-13', 32100, 'Paye');
INSERT INTO Facture VALUES (84, 62, 'Mast Elec Sarl', '2020-06-16', 16700, 'Paye');
INSERT INTO Facture VALUES (85, 73, 'C-Concepts', '2020-06-21', 25100, 'Paye');
INSERT INTO Facture VALUES (86, 101, 'Cortex SA', '2020-06-23', 33400, 'Paye');
INSERT INTO Facture VALUES (87, 64, 'Q-tum Sarl', '2020-06-25', 215000, 'Refuse');
INSERT INTO Facture VALUES (88, 69, 'IC Sanitaire', '2020-06-26', 2800, 'Paye');
INSERT INTO Facture VALUES (89, 95, 'Mast Elec Sarl', '2020-06-26', 4200, 'Paye');
INSERT INTO Facture VALUES (90, 96, 'Mast Elec Sarl', '2020-06-26', 7300, 'Paye');
INSERT INTO Facture VALUES (91, 86, 'Zil Energies', '2020-06-27', 13700, 'Paye');
INSERT INTO Facture VALUES (92, 68, 'GXChain SA', '2020-06-30', 24700, 'Paye');
INSERT INTO Facture VALUES (93, 89, 'Zil Energies', '2020-07-05', 17800, 'Paye');
INSERT INTO Facture VALUES (94, 93, 'Espaces Calorie SA', '2020-07-07', 9900, 'Paye');
INSERT INTO Facture VALUES (95, 98, 'Mast Elec Sarl', '2020-07-08', 4500, 'Paye');
INSERT INTO Facture VALUES (96, 74, 'Mast Elec Sarl', '2020-07-10', 14100, 'Paye');
INSERT INTO Facture VALUES (97, 92, 'Crepi Max', '2020-07-10', 30300, 'Paye');
INSERT INTO Facture VALUES (98, 88, 'Doge SA', '2020-07-11', 6800, 'Paye');
INSERT INTO Facture VALUES (99, 109, 'Vet SA', '2020-07-11', 2500, 'Paye');
INSERT INTO Facture VALUES (100, 83, 'Doge SA', '2020-07-23', 6400, 'Paye');
INSERT INTO Facture VALUES (101, 100, 'IC Sanitaire', '2020-07-23', 1400, 'Paye');
INSERT INTO Facture VALUES (102, 80, 'ForestPlus SA', '2020-07-24', 14100, 'Paye');
INSERT INTO Facture VALUES (103, 87, 'Kambria Sarl', '2020-07-24', 4200, 'Paye');
INSERT INTO Facture VALUES (104, 117, 'La petite menuiserie SNC', '2020-07-26', 4700, 'Paye');
INSERT INTO Facture VALUES (105, 102, 'OXT Carrelages', '2020-07-31', 4400, 'Paye');
INSERT INTO Facture VALUES (106, 111, 'Chiliz SA', '2020-08-03', 17100, 'Paye');
INSERT INTO Facture VALUES (107, 84, 'IC Sanitaire', '2020-08-05', 2100, 'Paye');
INSERT INTO Facture VALUES (108, 118, 'Kambria Sarl', '2020-08-08', 1500, 'Paye');
INSERT INTO Facture VALUES (109, 64, 'Q-tum Sarl', '2020-08-10', 198000, 'Paye');
INSERT INTO Facture VALUES (110, 107, 'BCD SA', '2020-08-11', 33000, 'Paye');
INSERT INTO Facture VALUES (111, 112, 'Safemoon', '2020-08-17', 2700, 'Paye');
INSERT INTO Facture VALUES (112, 113, 'Vet SA', '2020-08-17', 8500, 'Paye');
INSERT INTO Facture VALUES (113, 91, 'Luxx SA', '2020-08-24', 14900, 'Paye');
INSERT INTO Facture VALUES (114, 106, 'Espaces Calorie SA', '2020-08-24', 8100, 'Paye');
INSERT INTO Facture VALUES (115, 104, 'EJX Energies', '2020-08-25', 27200, 'Paye');
INSERT INTO Facture VALUES (116, 114, 'Link Ampere SA', '2020-08-26', 1900, 'Paye');
INSERT INTO Facture VALUES (117, 99, 'Maxi Lifts', '2020-08-27', 80400, 'Paye');
INSERT INTO Facture VALUES (118, 119, 'Pundix SA', '2020-08-27', 3700, 'Paye');
INSERT INTO Facture VALUES (119, 123, 'Doge SA', '2020-08-28', 5400, 'Paye');
INSERT INTO Facture VALUES (120, 108, 'Link Ampere SA', '2020-09-03', 22300, 'Paye');
INSERT INTO Facture VALUES (121, 103, 'Firo Constructions Sarl', '2020-09-06', 22400, 'Paye');
INSERT INTO Facture VALUES (122, 116, 'La petite menuiserie SNC', '2020-09-06', 1800, 'Paye');
INSERT INTO Facture VALUES (123, 105, 'Firo Constructions Sarl', '2020-09-09', 21000, 'Paye');
INSERT INTO Facture VALUES (124, 110, 'Solana Sarl', '2020-09-12', 2300, 'Paye');
INSERT INTO Facture VALUES (125, 124, 'Neo Sarl', '2020-09-12', 3100, 'Paye');
INSERT INTO Facture VALUES (126, 126, 'Doge SA', '2020-09-13', 8200, 'Paye');
INSERT INTO Facture VALUES (127, 131, 'Doge SA', '2020-09-15', 13400, 'Paye');
INSERT INTO Facture VALUES (128, 121, 'OXT Carrelages', '2020-09-17', 6700, 'Paye');
INSERT INTO Facture VALUES (129, 120, 'Vet SA', '2020-09-19', 1800, 'Paye');
INSERT INTO Facture VALUES (130, 130, 'BR Buildings', '2020-09-20', 9200, 'Paye');
INSERT INTO Facture VALUES (131, 133, 'Maxi Lifts', '2020-09-27', 40600, 'Paye');
INSERT INTO Facture VALUES (132, 125, 'Aurora Sarl', '2020-09-29', 2500, 'Paye');
INSERT INTO Facture VALUES (133, 122, 'Kambria Sarl', '2020-10-02', 5400, 'Paye');
INSERT INTO Facture VALUES (134, 115, 'Crepi Max', '2020-10-07', 25600, 'Paye');
INSERT INTO Facture VALUES (135, 137, 'Reef SA', '2020-10-08', 1200, 'Paye');
INSERT INTO Facture VALUES (136, 132, 'La petite menuiserie SNC', '2020-10-10', 5500, 'Paye');
INSERT INTO Facture VALUES (137, 128, 'Chiliz SA', '2020-10-20', 31900, 'Paye');
INSERT INTO Facture VALUES (138, 146, 'Doge SA', '2020-10-21', 20300, 'Paye');
INSERT INTO Facture VALUES (139, 136, 'Link Ampere SA', '2020-10-28', 11100, 'Paye');
INSERT INTO Facture VALUES (140, 143, 'Doge SA', '2020-10-30', 2100, 'Paye');
INSERT INTO Facture VALUES (141, 140, 'Kambria Sarl', '2020-11-02', 2500, 'Paye');
INSERT INTO Facture VALUES (142, 144, 'Link Ampere SA', '2020-11-02', 2700, 'Paye');
INSERT INTO Facture VALUES (143, 150, 'Itos Sarl', '2020-11-02', 18800, 'Paye');
INSERT INTO Facture VALUES (144, 149, 'La petite menuiserie SNC', '2020-11-06', 3600, 'Paye');
INSERT INTO Facture VALUES (145, 139, 'Link Ampere SA', '2020-11-07', 3000, 'Paye');
INSERT INTO Facture VALUES (146, 127, 'Solana Sarl', '2020-11-08', 3400, 'Paye');
INSERT INTO Facture VALUES (147, 158, 'Solana Sarl', '2020-11-12', 2000, 'Paye');
INSERT INTO Facture VALUES (148, 138, 'Solana Sarl', '2020-11-15', 5000, 'Paye');
INSERT INTO Facture VALUES (149, 142, 'Dotana SA', '2020-11-18', 3700, 'Paye');
INSERT INTO Facture VALUES (150, 155, 'Neo Flex', '2020-11-21', 74900, 'Paye');
INSERT INTO Facture VALUES (151, 129, 'Espaces Wend Sarl', '2020-11-23', 5600, 'Paye');
INSERT INTO Facture VALUES (152, 141, 'EJX Energies', '2020-11-24', 9800, 'Paye');
INSERT INTO Facture VALUES (153, 151, 'Doge SA', '2020-11-24', 4000, 'Paye');
INSERT INTO Facture VALUES (154, 134, 'OXT Carrelages', '2020-11-26', 5400, 'Paye');
INSERT INTO Facture VALUES (155, 153, 'Solana Sarl', '2020-11-30', 6100, 'Paye');
INSERT INTO Facture VALUES (156, 166, 'Vet SA', '2020-12-03', 4600, 'Paye');
INSERT INTO Facture VALUES (157, 147, 'Vet SA', '2020-12-04', 2600, 'Paye');
INSERT INTO Facture VALUES (158, 135, 'Zil Energies', '2020-12-05', 24600, 'Refuse');
INSERT INTO Facture VALUES (159, 145, 'DMM Paysages', '2020-12-13', 3500, 'Paye');
INSERT INTO Facture VALUES (160, 167, 'Bayer', '2020-12-21', 5500, 'Paye');
INSERT INTO Facture VALUES (161, 176, 'Aurora Sarl', '2020-12-26', 1100, 'Paye');
INSERT INTO Facture VALUES (162, 152, 'ICM Shapes', '2020-12-28', 3300, 'Paye');
INSERT INTO Facture VALUES (163, 154, 'Safemoon', '2021-01-02', 3400, 'Paye');
INSERT INTO Facture VALUES (164, 148, 'Safemoon', '2021-01-06', 3300, 'Paye');
INSERT INTO Facture VALUES (165, 160, 'Pundix SA', '2021-01-08', 1800, 'Paye');
INSERT INTO Facture VALUES (166, 178, 'Dash Sarl', '2021-01-11', 4100, 'Paye');
INSERT INTO Facture VALUES (167, 157, 'Reef SA', '2021-01-14', 5800, 'Paye');
INSERT INTO Facture VALUES (168, 164, 'Ontology SA', '2021-01-14', 3200, 'Paye');
INSERT INTO Facture VALUES (169, 172, 'Demoz SA', '2021-01-16', 5100, 'Paye');
INSERT INTO Facture VALUES (170, 188, 'Pundix SA', '2021-01-16', 2600, 'Paye');
INSERT INTO Facture VALUES (171, 175, 'OXT Carrelages', '2021-01-17', 4600, 'Paye');
INSERT INTO Facture VALUES (172, 186, 'Dotana SA', '2021-01-19', 2000, 'Paye');
INSERT INTO Facture VALUES (173, 189, 'Shiba Sarl', '2021-01-19', 3100, 'Paye');
INSERT INTO Facture VALUES (174, 181, 'InsidePaint SA', '2021-01-21', 2000, 'Paye');
INSERT INTO Facture VALUES (175, 159, 'Safemoon', '2021-01-23', 5400, 'Paye');
INSERT INTO Facture VALUES (176, 179, 'Pundix SA', '2021-01-23', 1700, 'Paye');
INSERT INTO Facture VALUES (177, 169, 'Bayer', '2021-01-24', 8000, 'Paye');
INSERT INTO Facture VALUES (178, 156, 'Neo Sarl', '2021-01-25', 2800, 'Paye');
INSERT INTO Facture VALUES (179, 165, 'Aurora Sarl', '2021-01-25', 4500, 'Paye');
INSERT INTO Facture VALUES (180, 180, 'Neo Sarl', '2021-01-27', 4400, 'Paye');
INSERT INTO Facture VALUES (181, 177, 'Ontology SA', '2021-01-31', 2600, 'Paye');
INSERT INTO Facture VALUES (182, 173, 'Tezer SA', '2021-02-02', 2400, 'Paye');
INSERT INTO Facture VALUES (183, 185, 'Bixa Sarl', '2021-02-04', 5500, 'Paye');
INSERT INTO Facture VALUES (184, 170, 'Kambria Sarl', '2021-02-14', 4900, 'Paye');
INSERT INTO Facture VALUES (185, 161, 'Bayer', '2021-02-15', 2100, 'Paye');
INSERT INTO Facture VALUES (186, 191, 'Safemoon', '2021-02-15', 5300, 'Paye');
INSERT INTO Facture VALUES (187, 162, 'Maxi Lifts', '2021-02-18', 55400, 'Paye');
INSERT INTO Facture VALUES (188, 163, 'OXT Carrelages', '2021-02-18', 2900, 'Paye');
INSERT INTO Facture VALUES (189, 190, 'AutoSilo SA', '2021-02-23', 3900, 'Paye');
INSERT INTO Facture VALUES (190, 187, 'Dash Sarl', '2021-02-25', 4600, 'Paye');
INSERT INTO Facture VALUES (191, 168, 'La petite menuiserie SNC', '2021-03-03', 4600, 'Paye');
INSERT INTO Facture VALUES (192, 171, 'Kambria Sarl', '2021-03-03', 4400, 'Paye');
INSERT INTO Facture VALUES (193, 205, 'AX Espaces verts', '2021-03-08', 1400, 'Paye');
INSERT INTO Facture VALUES (194, 199, 'AX Espaces verts', '2021-03-09', 4600, 'Paye');
INSERT INTO Facture VALUES (195, 200, 'Aurora Sarl', '2021-03-11', 1600, 'Paye');
INSERT INTO Facture VALUES (196, 174, 'Pundix SA', '2021-03-16', 3400, 'Paye');
INSERT INTO Facture VALUES (197, 184, 'DMM Paysages', '2021-03-17', 1200, 'Paye');
INSERT INTO Facture VALUES (198, 182, 'AX Espaces verts', '2021-03-18', 3500, 'Paye');
INSERT INTO Facture VALUES (199, 183, 'Aurora Sarl', '2021-03-23', 4600, 'Paye');
INSERT INTO Facture VALUES (200, 201, 'Pundix SA', '2021-03-23', 2100, 'Paye');
INSERT INTO Facture VALUES (201, 204, 'Bayer', '2021-03-24', 4300, 'Paye');
INSERT INTO Facture VALUES (202, 206, 'Demoz SA', '2021-03-26', 3300, 'Paye');
INSERT INTO Facture VALUES (203, 193, 'DMM Paysages', '2021-03-27', 4600, 'Paye');
INSERT INTO Facture VALUES (204, 194, 'Cleanser SA', '2021-04-03', 3700, 'Paye');
INSERT INTO Facture VALUES (205, 212, 'AX Espaces verts', '2021-04-05', 3100, 'Paye');
INSERT INTO Facture VALUES (206, 192, 'Aurora Sarl', '2021-04-06', 2800, 'Paye');
INSERT INTO Facture VALUES (207, 218, 'Glassdoor', '2021-04-06', 2800, 'Paye');
INSERT INTO Facture VALUES (208, 196, 'Ripple Sarl', '2021-04-12', 4900, 'Paye');
INSERT INTO Facture VALUES (209, 208, 'Dotana SA', '2021-04-13', 1600, 'Paye');
INSERT INTO Facture VALUES (210, 225, 'Cardano SA', '2021-04-14', 4500, 'Paye');
INSERT INTO Facture VALUES (211, 198, 'Safemoon', '2021-04-16', 2100, 'Paye');
INSERT INTO Facture VALUES (212, 215, 'Safemoon', '2021-04-16', 3500, 'Paye');
INSERT INTO Facture VALUES (213, 203, 'Ripple Sarl', '2021-04-17', 1700, 'Paye');
INSERT INTO Facture VALUES (214, 214, 'AX Espaces verts', '2021-04-17', 2800, 'Paye');
INSERT INTO Facture VALUES (215, 211, 'Bayer', '2021-04-18', 3600, 'Paye');
INSERT INTO Facture VALUES (216, 195, 'BR Buildings', '2021-04-20', 5700, 'Paye');
INSERT INTO Facture VALUES (217, 221, 'Solana Sarl', '2021-04-24', 2100, 'Paye');
INSERT INTO Facture VALUES (218, 217, 'Aurora Sarl', '2021-04-26', 900, 'Paye');
INSERT INTO Facture VALUES (219, 202, 'Aurora Sarl', '2021-04-27', 3300, 'Paye');
INSERT INTO Facture VALUES (220, 197, 'Ripple Sarl', '2021-05-01', 4000, 'Paye');
INSERT INTO Facture VALUES (221, 228, 'Cardano SA', '2021-05-02', 3300, 'Paye');
INSERT INTO Facture VALUES (222, 230, 'Cardano SA', '2021-05-04', 1500, 'Paye');
INSERT INTO Facture VALUES (223, 207, 'Safemoon', '2021-05-06', 3700, 'Paye');
INSERT INTO Facture VALUES (224, 216, 'Bayer', '2021-05-07', 5000, 'Paye');
INSERT INTO Facture VALUES (225, 209, 'AX Espaces verts', '2021-05-14', 4000, 'Paye');
INSERT INTO Facture VALUES (226, 227, 'Pundix SA', '2021-05-22', 1400, 'Paye');
INSERT INTO Facture VALUES (227, 237, 'AX Espaces verts', '2021-05-24', 3200, 'Paye');
INSERT INTO Facture VALUES (228, 236, 'AutoSilo SA', '2021-05-26', 1700, 'Paye');
INSERT INTO Facture VALUES (229, 239, 'Insolar Volta SA', '2021-05-30', 17300, 'Paye');
INSERT INTO Facture VALUES (230, 210, 'AutoSilo SA', '2021-06-01', 4400, 'Paye');
INSERT INTO Facture VALUES (231, 224, 'Safemoon', '2021-06-01', 2600, 'En suspens');
INSERT INTO Facture VALUES (232, 220, 'Ripple Sarl', '2021-06-03', 3100, 'Paye');
INSERT INTO Facture VALUES (233, 229, 'AutoSilo SA', '2021-06-09', 3900, 'Paye');
INSERT INTO Facture VALUES (234, 231, 'Glassdoor', '2021-06-09', 1900, 'Paye');
INSERT INTO Facture VALUES (235, 246, 'Insolar Volta SA', '2021-06-12', 6700, 'Paye');
INSERT INTO Facture VALUES (236, 213, 'Cellar SA', '2021-06-14', 11300, 'Paye');
INSERT INTO Facture VALUES (237, 240, 'AutoSilo SA', '2021-06-14', 5500, 'Paye');
INSERT INTO Facture VALUES (238, 222, 'Cleanser SA', '2021-06-19', 2500, 'Paye');
INSERT INTO Facture VALUES (239, 219, 'Cleanser SA', '2021-06-21', 5700, 'Paye');
INSERT INTO Facture VALUES (240, 245, 'Insolar Volta SA', '2021-06-23', 23900, 'Paye');
INSERT INTO Facture VALUES (241, 226, 'AX Espaces verts', '2021-06-28', 1700, 'Paye');
INSERT INTO Facture VALUES (242, 234, 'Cardano SA', '2021-07-01', 3900, 'Paye');
INSERT INTO Facture VALUES (243, 252, 'Insolar Volta SA', '2021-07-02', 13400, 'Paye');
INSERT INTO Facture VALUES (244, 241, 'Glassdoor', '2021-07-05', 4100, 'Paye');
INSERT INTO Facture VALUES (245, 223, 'Cellar SA', '2021-07-08', 10100, 'En suspens');
INSERT INTO Facture VALUES (246, 233, 'Aurora Sarl', '2021-07-19', 3000, 'Paye');
INSERT INTO Facture VALUES (247, 232, 'Cleanser SA', '2021-07-22', 4700, 'Paye');
INSERT INTO Facture VALUES (248, 242, 'MultiVAC SA', '2021-07-23', 3000, 'Paye');
INSERT INTO Facture VALUES (249, 238, 'Cellar SA', '2021-08-03', 16000, 'Refuse');
INSERT INTO Facture VALUES (250, 235, 'Cardano SA', '2021-08-05', 4200, 'Paye');
INSERT INTO Facture VALUES (251, 251, 'Insolar Volta SA', '2021-08-06', 19100, 'En suspens');
INSERT INTO Facture VALUES (252, 243, 'Cleanser SA', '2021-08-16', 2900, 'Paye');
INSERT INTO Facture VALUES (253, 248, 'Cleanser SA', '2021-08-17', 4100, 'Paye');
INSERT INTO Facture VALUES (254, 238, 'Cellar SA', '2021-08-18', 15200, 'Paye');
INSERT INTO Facture VALUES (255, 244, 'Cardano SA', '2021-08-19', 4100, 'Paye');
INSERT INTO Facture VALUES (256, 253, 'AX Espaces verts', '2021-08-21', 2800, 'Paye');
INSERT INTO Facture VALUES (257, 247, 'Quick Cleaner SA', '2021-08-29', 4000, 'Paye');
INSERT INTO Facture VALUES (258, 250, 'Cleanser SA', '2021-08-30', 3900, 'Paye');
INSERT INTO Facture VALUES (259, 249, 'Cardano SA', '2021-09-10', 5300, 'Paye');
INSERT INTO Facture VALUES (260, 254, 'Cleanser SA', '2021-09-13', 5100, 'En suspens');
INSERT INTO Facture VALUES (261, 255, 'Cleanser SA', '2021-09-14', 3600, 'En suspens');
INSERT INTO Facture VALUES (262, 256, 'Cellar SA', '2021-09-25', 21300, 'En suspens');

-- sqlserver /*
GO
-- sqlserver */
