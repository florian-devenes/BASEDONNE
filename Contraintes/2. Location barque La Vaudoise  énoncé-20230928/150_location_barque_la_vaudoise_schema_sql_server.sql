-- ----------------------------------------------------------
-- ---------------------------------------------------------------------------
-- script :         schema.sql
-- database:        location_barque_la_vaudoise
-- contributors :   Gabor Maksay (gmy)
--                  Olivier Moullet (omt)
--                  Mahtias Oberson (mon)
-- history :        when       | ver | who | what
--                  2019-01-08 | 2.0 | mon | compliance
--                  2017-xx-xx | 1.0 | omt | creation

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Création de la BD sur SQLServer
USE master;

-- Cherche une BD appellée LocationBarqueLaVaudoise et la supprime le cas échéant
IF EXISTS(SELECT * FROM sys.databases WHERE NAME='LocationBarqueLaVaudoise')
DROP DATABASE LocationBarqueLaVaudoise;
GO

-- Crée la BD et l'utilise
CREATE DATABASE LocationBarqueLaVaudoise;
GO

USE LocationBarqueLaVaudoise;
GO

-- ----------------------------------------------------------
-- ----------------------------------------------------------

-- Création de la BD sur PostgreSQL

/*
DROP DATABASE "LocationBarqueLaVaudoise";

CREATE DATABASE "LocationBarqueLaVaudoise";
*/

-- Suppression des tables et de toutes les contraintes liées
-- À commenter pour SQLServer
-- DROP TABLE IF EXISTS Adresse CASCADE;
-- DROP TABLE IF EXISTS Ligne CASCADE;
-- DROP TABLE IF EXISTS Facture CASCADE;
-- DROP TABLE IF EXISTS Reservation CASCADE;
-- DROP TABLE IF EXISTS Contrat CASCADE;
-- DROP TABLE IF EXISTS Sortie CASCADE;
-- DROP TABLE IF EXISTS Contact CASCADE;
-- DROP TABLE IF EXISTS Entreprise CASCADE;
-- DROP TABLE IF EXISTS PP CASCADE;
-- DROP TABLE IF EXISTS Entite CASCADE;
-- DROP TABLE IF EXISTS Localite CASCADE;

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Création des tables

CREATE TABLE Localite
(
  No INTEGER NOT NULL,
  Nom VARCHAR(50) NOT NULL,
  NPA VARCHAR(50) NOT NULL,
  Region VARCHAR(50),
  Pays VARCHAR(50) NOT NULL
);

CREATE TABLE Entite
(
  No INTEGER NOT NULL,
  DateDebut DATE NOT NULL
);

CREATE TABLE Entreprise
(
  EntiteNo INTEGER NOT NULL,
  Nom VARCHAR(50) NOT NULL,
  Type VARCHAR(50) NOT NULL,
  NoTVA VARCHAR(50)
);

CREATE TABLE PP
(
  EntiteNo INTEGER NOT NULL,
  Nom VARCHAR(50) NOT NULL,
  Prenom VARCHAR(50) NOT NULL,
  Civilite VARCHAR(50) NOT NULL,
  DateNaissance DATE NOT NULL
);

CREATE TABLE Sortie
(
  No INTEGER NOT NULL,
  Designation VARCHAR(50) NOT NULL,
  DateDebut DATE NOT NULL,
  DateFin DATE NOT NULL,
  HeureDebut DATE NOT NULL,
  HeureFin DATE NOT NULL,
  Type VARCHAR(50) NOT NULL,
  Commentaire VARCHAR(50) NOT NULL,
  PortDepart INTEGER NOT NULL,
  PortArrivee INTEGER NOT NULL,
  Precedente INTEGER
);

CREATE TABLE Facture
(
  No INTEGER NOT NULL,
  Date DATE NOT NULL,
  Intitule VARCHAR(50),
  MontantBrut INTEGER NOT NULL,
  Statut VARCHAR(50) NOT NULL,
  DateStatut DATE,
  EntiteNo INTEGER NOT NULL,
  SortieNo INTEGER
);

CREATE TABLE Ligne
(
  FactureNo INTEGER NOT NULL,
  No INTEGER NOT NULL,
  Qte INTEGER NOT NULL,
  Designation VARCHAR(50) NOT NULL,
  PrixUnitaire INTEGER NOT NULL,
  Montant INTEGER NOT NULL
);

CREATE TABLE Adresse
(
  EntiteNo INTEGER NOT NULL,
  No INTEGER NOT NULL,
  Ligne1 VARCHAR(100) NOT NULL,
  Ligne2 VARCHAR(50),
  Ligne3 VARCHAR(50),
  NoRue VARCHAR(50),
  LocaliteNo INTEGER NOT NULL
);

CREATE TABLE Contrat
(
  No INTEGER NOT NULL,
  Date DATE NOT NULL,
  Statut VARCHAR(50) NOT NULL,
  DateStatut DATE,
  SortieNo INTEGER NOT NULL,
  PPEntiteNo INTEGER NOT NULL
);

CREATE TABLE Contact
(
  EntrepriseentiteNo INTEGER NOT NULL,
  PPEntiteNo INTEGER NOT NULL
);

CREATE TABLE Reservation
(
  EntiteNo INTEGER NOT NULL,
  SortieNo INTEGER NOT NULL,
  Date DATE NOT NULL
); 

GO

-- ----------------------------------------------------------
-- Clés primaires

ALTER TABLE Localite ADD
  CONSTRAINT Localite_pkey PRIMARY KEY(No);
   
ALTER TABLE Entite ADD
  CONSTRAINT Entite_pkey PRIMARY KEY(No);
   
ALTER TABLE Entreprise ADD
  CONSTRAINT Entreprise_pkey PRIMARY KEY(EntiteNo);
   
ALTER TABLE PP ADD
  CONSTRAINT PP_pkey PRIMARY KEY(EntiteNo);

ALTER TABLE Sortie ADD
  CONSTRAINT Sortie_pkey PRIMARY KEY(No);
   
ALTER TABLE Facture ADD
  CONSTRAINT Facture_pkey PRIMARY KEY(No);
   
ALTER TABLE Ligne ADD
  CONSTRAINT Ligne_pkey PRIMARY KEY(FactureNo, No);
   
ALTER TABLE Adresse ADD
  CONSTRAINT Adresse_pkey PRIMARY KEY(EntiteNo,No);

ALTER TABLE Contrat ADD
  CONSTRAINT Contrat_pkey PRIMARY KEY(No);
   
ALTER TABLE Contact ADD
  CONSTRAINT Contact_pkey PRIMARY KEY(EntrepriseEntiteNo, PPEntiteNo);
   
ALTER TABLE Reservation ADD
  CONSTRAINT Reservation_pkey PRIMARY KEY(EntiteNo, SortieNo);

GO  

-- ----------------------------------------------------------
-- Création des clés étrangères

ALTER TABLE Entreprise ADD 
  CONSTRAINT Entreprise_fkey FOREIGN KEY(EntiteNo) REFERENCES Entite;  

ALTER TABLE PP ADD 
  CONSTRAINT PP_fkey FOREIGN KEY(EntiteNo) REFERENCES Entite; 

ALTER TABLE Sortie ADD 
  CONSTRAINT Sortie_fkey1 FOREIGN KEY(PortDepart) REFERENCES Localite;

ALTER TABLE Sortie ADD 
  CONSTRAINT Sortie_fkey2 FOREIGN KEY(PortArrivee) REFERENCES Localite;

ALTER TABLE Sortie ADD   
  CONSTRAINT Sortie_fkey3 FOREIGN KEY(Precedente) REFERENCES Sortie;	   
	   
ALTER TABLE Facture ADD 
  CONSTRAINT Facture_fkey1 FOREIGN KEY(EntiteNo) REFERENCES Entite;

ALTER TABLE Facture ADD  
  CONSTRAINT Facture_fkey2 FOREIGN KEY(SortieNo) REFERENCES Sortie;
	   
ALTER TABLE Ligne ADD 
  CONSTRAINT Ligne_fkey FOREIGN KEY(FactureNo) REFERENCES Facture;

ALTER TABLE Adresse ADD 
  CONSTRAINT Adresse_fkey1 FOREIGN KEY(EntiteNo) REFERENCES Entite;

ALTER TABLE Adresse ADD   
  CONSTRAINT Adresse_fkey2 FOREIGN KEY(LocaliteNo) REFERENCES Localite;	   

ALTER TABLE Contrat ADD 
  CONSTRAINT Contrat_fkey1 FOREIGN KEY(SortieNo) REFERENCES Sortie;

ALTER TABLE Contrat ADD   
  CONSTRAINT Contrat_fkey2 FOREIGN KEY(PPEntiteNo) REFERENCES PP;	 

ALTER TABLE Contact ADD 
  CONSTRAINT Contact_fkey1 FOREIGN KEY(EntrepriseEntiteNo) REFERENCES Entreprise;

ALTER TABLE Contact ADD   
  CONSTRAINT Contact_fkey2 FOREIGN KEY(PPEntiteNo) REFERENCES PP;
	   
ALTER TABLE Reservation ADD 
  CONSTRAINT Reservation_fkey1 FOREIGN KEY(EntiteNo) REFERENCES Entite;

ALTER TABLE Reservation ADD   
  CONSTRAINT Reservation_fkey2 FOREIGN KEY(SortieNo) REFERENCES Sortie;	

GO     

-- ----------------------------------------------------------
-- ----------------------------------------------------------
-- Ajout des lignes

-- Table Localite
-- No INTEGER NOT NULL,Nom VARCHAR(50) NOT NULL, NPA VARCHAR(50) NOT NULL, Region VARCHAR(50), Pays   VARCHAR(50) NOT NULL
INSERT INTO Localite VALUES(1,'Lausanne','1000','Vaud','Suisse');
INSERT INTO Localite VALUES(2,'Jouxtens-Mézery','1008','Vaud','Suisse');
INSERT INTO Localite VALUES(3,'Prilly','1008','Vaud','Suisse');
INSERT INTO Localite VALUES(4,'Pully','1009','Vaud','Suisse');
INSERT INTO Localite VALUES(5,'Renens VD','1020','Vaud','Suisse');
INSERT INTO Localite VALUES(6,'Chavannes-près-Renens','1022','Vaud','Suisse');
INSERT INTO Localite VALUES(7,'Crissier','1023','Vaud','Suisse');
INSERT INTO Localite VALUES(8,'Ecublens VD','1024','Vaud','Suisse');
INSERT INTO Localite VALUES(9,'St-Sulpice VD','1025','Vaud','Suisse');
INSERT INTO Localite VALUES(10,'Denges','1026','Vaud','Suisse');
INSERT INTO Localite VALUES(11,'Echandens','1026','Vaud','Suisse');
INSERT INTO Localite VALUES(12,'Lonay','1027','Vaud','Suisse');
INSERT INTO Localite VALUES(13,'Préverenges','1028','Vaud','Suisse');
INSERT INTO Localite VALUES(14,'Villars-Ste-Croix','1029','Vaud','Suisse');
INSERT INTO Localite VALUES(15,'Bussigny-près-Lausanne','1030','Vaud','Suisse');
INSERT INTO Localite VALUES(16,'Mex VD','1031','Vaud','Suisse');
INSERT INTO Localite VALUES(17,'Romanel-sur-Lausanne','1032','Vaud','Suisse');
INSERT INTO Localite VALUES(18,'Cheseaux-sur-Lausanne','1033','Vaud','Suisse');
INSERT INTO Localite VALUES(19,'Boussens','1034','Vaud','Suisse');
INSERT INTO Localite VALUES(20,'Bournens','1035','Vaud','Suisse');
INSERT INTO Localite VALUES(21,'Sullens','1036','Vaud','Suisse');
INSERT INTO Localite VALUES(22,'Etagnières','1037','Vaud','Suisse');
INSERT INTO Localite VALUES(23,'Bercher','1038','Vaud','Suisse');
INSERT INTO Localite VALUES(24,'Echallens','1040','Vaud','Suisse');
INSERT INTO Localite VALUES(25,'St-Barthélemy VD','1040','Vaud','Suisse');
INSERT INTO Localite VALUES(26,'Villars-le-Terroir','1040','Vaud','Suisse');
INSERT INTO Localite VALUES(27,'Bottens','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(28,'Dommartin','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(29,'Montaubion-Chardonney','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(30,'Naz','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(31,'Poliez-le-Grand','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(32,'Poliez-Pittet','1041','Vaud','Suisse');
INSERT INTO Localite VALUES(33,'Assens','1042','Vaud','Suisse');
INSERT INTO Localite VALUES(34,'Bettens','1042','Vaud','Suisse');
INSERT INTO Localite VALUES(35,'Bioley-Orjulaz','1042','Vaud','Suisse');
INSERT INTO Localite VALUES(36,'Sugnens','1043','Vaud','Suisse');
INSERT INTO Localite VALUES(37,'Fey','1044','Vaud','Suisse');
INSERT INTO Localite VALUES(38,'Ogens','1045','Vaud','Suisse');
INSERT INTO Localite VALUES(39,'Rueyres','1046','Vaud','Suisse');
INSERT INTO Localite VALUES(40,'Oppens','1047','Vaud','Suisse');
INSERT INTO Localite VALUES(41,'Le Mont-sur-Lausanne','1052','Vaud','Suisse');
INSERT INTO Localite VALUES(42,'Bretigny-sur-Morrens','1053','Vaud','Suisse');
INSERT INTO Localite VALUES(43,'Cugy VD','1053','Vaud','Suisse');
INSERT INTO Localite VALUES(44,'Morrens VD','1054','Vaud','Suisse');
INSERT INTO Localite VALUES(45,'Froideville','1055','Vaud','Suisse');
INSERT INTO Localite VALUES(46,'Villars-Tiercelin','1058','Vaud','Suisse');
INSERT INTO Localite VALUES(47,'Peney-le-Jorat','1059','Vaud','Suisse');
INSERT INTO Localite VALUES(48,'Villars-Mendraz','1061','Vaud','Suisse');
INSERT INTO Localite VALUES(49,'Sottens','1062','Vaud','Suisse');
INSERT INTO Localite VALUES(50,'Boulens','1063','Vaud','Suisse');
INSERT INTO Localite VALUES(51,'Chapelle-sur-Moudon','1063','Vaud','Suisse');
INSERT INTO Localite VALUES(52,'Martherenges','1063','Vaud','Suisse');
INSERT INTO Localite VALUES(53,'Peyres-Possens','1063','Vaud','Suisse');
INSERT INTO Localite VALUES(54,'Epalinges','1066','Vaud','Suisse');
INSERT INTO Localite VALUES(55,'Les Monts-de-Pully','1068','Vaud','Suisse');
INSERT INTO Localite VALUES(56,'Puidoux','1070','Vaud','Suisse');
INSERT INTO Localite VALUES(57,'Chexbres','1071','Vaud','Suisse');
INSERT INTO Localite VALUES(58,'Rivaz','1071','Vaud','Suisse');
INSERT INTO Localite VALUES(59,'St-Saphorin','1071','Vaud','Suisse');
INSERT INTO Localite VALUES(60,'Forel','1072','Vaud','Suisse');
INSERT INTO Localite VALUES(61,'Mollie-Margot','1073','Vaud','Suisse');
INSERT INTO Localite VALUES(62,'Savigny','1073','Vaud','Suisse');
INSERT INTO Localite VALUES(63,'Ferlens VD','1076','Vaud','Suisse');
INSERT INTO Localite VALUES(64,'Servion','1077','Vaud','Suisse');
INSERT INTO Localite VALUES(65,'Essertes','1078','Vaud','Suisse');
INSERT INTO Localite VALUES(66,'Les Cullayes','1080','Vaud','Suisse');
INSERT INTO Localite VALUES(67,'Montpreveyres','1081','Vaud','Suisse');
INSERT INTO Localite VALUES(68,'Corcelles-le-Jorat','1082','Vaud','Suisse');
INSERT INTO Localite VALUES(69,'Mézières VD','1083','Vaud','Suisse');
INSERT INTO Localite VALUES(70,'Carrouge VD','1084','Vaud','Suisse');
INSERT INTO Localite VALUES(71,'Vulliens','1085','Vaud','Suisse');
INSERT INTO Localite VALUES(72,'Ropraz','1088','Vaud','Suisse');
INSERT INTO Localite VALUES(73,'La Croix','1090','Vaud','Suisse');
INSERT INTO Localite VALUES(74,'Aran','1091','Vaud','Suisse');
INSERT INTO Localite VALUES(75,'Chenaux','1091','Vaud','Suisse');
INSERT INTO Localite VALUES(76,'Grandvaux','1091','Vaud','Suisse');
INSERT INTO Localite VALUES(77,'Belmont-sur-Lausanne','1092','Vaud','Suisse');
INSERT INTO Localite VALUES(78,'La Conversion','1093','Vaud','Suisse');
INSERT INTO Localite VALUES(79,'Paudex','1094','Vaud','Suisse');
INSERT INTO Localite VALUES(80,'Lutry','1095','Vaud','Suisse');
INSERT INTO Localite VALUES(81,'Cully','1096','Vaud','Suisse');
INSERT INTO Localite VALUES(82,'Villette','1096','Vaud','Suisse');
INSERT INTO Localite VALUES(83,'Riex','1097','Vaud','Suisse');
INSERT INTO Localite VALUES(84,'Epesses','1098','Vaud','Suisse');
INSERT INTO Localite VALUES(85,'Morges','1110','Vaud','Suisse');
INSERT INTO Localite VALUES(86,'Echichens','1112','Vaud','Suisse');
INSERT INTO Localite VALUES(87,'St-Saphorin-sur-Morges','1113','Vaud','Suisse');
INSERT INTO Localite VALUES(88,'Colombier VD','1114','Vaud','Suisse');
INSERT INTO Localite VALUES(89,'Vullierens','1115','Vaud','Suisse');
INSERT INTO Localite VALUES(90,'Cottens VD','1116','Vaud','Suisse');
INSERT INTO Localite VALUES(91,'Grancy','1117','Vaud','Suisse');
INSERT INTO Localite VALUES(92,'Bremblens','1121','Vaud','Suisse');
INSERT INTO Localite VALUES(93,'Romanel-sur-Morges','1122','Vaud','Suisse');
INSERT INTO Localite VALUES(94,'Aclens','1123','Vaud','Suisse');
INSERT INTO Localite VALUES(95,'Gollion','1124','Vaud','Suisse');
INSERT INTO Localite VALUES(96,'Monnaz','1125','Vaud','Suisse');
INSERT INTO Localite VALUES(97,'Vaux-sur-Morges','1126','Vaud','Suisse');
INSERT INTO Localite VALUES(98,'Clarmont','1127','Vaud','Suisse');
INSERT INTO Localite VALUES(99,'Reverolle','1128','Vaud','Suisse');
INSERT INTO Localite VALUES(100,'Tolochenaz','1131','Vaud','Suisse');
INSERT INTO Localite VALUES(101,'Lully VD','1132','Vaud','Suisse');
INSERT INTO Localite VALUES(102,'Chigny','1134','Vaud','Suisse');
INSERT INTO Localite VALUES(103,'Vufflens-le-Château','1134','Vaud','Suisse');
INSERT INTO Localite VALUES(104,'Denens','1135','Vaud','Suisse');
INSERT INTO Localite VALUES(105,'Bussy-Chardonney','1136','Vaud','Suisse');
INSERT INTO Localite VALUES(106,'Sévery','1141','Vaud','Suisse');
INSERT INTO Localite VALUES(107,'Pampigny','1142','Vaud','Suisse');
INSERT INTO Localite VALUES(108,'Apples','1143','Vaud','Suisse');
INSERT INTO Localite VALUES(109,'Ballens','1144','Vaud','Suisse');
INSERT INTO Localite VALUES(110,'Bière','1145','Vaud','Suisse');
INSERT INTO Localite VALUES(111,'Mollens VD','1146','Vaud','Suisse');
INSERT INTO Localite VALUES(112,'Montricher','1147','Vaud','Suisse');
INSERT INTO Localite VALUES(113,'Chavannes-le-Veyron','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(114,'Cuarnens','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(115,'L‘Isle','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(116,'La Coudre','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(117,'La Praz','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(118,'Mauraz','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(119,'Moiry VD','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(120,'Mont-la-Ville','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(121,'Villars-Bozon','1148','Vaud','Suisse');
INSERT INTO Localite VALUES(122,'Berolle','1149','Vaud','Suisse');
INSERT INTO Localite VALUES(123,'St-Prex','1162','Vaud','Suisse');
INSERT INTO Localite VALUES(124,'Etoy','1163','Vaud','Suisse');
INSERT INTO Localite VALUES(125,'Buchillon','1164','Vaud','Suisse');
INSERT INTO Localite VALUES(126,'Allaman','1165','Vaud','Suisse');
INSERT INTO Localite VALUES(127,'Perroy','1166','Vaud','Suisse');
INSERT INTO Localite VALUES(128,'Lussy-sur-Morges','1167','Vaud','Suisse');
INSERT INTO Localite VALUES(129,'Villars-sous-Yens','1168','Vaud','Suisse');
INSERT INTO Localite VALUES(130,'Yens','1169','Vaud','Suisse');
INSERT INTO Localite VALUES(131,'Aubonne','1170','Vaud','Suisse');
INSERT INTO Localite VALUES(132,'Bougy-Villars','1172','Vaud','Suisse');
INSERT INTO Localite VALUES(133,'Féchy','1173','Vaud','Suisse');
INSERT INTO Localite VALUES(134,'Montherod','1174','Vaud','Suisse');
INSERT INTO Localite VALUES(135,'Pizy','1174','Vaud','Suisse');
INSERT INTO Localite VALUES(136,'Lavigny','1175','Vaud','Suisse');
INSERT INTO Localite VALUES(137,'St-Livres','1176','Vaud','Suisse');
INSERT INTO Localite VALUES(138,'Rolle','1180','Vaud','Suisse');
INSERT INTO Localite VALUES(139,'Tartegnin','1180','Vaud','Suisse');
INSERT INTO Localite VALUES(140,'Gilly','1182','Vaud','Suisse');
INSERT INTO Localite VALUES(141,'Bursins','1183','Vaud','Suisse');
INSERT INTO Localite VALUES(142,'Luins','1184','Vaud','Suisse');
INSERT INTO Localite VALUES(143,'Vinzel','1184','Vaud','Suisse');
INSERT INTO Localite VALUES(144,'Mont-sur-Rolle','1185','Vaud','Suisse');
INSERT INTO Localite VALUES(145,'Essertines-sur-Rolle','1186','Vaud','Suisse');
INSERT INTO Localite VALUES(146,'St-Oyens','1187','Vaud','Suisse');
INSERT INTO Localite VALUES(147,'Gimel','1188','Vaud','Suisse');
INSERT INTO Localite VALUES(148,'St-George','1188','Vaud','Suisse');
INSERT INTO Localite VALUES(149,'Saubraz','1189','Vaud','Suisse');
INSERT INTO Localite VALUES(150,'Bursinel','1195','Vaud','Suisse');
INSERT INTO Localite VALUES(151,'Dully','1195','Vaud','Suisse');
INSERT INTO Localite VALUES(152,'Gland','1196','Vaud','Suisse');
INSERT INTO Localite VALUES(153,'Prangins','1197','Vaud','Suisse');
INSERT INTO Localite VALUES(154,'Nyon','1260','Vaud','Suisse');
INSERT INTO Localite VALUES(155,'Le Vaud','1261','Vaud','Suisse');
INSERT INTO Localite VALUES(156,'Longirod','1261','Vaud','Suisse');
INSERT INTO Localite VALUES(157,'Marchissy','1261','Vaud','Suisse');
INSERT INTO Localite VALUES(158,'Eysins','1262','Vaud','Suisse');
INSERT INTO Localite VALUES(159,'Crassier','1263','Vaud','Suisse');
INSERT INTO Localite VALUES(160,'St-Cergue','1264','Vaud','Suisse');
INSERT INTO Localite VALUES(161,'La Cure','1265','Vaud','Suisse');
INSERT INTO Localite VALUES(162,'Duillier','1266','Vaud','Suisse');
INSERT INTO Localite VALUES(163,'Coinsins','1267','Vaud','Suisse');
INSERT INTO Localite VALUES(164,'Vich','1267','Vaud','Suisse');
INSERT INTO Localite VALUES(165,'Begnins','1268','Vaud','Suisse');
INSERT INTO Localite VALUES(166,'Burtigny','1268','Vaud','Suisse');
INSERT INTO Localite VALUES(167,'Bassins','1269','Vaud','Suisse');
INSERT INTO Localite VALUES(168,'Trélex','1270','Vaud','Suisse');
INSERT INTO Localite VALUES(169,'Givrins','1271','Vaud','Suisse');
INSERT INTO Localite VALUES(170,'Genolier','1272','Vaud','Suisse');
INSERT INTO Localite VALUES(171,'Arzier','1273','Vaud','Suisse');
INSERT INTO Localite VALUES(172,'Le Muids','1273','Vaud','Suisse');
INSERT INTO Localite VALUES(173,'Grens','1274','Vaud','Suisse');
INSERT INTO Localite VALUES(174,'Signy','1274','Vaud','Suisse');
INSERT INTO Localite VALUES(175,'Chéserex','1275','Vaud','Suisse');
INSERT INTO Localite VALUES(176,'Gingins','1276','Vaud','Suisse');
INSERT INTO Localite VALUES(177,'Arnex-sur-Nyon','1277','Vaud','Suisse');
INSERT INTO Localite VALUES(178,'Borex','1277','Vaud','Suisse');
INSERT INTO Localite VALUES(179,'La Rippie','1278','Vaud','Suisse');
INSERT INTO Localite VALUES(180,'Bogis-Bossey','1279','Vaud','Suisse');
INSERT INTO Localite VALUES(181,'Chavannes-de-Bogis','1279','Vaud','Suisse');
INSERT INTO Localite VALUES(182,'Chavannes-des-Bois','1290','Vaud','Suisse');
INSERT INTO Localite VALUES(183,'Commugny','1291','Vaud','Suisse');
INSERT INTO Localite VALUES(184,'Mies','1295','Vaud','Suisse');
INSERT INTO Localite VALUES(185,'Tannay','1295','Vaud','Suisse');
INSERT INTO Localite VALUES(186,'Coppet','1296','Vaud','Suisse');
INSERT INTO Localite VALUES(187,'Founex','1297','Vaud','Suisse');
INSERT INTO Localite VALUES(188,'Crans-près-Céligny','1299','Vaud','Suisse');
INSERT INTO Localite VALUES(189,'Vufflens-la-Ville','1302','Vaud','Suisse');
INSERT INTO Localite VALUES(190,'Penthaz','1303','Vaud','Suisse');
INSERT INTO Localite VALUES(191,'Allens','1304','Vaud','Suisse');
INSERT INTO Localite VALUES(192,'Cossonay-Ville','1304','Vaud','Suisse');
INSERT INTO Localite VALUES(193,'Dizy','1304','Vaud','Suisse');
INSERT INTO Localite VALUES(194,'Senarclens','1304','Vaud','Suisse');
INSERT INTO Localite VALUES(195,'Penthalaz','1305','Vaud','Suisse');
INSERT INTO Localite VALUES(196,'Daillens','1306','Vaud','Suisse');
INSERT INTO Localite VALUES(197,'Lussery-Villars','1307','Vaud','Suisse');
INSERT INTO Localite VALUES(198,'La Chaux','1308','Vaud','Suisse');
INSERT INTO Localite VALUES(199,'Eclépens','1312','Vaud','Suisse');
INSERT INTO Localite VALUES(200,'Ferreyres','1313','Vaud','Suisse');
INSERT INTO Localite VALUES(201,'La Sarraz','1315','Vaud','Suisse');
INSERT INTO Localite VALUES(202,'Chevilly','1316','Vaud','Suisse');
INSERT INTO Localite VALUES(203,'Orny','1317','Vaud','Suisse');
INSERT INTO Localite VALUES(204,'Pompaples','1318','Vaud','Suisse');
INSERT INTO Localite VALUES(205,'Arnex-sur-Orbe','1321','Vaud','Suisse');
INSERT INTO Localite VALUES(206,'Croy','1322','Vaud','Suisse');
INSERT INTO Localite VALUES(207,'Romainmôtier','1323','Vaud','Suisse');
INSERT INTO Localite VALUES(208,'Premier','1324','Vaud','Suisse');
INSERT INTO Localite VALUES(209,'Vaulion','1325','Vaud','Suisse');
INSERT INTO Localite VALUES(210,'Juriens','1326','Vaud','Suisse');
INSERT INTO Localite VALUES(211,'Bretonnières','1329','Vaud','Suisse');
INSERT INTO Localite VALUES(212,'Vallorbe','1337','Vaud','Suisse');
INSERT INTO Localite VALUES(213,'Ballaigues','1338','Vaud','Suisse');
INSERT INTO Localite VALUES(214,'Orient','1341','Vaud','Suisse');
INSERT INTO Localite VALUES(215,'Le Pont','1342','Vaud','Suisse');
INSERT INTO Localite VALUES(216,'Les Chabonnières','1343','Vaud','Suisse');
INSERT INTO Localite VALUES(217,'L’Abbaye','1344','Vaud','Suisse');
INSERT INTO Localite VALUES(218,'Le Lieu','1345','Vaud','Suisse');
INSERT INTO Localite VALUES(219,'Les Bioux','1346','Vaud','Suisse');
INSERT INTO Localite VALUES(220,'Le Sentier','1347','Vaud','Suisse');
INSERT INTO Localite VALUES(221,'Le Solliat','1347','Vaud','Suisse');
INSERT INTO Localite VALUES(222,'Le Brassus','1348','Vaud','Suisse');
INSERT INTO Localite VALUES(223,'Orbe','1350','Vaud','Suisse');
INSERT INTO Localite VALUES(224,'Agiez','1352','Vaud','Suisse');
INSERT INTO Localite VALUES(225,'Bofflens','1353','Vaud','Suisse');
INSERT INTO Localite VALUES(226,'Montcherand','1354','Vaud','Suisse');
INSERT INTO Localite VALUES(227,'L''Abergement','1355','Vaud','Suisse');
INSERT INTO Localite VALUES(228,'Sergey','1355','Vaud','Suisse');
INSERT INTO Localite VALUES(229,'La Russille','1356','Vaud','Suisse');
INSERT INTO Localite VALUES(230,'Les Clées','1356','Vaud','Suisse');
INSERT INTO Localite VALUES(231,'Lignerolle','1357','Vaud','Suisse');
INSERT INTO Localite VALUES(232,'Valeyres-sous-Rances','1358','Vaud','Suisse');
INSERT INTO Localite VALUES(233,'Bavois','1372','Vaud','Suisse');
INSERT INTO Localite VALUES(234,'Chavornay','1373','Vaud','Suisse');
INSERT INTO Localite VALUES(235,'Corcelles-sur-Chavornay','1374','Vaud','Suisse');
INSERT INTO Localite VALUES(236,'Penthéréaz','1375','Vaud','Suisse');
INSERT INTO Localite VALUES(237,'Eclagnens','1376','Vaud','Suisse');
INSERT INTO Localite VALUES(238,'Goumoens-la-Ville','1376','Vaud','Suisse');
INSERT INTO Localite VALUES(239,'Goumoens-le-Jux','1376','Vaud','Suisse');
INSERT INTO Localite VALUES(240,'Oulens-sous-Echallens','1377','Vaud','Suisse');
INSERT INTO Localite VALUES(241,'Cheseaux-Noréaz','1400','Vaud','Suisse');
INSERT INTO Localite VALUES(242,'Yverdon-les-Bains','1400','Vaud','Suisse');
INSERT INTO Localite VALUES(243,'Cuarny','1404','Vaud','Suisse');
INSERT INTO Localite VALUES(244,'Villars-Epeney','1404','Vaud','Suisse');
INSERT INTO Localite VALUES(245,'Pomy','1405','Vaud','Suisse');
INSERT INTO Localite VALUES(246,'Cronay','1406','Vaud','Suisse');
INSERT INTO Localite VALUES(247,'Bioley-Magnoux','1407','Vaud','Suisse');
INSERT INTO Localite VALUES(248,'Donneloye','1407','Vaud','Suisse');
INSERT INTO Localite VALUES(249,'Gossens','1407','Vaud','Suisse');
INSERT INTO Localite VALUES(250,'Mézery-près-Donneloye','1407','Vaud','Suisse');
INSERT INTO Localite VALUES(251,'Prahins','1408','Vaud','Suisse');
INSERT INTO Localite VALUES(252,'Chanéaz','1409','Vaud','Suisse');
INSERT INTO Localite VALUES(253,'Correvon','1410','Vaud','Suisse');
INSERT INTO Localite VALUES(254,'Denezy','1410','Vaud','Suisse');
INSERT INTO Localite VALUES(255,'St-Cierges','1410','Vaud','Suisse');
INSERT INTO Localite VALUES(256,'Thierrens','1410','Vaud','Suisse');
INSERT INTO Localite VALUES(257,'Ursins','1412','Vaud','Suisse');
INSERT INTO Localite VALUES(258,'Valeyres-sous-Ursins','1412','Vaud','Suisse');
INSERT INTO Localite VALUES(259,'Orzens','1413','Vaud','Suisse');
INSERT INTO Localite VALUES(260,'Démoret','1415','Vaud','Suisse');
INSERT INTO Localite VALUES(261,'Molondin','1415','Vaud','Suisse');
INSERT INTO Localite VALUES(262,'Pailly','1416','Vaud','Suisse');
INSERT INTO Localite VALUES(263,'Epautheyres','1417','Vaud','Suisse');
INSERT INTO Localite VALUES(264,'Essertines-sur-Yverdon','1417','Vaud','Suisse');
INSERT INTO Localite VALUES(265,'Vuarrens','1418','Vaud','Suisse');
INSERT INTO Localite VALUES(266,'Fiez','1420','Vaud','Suisse');
INSERT INTO Localite VALUES(267,'Fontaines-sur-Grandson','1421','Vaud','Suisse');
INSERT INTO Localite VALUES(268,'Grandevent','1421','Vaud','Suisse');
INSERT INTO Localite VALUES(269,'Grandson','1422','Vaud','Suisse');
INSERT INTO Localite VALUES(270,'Fontanezier','1423','Vaud','Suisse');
INSERT INTO Localite VALUES(271,'Romairon','1423','Vaud','Suisse');
INSERT INTO Localite VALUES(272,'Vaugondry','1423','Vaud','Suisse');
INSERT INTO Localite VALUES(273,'Villars-Burquin','1423','Vaud','Suisse');
INSERT INTO Localite VALUES(274,'Champagne','1424','Vaud','Suisse');
INSERT INTO Localite VALUES(275,'Onnens VD','1425','Vaud','Suisse');
INSERT INTO Localite VALUES(276,'Concise','1426','Vaud','Suisse');
INSERT INTO Localite VALUES(277,'Corcelles-près-Concise','1426','Vaud','Suisse');
INSERT INTO Localite VALUES(278,'Bonvillars','1427','Vaud','Suisse');
INSERT INTO Localite VALUES(279,'Mutrux','1428','Vaud','Suisse');
INSERT INTO Localite VALUES(280,'Provence','1428','Vaud','Suisse');
INSERT INTO Localite VALUES(281,'Giez','1429','Vaud','Suisse');
INSERT INTO Localite VALUES(282,'Orges','1430','Vaud','Suisse');
INSERT INTO Localite VALUES(283,'Novalles','1431','Vaud','Suisse');
INSERT INTO Localite VALUES(284,'Vugelles-La','1431','Vaud','Suisse');
INSERT INTO Localite VALUES(285,'Belmont-sur-Yverdon','1432','Vaud','Suisse');
INSERT INTO Localite VALUES(286,'Gressy','1432','Vaud','Suisse');
INSERT INTO Localite VALUES(287,'Suchy','1433','Vaud','Suisse');
INSERT INTO Localite VALUES(288,'Ependes VD','1434','Vaud','Suisse');
INSERT INTO Localite VALUES(289,'Essert-Pittet','1435','Vaud','Suisse');
INSERT INTO Localite VALUES(290,'Chamblon','1436','Vaud','Suisse');
INSERT INTO Localite VALUES(291,'Treycovagnes','1436','Vaud','Suisse');
INSERT INTO Localite VALUES(292,'Suscévaz','1437','Vaud','Suisse');
INSERT INTO Localite VALUES(293,'Mathod','1438','Vaud','Suisse');
INSERT INTO Localite VALUES(294,'Rances','1439','Vaud','Suisse');
INSERT INTO Localite VALUES(295,'Montagny-Charmard','1440','Vaud','Suisse');
INSERT INTO Localite VALUES(296,'Valeyres-sous-Montagny','1441','Vaud','Suisse');
INSERT INTO Localite VALUES(297,'Montagny-près-Yverdon','1442','Vaud','Suisse');
INSERT INTO Localite VALUES(298,'Champvent','1443','Vaud','Suisse');
INSERT INTO Localite VALUES(299,'Essert-sous-Champvent','1443','Vaud','Suisse');
INSERT INTO Localite VALUES(300,'Villars-sous-Champvent','1443','Vaud','Suisse');
INSERT INTO Localite VALUES(301,'Vuiteboeuf','1445','Vaud','Suisse');
INSERT INTO Localite VALUES(302,'Baulmes','1446','Vaud','Suisse');
INSERT INTO Localite VALUES(303,'La Sagne','1450','Vaud','Suisse');
INSERT INTO Localite VALUES(304,'Le Château-de-Ste-Croix','1450','Vaud','Suisse');
INSERT INTO Localite VALUES(305,'Ste-Croix','1450','Vaud','Suisse');
INSERT INTO Localite VALUES(306,'Les Rasses','1452','Vaud','Suisse');
INSERT INTO Localite VALUES(307,'Bullet','1453','Vaud','Suisse');
INSERT INTO Localite VALUES(308,'Mauborget','1453','Vaud','Suisse');
INSERT INTO Localite VALUES(309,'L''Auberson','1454','Vaud','Suisse');
INSERT INTO Localite VALUES(310,'La Vraconnaz','1454','Vaud','Suisse');
INSERT INTO Localite VALUES(311,'Yvonand','1462','Vaud','Suisse');
INSERT INTO Localite VALUES(312,'Rovray','1463','Vaud','Suisse');
INSERT INTO Localite VALUES(313,'Chavannes-le-Chêne','1464','Vaud','Suisse');
INSERT INTO Localite VALUES(314,'Chêne-Pâquier','1464','Vaud','Suisse');
INSERT INTO Localite VALUES(315,'Vucherens','1509','Vaud','Suisse');
INSERT INTO Localite VALUES(316,'Moudon','1510','Vaud','Suisse');
INSERT INTO Localite VALUES(317,'Syens','1510','Vaud','Suisse');
INSERT INTO Localite VALUES(318,'Chavannes-sur-Moudon','1512','Vaud','Suisse');
INSERT INTO Localite VALUES(319,'Hermenches','1513','Vaud','Suisse');
INSERT INTO Localite VALUES(320,'Rossenges','1513','Vaud','Suisse');
INSERT INTO Localite VALUES(321,'Bussy-sur-Moudon','1514','Vaud','Suisse');
INSERT INTO Localite VALUES(322,'Neyruz-sur-Moudon','1515','Vaud','Suisse');
INSERT INTO Localite VALUES(323,'Villars-le-Comte','1515','Vaud','Suisse');
INSERT INTO Localite VALUES(324,'Curtilles','1521','Vaud','Suisse');
INSERT INTO Localite VALUES(325,'Lucens','1522','Vaud','Suisse');
INSERT INTO Localite VALUES(326,'Oulens-sur-Lucens','1522','Vaud','Suisse');
INSERT INTO Localite VALUES(327,'Granges-près-Marnand','1523','Vaud','Suisse');
INSERT INTO Localite VALUES(328,'Marnand','1524','Vaud','Suisse');
INSERT INTO Localite VALUES(329,'Henniez','1525','Vaud','Suisse');
INSERT INTO Localite VALUES(330,'Seigneux','1525','Vaud','Suisse');
INSERT INTO Localite VALUES(331,'Cremin','1526','Vaud','Suisse');
INSERT INTO Localite VALUES(332,'Forel-sur-Lucens','1526','Vaud','Suisse');
INSERT INTO Localite VALUES(333,'Payerne','1530','Vaud','Suisse');
INSERT INTO Localite VALUES(334,'Sassel','1534','Vaud','Suisse');
INSERT INTO Localite VALUES(335,'Combremont-le-Grand','1535','Vaud','Suisse');
INSERT INTO Localite VALUES(336,'Combremont-le-Petit','1536','Vaud','Suisse');
INSERT INTO Localite VALUES(337,'Champtauroz','1537','Vaud','Suisse');
INSERT INTO Localite VALUES(338,'Treytorrens','1538','Vaud','Suisse');
INSERT INTO Localite VALUES(339,'Grandcour','1543','Vaud','Suisse');
INSERT INTO Localite VALUES(340,'Chevroux','1545','Vaud','Suisse');
INSERT INTO Localite VALUES(341,'Vers-chez-Perrin','1551','Vaud','Suisse');
INSERT INTO Localite VALUES(342,'Trey','1552','Vaud','Suisse');
INSERT INTO Localite VALUES(343,'Rossens VD','1554','Vaud','Suisse');
INSERT INTO Localite VALUES(344,'Sédeilles','1554','Vaud','Suisse');
INSERT INTO Localite VALUES(345,'Villarzel','1555','Vaud','Suisse');
INSERT INTO Localite VALUES(346,'Corcelles-près-Payerne','1562','Vaud','Suisse');
INSERT INTO Localite VALUES(347,'Missy','1565','Vaud','Suisse');
INSERT INTO Localite VALUES(348,'Avenches','1580','Vaud','Suisse');
INSERT INTO Localite VALUES(349,'Oleyres','1580','Vaud','Suisse');
INSERT INTO Localite VALUES(350,'Donatyre','1582','Vaud','Suisse');
INSERT INTO Localite VALUES(351,'Villars-le-Grand','1584','Vaud','Suisse');
INSERT INTO Localite VALUES(352,'Bellerive VD','1585','Vaud','Suisse');
INSERT INTO Localite VALUES(353,'Cotterd','1585','Vaud','Suisse');
INSERT INTO Localite VALUES(354,'Salavaux','1585','Vaud','Suisse');
INSERT INTO Localite VALUES(355,'Vallamand','1586','Vaud','Suisse');
INSERT INTO Localite VALUES(356,'Constantine','1587','Vaud','Suisse');
INSERT INTO Localite VALUES(357,'Montmagny','1587','Vaud','Suisse');
INSERT INTO Localite VALUES(358,'Cudrefin','1588','Vaud','Suisse');
INSERT INTO Localite VALUES(359,'Chabrey','1589','Vaud','Suisse');
INSERT INTO Localite VALUES(360,'Faoug','1595','Vaud','Suisse');
INSERT INTO Localite VALUES(361,'Les Tavernes','1607','Vaud','Suisse');
INSERT INTO Localite VALUES(362,'Les Thioleyres','1607','Vaud','Suisse');
INSERT INTO Localite VALUES(363,'Palézieux','1607','Vaud','Suisse');
INSERT INTO Localite VALUES(364,'Palézieux-Village','1607','Vaud','Suisse');
INSERT INTO Localite VALUES(365,'Bussigny-sur-Oron','1608','Vaud','Suisse');
INSERT INTO Localite VALUES(366,'Chesalles-sur-Oron','1608','Vaud','Suisse');
INSERT INTO Localite VALUES(367,'Oron-le-Châtel','1608','Vaud','Suisse');
INSERT INTO Localite VALUES(368,'Châtillens','1610','Vaud','Suisse');
INSERT INTO Localite VALUES(369,'Oron-la-Ville','1610','Vaud','Suisse');
INSERT INTO Localite VALUES(370,'Vuibroye','1610','Vaud','Suisse');
INSERT INTO Localite VALUES(371,'Ecoteaux','1612','Vaud','Suisse');
INSERT INTO Localite VALUES(372,'Maracon','1613','Vaud','Suisse');
INSERT INTO Localite VALUES(373,'La Tine','1658','Vaud','Suisse');
INSERT INTO Localite VALUES(374,'Rossinière','1658','Vaud','Suisse');
INSERT INTO Localite VALUES(375,'Flendruz','1659','Vaud','Suisse');
INSERT INTO Localite VALUES(376,'Rougemont','1659','Vaud','Suisse');
INSERT INTO Localite VALUES(377,'Château-d''Oex','1660','Vaud','Suisse');
INSERT INTO Localite VALUES(378,'L''Etivaz','1660','Vaud','Suisse');
INSERT INTO Localite VALUES(379,'La Lécherette','1660','Vaud','Suisse');
INSERT INTO Localite VALUES(380,'Les Moulins','1660','Vaud','Suisse');
INSERT INTO Localite VALUES(381,'Cerniaz VD','1682','Vaud','Suisse');
INSERT INTO Localite VALUES(382,'Dompierre VD','1682','Vaud','Suisse');
INSERT INTO Localite VALUES(383,'Lovatens','1682','Vaud','Suisse');
INSERT INTO Localite VALUES(384,'Prévonloup','1682','Vaud','Suisse');
INSERT INTO Localite VALUES(385,'Villars-Bramard','1682','Vaud','Suisse');
INSERT INTO Localite VALUES(386,'Brenles','1683','Vaud','Suisse');
INSERT INTO Localite VALUES(387,'Chesalles-sur-Moudon','1683','Vaud','Suisse');
INSERT INTO Localite VALUES(388,'Sarzens','1683','Vaud','Suisse');
INSERT INTO Localite VALUES(389,'Mur','1787','Vaud','Suisse');
INSERT INTO Localite VALUES(390,'Vevey','1800','Vaud','Suisse');
INSERT INTO Localite VALUES(391,'Le Mont-Pèlerin','1801','Vaud','Suisse');
INSERT INTO Localite VALUES(392,'Corseaux','1802','Vaud','Suisse');
INSERT INTO Localite VALUES(393,'Chardonne','1803','Vaud','Suisse');
INSERT INTO Localite VALUES(394,'Corsier-sur-Vevey','1804','Vaud','Suisse');
INSERT INTO Localite VALUES(395,'Jongny','1805','Vaud','Suisse');
INSERT INTO Localite VALUES(396,'St-Légier-La','1806','Vaud','Suisse');
INSERT INTO Localite VALUES(397,'Blonay','1807','Vaud','Suisse');
INSERT INTO Localite VALUES(398,'Les Monts-de-Corsier','1808','Vaud','Suisse');
INSERT INTO Localite VALUES(399,'Fenil-sur-Corsier','1809','Vaud','Suisse');
INSERT INTO Localite VALUES(400,'La Tour-de-Peilz','1814','Vaud','Suisse');
INSERT INTO Localite VALUES(401,'Clarens','1815','Vaud','Suisse');
INSERT INTO Localite VALUES(402,'Chailly-Montreux','1816','Vaud','Suisse');
INSERT INTO Localite VALUES(403,'Brent','1817','Vaud','Suisse');
INSERT INTO Localite VALUES(404,'Montreux','1820','Vaud','Suisse');
INSERT INTO Localite VALUES(405,'Territet','1820','Vaud','Suisse');
INSERT INTO Localite VALUES(406,'Territet-Veytaux','1820','Vaud','Suisse');
INSERT INTO Localite VALUES(407,'Veytaux','1820','Vaud','Suisse');
INSERT INTO Localite VALUES(408,'Chernex','1822','Vaud','Suisse');
INSERT INTO Localite VALUES(409,'Glion','1823','Vaud','Suisse');
INSERT INTO Localite VALUES(410,'Caux','1824','Vaud','Suisse');
INSERT INTO Localite VALUES(411,'Chamby','1832','Vaud','Suisse');
INSERT INTO Localite VALUES(412,'Villard-sur-Chamby','1832','Vaud','Suisse');
INSERT INTO Localite VALUES(413,'Les Avants','1833','Vaud','Suisse');
INSERT INTO Localite VALUES(414,'Villeneuve VD','1844','Vaud','Suisse');
INSERT INTO Localite VALUES(415,'Noville','1845','Vaud','Suisse');
INSERT INTO Localite VALUES(416,'Chessel','1846','Vaud','Suisse');
INSERT INTO Localite VALUES(417,'Rennaz','1847','Vaud','Suisse');
INSERT INTO Localite VALUES(418,'Roche VD','1852','Vaud','Suisse');
INSERT INTO Localite VALUES(419,'Yvorne','1853','Vaud','Suisse');
INSERT INTO Localite VALUES(420,'Leysin','1854','Vaud','Suisse');
INSERT INTO Localite VALUES(421,'Corbeyrier','1856','Vaud','Suisse');
INSERT INTO Localite VALUES(422,'Aigle','1860','Vaud','Suisse');
INSERT INTO Localite VALUES(423,'La Comballaz','1862','Vaud','Suisse');
INSERT INTO Localite VALUES(424,'Les Mosses','1862','Vaud','Suisse');
INSERT INTO Localite VALUES(425,'Le Sépey','1863','Vaud','Suisse');
INSERT INTO Localite VALUES(426,'Vers-l''Eglise','1864','Vaud','Suisse');
INSERT INTO Localite VALUES(427,'Les Diablerets','1865','Vaud','Suisse');
INSERT INTO Localite VALUES(428,'La Forclaz','1866','Vaud','Suisse');
INSERT INTO Localite VALUES(429,'Ollon VD','1867','Vaud','Suisse');
INSERT INTO Localite VALUES(430,'Panex','1867','Vaud','Suisse');
INSERT INTO Localite VALUES(431,'St-Triphon','1867','Vaud','Suisse');
INSERT INTO Localite VALUES(432,'Bex','1880','Vaud','Suisse');
INSERT INTO Localite VALUES(433,'Fenalet-sur-Bex','1880','Vaud','Suisse');
INSERT INTO Localite VALUES(434,'Frenières-sur-Bex','1880','Vaud','Suisse');
INSERT INTO Localite VALUES(435,'Les Plans-sur-Bex','1880','Vaud','Suisse');
INSERT INTO Localite VALUES(436,'Les Posses-sur-Bex','1880','Vaud','Suisse');
INSERT INTO Localite VALUES(437,'Gryon','1882','Vaud','Suisse');
INSERT INTO Localite VALUES(438,'Arveyes','1884','Vaud','Suisse');
INSERT INTO Localite VALUES(439,'Huémoz','1884','Vaud','Suisse');
INSERT INTO Localite VALUES(440,'Villars-sur-Ollon','1884','Vaud','Suisse');
INSERT INTO Localite VALUES(441,'Chesières','1885','Vaud','Suisse');
INSERT INTO Localite VALUES(442,'Lavey-les-Bains','1892','Vaud','Suisse');
INSERT INTO Localite VALUES(443,'Lavey-Village','1892','Vaud','Suisse');
INSERT INTO Localite VALUES(444,'Morcles','1892','Vaud','Suisse');
INSERT INTO Localite VALUES(445,'Plan-les-Ouates','1228','Genève','Suisse');
INSERT INTO Localite VALUES(446,'Corsier','1246','Genève','Suisse');
INSERT INTO Localite VALUES(447,'Onex','1213','Genève','Suisse');
INSERT INTO Localite VALUES(448,'Hermance','1248','Genève','Suisse');
INSERT INTO Localite VALUES(449,'Anières','1247','Genève','Suisse');
INSERT INTO Localite VALUES(450,'Collonge-Bellerive','1245','Genève','Suisse');
INSERT INTO Localite VALUES(451,'Vesenaz','1222','Genève','Suisse');
INSERT INTO Localite VALUES(452,'Cologny','1223','Genève','Suisse');

GO

-- Table Entite
-- No INTEGER NOT NULL,DateDebut DATE NOT NULL
INSERT INTO Entite VALUES(1,'2001-01-02');
INSERT INTO Entite VALUES(2,'2001-01-21');
INSERT INTO Entite VALUES(3,'2001-02-09');
INSERT INTO Entite VALUES(4,'2001-02-28');
INSERT INTO Entite VALUES(5,'2001-03-19');
INSERT INTO Entite VALUES(6,'2001-04-07');
INSERT INTO Entite VALUES(7,'2001-04-26');
INSERT INTO Entite VALUES(8,'2001-05-15');
INSERT INTO Entite VALUES(9,'2001-06-03');
INSERT INTO Entite VALUES(10,'2001-06-22');
INSERT INTO Entite VALUES(11,'2001-07-11');
INSERT INTO Entite VALUES(12,'2001-07-30');
INSERT INTO Entite VALUES(13,'2001-08-18');
INSERT INTO Entite VALUES(14,'2001-09-06');
INSERT INTO Entite VALUES(15,'2001-09-25');
INSERT INTO Entite VALUES(16,'2001-10-14');
INSERT INTO Entite VALUES(17,'2001-11-02');
INSERT INTO Entite VALUES(18,'2001-11-21');
INSERT INTO Entite VALUES(19,'2001-12-10');
INSERT INTO Entite VALUES(20,'2001-12-29');
INSERT INTO Entite VALUES(21,'2002-01-17');
INSERT INTO Entite VALUES(22,'2002-02-05');
INSERT INTO Entite VALUES(23,'2002-02-24');
INSERT INTO Entite VALUES(24,'2002-03-15');
INSERT INTO Entite VALUES(25,'2002-04-03');
INSERT INTO Entite VALUES(26,'2002-04-22');
INSERT INTO Entite VALUES(27,'2002-05-11');
INSERT INTO Entite VALUES(28,'2002-05-30');
INSERT INTO Entite VALUES(29,'2002-06-18');
INSERT INTO Entite VALUES(30,'2002-07-07');
INSERT INTO Entite VALUES(31,'2002-07-26');
INSERT INTO Entite VALUES(32,'2002-08-14');
INSERT INTO Entite VALUES(33,'2002-09-02');
INSERT INTO Entite VALUES(34,'2002-09-21');
INSERT INTO Entite VALUES(35,'2002-10-10');
INSERT INTO Entite VALUES(36,'2002-10-29');
INSERT INTO Entite VALUES(37,'2002-11-17');
INSERT INTO Entite VALUES(38,'2002-12-06');
INSERT INTO Entite VALUES(39,'2002-12-25');
INSERT INTO Entite VALUES(40,'2003-01-13');
INSERT INTO Entite VALUES(41,'2003-02-01');
INSERT INTO Entite VALUES(42,'2003-02-20');
INSERT INTO Entite VALUES(43,'2003-03-11');
INSERT INTO Entite VALUES(44,'2003-03-30');
INSERT INTO Entite VALUES(45,'2003-04-18');
INSERT INTO Entite VALUES(46,'2003-05-07');
INSERT INTO Entite VALUES(47,'2003-05-26');
INSERT INTO Entite VALUES(48,'2003-06-14');
INSERT INTO Entite VALUES(49,'2003-07-03');
INSERT INTO Entite VALUES(50,'2003-07-22');
INSERT INTO Entite VALUES(51,'2003-08-10');
INSERT INTO Entite VALUES(52,'2003-08-29');
INSERT INTO Entite VALUES(53,'2003-09-17');
INSERT INTO Entite VALUES(54,'2003-10-06');
INSERT INTO Entite VALUES(55,'2003-10-25');
INSERT INTO Entite VALUES(56,'2003-11-13');
INSERT INTO Entite VALUES(57,'2003-12-02');
INSERT INTO Entite VALUES(58,'2003-12-21');
INSERT INTO Entite VALUES(59,'2004-01-09');
INSERT INTO Entite VALUES(60,'2004-01-28');
INSERT INTO Entite VALUES(61,'2004-02-16');
INSERT INTO Entite VALUES(62,'2004-03-06');
INSERT INTO Entite VALUES(63,'2004-03-25');
INSERT INTO Entite VALUES(64,'2004-04-13');
INSERT INTO Entite VALUES(65,'2004-05-02');
INSERT INTO Entite VALUES(66,'2004-05-21');
INSERT INTO Entite VALUES(67,'2004-06-09');
INSERT INTO Entite VALUES(68,'2004-06-28');
INSERT INTO Entite VALUES(69,'2004-07-17');
INSERT INTO Entite VALUES(70,'2004-08-05');
INSERT INTO Entite VALUES(71,'2004-08-24');
INSERT INTO Entite VALUES(72,'2004-09-12');
INSERT INTO Entite VALUES(73,'2004-10-01');
INSERT INTO Entite VALUES(74,'2004-10-20');
INSERT INTO Entite VALUES(75,'2004-11-08');
INSERT INTO Entite VALUES(76,'2004-11-27');
INSERT INTO Entite VALUES(77,'2004-12-16');
INSERT INTO Entite VALUES(78,'2005-01-04');
INSERT INTO Entite VALUES(79,'2005-01-23');
INSERT INTO Entite VALUES(80,'2005-02-11');
INSERT INTO Entite VALUES(81,'2005-03-02');
INSERT INTO Entite VALUES(82,'2005-03-21');
INSERT INTO Entite VALUES(83,'2005-04-09');
INSERT INTO Entite VALUES(84,'2005-04-28');
INSERT INTO Entite VALUES(85,'2005-05-17');
INSERT INTO Entite VALUES(86,'2005-06-05');
INSERT INTO Entite VALUES(87,'2005-06-24');
INSERT INTO Entite VALUES(88,'2005-07-13');
INSERT INTO Entite VALUES(89,'2005-08-01');
INSERT INTO Entite VALUES(90,'2005-08-20');
INSERT INTO Entite VALUES(91,'2005-09-08');
INSERT INTO Entite VALUES(92,'2005-09-27');
INSERT INTO Entite VALUES(93,'2005-10-16');
INSERT INTO Entite VALUES(94,'2005-11-04');
INSERT INTO Entite VALUES(95,'2005-11-23');
INSERT INTO Entite VALUES(96,'2005-12-12');
INSERT INTO Entite VALUES(97,'2005-12-31');
INSERT INTO Entite VALUES(98,'2006-01-19');
INSERT INTO Entite VALUES(99,'2006-02-07');
INSERT INTO Entite VALUES(100,'2006-02-26');
INSERT INTO Entite VALUES(101,'2006-03-17');
INSERT INTO Entite VALUES(102,'2006-04-05');
INSERT INTO Entite VALUES(103,'2006-04-24');
INSERT INTO Entite VALUES(104,'2006-05-13');
INSERT INTO Entite VALUES(105,'2006-06-01');
INSERT INTO Entite VALUES(106,'2006-06-20');
INSERT INTO Entite VALUES(107,'2006-07-09');
INSERT INTO Entite VALUES(108,'2006-07-28');
INSERT INTO Entite VALUES(109,'2006-08-16');
INSERT INTO Entite VALUES(110,'2006-09-04');
INSERT INTO Entite VALUES(111,'2006-09-23');
INSERT INTO Entite VALUES(112,'2006-10-12');
INSERT INTO Entite VALUES(113,'2006-10-31');
INSERT INTO Entite VALUES(114,'2006-11-19');
INSERT INTO Entite VALUES(115,'2006-12-08');
INSERT INTO Entite VALUES(116,'2006-12-27');
INSERT INTO Entite VALUES(117,'2007-01-15');
INSERT INTO Entite VALUES(118,'2007-02-03');
INSERT INTO Entite VALUES(119,'2007-02-22');
INSERT INTO Entite VALUES(120,'2007-03-13');
INSERT INTO Entite VALUES(121,'2007-04-01');
INSERT INTO Entite VALUES(122,'2007-04-20');
INSERT INTO Entite VALUES(123,'2007-05-09');
INSERT INTO Entite VALUES(124,'2007-05-28');
INSERT INTO Entite VALUES(125,'2007-06-16');
INSERT INTO Entite VALUES(126,'2007-07-05');
INSERT INTO Entite VALUES(127,'2007-07-24');
INSERT INTO Entite VALUES(128,'2007-08-12');
INSERT INTO Entite VALUES(129,'2007-08-31');
INSERT INTO Entite VALUES(130,'2007-09-19');
INSERT INTO Entite VALUES(131,'2007-10-08');
INSERT INTO Entite VALUES(132,'2007-10-27');
INSERT INTO Entite VALUES(133,'2007-11-15');
INSERT INTO Entite VALUES(134,'2007-12-04');
INSERT INTO Entite VALUES(135,'2007-12-23');
INSERT INTO Entite VALUES(136,'2008-01-11');
INSERT INTO Entite VALUES(137,'2008-01-30');
INSERT INTO Entite VALUES(138,'2008-02-18');
INSERT INTO Entite VALUES(139,'2008-03-08');
INSERT INTO Entite VALUES(140,'2008-03-27');
INSERT INTO Entite VALUES(141,'2008-04-15');
INSERT INTO Entite VALUES(142,'2008-05-04');
INSERT INTO Entite VALUES(143,'2008-05-23');
INSERT INTO Entite VALUES(144,'2008-06-11');
INSERT INTO Entite VALUES(145,'2008-06-30');
INSERT INTO Entite VALUES(146,'2008-07-19');
INSERT INTO Entite VALUES(147,'2008-08-07');
INSERT INTO Entite VALUES(148,'2008-08-26');
INSERT INTO Entite VALUES(149,'2008-09-14');
INSERT INTO Entite VALUES(150,'2008-10-03');
INSERT INTO Entite VALUES(151,'2008-10-22');
INSERT INTO Entite VALUES(152,'2008-11-10');
INSERT INTO Entite VALUES(153,'2008-11-29');
INSERT INTO Entite VALUES(154,'2008-12-18');
INSERT INTO Entite VALUES(155,'2009-01-06');
INSERT INTO Entite VALUES(156,'2009-01-25');
INSERT INTO Entite VALUES(157,'2009-02-13');
INSERT INTO Entite VALUES(158,'2009-03-04');
INSERT INTO Entite VALUES(159,'2009-03-23');
INSERT INTO Entite VALUES(160,'2009-04-11');
INSERT INTO Entite VALUES(161,'2009-04-30');
INSERT INTO Entite VALUES(162,'2009-05-19');
INSERT INTO Entite VALUES(163,'2009-06-07');
INSERT INTO Entite VALUES(164,'2009-06-26');
INSERT INTO Entite VALUES(165,'2009-07-15');
INSERT INTO Entite VALUES(166,'2009-08-03');
INSERT INTO Entite VALUES(167,'2009-08-22');
INSERT INTO Entite VALUES(168,'2009-09-10');
INSERT INTO Entite VALUES(169,'2009-09-29');
INSERT INTO Entite VALUES(170,'2009-10-18');
INSERT INTO Entite VALUES(171,'2009-11-06');
INSERT INTO Entite VALUES(172,'2009-11-25');
INSERT INTO Entite VALUES(173,'2009-12-14');
INSERT INTO Entite VALUES(174,'2010-01-02');
INSERT INTO Entite VALUES(175,'2010-01-21');
INSERT INTO Entite VALUES(176,'2010-02-09');
INSERT INTO Entite VALUES(177,'2010-02-28');
INSERT INTO Entite VALUES(178,'2010-03-19');
INSERT INTO Entite VALUES(179,'2010-04-07');
INSERT INTO Entite VALUES(180,'2010-04-26');
INSERT INTO Entite VALUES(181,'2010-05-15');
INSERT INTO Entite VALUES(182,'2010-06-03');
INSERT INTO Entite VALUES(183,'2010-06-22');
INSERT INTO Entite VALUES(184,'2010-07-11');
INSERT INTO Entite VALUES(185,'2010-07-30');
INSERT INTO Entite VALUES(186,'2010-08-18');
INSERT INTO Entite VALUES(187,'2010-09-06');
INSERT INTO Entite VALUES(188,'2010-09-25');
INSERT INTO Entite VALUES(189,'2010-10-14');
INSERT INTO Entite VALUES(190,'2010-11-02');
INSERT INTO Entite VALUES(191,'2010-11-21');
INSERT INTO Entite VALUES(192,'2010-12-10');
INSERT INTO Entite VALUES(193,'2010-12-29');
INSERT INTO Entite VALUES(194,'2011-01-17');
INSERT INTO Entite VALUES(195,'2011-02-05');
INSERT INTO Entite VALUES(196,'2011-02-24');
INSERT INTO Entite VALUES(197,'2011-03-15');
INSERT INTO Entite VALUES(198,'2011-04-03');
INSERT INTO Entite VALUES(199,'2011-04-22');
INSERT INTO Entite VALUES(200,'2011-05-11');
INSERT INTO Entite VALUES(201,'2011-05-30');
INSERT INTO Entite VALUES(202,'2011-06-18');
INSERT INTO Entite VALUES(203,'2011-07-07');
INSERT INTO Entite VALUES(204,'2011-07-26');
INSERT INTO Entite VALUES(205,'2011-08-14');
INSERT INTO Entite VALUES(206,'2011-09-02');
INSERT INTO Entite VALUES(207,'2011-09-21');
INSERT INTO Entite VALUES(208,'2011-10-10');
INSERT INTO Entite VALUES(209,'2011-10-29');
INSERT INTO Entite VALUES(210,'2011-11-17');
INSERT INTO Entite VALUES(211,'2011-12-06');
INSERT INTO Entite VALUES(212,'2011-12-25');
INSERT INTO Entite VALUES(213,'2012-01-13');
INSERT INTO Entite VALUES(214,'2012-02-01');
INSERT INTO Entite VALUES(215,'2012-02-20');
INSERT INTO Entite VALUES(216,'2012-03-10');
INSERT INTO Entite VALUES(217,'2012-03-29');
INSERT INTO Entite VALUES(218,'2012-04-17');
INSERT INTO Entite VALUES(219,'2012-05-06');
INSERT INTO Entite VALUES(220,'2012-05-25');

GO


-- Table Entreprise
-- EntiteNo INTEGER NOT NULL,RaisonSociale VARCHAR(50) NOT NULL,Type VARCHAR(50) NOT NULL,NoTVA VARCHAR(50)
INSERT INTO Entreprise VALUES(5,'UBS','SA','CHE-123.856.789 TVA' );
INSERT INTO Entreprise VALUES(10,'Meyer','Sarl','CHE-223.436.789 TVA');
INSERT INTO Entreprise VALUES(15,'Medtronic','SA','CHE-923.436.739 TVA');
INSERT INTO Entreprise VALUES(20,'HEIG-VD','SA','CHE-142.256.739 TVA');
INSERT INTO Entreprise VALUES(25,'La Poste Renens VD','SAS','CHE-523.151.189 TVA');
INSERT INTO Entreprise VALUES(30,'Transport Lausannois','SA','CHE-113.436.281 TVA');
INSERT INTO Entreprise VALUES(35,'SCHL','Sarl','CHE-293.436.789 TVA');
INSERT INTO Entreprise VALUES(40,'Tv-Services','SA','CHE-125.436.739 TVA');
INSERT INTO Entreprise VALUES(45,'Café des Bouchers','SA','CHE-122.256.739 TVA');
INSERT INTO Entreprise VALUES(50,'Mairie Chavannes-près-Renens','SAS','CHE-196.151.189 TVA');
INSERT INTO Entreprise VALUES(55,'Mediamarkt','SA','CHE-533.426.389 TVA');
INSERT INTO Entreprise VALUES(60,'Interdiscount','Sarl','CHE-221.232.729 TVA');
INSERT INTO Entreprise VALUES(65,'Fnac','SA','CHE-233.436.739 TVA');
INSERT INTO Entreprise VALUES(70,'Atari','SA','CHE-921.436.789 TVA');
INSERT INTO Entreprise VALUES(75,'La mobilière','SAS','CHE-642.436.739 TVA');
INSERT INTO Entreprise VALUES(80,'Helsana','SA','CHE-156.256.739 TVA');
INSERT INTO Entreprise VALUES(85,'KPMG','Sarl','CHE-133.151.189 TVA');
INSERT INTO Entreprise VALUES(90,'Price Waterhouse Coopers ','SA','CHE-883.436.281 TVA');
INSERT INTO Entreprise VALUES(95,'BCV','SA','CHE-222.436.789 TVA');
INSERT INTO Entreprise VALUES(100,'Raffeisen','SAS','CHE-513.436.768 TVA');
INSERT INTO Entreprise VALUES(105,'Orange','SA','CHE-422.256.739 TVA');
INSERT INTO Entreprise VALUES(110,'Aldi','Sarl','CHE-123.151.189 TVA');
INSERT INTO Entreprise VALUES(115,'Aligros','SA','CHE-113.426.389 TVA');
INSERT INTO Entreprise VALUES(120,'Peugeot','SA','CHE-121.232.729 TVA');
INSERT INTO Entreprise VALUES(125,'Zinc Club','SAS','CHE-123.436.239 TVA');
INSERT INTO Entreprise VALUES(130,'BuzzClub','SA','CHE-283.236.789 TVA');
INSERT INTO Entreprise VALUES(135,'Migros','Sarl','CHE-183.426.666 TVA');
INSERT INTO Entreprise VALUES(140,'Coop','SA','CHE-322.256.739 TVA');
INSERT INTO Entreprise VALUES(145,'Pernod-Riccard','SA','CHE-821.151.189 TVA');
INSERT INTO Entreprise VALUES(150,'Boucherie de la plaine','SAS','CHE-113.416.281 TVA');
INSERT INTO Entreprise VALUES(155,'SOS-Plombier','SA','CHE-223.416.789 TVA');
INSERT INTO Entreprise VALUES(160,'Vis-Ta-Visse','Sarl','CHE-747.416.739 TVA');
INSERT INTO Entreprise VALUES(165,'Salesforce.com','SA','CHE-612.216.739 TVA');
INSERT INTO Entreprise VALUES(170,'Ikea','SA','CHE-683.111.189 TVA');
INSERT INTO Entreprise VALUES(175,'Python Sécurité','SAS','CHE-118.416.389 TVA');
INSERT INTO Entreprise VALUES(180,'Quinodoz & Fils','SA','CHE-221.212.729 TVA');
INSERT INTO Entreprise VALUES(185,'Maxi-Bazar','Sarl', 'CHE-723.434.289 TVA');
INSERT INTO Entreprise VALUES(190,'Manor','SA','CHE-723.434.789 TVA');
INSERT INTO Entreprise VALUES(195,'Aux petites Pizzas','SA','CHE-423.446.739 TVA');
INSERT INTO Entreprise VALUES(200,'Ali Kebab','SAS','CHE-165.256.739 TVA');
INSERT INTO Entreprise VALUES(205,'Le club économique Lavaux','SA','CHE-623.151.189 TVA');
INSERT INTO Entreprise VALUES(210,'Le petit noêl des enfants','Sarl','CHE-773.436.281 TVA');
--La ligne 215 n'existe pas se qui crée une erreur de réservation sur la sortie 216, contrainte d'integrite 2

GO


-- Table PP
--EntiteNo INTEGER NOT NULL,Nom VARCHAR(50) NOT NULL,Prenom VARCHAR(50) NOT NULL,Civilite VARCHAR(50) NOT NULL, DateNaissance DATE NOT NULL
INSERT INTO PP VALUES(1,'Papaux','Rose-Marie','Madame' ,'1959-11-09');
INSERT INTO PP VALUES(2,'Meyer','Julien','Monsieur','1970-06-06');
INSERT INTO PP VALUES(3,'Ponce','Adil','Monsieur','1978-02-27');
INSERT INTO PP VALUES(4,'Buchen','Adrien','Monsieur','1961-07-06');
INSERT INTO PP VALUES(6,'Pauchard','Pascale','Madame' ,'1975-02-02');
INSERT INTO PP VALUES(7,'Peris','Sarah','Madame' ,'1955-12-03');
INSERT INTO PP VALUES(8,'Abtouche','Simon','Monsieur','1982-11-13');
INSERT INTO PP VALUES(9,'Abou','Jean-Pierre','Monsieur','1985-11-14');
INSERT INTO PP VALUES(11,'Bouvier','Julien','Monsieur','1957-02-18');
INSERT INTO PP VALUES(12,'Bakhsh','Fabien','Monsieur','1965-01-08');
INSERT INTO PP VALUES(13,'Beaudoin','Ousmane','Monsieur','1945-11-18');
INSERT INTO PP VALUES(14,'Araya-Diaz','Chouga','Monsieur','1957-01-02');
INSERT INTO PP VALUES(16,'Abdulmanan','Renaud','Monsieur','1975-06-06');
INSERT INTO PP VALUES(17,'Akari','Gaëtan','Monsieur','1974-12-16');
INSERT INTO PP VALUES(18,'Bouchard-Huppé','Romuald','Monsieur','1955-04-05');
INSERT INTO PP VALUES(19,'Bourret','Aurélien','Monsieur','1964-04-16');
INSERT INTO PP VALUES(21,'Butler','Yonnick','Monsieur','1957-02-26');
INSERT INTO PP VALUES(22,'Bezzaoucha','Erwann','Monsieur','1957-05-16');
INSERT INTO PP VALUES(23,'Benzakour Knidel','Alain','Monsieur','1947-06-27');
INSERT INTO PP VALUES(24,'Piard','Nadia','Madame' ,'1971-10-06');
INSERT INTO PP VALUES(26,'BonMonsieur','Dmytro','Monsieur','1953-12-16');
INSERT INTO PP VALUES(27,'Bonin','François','Monsieur','1983-11-12');
INSERT INTO PP VALUES(28,'Beauchemin','Jonathan','Monsieur','1972-11-01');
INSERT INTO PP VALUES(29,'Bousquet','Fabien','Monsieur','1941-11-06');
INSERT INTO PP VALUES(31,'Abdel-Halim','Bryan','Monsieur','1980-05-17');
INSERT INTO PP VALUES(32,'Atindehou','Michaël','Monsieur','1979-08-08');
INSERT INTO PP VALUES(33,'Boudriau','Jonathan','Monsieur','1982-01-30');
INSERT INTO PP VALUES(34,'Ahmed','Vadym','Monsieur','1978-05-14');
INSERT INTO PP VALUES(36,'Ali-Côté','Guillaume','Monsieur','1978-05-14');
INSERT INTO PP VALUES(37,'Aloe','Eric','Monsieur','1974-07-04');
INSERT INTO PP VALUES(38,'Perriard','Raymonde','Madame' ,'1961-02-12');
INSERT INTO PP VALUES(39,'Agurto Pena','Romain','Monsieur','1991-06-16');
INSERT INTO PP VALUES(41,'Allard','Kévin','Monsieur','1950-09-09');
INSERT INTO PP VALUES(42,'Azoulay','Julien','Monsieur','1949-05-15');
INSERT INTO PP VALUES(43,'Pythoud','Catherine','Madame' ,'1984-01-02');
INSERT INTO PP VALUES(44,'Quinodoz','Marylin','Madame' ,'1985-11-03');
INSERT INTO PP VALUES(46,'Azimi','William','Monsieur','1955-10-17');
INSERT INTO PP VALUES(47,'Behsudi','Willy','Monsieur','1965-10-04');
INSERT INTO PP VALUES(48,'Balarezo','Thomas','Monsieur','1984-02-28');
INSERT INTO PP VALUES(49,'Attayeb','Arnaud','Monsieur','1947-02-08');
INSERT INTO PP VALUES(51,'Aligoté','Benjamin','Monsieur','1955-12-18');
INSERT INTO PP VALUES(52,'Abdul Ahmad','Julien','Monsieur','1966-07-02');
INSERT INTO PP VALUES(53,'Déodati','Eric','Monsieur','1965-11-02');
INSERT INTO PP VALUES(54,'Ali','Denis','Monsieur','1954-10-02');
INSERT INTO PP VALUES(56,'Rahmed','Eric','Monsieur','1964-04-05');
INSERT INTO PP VALUES(57,'Benidir','Cédric','Monsieur','1964-03-01');
INSERT INTO PP VALUES(58,'Brassard','Christophe','Monsieur','1947-12-26');
INSERT INTO PP VALUES(59,'Moghrabi','Fabrice','Monsieur','1987-05-18');

INSERT INTO PP VALUES(62,'Pillonel','Violaine','Madame' ,'1981-10-07');
INSERT INTO PP VALUES(63,'Bautista','Jean-Charles','Monsieur','1983-10-10');
INSERT INTO PP VALUES(64,'Belony','Urs','Monsieur','1981-09-02');
INSERT INTO PP VALUES(66,'Boursas','Daniel','Monsieur','1983-10-17');
INSERT INTO PP VALUES(67,'Boko','Fabien','Monsieur','1952-10-12');
INSERT INTO PP VALUES(68,'Bourget','Jérôme','Monsieur','1981-02-10');
INSERT INTO PP VALUES(69,'Brousseau','Serge','Monsieur','1980-09-20');
INSERT INTO PP VALUES(71,'Bisson','Nicolas','Monsieur','1980-11-30');
INSERT INTO PP VALUES(72,'Renevey','Marlis','Madame' ,'1977-05-14');
INSERT INTO PP VALUES(73,'Ah-Sen','René','Monsieur','1978-08-18');
INSERT INTO PP VALUES(74,'Al-Moghrabi','Hansjörg','Monsieur','1973-07-18');
INSERT INTO PP VALUES(76,'lonel','Catherine','Madame' ,'1970-08-18');
INSERT INTO PP VALUES(77,'Béliard-Joseph','Bruno','Monsieur','1980-04-12');
INSERT INTO PP VALUES(78,'Boyd','Marc-Henri','Monsieur','1970-09-07');
INSERT INTO PP VALUES(79,'Dahan','Serge','Monsieur','1968-02-05');
INSERT INTO PP VALUES(81,'Al-Atrash','André','Monsieur','1987-01-22');
INSERT INTO PP VALUES(82,'Bartlett','Fabrice','Monsieur','1984-10-13');

INSERT INTO PP VALUES(84,'Boire','Fabrice','Monsieur','1984-07-14');
INSERT INTO PP VALUES(86,'Archambault','Guillaume','Monsieur','1984-12-22');
INSERT INTO PP VALUES(87,'Blouin','Alain','Monsieur','1967-12-18');
INSERT INTO PP VALUES(88,'Al-Nakeeb','Bernard','Monsieur','1985-11-18');
INSERT INTO PP VALUES(89,'Amarsat','René','Monsieur','1986-08-02');
INSERT INTO PP VALUES(91,'Bault','Olivier','Monsieur','1985-01-22');
INSERT INTO PP VALUES(92,'Berni','Alexandre','Monsieur','1985-10-02');
INSERT INTO PP VALUES(93,'Beaulieu','Gilles','Monsieur','1984-05-05');
INSERT INTO PP VALUES(94,'Chartrand','Thomas','Monsieur','1964-03-03');
INSERT INTO PP VALUES(96,'Benoit','Gilles','Monsieur','1986-10-26');
INSERT INTO PP VALUES(97,'Afghani','Marc','Monsieur','1984-01-18');
INSERT INTO PP VALUES(98,'Bernard','Georges','Monsieur','1986-01-28');
INSERT INTO PP VALUES(99,'Humair','Inge','Madame','1981-11-07');
INSERT INTO PP VALUES(101,'Beau','Claude-Alain','Monsieur','1983-03-02');
INSERT INTO PP VALUES(102,'Bien-Aimé','Edgard','Monsieur','1981-10-02');
INSERT INTO PP VALUES(103,'Belean','Jean-François','Monsieur','1983-10-07');
INSERT INTO PP VALUES(104,'Bélanger','Claude-Alain','Monsieur','1982-10-22');
INSERT INTO PP VALUES(106,'Bhaloo','Roland','Monsieur','1981-02-14');
INSERT INTO PP VALUES(107,'Ahmed','Philippe','Monsieur','1980-09-21');
INSERT INTO PP VALUES(108,'Alam','Peter','Monsieur','1979-10-21');
INSERT INTO PP VALUES(109,'Jabornigg','Nicole','Madame','1977-06-14');
INSERT INTO PP VALUES(111,'Al-Ged','Yvan','Monsieur','1971-11-21');
INSERT INTO PP VALUES(112,'Bétancourt','Daniel','Monsieur','1973-07-17');
INSERT INTO PP VALUES(113,'Jaccard','Yvette','Madame','1988-07-17');
INSERT INTO PP VALUES(114,'Antaya','Pascal','Monsieur','1990-11-12');
INSERT INTO PP VALUES(116,'Belfix','Fabrice','Monsieur','1985-09-07');
INSERT INTO PP VALUES(117,'Béranger','Bernard','Monsieur','1985-02-05');
INSERT INTO PP VALUES(118,'Joye','Bernadette','Madame','1986-11-22');
INSERT INTO PP VALUES(119,'Boyard','Dominique','Madame','1984-12-15');
INSERT INTO PP VALUES(121,'Bellemare','Dominique','Monsieur','1987-10-08');
INSERT INTO PP VALUES(122,'Baarabe','Joakim','Monsieur','1984-07-07');
INSERT INTO PP VALUES(123,'Benidir','Alexandre','Monsieur','1987-11-22');
INSERT INTO PP VALUES(124,'Alamy','Emmanuel','Monsieur','1987-11-18');
INSERT INTO PP VALUES(126,'Bergeron','Julien','Monsieur','1985-12-18');
INSERT INTO PP VALUES(127,'Boulanger','Raphaël','Monsieur','1987-08-12');
INSERT INTO PP VALUES(128,'Borduas-Paré','Claude','Monsieur','1985-11-02');
INSERT INTO PP VALUES(129,'Buri','Bernard','Monsieur','1985-10-12');
INSERT INTO PP VALUES(131,'Brault','Cyrille','Monsieur','1984-05-15');
INSERT INTO PP VALUES(132,'Bessette','Vincent','Monsieur','1974-08-03');
INSERT INTO PP VALUES(133,'André','Claude','Monsieur','1986-07-26');
INSERT INTO PP VALUES(134,'Awad','Pascal','Monsieur','1985-12-02');
INSERT INTO PP VALUES(136,'Akbari','Albert','Monsieur','1987-12-05');
INSERT INTO PP VALUES(137,'kilchör','Marielle','Madame','1982-06-07');
INSERT INTO PP VALUES(138,'Barkley','Michel','Monsieur','1982-01-12');
INSERT INTO PP VALUES(139,'Aviles-Valdenegro','Conrad','Monsieur','1982-10-02');
INSERT INTO PP VALUES(141,'Aebischer','Daniel','Monsieur','1982-10-07');
INSERT INTO PP VALUES(142,'Aeby','Dominique','Monsieur','1981-10-02');
INSERT INTO PP VALUES(143,'Arnold','André','Monsieur','1980-02-14');
INSERT INTO PP VALUES(144,'Bachmann','Christophe','Monsieur','1979-09-21');
INSERT INTO PP VALUES(146,'Baechler','Christian','Monsieur','1979-03-22');
INSERT INTO PP VALUES(147,'Köhl','Sabine','Madame','1978-06-14');
INSERT INTO PP VALUES(148,'Bapst','Michel','Monsieur','1975-11-12');
INSERT INTO PP VALUES(149,'Barras','Alain','Monsieur','1972-07-17');
INSERT INTO PP VALUES(151,'Krattinger','Gilberte','Madame','1990-10-11');

INSERT INTO PP VALUES(153,'Berger','Martin','Monsieur','1982-09-07');
INSERT INTO PP VALUES(154,'Bersier','Maurice','Monsieur','1992-12-05');
INSERT INTO PP VALUES(156,'Losey','Anna','Madame','1987-03-12');
INSERT INTO PP VALUES(157,'Marmy','Josiane','Madame','1987-10-10');
INSERT INTO PP VALUES(158,'Blanc','Yves','Monsieur','1986-12-28');
INSERT INTO PP VALUES(159,'Bommer','Jean-Baptiste','Monsieur','1984-05-07');
INSERT INTO PP VALUES(161,'Borgognon','Eric','Monsieur','1987-10-20');
INSERT INTO PP VALUES(162,'Bourqui','Dominique','Monsieur','1987-11-19');
INSERT INTO PP VALUES(163,'Bratschi','Jean-Daniel','Monsieur','1985-11-11');
INSERT INTO PP VALUES(164,'Bugnon','Jean-Bernard','Monsieur','1987-06-12');
INSERT INTO PP VALUES(166,'Burgy','Marc','Monsieur','1985-11-12');
INSERT INTO PP VALUES(167,'Carrard-liniger','Robert','Monsieur','1985-10-06');
INSERT INTO PP VALUES(168,'Castaldi','Julien','Monsieur','1984-06-15');
INSERT INTO PP VALUES(169,'Ceriani-lambert','Nicolas','Monsieur','1984-04-03');
INSERT INTO PP VALUES(171,'Chambettaz','Romain','Monsieur','1986-09-26');
INSERT INTO PP VALUES(172,'Chanez','Shael','Monsieur','1985-04-18');
INSERT INTO PP VALUES(173,'Chardonnens','Jean-Noel','Monsieur','1986-04-28');
INSERT INTO PP VALUES(174,'Mast','Florence','Madame','1983-02-07');
INSERT INTO PP VALUES(176,'Chardon','Baptiste','Monsieur','1982-01-12');
INSERT INTO PP VALUES(177,'Charrot','Florent','Monsieur','1983-10-02');
INSERT INTO PP VALUES(178,'Chanot','Mickaël','Monsieur','1982-11-07');
INSERT INTO PP VALUES(179,'Chassot','Nabil','Monsieur','1981-11-02');
INSERT INTO PP VALUES(181,'Chevalley','Jean','Monsieur','1980-05-14');
INSERT INTO PP VALUES(182,'Corboz','Yann','Monsieur','1979-08-20');
INSERT INTO PP VALUES(183,'Corminboeuf','Daniel','Monsieur','1980-12-14');
INSERT INTO PP VALUES(184,'Marmy','Carine','Madame','1977-07-11');
INSERT INTO PP VALUES(186,'Cormin','David','Monsieur','1977-07-17');
INSERT INTO PP VALUES(187,'Cornol','Julian','Monsieur','1972-04-17');
INSERT INTO PP VALUES(188,'Monney','Anne-Marie','Madame','1992-01-17');
INSERT INTO PP VALUES(189,'Cotting','Bernard','Monsieur','1990-11-19');
INSERT INTO PP VALUES(191,'Cotti','Karim','Monsieur','1992-01-27');
INSERT INTO PP VALUES(192,'Crausaz','Joël','Monsieur','1988-12-25');
INSERT INTO PP VALUES(193,'Meyer','Myriam','Madame','1987-06-23');
INSERT INTO PP VALUES(194,'Montemayor','Anne-Marie','Madame','1986-02-15');
INSERT INTO PP VALUES(196,'Cuany','Dany','Monsieur','1985-03-18');
INSERT INTO PP VALUES(197,'Currat','Rui','Monsieur','1985-02-07');
INSERT INTO PP VALUES(198,'Devalois','Nicolas','Monsieur','1957-11-10');
INSERT INTO PP VALUES(199,'Dietlin','Ian','Monsieur','1987-10-19');
INSERT INTO PP VALUES(201,'Dos','Arnaud','Monsieur','1984-02-18');
INSERT INTO PP VALUES(202,'Doudin','Jaques','Monsieur','1985-12-12');
INSERT INTO PP VALUES(203,'Duport','Jean-Charles','Monsieur','1985-11-17');
INSERT INTO PP VALUES(204,'Egger','Christophe','Monsieur','1987-11-12');
INSERT INTO PP VALUES(206,'Fontaine','Lucas','Monsieur','1984-05-04');
INSERT INTO PP VALUES(207,'Fontini','Christian','Monsieur','1984-08-30');
INSERT INTO PP VALUES(208,'Fornerod','Sébastien','Monsieur','1987-07-21');
INSERT INTO PP VALUES(209,'Fander','Jérome','Monsieur','1984-01-18');
INSERT INTO PP VALUES(211,'Godel','Stéphane','Monsieur','1986-01-28');
INSERT INTO PP VALUES(212,'Nucifora','Marie-Claude','Madame','1981-12-07');
INSERT INTO PP VALUES(213,'Bodel','Meven','Monsieur','1981-11-02');
INSERT INTO PP VALUES(214,'Graf-chuard','Marc','Monsieur','1983-12-12');
INSERT INTO PP VALUES(216,'Grandgirard','Kevin','Monsieur','1972-11-17');
INSERT INTO PP VALUES(217,'Guerry','Michel','Monsieur','1981-11-12');
INSERT INTO PP VALUES(218,'Häenni','Carlo','Monsieur','1980-05-04');
INSERT INTO PP VALUES(219,'Henchoz','Peter','Monsieur','1979-08-30');
-- Modification pour contrainte d'intégrité 6
INSERT INTO PP VALUES(61,'Adel','Kurt','Monsieur','1986-05-27');
INSERT INTO PP VALUES(83,'Altuntas','Pierre-Yves','Monsieur','1987-11-10');
INSERT INTO PP VALUES(152,'Baudin','Patrice','Monsieur','1990-11-19');
--Modification pour Validation
INSERT INTO PP VALUES(115,'Grand','Alain','Monsieur','1972-12-17');

GO

-- Table Sortie
--No INTEGER NOT NULL,Designation VARCHAR(50) NOT NULL,DateDebut DATE NOT NULL,DateFin DATE NOT NULL,HeureDebut DATE NOT NULL,HeureFin DATE NOT NULL,Type VARCHAR(50) NOT NULL,Commentaire VARCHAR(50) NOT NULL,PortDepart INTEGER NOT NULL,PortArrivee INTEGER NOT NULL,Precedente INTEGER NOT NULL
INSERT INTO Sortie VALUES(1,'Anniversaire','2001-01-20','2001-01-20','2001-01-20 19:00:00','2001-01-20 22:00:00','commercial','-',1,1, NULL);
INSERT INTO Sortie VALUES(2,'Anniversaire','2001-02-08','2001-02-08','2001-02-08 19:00:00','2001-02-08 22:00:00','commercial','-',1,1,1);
INSERT INTO Sortie VALUES(3,'Anniversaire','2001-02-27','2001-02-27','2001-02-27 19:00:00','2001-02-27 22:00:00','commercial','-',1,1,2);
INSERT INTO Sortie VALUES(4,'Anniversaire','2001-03-18','2001-03-18','2001-03-18 19:00:00','2001-03-18 22:00:00','commercial','-',1,1,3);
INSERT INTO Sortie VALUES(5,'interne','2001-04-06','2001-04-06','2001-04-06 19:00:00','2001-04-06 22:00:00','interne','-',1,85,4);
INSERT INTO Sortie VALUES(6,'Sortie Entreprise','2001-04-25','2001-04-25','2001-04-25 19:00:00','2001-04-25 22:00:00','commercial','-',1,1,5);
INSERT INTO Sortie VALUES(7,'Anniversaire','2001-05-14','2001-05-14','2001-05-14 19:00:00','2001-05-14 22:00:00','commercial','-',1,1,6);
INSERT INTO Sortie VALUES(8,'Anniversaire','2001-06-02','2001-06-02','2001-06-02 19:00:00','2001-06-02 22:00:00','commercial','-',1,1,7);
INSERT INTO Sortie VALUES(9,'Anniversaire','2001-06-21','2001-06-21','2001-06-21 19:00:00','2001-06-21 22:00:00','commercial','-',1,1,8);
INSERT INTO Sortie VALUES(10,'entraînement','2001-07-10','2001-07-10','2001-07-10 19:00:00','2001-07-10 22:00:00','entraînement','-',1,1,9);
INSERT INTO Sortie VALUES(11,'Sortie Entreprise','2001-07-29','2001-07-29','2001-07-29 19:00:00','2001-07-29 22:00:00','commercial','-',1,1,10);
INSERT INTO Sortie VALUES(12,'Anniversaire','2001-08-17','2001-08-17','2001-08-17 19:00:00','2001-08-17 22:00:00','commercial','-',1,1,11);
INSERT INTO Sortie VALUES(13,'Anniversaire','2001-09-05','2001-09-05','2001-09-05 19:00:00','2001-09-05 22:00:00','commercial','-',1,1,12);
INSERT INTO Sortie VALUES(14,'Anniversaire','2001-09-24','2001-09-24','2001-09-24 19:00:00','2001-09-24 22:00:00','commercial','-',1,1,13);
INSERT INTO Sortie VALUES(15,'interne','2001-10-13','2001-10-13','2001-10-13 19:00:00','2001-10-13 22:00:00','interne','-',1,1,14);
INSERT INTO Sortie VALUES(16,'Sortie Entreprise','2001-11-01','2001-11-01','2001-11-01 19:00:00','2001-11-01 22:00:00','commercial','-',1,1,15);
INSERT INTO Sortie VALUES(17,'Sortie Entreprise','2001-11-20','2001-11-20','2001-11-20 19:00:00','2001-11-20 22:00:00','commercial','-',1,1,16);
INSERT INTO Sortie VALUES(18,'Anniversaire','2001-12-09','2001-12-09','2001-12-09 19:00:00','2001-12-09 22:00:00','commercial','-',1,1,17);
INSERT INTO Sortie VALUES(19,'Anniversaire','2001-12-28','2001-12-28','2001-12-28 19:00:00','2001-12-28 22:00:00','commercial','-',1,1,18);
INSERT INTO Sortie VALUES(20,'entraînement','2002-01-16','2002-01-16','2002-01-16 19:00:00','2002-01-16 22:00:00','entraînement','-',1,1,19);
INSERT INTO Sortie VALUES(21,'Sortie Entreprise','2002-02-04','2002-02-04','2002-02-04 19:00:00','2002-02-04 22:00:00','commercial','-',1,1,20);
INSERT INTO Sortie VALUES(22,'Sortie Entreprise','2002-02-23','2002-02-23','2002-02-23 19:00:00','2002-02-23 22:00:00','commercial','-',1,1,21);
INSERT INTO Sortie VALUES(23,'Anniversaire','2002-03-14','2002-03-14','2002-03-14 19:00:00','2002-03-14 22:00:00','commercial','-',1,1,22);
INSERT INTO Sortie VALUES(24,'Anniversaire','2002-04-02','2002-04-02','2002-04-02 19:00:00','2002-04-02 22:00:00','commercial','-',1,1,23);
INSERT INTO Sortie VALUES(25,'interne','2002-04-21','2002-04-21','2002-04-21 19:00:00','2002-04-21 22:00:00','interne','-',1,1,24);
INSERT INTO Sortie VALUES(26,'Anniversaire','2002-05-10','2002-05-10','2002-05-10 19:00:00','2002-05-10 22:00:00','commercial','-',1,1,25);
INSERT INTO Sortie VALUES(27,'Sortie Entreprise','2002-05-29','2002-05-29','2002-05-29 19:00:00','2002-05-29 22:00:00','commercial','-',1,1,26);
INSERT INTO Sortie VALUES(28,'Sortie Entreprise','2002-06-17','2002-06-17','2002-06-17 19:00:00','2002-06-17 22:00:00','commercial','-',1,1,27);
INSERT INTO Sortie VALUES(29,'Anniversaire','2002-07-06','2002-07-06','2002-07-06 19:00:00','2002-07-06 22:00:00','commercial','-',1,1,28);
INSERT INTO Sortie VALUES(30,'entraînement','2002-07-25','2002-07-25','2002-07-25 19:00:00','2002-07-25 22:00:00','entraînement','-',1,1,29);
INSERT INTO Sortie VALUES(31,'Anniversaire','2002-08-13','2002-08-13','2002-08-13 19:00:00','2002-08-13 22:00:00','commercial','-',1,1,30);
INSERT INTO Sortie VALUES(32,'Sortie Entreprise','2002-09-01','2002-09-01','2002-09-01 19:00:00','2002-09-01 22:00:00','commercial','-',1,1,31);
INSERT INTO Sortie VALUES(33,'Sortie Entreprise','2002-09-20','2002-09-20','2002-09-20 19:00:00','2002-09-20 22:00:00','commercial','-',1,1,32);
INSERT INTO Sortie VALUES(34,'Anniversaire','2002-10-09','2002-10-09','2002-10-09 19:00:00','2002-10-09 22:00:00','commercial','-',1,1,33);
INSERT INTO Sortie VALUES(35,'interne','2002-10-28','2002-10-28','2002-10-28 19:00:00','2002-10-28 22:00:00','interne','-',1,1,34);
INSERT INTO Sortie VALUES(36,'Anniversaire','2002-11-16','2002-11-16','2002-11-16 19:00:00','2002-11-16 22:00:00','commercial','-',1,85,35);
INSERT INTO Sortie VALUES(37,'Anniversaire','2002-12-05','2002-12-05','2002-12-05 19:00:00','2002-12-05 22:00:00','commercial','-',1,1,36);
INSERT INTO Sortie VALUES(38,'Anniversaire','2002-12-24','2002-12-24','2002-12-24 19:00:00','2002-12-24 22:00:00','commercial','-',1,1,37);
INSERT INTO Sortie VALUES(39,'Anniversaire','2003-01-12','2003-01-12','2003-01-12 19:00:00','2003-01-12 22:00:00','commercial','-',1,1,38);
INSERT INTO Sortie VALUES(40,'entraînement','2003-01-31','2003-01-31','2003-01-31 19:00:00','2003-01-31 22:00:00','entraînement','-',1,1,39);
INSERT INTO Sortie VALUES(41,'Sortie Entreprise','2003-02-19','2003-02-19','2003-02-19 19:00:00','2003-02-19 22:00:00','commercial','-',1,1,40);
INSERT INTO Sortie VALUES(42,'Anniversaire','2003-03-10','2003-03-10','2003-03-10 19:00:00','2003-03-10 22:00:00','commercial','-',1,1,41);
INSERT INTO Sortie VALUES(43,'Anniversaire','2003-03-29','2003-03-29','2003-03-29 19:00:00','2003-03-29 22:00:00','commercial','-',1,1,42);
INSERT INTO Sortie VALUES(44,'Anniversaire','2003-04-17','2003-04-17','2003-04-17 19:00:00','2003-04-17 22:00:00','commercial','-',1,1,43);
INSERT INTO Sortie VALUES(45,'interne','2003-05-06','2003-05-06','2003-05-06 19:00:00','2003-05-06 22:00:00','interne','-',1,1,44);
INSERT INTO Sortie VALUES(46,'Sortie Entreprise','2003-05-25','2003-05-25','2003-05-25 19:00:00','2003-05-25 22:00:00','commercial','-',1,1,45);
INSERT INTO Sortie VALUES(47,'Anniversaire','2003-06-13','2003-06-13','2003-06-13 19:00:00','2003-06-13 22:00:00','commercial','-',1,1,46);
INSERT INTO Sortie VALUES(48,'Anniversaire','2003-07-02','2003-07-02','2003-07-02 19:00:00','2003-07-02 22:00:00','commercial','-',1,1,47);
INSERT INTO Sortie VALUES(49,'Anniversaire','2003-07-21','2003-07-21','2003-07-21 19:00:00','2003-07-21 22:00:00','commercial','-',1,1,48);
INSERT INTO Sortie VALUES(50,'entraînement','2003-08-09','2003-08-09','2003-08-09 19:00:00','2003-08-09 22:00:00','entraînement','-',1,1,49);
INSERT INTO Sortie VALUES(51,'Sortie Entreprise','2003-08-28','2003-08-28','2003-08-28 19:00:00','2003-08-28 22:00:00','commercial','-',1,1,50);
INSERT INTO Sortie VALUES(52,'Sortie Entreprise','2003-09-16','2003-09-16','2003-09-16 19:00:00','2003-09-16 22:00:00','commercial','-',1,1,51);
INSERT INTO Sortie VALUES(53,'Anniversaire','2003-10-05','2003-10-05','2003-10-05 19:00:00','2003-10-05 22:00:00','commercial','-',1,1,52);
INSERT INTO Sortie VALUES(54,'Anniversaire','2003-10-24','2003-10-24','2003-10-24 19:00:00','2003-10-24 22:00:00','commercial','-',1,1,53);
INSERT INTO Sortie VALUES(55,'interne','2003-11-12','2003-11-12','2003-11-12 19:00:00','2003-11-12 22:00:00','interne','-',1,1,54);
INSERT INTO Sortie VALUES(56,'Sortie Entreprise','2003-12-01','2003-12-01','2003-12-01 19:00:00','2003-12-01 22:00:00','commercial','-',1,1,55);
INSERT INTO Sortie VALUES(57,'Sortie Entreprise','2003-12-20','2003-12-20','2003-12-20 19:00:00','2003-12-20 22:00:00','commercial','-',1,1,56);
INSERT INTO Sortie VALUES(58,'Anniversaire','2004-01-08','2004-01-08','2004-01-08 19:00:00','2004-01-08 22:00:00','commercial','-',1,1,57);
INSERT INTO Sortie VALUES(59,'Anniversaire','2004-01-27','2004-01-27','2004-01-27 19:00:00','2004-01-27 22:00:00','commercial','-',1,1,58);
INSERT INTO Sortie VALUES(60,'entraînement','2004-02-15','2004-02-15','2004-02-15 19:00:00','2004-02-15 22:00:00','entraînement','-',1,1,59);
INSERT INTO Sortie VALUES(61,'Anniversaire','2004-03-05','2004-03-05','2004-03-05 19:00:00','2004-03-05 22:00:00','commercial','-',1,1,60);
INSERT INTO Sortie VALUES(62,'Sortie Entreprise','2004-03-24','2004-03-24','2004-03-24 19:00:00','2004-03-24 22:00:00','commercial','-',1,1,61);
INSERT INTO Sortie VALUES(63,'Sortie Entreprise','2004-04-12','2004-04-12','2004-04-12 19:00:00','2004-04-12 22:00:00','commercial','-',1,1,62);
INSERT INTO Sortie VALUES(64,'Anniversaire','2004-05-01','2004-05-01','2004-05-01 19:00:00','2004-05-01 22:00:00','commercial','-',1,1,63);
INSERT INTO Sortie VALUES(65,'interne','2004-05-20','2004-05-20','2004-05-20 19:00:00','2004-05-20 22:00:00','interne','-',1,85,64);
INSERT INTO Sortie VALUES(66,'Anniversaire','2004-06-08','2004-06-08','2004-06-08 19:00:00','2004-06-08 22:00:00','commercial','-',1,1,65);
INSERT INTO Sortie VALUES(67,'Sortie Entreprise','2004-06-27','2004-06-27','2004-06-27 19:00:00','2004-06-27 22:00:00','commercial','-',1,1,66);
INSERT INTO Sortie VALUES(68,'Sortie Entreprise','2004-07-16','2004-07-16','2004-07-16 19:00:00','2004-07-16 22:00:00','commercial','-',1,1,67);
INSERT INTO Sortie VALUES(69,'Anniversaire','2004-08-04','2004-08-04','2004-08-04 19:00:00','2004-08-04 22:00:00','commercial','-',1,1,68);
INSERT INTO Sortie VALUES(70,'entraînement','2004-08-23','2004-08-23','2004-08-23 19:00:00','2004-08-23 22:00:00','entraînement','-',1,1,69);
INSERT INTO Sortie VALUES(71,'Anniversaire','2004-09-11','2004-09-11','2004-09-11 19:00:00','2004-09-11 22:00:00','commercial','-',1,1,70);
INSERT INTO Sortie VALUES(72,'Anniversaire','2004-09-30','2004-09-30','2004-09-30 19:00:00','2004-09-30 22:00:00','commercial','-',1,1,71);
INSERT INTO Sortie VALUES(73,'Anniversaire','2004-10-19','2004-10-19','2004-10-19 19:00:00','2004-10-19 22:00:00','commercial','-',1,1,72);
INSERT INTO Sortie VALUES(74,'Anniversaire','2004-11-07','2004-11-07','2004-11-07 19:00:00','2004-11-07 22:00:00','commercial','-',1,1,73);
INSERT INTO Sortie VALUES(75,'interne','2004-11-26','2004-11-26','2004-11-26 19:00:00','2004-11-26 22:00:00','interne','-',1,1,74);
INSERT INTO Sortie VALUES(76,'Sortie Entreprise','2004-12-15','2004-12-15','2004-12-15 19:00:00','2004-12-15 22:00:00','commercial','-',1,1,75);
INSERT INTO Sortie VALUES(77,'Anniversaire','2005-01-03','2005-01-03','2005-01-03 19:00:00','2005-01-03 22:00:00','commercial','-',1,1,76);
INSERT INTO Sortie VALUES(78,'Anniversaire','2005-01-22','2005-01-22','2005-01-22 19:00:00','2005-01-22 22:00:00','commercial','-',1,1,77);
INSERT INTO Sortie VALUES(79,'Anniversaire','2005-02-10','2005-02-10','2005-02-10 19:00:00','2005-02-10 22:00:00','commercial','-',1,1,78);
INSERT INTO Sortie VALUES(80,'entraînement','2005-03-01','2005-03-01','2005-03-01 19:00:00','2005-03-01 22:00:00','entraînement','-',1,1,79);
INSERT INTO Sortie VALUES(81,'Sortie Entreprise','2005-03-20','2005-03-20','2005-03-20 19:00:00','2005-03-20 22:00:00','commercial','-',1,1,80);
INSERT INTO Sortie VALUES(82,'Anniversaire','2005-04-08','2005-04-08','2005-04-08 19:00:00','2005-04-08 22:00:00','commercial','-',1,1,81);
INSERT INTO Sortie VALUES(83,'Anniversaire','2005-04-27','2005-04-27','2005-04-27 19:00:00','2005-04-27 22:00:00','commercial','-',1,1,82);
INSERT INTO Sortie VALUES(84,'Anniversaire','2005-05-16','2005-05-16','2005-05-16 19:00:00','2005-05-16 22:00:00','commercial','-',1,1,83);
INSERT INTO Sortie VALUES(85,'interne','2005-06-04','2005-06-04','2005-06-04 19:00:00','2005-06-04 22:00:00','interne','-',1,1,84);
INSERT INTO Sortie VALUES(86,'Sortie Entreprise','2005-06-23','2005-06-23','2005-06-23 19:00:00','2005-06-23 22:00:00','commercial','-',1,1,85);
INSERT INTO Sortie VALUES(87,'Sortie Entreprise','2005-07-12','2005-07-12','2005-07-12 19:00:00','2005-07-12 22:00:00','commercial','-',1,1,86);
INSERT INTO Sortie VALUES(88,'Anniversaire','2005-07-31','2005-07-31','2005-07-31 19:00:00','2005-07-31 22:00:00','commercial','-',1,1,87);
INSERT INTO Sortie VALUES(89,'Anniversaire','2005-08-19','2005-08-19','2005-08-19 19:00:00','2005-08-19 22:00:00','commercial','-',1,1,88);
INSERT INTO Sortie VALUES(90,'entraînement','2005-09-07','2005-09-07','2005-09-07 19:00:00','2005-09-07 22:00:00','entraînement','-',1,1,89);
INSERT INTO Sortie VALUES(91,'Sortie Entreprise','2005-09-26','2005-09-26','2005-09-26 19:00:00','2005-09-26 22:00:00','commercial','-',1,1,90);
INSERT INTO Sortie VALUES(92,'Sortie Entreprise','2005-10-15','2005-10-15','2005-10-15 19:00:00','2005-10-15 22:00:00','commercial','-',1,1,91);
INSERT INTO Sortie VALUES(93,'Anniversaire','2005-11-03','2005-11-03','2005-11-03 19:00:00','2005-11-03 22:00:00','commercial','-',1,1,92);
INSERT INTO Sortie VALUES(94,'Anniversaire','2005-11-22','2005-11-22','2005-11-22 19:00:00','2005-11-22 22:00:00','commercial','-',1,1,93);
INSERT INTO Sortie VALUES(95,'interne','2005-12-11','2005-12-11','2005-12-11 19:00:00','2005-12-11 22:00:00','interne','-',1,1,94);
INSERT INTO Sortie VALUES(96,'Anniversaire','2005-12-30','2005-12-30','2005-12-30 19:00:00','2005-12-30 22:00:00','commercial','-',1,1,95);
INSERT INTO Sortie VALUES(97,'Sortie Entreprise','2006-01-18','2006-01-18','2006-01-18 19:00:00','2006-01-18 22:00:00','commercial','-',1,1,96);
INSERT INTO Sortie VALUES(98,'Sortie Entreprise','2006-02-06','2006-02-06','2006-02-06 19:00:00','2006-02-06 22:00:00','commercial','-',1,1,97);
INSERT INTO Sortie VALUES(99,'Anniversaire','2006-02-25','2006-02-25','2006-02-25 19:00:00','2006-02-25 22:00:00','commercial','-',1,1,98);
INSERT INTO Sortie VALUES(100,'entraînement','2006-03-16','2006-03-16','2006-03-16 19:00:00','2006-03-16 22:00:00','entraînement','-',1,1,99);
INSERT INTO Sortie VALUES(101,'Anniversaire','2006-04-04','2006-04-04','2006-04-04 19:00:00','2006-04-04 22:00:00','commercial','-',1,1,100);
INSERT INTO Sortie VALUES(102,'Sortie Entreprise','2006-04-23','2006-04-23','2006-04-23 19:00:00','2006-04-23 22:00:00','commercial','-',1,1,101);
INSERT INTO Sortie VALUES(103,'Sortie Entreprise','2006-05-12','2006-05-12','2006-05-12 19:00:00','2006-05-12 22:00:00','commercial','-',1,1,102);
INSERT INTO Sortie VALUES(104,'Anniversaire','2006-05-31','2006-05-31','2006-05-31 19:00:00','2006-05-31 22:00:00','commercial','-',1,1,103);
INSERT INTO Sortie VALUES(105,'interne','2006-06-19','2006-06-19','2006-06-19 19:00:00','2006-06-19 22:00:00','interne','-',1,1,104);
INSERT INTO Sortie VALUES(106,'Anniversaire','2006-07-08','2006-07-08','2006-07-08 19:00:00','2006-07-08 22:00:00','commercial','-',1,1,105);
INSERT INTO Sortie VALUES(107,'Anniversaire','2006-07-27','2006-07-27','2006-07-27 19:00:00','2006-07-27 22:00:00','commercial','-',1,1,106);
INSERT INTO Sortie VALUES(108,'Anniversaire','2006-08-15','2006-08-15','2006-08-15 19:00:00','2006-08-15 22:00:00','commercial','-',1,1,107);
INSERT INTO Sortie VALUES(109,'Anniversaire','2006-09-03','2006-09-03','2006-09-03 19:00:00','2006-09-03 22:00:00','commercial','-',1,1,108);
INSERT INTO Sortie VALUES(110,'entraînement','2006-09-22','2006-09-22','2006-09-22 19:00:00','2006-09-22 22:00:00','entraînement','-',1,1,109);
INSERT INTO Sortie VALUES(111,'Sortie Entreprise','2006-10-11','2006-10-11','2006-10-11 19:00:00','2006-10-11 22:00:00','commercial','-',1,1,110);
INSERT INTO Sortie VALUES(112,'Anniversaire','2006-10-30','2006-10-30','2006-10-30 19:00:00','2006-10-30 22:00:00','commercial','-',1,1,111);
INSERT INTO Sortie VALUES(113,'Anniversaire','2006-11-18','2006-11-18','2006-11-18 19:00:00','2006-11-18 22:00:00','commercial','-',1,1,112);
INSERT INTO Sortie VALUES(114,'Anniversaire','2006-12-07','2006-12-07','2006-12-07 19:00:00','2006-12-07 22:00:00','commercial','-',1,1,113);
INSERT INTO Sortie VALUES(115,'interne','2006-12-26','2006-12-26','2006-12-26 19:00:00','2006-12-26 22:00:00','interne','-',1,1,114);
INSERT INTO Sortie VALUES(116,'Sortie Entreprise','2007-01-14','2007-01-14','2007-01-14 19:00:00','2007-01-14 22:00:00','commercial','-',1,1,115);
INSERT INTO Sortie VALUES(117,'Anniversaire','2007-02-02','2007-02-02','2007-02-02 19:00:00','2007-02-02 22:00:00','commercial','-',1,1,116);
INSERT INTO Sortie VALUES(118,'Anniversaire','2007-02-21','2007-02-21','2007-02-21 19:00:00','2007-02-21 22:00:00','commercial','-',1,1,117);
INSERT INTO Sortie VALUES(119,'Anniversaire','2007-03-12','2007-03-12','2007-03-12 19:00:00','2007-03-12 22:00:00','commercial','-',1,1,118);
INSERT INTO Sortie VALUES(120,'entraînement','2007-03-31','2007-03-31','2007-03-31 19:00:00','2007-03-31 22:00:00','entraînement','-',1,1,119);
INSERT INTO Sortie VALUES(121,'Sortie Entreprise','2007-04-19','2007-04-19','2007-04-19 19:00:00','2007-04-19 22:00:00','commercial','-',1,1,120);
INSERT INTO Sortie VALUES(122,'Sortie Entreprise','2007-05-08','2007-05-08','2007-05-08 19:00:00','2007-05-08 22:00:00','commercial','-',1,1,121);
INSERT INTO Sortie VALUES(123,'Anniversaire','2007-05-27','2007-05-27','2007-05-27 19:00:00','2007-05-27 22:00:00','commercial','-',1,85,122);
INSERT INTO Sortie VALUES(124,'Anniversaire','2007-06-15','2007-06-15','2007-06-15 19:00:00','2007-06-15 22:00:00','commercial','-',1,1,123);
INSERT INTO Sortie VALUES(125,'interne','2007-07-04','2007-07-04','2007-07-04 19:00:00','2007-07-04 22:00:00','interne','-',1,1,124);
INSERT INTO Sortie VALUES(126,'Sortie Entreprise','2007-07-23','2007-07-23','2007-07-23 19:00:00','2007-07-23 22:00:00','commercial','-',1,1,125);
INSERT INTO Sortie VALUES(127,'Sortie Entreprise','2007-08-11','2007-08-11','2007-08-11 19:00:00','2007-08-11 22:00:00','commercial','-',1,1,126);
INSERT INTO Sortie VALUES(128,'Anniversaire','2007-08-30','2007-08-30','2007-08-30 19:00:00','2007-08-30 22:00:00','commercial','-',1,1,127);
INSERT INTO Sortie VALUES(129,'Anniversaire','2007-09-18','2007-09-18','2007-09-18 19:00:00','2007-09-18 22:00:00','commercial','-',1,1,128);
INSERT INTO Sortie VALUES(130,'entraînement','2007-10-07','2007-10-07','2007-10-07 19:00:00','2007-10-07 22:00:00','entraînement','-',1,1,129);
INSERT INTO Sortie VALUES(131,'Anniversaire','2007-10-26','2007-10-26','2007-10-26 19:00:00','2007-10-26 22:00:00','commercial','-',1,1,130);
INSERT INTO Sortie VALUES(132,'Sortie Entreprise','2007-11-14','2007-11-14','2007-11-14 19:00:00','2007-11-14 22:00:00','commercial','-',1,1,131);
INSERT INTO Sortie VALUES(133,'Sortie Entreprise','2007-12-03','2007-12-03','2007-12-03 19:00:00','2007-12-03 22:00:00','commercial','-',1,1,132);
INSERT INTO Sortie VALUES(134,'Anniversaire','2007-12-22','2007-12-22','2007-12-22 19:00:00','2007-12-22 22:00:00','commercial','-',1,1,133);
INSERT INTO Sortie VALUES(135,'interne','2008-01-10','2008-01-10','2008-01-10 19:00:00','2008-01-10 22:00:00','interne','-',1,1,134);
INSERT INTO Sortie VALUES(136,'Anniversaire','2008-01-29','2008-01-29','2008-01-29 19:00:00','2008-01-29 22:00:00','commercial','-',1,1,135);
INSERT INTO Sortie VALUES(137,'Sortie Entreprise','2008-02-17','2008-02-17','2008-02-17 19:00:00','2008-02-17 22:00:00','commercial','-',1,1,136);
INSERT INTO Sortie VALUES(138,'Sortie Entreprise','2008-03-07','2008-03-07','2008-03-07 19:00:00','2008-03-07 22:00:00','commercial','-',1,1,137);
INSERT INTO Sortie VALUES(139,'Anniversaire','2008-03-26','2008-03-26','2008-03-26 19:00:00','2008-03-26 22:00:00','commercial','-',1,1,138);
INSERT INTO Sortie VALUES(140,'entraînement','2008-04-14','2008-04-14','2008-04-14 19:00:00','2008-04-14 22:00:00','entraînement','-',1,1,139);
INSERT INTO Sortie VALUES(141,'Anniversaire','2008-05-03','2008-05-03','2008-05-03 19:00:00','2008-05-03 22:00:00','commercial','-',1,1,140);
INSERT INTO Sortie VALUES(142,'Anniversaire','2008-05-22','2008-05-22','2008-05-22 19:00:00','2008-05-22 22:00:00','commercial','-',1,1,141);
INSERT INTO Sortie VALUES(143,'Anniversaire','2008-06-10','2008-06-10','2008-06-10 19:00:00','2008-06-10 22:00:00','commercial','-',1,1,142);
INSERT INTO Sortie VALUES(144,'Anniversaire','2008-06-29','2008-06-29','2008-06-29 19:00:00','2008-06-29 22:00:00','commercial','-',1,1,143);
INSERT INTO Sortie VALUES(145,'interne','2008-07-18','2008-07-18','2008-07-18 19:00:00','2008-07-18 22:00:00','interne','-',1,1,144);
INSERT INTO Sortie VALUES(146,'Sortie Entreprise','2008-08-06','2008-08-06','2008-08-06 19:00:00','2008-08-06 22:00:00','commercial','-',1,1,145);
INSERT INTO Sortie VALUES(147,'Anniversaire','2008-08-25','2008-08-25','2008-08-25 19:00:00','2008-08-25 22:00:00','commercial','-',1,1,146);
INSERT INTO Sortie VALUES(148,'Anniversaire','2008-09-13','2008-09-13','2008-09-13 19:00:00','2008-09-13 22:00:00','commercial','-',1,1,147);
INSERT INTO Sortie VALUES(149,'Anniversaire','2008-10-02','2008-10-02','2008-10-02 19:00:00','2008-10-02 22:00:00','commercial','-',1,1,148);
INSERT INTO Sortie VALUES(150,'entraînement','2008-10-21','2008-10-21','2008-10-21 19:00:00','2008-10-21 22:00:00','entraînement','-',1,1,149);
INSERT INTO Sortie VALUES(151,'Sortie Entreprise','2008-11-09','2008-11-09','2008-11-09 19:00:00','2008-11-09 22:00:00','commercial','-',1,1,150);
INSERT INTO Sortie VALUES(152,'Anniversaire','2008-11-28','2008-11-28','2008-11-28 19:00:00','2008-11-28 22:00:00','commercial','-',1,1,151);
INSERT INTO Sortie VALUES(153,'Anniversaire','2008-12-17','2008-12-17','2008-12-17 19:00:00','2008-12-17 22:00:00','commercial','-',1,1,152);
INSERT INTO Sortie VALUES(154,'Anniversaire','2009-01-05','2009-01-05','2009-01-05 19:00:00','2009-01-05 22:00:00','commercial','-',1,1,153);
INSERT INTO Sortie VALUES(155,'interne','2009-01-24','2009-01-24','2009-01-24 19:00:00','2009-01-24 22:00:00','interne','-',1,1,154);
INSERT INTO Sortie VALUES(156,'Sortie Entreprise','2009-02-12','2009-02-12','2009-02-12 19:00:00','2009-02-12 22:00:00','commercial','-',1,1,155);
INSERT INTO Sortie VALUES(157,'Sortie Entreprise','2009-03-03','2009-03-03','2009-03-03 19:00:00','2009-03-03 22:00:00','commercial','-',1,1,156);
INSERT INTO Sortie VALUES(158,'Anniversaire','2009-03-22','2009-03-22','2009-03-22 19:00:00','2009-03-22 22:00:00','commercial','-',1,1,157);
INSERT INTO Sortie VALUES(159,'Anniversaire','2009-04-10','2009-04-10','2009-04-10 19:00:00','2009-04-10 22:00:00','commercial','-',1,1,158);
INSERT INTO Sortie VALUES(160,'entraînement','2009-04-29','2009-04-29','2009-04-29 19:00:00','2009-04-29 22:00:00','entraînement','-',1,1,159);
INSERT INTO Sortie VALUES(161,'Sortie Entreprise','2009-05-18','2009-05-18','2009-05-18 19:00:00','2009-05-18 22:00:00','commercial','-',1,1,160);
INSERT INTO Sortie VALUES(162,'Sortie Entreprise','2009-06-06','2009-06-06','2009-06-06 19:00:00','2009-06-06 22:00:00','commercial','-',1,1,161);
INSERT INTO Sortie VALUES(163,'Anniversaire','2009-06-25','2009-06-25','2009-06-25 19:00:00','2009-06-25 22:00:00','commercial','-',1,1,162);
INSERT INTO Sortie VALUES(164,'Anniversaire','2009-07-14','2009-07-14','2009-07-14 19:00:00','2009-07-14 22:00:00','commercial','-',1,1,163);
INSERT INTO Sortie VALUES(165,'interne','2009-08-02','2009-08-02','2009-08-02 19:00:00','2009-08-02 22:00:00','interne','-',1,1,164);
INSERT INTO Sortie VALUES(166,'Anniversaire','2009-08-21','2009-08-21','2009-08-21 19:00:00','2009-08-21 22:00:00','commercial','-',1,1,165);
INSERT INTO Sortie VALUES(167,'Sortie Entreprise','2009-09-09','2009-09-09','2009-09-09 19:00:00','2009-09-09 22:00:00','commercial','-',1,1,166);
INSERT INTO Sortie VALUES(168,'Sortie Entreprise','2009-09-28','2009-09-28','2009-09-28 19:00:00','2009-09-28 22:00:00','commercial','-',1,1,167);
INSERT INTO Sortie VALUES(169,'Anniversaire','2009-10-17','2009-10-17','2009-10-17 19:00:00','2009-10-17 22:00:00','commercial','-',1,1,168);
INSERT INTO Sortie VALUES(170,'entraînement','2009-11-05','2009-11-05','2009-11-05 19:00:00','2009-11-05 22:00:00','entraînement','-',1,1,169);
INSERT INTO Sortie VALUES(171,'Anniversaire','2009-11-24','2009-11-24','2009-11-24 19:00:00','2009-11-24 22:00:00','commercial','-',1,1,170);
INSERT INTO Sortie VALUES(172,'Sortie Entreprise','2009-12-13','2009-12-13','2009-12-13 19:00:00','2009-12-13 22:00:00','commercial','-',1,1,171);
INSERT INTO Sortie VALUES(173,'Sortie Entreprise','2010-01-01','2010-01-01','2010-01-01 19:00:00','2010-01-01 22:00:00','commercial','-',1,1,172);
INSERT INTO Sortie VALUES(174,'Anniversaire','2010-01-20','2010-01-20','2010-01-20 19:00:00','2010-01-20 22:00:00','commercial','-',1,1,173);
INSERT INTO Sortie VALUES(175,'interne','2010-02-08','2010-02-08','2010-02-08 19:00:00','2010-02-08 22:00:00','interne','-',1,1,174);
INSERT INTO Sortie VALUES(176,'Anniversaire','2010-02-27','2010-02-27','2010-02-27 19:00:00','2010-02-27 22:00:00','commercial','-',1,1,175);
INSERT INTO Sortie VALUES(177,'Anniversaire','2010-03-18','2010-03-18','2010-03-18 19:00:00','2010-03-18 22:00:00','commercial','-',1,1,176);
INSERT INTO Sortie VALUES(178,'Anniversaire','2010-04-06','2010-04-06','2010-04-06 19:00:00','2010-04-06 22:00:00','commercial','-',1,1,177);
INSERT INTO Sortie VALUES(179,'Anniversaire','2010-04-25','2010-04-25','2010-04-25 19:00:00','2010-04-25 22:00:00','commercial','-',1,1,178);
INSERT INTO Sortie VALUES(180,'entraînement','2010-05-14','2010-05-14','2010-05-14 19:00:00','2010-05-14 22:00:00','entraînement','-',1,1,179);
INSERT INTO Sortie VALUES(181,'Sortie Entreprise','2010-06-02','2010-06-02','2010-06-02 19:00:00','2010-06-02 22:00:00','commercial','-',1,1,180);
INSERT INTO Sortie VALUES(182,'Anniversaire','2010-06-21','2010-06-21','2010-06-21 19:00:00','2010-06-21 22:00:00','commercial','-',1,1,181);
INSERT INTO Sortie VALUES(183,'Anniversaire','2010-07-10','2010-07-10','2010-07-10 19:00:00','2010-07-10 22:00:00','commercial','-',1,1,182);
INSERT INTO Sortie VALUES(184,'Anniversaire','2010-07-29','2010-07-29','2010-07-29 19:00:00','2010-07-29 22:00:00','commercial','-',1,1,183);
INSERT INTO Sortie VALUES(185,'interne','2010-08-17','2010-08-17','2010-08-17 19:00:00','2010-08-17 22:00:00','interne','-',1,1,184);
INSERT INTO Sortie VALUES(186,'Sortie Entreprise','2010-09-05','2010-09-05','2010-09-05 19:00:00','2010-09-05 22:00:00','commercial','-',1,1,185);
INSERT INTO Sortie VALUES(187,'Anniversaire','2010-09-24','2010-09-24','2010-09-24 19:00:00','2010-09-24 22:00:00','commercial','-',1,1,186);
INSERT INTO Sortie VALUES(188,'Anniversaire','2010-10-13','2010-10-13','2010-10-13 19:00:00','2010-10-13 22:00:00','commercial','-',1,1,187);
INSERT INTO Sortie VALUES(189,'Anniversaire','2010-11-01','2010-11-01','2010-11-01 19:00:00','2010-11-01 22:00:00','commercial','-',1,1,188);
INSERT INTO Sortie VALUES(190,'entraînement','2010-11-20','2010-11-20','2010-11-20 19:00:00','2010-11-20 22:00:00','entraînement','-',1,1,189);
INSERT INTO Sortie VALUES(191,'Sortie Entreprise','2010-12-09','2010-12-09','2010-12-09 19:00:00','2010-12-09 22:00:00','commercial','-',1,1,190);
INSERT INTO Sortie VALUES(192,'Sortie Entreprise','2010-12-28','2010-12-28','2010-12-28 19:00:00','2010-12-28 22:00:00','commercial','-',1,1,191);
INSERT INTO Sortie VALUES(193,'Anniversaire','2011-01-16','2011-01-16','2011-01-16 19:00:00','2011-01-16 22:00:00','commercial','-',1,1,192);
INSERT INTO Sortie VALUES(194,'Anniversaire','2011-02-04','2011-02-04','2011-02-04 19:00:00','2011-02-04 22:00:00','commercial','-',1,1,193);
INSERT INTO Sortie VALUES(195,'interne','2011-02-23','2011-02-23','2011-02-23 19:00:00','2011-02-23 22:00:00','interne','-',1,1,194);
INSERT INTO Sortie VALUES(196,'Sortie Entreprise','2011-03-14','2011-03-14','2011-03-14 19:00:00','2011-03-14 22:00:00','commercial','-',1,1,195);
INSERT INTO Sortie VALUES(197,'Sortie Entreprise','2011-04-02','2011-04-02','2011-04-02 19:00:00','2011-04-02 22:00:00','commercial','-',1,1,196);
INSERT INTO Sortie VALUES(198,'Anniversaire','2011-04-21','2011-04-21','2011-04-21 19:00:00','2011-04-21 22:00:00','commercial','-',1,1,197);
INSERT INTO Sortie VALUES(199,'Anniversaire','2011-05-10','2011-05-10','2011-05-10 19:00:00','2011-05-10 22:00:00','commercial','-',1,1,198);
INSERT INTO Sortie VALUES(200,'entraînement','2011-05-29','2011-05-29','2011-05-29 19:00:00','2011-05-29 22:00:00','entraînement','-',1,1,199);
INSERT INTO Sortie VALUES(201,'Anniversaire','2011-06-17','2011-06-17','2011-06-17 19:00:00','2011-06-17 22:00:00','commercial','-',1,1,200);
INSERT INTO Sortie VALUES(202,'Sortie Entreprise','2011-07-06','2011-07-06','2011-07-06 19:00:00','2011-07-06 22:00:00','commercial','-',1,1,201);
INSERT INTO Sortie VALUES(203,'Sortie Entreprise','2011-07-25','2011-07-25','2011-07-25 19:00:00','2011-07-25 22:00:00','commercial','-',1,1,202);
INSERT INTO Sortie VALUES(204,'Anniversaire','2011-08-13','2011-08-13','2011-08-13 19:00:00','2011-08-13 22:00:00','commercial','-',1,1,203);
INSERT INTO Sortie VALUES(205,'interne','2011-09-01','2011-09-01','2011-09-01 19:00:00','2011-09-01 22:00:00','interne','-',1,1,204);
INSERT INTO Sortie VALUES(206,'Anniversaire','2011-09-20','2011-09-20','2011-09-20 19:00:00','2011-09-20 22:00:00','commercial','-',1,1,205);
INSERT INTO Sortie VALUES(207,'Sortie Entreprise','2011-10-09','2011-10-09','2011-10-09 19:00:00','2011-10-09 22:00:00','commercial','-',1,1,206);
INSERT INTO Sortie VALUES(208,'Sortie Entreprise','2011-10-28','2011-10-28','2011-10-28 19:00:00','2011-10-28 22:00:00','commercial','-',1,1,207);
INSERT INTO Sortie VALUES(209,'Anniversaire','2011-11-16','2011-11-16','2011-11-16 19:00:00','2011-11-16 22:00:00','commercial','-',1,1,208);
INSERT INTO Sortie VALUES(210,'entraînement','2011-12-05','2011-12-05','2011-12-05 19:00:00','2011-12-05 22:00:00','entraînement','-',1,1,209);
INSERT INTO Sortie VALUES(211,'Anniversaire','2011-12-24','2011-12-24','2011-12-24 19:00:00','2011-12-24 22:00:00','commercial','-',1,1,210);
INSERT INTO Sortie VALUES(212,'Anniversaire','2012-01-12','2012-01-12','2012-01-12 19:00:00','2012-01-12 22:00:00','commercial','-',1,1,211);
INSERT INTO Sortie VALUES(213,'Anniversaire','2012-01-31','2012-01-31','2012-01-31 19:00:00','2012-01-31 22:00:00','commercial','-',1,1,212);
INSERT INTO Sortie VALUES(214,'Anniversaire','2012-02-19','2012-02-19','2012-02-19 19:00:00','2012-02-19 22:00:00','commercial','-',1,1,213);
INSERT INTO Sortie VALUES(215,'interne','2012-03-09','2012-03-09','2012-03-09 19:00:00','2012-03-09 22:00:00','interne','-',1,1,214);
INSERT INTO Sortie VALUES(216,'Anniversaire','2012-03-28','2012-03-28','2012-03-28 19:00:00','2012-03-28 22:00:00','commercial','-',1,1,215);
INSERT INTO Sortie VALUES(217,'Sortie Entreprise','2012-04-16','2012-04-16','2012-04-16 19:00:00','2012-04-16 22:00:00','commercial','-',1,1,216);
INSERT INTO Sortie VALUES(218,'Sortie Entreprise','2012-05-05','2012-05-05','2012-05-05 19:00:00','2012-05-05 22:00:00','commercial','-',1,1,217);
INSERT INTO Sortie VALUES(219,'Anniversaire','2012-05-24','2012-05-24','2012-05-24 19:00:00','2012-05-24 22:00:00','commercial','-',1,1,218);
INSERT INTO Sortie VALUES(220,'entraînement','2012-06-12','2012-06-12','2012-06-12 19:00:00','2012-06-12 22:00:00','entraînement','-',1,1,219);

GO

-- Table Facture
--No INTEGER NOT NULL,Date DATE NOT NULL,Intitule VARCHAR(50),MontantBrut INTEGER NOT NULL,Statut VARCHAR(50) NOT NULL,DateStatut DATE, EntiteNo INTEGER NOT NULL,Sortie INTEGER
INSERT INTO Facture VALUES(1,'2001-01-07','Anniversaire',800,'payée','2001-01-13',1,1);
INSERT INTO Facture VALUES(2,'2001-01-26','Anniversaire',800,'payée','2001-02-01',2,2);
INSERT INTO Facture VALUES(3,'2001-02-14','Anniversaire',800,'payée','2001-02-20',2,3);
INSERT INTO Facture VALUES(4,'2001-03-05','Anniversaire',800,'payée','2001-03-11',3,4);
INSERT INTO Facture VALUES(5,'2001-04-12','Sortie Entreprise',1650,'payée','2001-04-18',5,6);
INSERT INTO Facture VALUES(6,'2001-05-01','Anniversaire',800,'payée','2001-05-07',7,7);
INSERT INTO Facture VALUES(7,'2001-05-20','Anniversaire',800,'payée','2001-05-26',7,8);
INSERT INTO Facture VALUES(8,'2001-06-08','Anniversaire',800,'payée','2001-06-14',8,9);
INSERT INTO Facture VALUES(9,'2001-07-16','Sortie Entreprise',1650,'payée','2001-07-22',11,11);
INSERT INTO Facture VALUES(10,'2001-08-04','Anniversaire',800,'payée','2001-08-10',12,12);
INSERT INTO Facture VALUES(11,'2001-08-23','Anniversaire',800,'payée','2001-08-29',12,13);
INSERT INTO Facture VALUES(12,'2001-09-11','Anniversaire',800,'payée','2001-09-17',13,14);
INSERT INTO Facture VALUES(13,'2001-10-19','Sortie Entreprise',1650,'payée','2001-10-25',16,16);
INSERT INTO Facture VALUES(14,'2001-11-07','Anniversaire',800,'payée','2001-11-13',17,17);
INSERT INTO Facture VALUES(15,'2001-11-26','Anniversaire',800,'payée','2001-12-02',17,18);
INSERT INTO Facture VALUES(16,'2001-12-15','Anniversaire',800,'payée','2001-12-21',18,19);
INSERT INTO Facture VALUES(17,'2002-01-22','Sortie Entreprise',1650,'payée','2002-01-28',21,21);
INSERT INTO Facture VALUES(18,'2002-02-10','Anniversaire',800,'payée','2002-02-16',22,22);
INSERT INTO Facture VALUES(19,'2002-03-01','Anniversaire',800,'payée','2002-03-07',22,23);
INSERT INTO Facture VALUES(20,'2002-03-20','Anniversaire',800,'payée','2002-03-26',23,24);
INSERT INTO Facture VALUES(21,'2002-04-27','Sortie Entreprise',1650,'payée','2002-05-03',26,26);
INSERT INTO Facture VALUES(22,'2002-05-16','Anniversaire',800,'payée','2002-05-22',27,27);
INSERT INTO Facture VALUES(23,'2002-06-04','Anniversaire',800,'payée','2002-06-10',27,28);
INSERT INTO Facture VALUES(24,'2002-06-23','Anniversaire',800,'payée','2002-06-29',28,29);
INSERT INTO Facture VALUES(25,'2002-07-31','Sortie Entreprise',1650,'payée','2002-08-06',31,31);
INSERT INTO Facture VALUES(26,'2002-08-19','Anniversaire',800,'payée','2002-08-25',32,32);
INSERT INTO Facture VALUES(27,'2002-09-07','Anniversaire',800,'payée','2002-09-13',32,33);
INSERT INTO Facture VALUES(28,'2002-09-26','Anniversaire',800,'payée','2002-10-02',33,34);
INSERT INTO Facture VALUES(29,'2002-11-03','Sortie Entreprise',1650,'payée','2002-11-09',36,36);
INSERT INTO Facture VALUES(30,'2002-11-22','Anniversaire',800,'payée','2002-11-28',37,37);
INSERT INTO Facture VALUES(31,'2002-12-11','Anniversaire',800,'payée','2002-12-17',37,38);
INSERT INTO Facture VALUES(32,'2002-12-30','Anniversaire',800,'payée','2003-01-05',38,39);
INSERT INTO Facture VALUES(33,'2003-02-06','Sortie Entreprise',1650,'payée','2003-02-12',41,41);
INSERT INTO Facture VALUES(34,'2003-02-25','Anniversaire',800,'payée','2003-03-03',42,42);
INSERT INTO Facture VALUES(35,'2003-03-16','Anniversaire',800,'payée','2003-03-22',42,43);
INSERT INTO Facture VALUES(36,'2003-04-04','Anniversaire',800,'payée','2003-04-10',43,44);
INSERT INTO Facture VALUES(37,'2003-05-12','Sortie Entreprise',1650,'payée','2003-05-18',46,46);
INSERT INTO Facture VALUES(38,'2003-05-31','Anniversaire',800,'payée','2003-06-06',47,47);
INSERT INTO Facture VALUES(39,'2003-06-19','Anniversaire',800,'payée','2003-06-25',47,48);
INSERT INTO Facture VALUES(40,'2003-07-08','Anniversaire',800,'payée','2003-07-14',48,49);
INSERT INTO Facture VALUES(41,'2003-08-15','Sortie Entreprise',1650,'payée','2003-08-21',51,51);
INSERT INTO Facture VALUES(42,'2003-09-03','Anniversaire',800,'payée','2003-09-09',52,52);
INSERT INTO Facture VALUES(43,'2003-09-22','Anniversaire',800,'payée','2003-09-28',52,53);
INSERT INTO Facture VALUES(44,'2003-10-11','Anniversaire',800,'payée','2003-10-17',53,54);
INSERT INTO Facture VALUES(45,'2003-11-18','Sortie Entreprise',1650,'payée','2003-11-24',56,56);
INSERT INTO Facture VALUES(46,'2003-12-07','Anniversaire',800,'payée','2003-12-13',57,57);
INSERT INTO Facture VALUES(47,'2003-12-26','Anniversaire',800,'payée','2004-01-01',57,58);
INSERT INTO Facture VALUES(48,'2004-01-14','Anniversaire',800,'payée','2004-01-20',58,59);
INSERT INTO Facture VALUES(49,'2004-02-21','Sortie Entreprise',1650,'payée','2004-02-27',61,61);
INSERT INTO Facture VALUES(50,'2004-03-11','Anniversaire',800,'payée','2004-03-17',62,62);
INSERT INTO Facture VALUES(51,'2004-03-30','Anniversaire',800,'payée','2004-04-05',62,63);
INSERT INTO Facture VALUES(52,'2004-04-18','Anniversaire',800,'payée','2004-04-24',63,64);
INSERT INTO Facture VALUES(53,'2004-05-26','Sortie Entreprise',1650,'payée','2004-06-01',66,66);
INSERT INTO Facture VALUES(54,'2004-06-14','Anniversaire',800,'payée','2004-06-20',67,67);
INSERT INTO Facture VALUES(55,'2004-07-03','Anniversaire',800,'payée','2004-07-09',67,68);
INSERT INTO Facture VALUES(56,'2004-07-22','Anniversaire',800,'payée','2004-07-28',68,69);
INSERT INTO Facture VALUES(57,'2004-08-29','Sortie Entreprise',1650,'payée','2004-09-04',71,71);
INSERT INTO Facture VALUES(58,'2004-09-17','Anniversaire',800,'payée','2004-09-23',72,72);
INSERT INTO Facture VALUES(59,'2004-10-06','Anniversaire',800,'payée','2004-10-12',72,73);
INSERT INTO Facture VALUES(60,'2004-10-25','Anniversaire',800,'payée','2004-10-31',73,74);
INSERT INTO Facture VALUES(61,'2004-12-02','Sortie Entreprise',1650,'payée','2004-12-08',76,76);
INSERT INTO Facture VALUES(62,'2004-12-21','Anniversaire',800,'payée','2004-12-27',77,77);
INSERT INTO Facture VALUES(63,'2005-01-09','Anniversaire',800,'payée','2005-01-15',77,78);
INSERT INTO Facture VALUES(64,'2005-01-28','Anniversaire',800,'payée','2005-02-03',78,79);
INSERT INTO Facture VALUES(65,'2005-03-07','Sortie Entreprise',1650,'payée','2005-03-13',81,81);
INSERT INTO Facture VALUES(66,'2005-03-26','Anniversaire',800,'payée','2005-04-01',82,82);
INSERT INTO Facture VALUES(67,'2005-04-14','Anniversaire',800,'payée','2005-04-20',82,83);
INSERT INTO Facture VALUES(68,'2005-05-03','Anniversaire',800,'payée','2005-05-09',83,84);
INSERT INTO Facture VALUES(69,'2005-06-10','Sortie Entreprise',1650,'payée','2005-06-16',86,86);
INSERT INTO Facture VALUES(70,'2005-06-29','Anniversaire',800,'payée','2005-07-05',87,87);
INSERT INTO Facture VALUES(71,'2005-07-18','Anniversaire',800,'payée','2005-07-24',87,88);
INSERT INTO Facture VALUES(72,'2005-08-06','Anniversaire',800,'payée','2005-08-12',88,89);
INSERT INTO Facture VALUES(73,'2005-09-13','Sortie Entreprise',1650,'payée','2005-09-19',91,91);
INSERT INTO Facture VALUES(74,'2005-10-02','Anniversaire',800,'payée','2005-10-08',92,92);
INSERT INTO Facture VALUES(75,'2005-10-21','Anniversaire',800,'payée','2005-10-27',92,93);
INSERT INTO Facture VALUES(76,'2005-11-09','Anniversaire',800,'payée','2005-11-15',93,94);
INSERT INTO Facture VALUES(77,'2005-12-17','Sortie Entreprise',1650,'payée','2005-12-23',96,96);
INSERT INTO Facture VALUES(78,'2006-01-05','Anniversaire',800,'payée','2006-01-11',97,97);
INSERT INTO Facture VALUES(79,'2006-01-24','Anniversaire',800,'payée','2006-01-30',97,98);
INSERT INTO Facture VALUES(80,'2006-02-12','Anniversaire',800,'payée','2006-02-18',98,99);
INSERT INTO Facture VALUES(81,'2006-03-22','Sortie Entreprise',1650,'payée','2006-03-28',101,101);
INSERT INTO Facture VALUES(82,'2006-04-10','Anniversaire',800,'payée','2006-04-16',102,102);
INSERT INTO Facture VALUES(83,'2006-04-29','Anniversaire',800,'payée','2006-05-05',102,103);
INSERT INTO Facture VALUES(84,'2006-05-18','Anniversaire',800,'payée','2006-05-24',103,104);
INSERT INTO Facture VALUES(85,'2006-06-25','Sortie Entreprise',1650,'payée','2006-07-01',106,106);
INSERT INTO Facture VALUES(86,'2006-07-14','Anniversaire',800,'payée','2006-07-20',107,107);
INSERT INTO Facture VALUES(87,'2006-08-02','Anniversaire',800,'payée','2006-08-08',107,108);
INSERT INTO Facture VALUES(88,'2006-08-21','Anniversaire',800,'payée','2006-08-27',108,109);
INSERT INTO Facture VALUES(89,'2006-09-28','Sortie Entreprise',1650,'payée','2006-10-04',111,111);
INSERT INTO Facture VALUES(90,'2006-10-17','Anniversaire',800,'payée','2006-10-23',112,112);
INSERT INTO Facture VALUES(91,'2006-11-05','Anniversaire',800,'payée','2006-11-11',112,113);
INSERT INTO Facture VALUES(92,'2006-11-24','Anniversaire',800,'payée','2006-11-30',113,114);
INSERT INTO Facture VALUES(93,'2007-01-01','Sortie Entreprise',1650,'payée','2007-01-07',116,116);
INSERT INTO Facture VALUES(94,'2007-01-20','Anniversaire',800,'payée','2007-01-26',117,117);
INSERT INTO Facture VALUES(95,'2007-02-08','Anniversaire',800,'payée','2007-02-14',117,118);
INSERT INTO Facture VALUES(96,'2007-02-27','Anniversaire',800,'payée','2007-03-05',118,119);
INSERT INTO Facture VALUES(97,'2007-04-06','Sortie Entreprise',1650,'payée','2007-04-12',121,121);
INSERT INTO Facture VALUES(98,'2007-04-25','Anniversaire',800,'payée','2007-05-01',122,122);
INSERT INTO Facture VALUES(99,'2007-05-14','Anniversaire',800,'payée','2007-05-20',122,123);
INSERT INTO Facture VALUES(100,'2007-06-02','Anniversaire',800,'payée','2007-06-08',123,124);
INSERT INTO Facture VALUES(101,'2007-07-10','Sortie Entreprise',1650,'payée','2007-07-16',126,126);
INSERT INTO Facture VALUES(102,'2007-07-29','Anniversaire',800,'payée','2007-08-04',127,127);
INSERT INTO Facture VALUES(103,'2007-08-17','Anniversaire',800,'payée','2007-08-23',127,128);
INSERT INTO Facture VALUES(104,'2007-09-05','Anniversaire',800,'payée','2007-09-11',128,129);
INSERT INTO Facture VALUES(105,'2007-10-13','Sortie Entreprise',1650,'payée','2007-10-19',131,131);
INSERT INTO Facture VALUES(106,'2007-11-01','Anniversaire',800,'payée','2007-11-07',132,132);
INSERT INTO Facture VALUES(107,'2007-11-20','Anniversaire',800,'payée','2007-11-26',132,133);
INSERT INTO Facture VALUES(108,'2007-12-09','Anniversaire',800,'payée','2007-12-15',133,134);
INSERT INTO Facture VALUES(109,'2008-01-16','Sortie Entreprise',1650,'payée','2008-01-22',136,136);
INSERT INTO Facture VALUES(110,'2008-02-04','Anniversaire',800,'payée','2008-02-10',137,137);
INSERT INTO Facture VALUES(111,'2008-02-23','Anniversaire',800,'payée','2008-02-29',137,138);
INSERT INTO Facture VALUES(112,'2008-03-13','Anniversaire',800,'payée','2008-03-19',138,139);
INSERT INTO Facture VALUES(113,'2008-04-20','Sortie Entreprise',1650,'payée','2008-04-26',141,141);

INSERT INTO Facture VALUES(117,'2008-07-24','Sortie Entreprise',1650,'payée','2008-07-30',146,146);
INSERT INTO Facture VALUES(118,'2008-08-12','Anniversaire',800,'payée','2008-08-18',147,147);
INSERT INTO Facture VALUES(119,'2008-08-31','Anniversaire',800,'payée','2008-09-06',147,148);
INSERT INTO Facture VALUES(120,'2008-09-19','Anniversaire',800,'payée','2008-09-25',148,149);
INSERT INTO Facture VALUES(121,'2008-10-27','Sortie Entreprise',1650,'payée','2008-11-02',151,151);
INSERT INTO Facture VALUES(122,'2008-11-15','Anniversaire',800,'payée','2008-11-21',152,152);
INSERT INTO Facture VALUES(123,'2008-12-04','Anniversaire',800,'payée','2008-12-10',152,153);
INSERT INTO Facture VALUES(124,'2008-12-23','Anniversaire',800,'payée','2008-12-29',153,154);

INSERT INTO Facture VALUES(126,'2009-02-18','Anniversaire',800,'payée','2009-02-24',157,157);
INSERT INTO Facture VALUES(127,'2009-03-09','Anniversaire',800,'payée','2009-03-15',157,158);
INSERT INTO Facture VALUES(128,'2009-03-28','Anniversaire',800,'payée','2009-04-03',158,159);
INSERT INTO Facture VALUES(129,'2009-05-05','Sortie Entreprise',1650,'payée','2009-05-11',161,161);
INSERT INTO Facture VALUES(130,'2009-05-24','Anniversaire',800,'payée','2009-05-30',162,162);
INSERT INTO Facture VALUES(131,'2009-06-12','Anniversaire',800,'payée','2009-06-18',162,163);
INSERT INTO Facture VALUES(132,'2009-07-01','Anniversaire',800,'payée','2009-07-07',163,164);
INSERT INTO Facture VALUES(133,'2009-08-08','Sortie Entreprise',1650,'payée','2009-08-14',166,166);
INSERT INTO Facture VALUES(134,'2009-08-27','Anniversaire',800,'payée','2009-09-02',167,167);
INSERT INTO Facture VALUES(135,'2009-09-15','Anniversaire',800,'payée','2009-09-21',167,168);
INSERT INTO Facture VALUES(136,'2009-10-04','Anniversaire',800,'payée','2009-10-10',168,169);
INSERT INTO Facture VALUES(137,'2009-11-11','Sortie Entreprise',1650,'payée','2009-11-17',171,171);
INSERT INTO Facture VALUES(138,'2009-11-30','Anniversaire',800,'payée','2009-12-06',172,172);
INSERT INTO Facture VALUES(139,'2009-12-19','Anniversaire',800,'payée','2009-12-25',172,173);
INSERT INTO Facture VALUES(140,'2010-01-07','Anniversaire',800,'payée','2010-01-13',173,174);
INSERT INTO Facture VALUES(141,'2010-02-14','Sortie Entreprise',1650,'payée','2010-02-20',176,176);
INSERT INTO Facture VALUES(142,'2010-03-05','Anniversaire',800,'payée','2010-03-11',177,177);
INSERT INTO Facture VALUES(143,'2010-03-24','Anniversaire',800,'payée','2010-03-30',177,178);
INSERT INTO Facture VALUES(144,'2010-04-12','Anniversaire',800,'payée','2010-04-18',178,179);
INSERT INTO Facture VALUES(145,'2010-05-20','Sortie Entreprise',1650,'payée','2010-05-26',181,181);
INSERT INTO Facture VALUES(146,'2010-06-08','Anniversaire',800,'payée','2010-06-14',182,182);
INSERT INTO Facture VALUES(147,'2010-06-27','Anniversaire',800,'payée','2010-07-03',182,183);
INSERT INTO Facture VALUES(148,'2010-07-16','Anniversaire',800,'payée','2010-07-22',183,184);
INSERT INTO Facture VALUES(149,'2010-08-23','Sortie Entreprise',1650,'payée','2010-08-29',186,186);
INSERT INTO Facture VALUES(150,'2010-09-11','Anniversaire',800,'payée','2010-09-17',187,187);
INSERT INTO Facture VALUES(151,'2010-09-30','Anniversaire',800,'payée','2010-10-06',187,188);
INSERT INTO Facture VALUES(152,'2010-10-19','Anniversaire',800,'payée','2010-10-25',188,189);
INSERT INTO Facture VALUES(153,'2010-11-26','Sortie Entreprise',1650,'payée','2010-12-02',191,191);
INSERT INTO Facture VALUES(154,'2010-12-15','Anniversaire',800,'payée','2010-12-21',192,192);
INSERT INTO Facture VALUES(155,'2011-01-03','Anniversaire',800,'payée','2011-01-09',192,193);
INSERT INTO Facture VALUES(156,'2011-01-22','Anniversaire',800,'payée','2011-01-28',193,194);
INSERT INTO Facture VALUES(157,'2011-03-01','Sortie Entreprise',1650,'payée','2011-03-07',196,196);
INSERT INTO Facture VALUES(158,'2011-03-20','Anniversaire',800,'payée','2011-03-26',197,197);
INSERT INTO Facture VALUES(159,'2011-04-08','Anniversaire',800,'payée','2011-04-14',197,198);
INSERT INTO Facture VALUES(160,'2011-04-27','Anniversaire',800,'payée','2011-05-03',198,199);
INSERT INTO Facture VALUES(161,'2011-06-04','Sortie Entreprise',1650,'émise','2011-06-10',201,201);
INSERT INTO Facture VALUES(162,'2011-06-23','Anniversaire',800,'litige','2011-06-29',202,202);
--INSERT INTO Facture VALUES(163,'2011-07-12','Anniversaire',800,'émise','2011-07-18',202,203);
INSERT INTO Facture VALUES(164,'2011-07-31','Anniversaire',800,'émise','2011-08-06',203,204);
INSERT INTO Facture VALUES(165,'2011-09-07','Sortie Entreprise',1650,'émise','2011-09-13',206,206);
INSERT INTO Facture VALUES(166,'2011-09-26','Anniversaire',800,'litige','2011-10-02',207,207);
INSERT INTO Facture VALUES(167,'2011-10-15','Anniversaire',800,'émise','2011-10-21',207,208);
INSERT INTO Facture VALUES(168,'2011-11-03','Anniversaire',800,'émise','2011-11-09',208,209);
INSERT INTO Facture VALUES(169,'2011-12-11','Sortie Entreprise',1650,'émise','2011-12-17',211,211);
INSERT INTO Facture VALUES(170,'2011-12-30','Anniversaire',800,'émise','2012-01-05',212,212);
INSERT INTO Facture VALUES(172,'2012-02-06','Anniversaire',800,'émise','2012-02-12',213,214);
--Insertion supplémentaire pour contrainte d'intégrité 1
INSERT INTO Facture VALUES(163,'2012-02-06','Anniversaire',1600,'émise','2012-02-12',213,214);
--Supression de facture pour la contrainte 4
--INSERT INTO Facture VALUES(125,'2009-01-30','Sortie Entreprise',1650,'payée','2009-02-05',156,156);
--Suppression des facture pour les sortie 187 et 188 pour contrainte 5
--INSERT INTO Facture VALUES(114,'2008-05-09','Anniversaire',800,'payée','2008-05-15',142,142);
--INSERT INTO Facture VALUES(115,'2008-05-28','Anniversaire',800,'payée','2008-06-03',142,143);
--INSERT INTO Facture VALUES(116,'2008-06-16','Anniversaire',800,'payée','2008-06-22',143,144);

GO

-- Table Ligne
--FactureNo INTEGER NOT NULL,No INTEGER NOT NULL, Qte INTEGER NOT NULL, Designation  VARCHAR(50) NOT NULL, PrixUnitaire INTEGER NOT NULL, Montant INTEGER NOT NULL
INSERT INTO Ligne VALUES(1,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(2,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(3,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(4,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(5,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(6,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(7,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(8,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(9,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(10,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(11,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(12,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(13,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(14,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(15,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(16,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(17,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(18,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(19,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(20,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(21,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(22,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(23,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(24,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(25,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(26,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(27,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(28,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(29,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(30,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(31,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(32,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(33,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(34,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(35,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(36,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(37,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(38,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(39,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(40,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(41,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(42,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(43,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(44,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(45,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(46,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(47,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(48,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(49,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(50,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(51,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(52,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(53,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(54,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(55,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(56,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(57,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(58,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(59,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(60,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(61,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(62,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(63,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(64,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(65,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(66,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(67,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(68,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(69,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(70,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(71,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(72,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(73,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(74,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(75,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(76,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(77,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(78,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(79,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(80,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(81,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(82,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(83,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(84,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(85,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(86,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(87,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(88,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(89,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(90,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(91,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(92,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(93,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(94,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(95,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(96,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(97,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(98,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(99,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(100,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(101,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(102,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(103,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(104,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(105,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(106,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(107,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(108,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(109,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(110,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(111,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(112,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(113,1,1,'location bateau groupe lucratif',1650,1650);

-- Changement de la qte en 2 pour erreurs
INSERT INTO Ligne VALUES(117,1,2,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(118,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(119,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(120,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(121,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(122,1,2,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(123,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(124,1,1,'location bateau groupe non lucratif',800,800);

INSERT INTO Ligne VALUES(126,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(127,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(128,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(129,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(130,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(131,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(132,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(133,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(134,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(135,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(136,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(137,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(138,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(139,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(140,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(141,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(142,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(143,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(144,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(145,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(146,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(147,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(148,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(149,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(150,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(151,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(152,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(153,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(154,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(155,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(156,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(157,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(158,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(159,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(160,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(161,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(162,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(163,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(164,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(165,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(166,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(167,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(168,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(169,1,1,'location bateau groupe lucratif',1650,1650);
INSERT INTO Ligne VALUES(170,1,1,'location bateau groupe non lucratif',800,800);
INSERT INTO Ligne VALUES(172,1,1,'location bateau groupe non lucratif',800,800);
--Insertion supplémentaire pour contrainte d'intégrité 1
INSERT INTO Ligne VALUES(72,2,1,'Service traiteur',2000,2000);
INSERT INTO Ligne VALUES(72,3,2,'Musicien',800,1600);
INSERT INTO Ligne VALUES(100,2,1,'Service traiteur',2000,2000);
--Suppression pour contrainte 4
--INSERT INTO Ligne VALUES(125,1,1,'location bateau groupe lucratif',1650,1650);
--Suppression pour contrainte 5
--INSERT INTO Ligne VALUES(114,1,1,'location bateau groupe non lucratif',800,800);
--INSERT INTO Ligne VALUES(115,1,1,'location bateau groupe non lucratif',800,800);
--INSERT INTO Ligne VALUES(116,1,1,'location bateau groupe non lucratif',800,800);

GO


-- Table Adresse
--EntiteNo INTEGER NOT NULL,No INTEGER NOT NULL, Ligne1 VARCHAR(50) NOT NULL,Ligne2 VARCHAR(50),Ligne3 VARCHAR(50),NoRue VARCHAR(50),LocaliteNo INTEGER NOT NULL
INSERT INTO Adresse VALUES (1,1,'chemin de l''Echo','','','1',1);
INSERT INTO Adresse VALUES (2,1,'chemin des Criblettes','','','2',1);
INSERT INTO Adresse VALUES (3,1,'Impasse des Alouettes','','','3',1);
INSERT INTO Adresse VALUES (4,1,'rue Jeanne d''Arc','','','4',2);
INSERT INTO Adresse VALUES (5,1,'rue des Artisans','','','5',2);
INSERT INTO Adresse VALUES (6,1,'rue Basse','','','6',2);
INSERT INTO Adresse VALUES (7,1,'rue des Bateliers','','','7',3);
INSERT INTO Adresse VALUES (8,1,'rue Beethoven','','','8',3);
INSERT INTO Adresse VALUES (9,1,'rue des Bergers','','','9',3);
INSERT INTO Adresse VALUES (10,1,'rue Berlioz','','','10',3.5);
INSERT INTO Adresse VALUES (11,1,'route de Berstett','','','11',3.8);
INSERT INTO Adresse VALUES (12,1,'Place de la Bique','','','12',4.1);
INSERT INTO Adresse VALUES (13,1,'rue de la Bique','','','1',4.4);
INSERT INTO Adresse VALUES (14,1,'rue des Bleuets','','','2',4.7);
INSERT INTO Adresse VALUES (15,1,'Cour du Bouvreuil','','','3',5);
INSERT INTO Adresse VALUES (16,1,'rue Brandt','','','4',5.3);
INSERT INTO Adresse VALUES (17,1,'route de Brumath','','','5',5.6);
INSERT INTO Adresse VALUES (18,1,'Impasse des Cailles','','','6',5.9);
INSERT INTO Adresse VALUES (19,1,'rue du Canal','','','7',6.2);
INSERT INTO Adresse VALUES (20,1,'rue des Champs','','','8',6.5);
INSERT INTO Adresse VALUES (21,1,'rue du Champ du Feu','','','9',6.8);
INSERT INTO Adresse VALUES (22,1,'Impasse des Charmes','','','10',7.1);
INSERT INTO Adresse VALUES (23,1,'rue des Châtaigniers','','','11',7.4);
INSERT INTO Adresse VALUES (24,1,'rue Chateaubriand','','','12',7.7);
INSERT INTO Adresse VALUES (25,1,'rue du Château d''Eau','','','1',8);
INSERT INTO Adresse VALUES (26,1,'rue des Chênes','','','2',8.3);
INSERT INTO Adresse VALUES (27,1,'Cour du Chevalier','','','3',8.6);
INSERT INTO Adresse VALUES (28,1,'rue du Cheval Noir','','','4',8.9);
INSERT INTO Adresse VALUES (29,1,'rue de la Cité','','','5',9.2);
INSERT INTO Adresse VALUES (30,1,'rue du Climont','','','6',9.5);
INSERT INTO Adresse VALUES (31,1,'rue de la Colline','','','7',9.8);
INSERT INTO Adresse VALUES (32,1,'rue des Coquelicots','','','8',10.1);
INSERT INTO Adresse VALUES (33,1,'rue Corneille','','','9',10.4);
INSERT INTO Adresse VALUES (34,1,'rue du Coteau','','','10',10.7);
INSERT INTO Adresse VALUES (35,1,'rue du Cottage','','','11',11);
INSERT INTO Adresse VALUES (36,1,'rue de la Couronne','','','12',11.3);
INSERT INTO Adresse VALUES (37,1,'rue du Dabo','','','1',11.6);
INSERT INTO Adresse VALUES (38,1,'rue Diderot','','','2',11.9);
INSERT INTO Adresse VALUES (39,1,'rue du Donon','','','3',12.2);
INSERT INTO Adresse VALUES (40,1,'rue des Faisans','','','4',12.5);
INSERT INTO Adresse VALUES (41,1,'Cour de la Fauvette','','','5',12.8);
INSERT INTO Adresse VALUES (42,1,'rue des Fleurs','','','6',13.1);
INSERT INTO Adresse VALUES (43,1,'rue de la Forêt','','','7',13.4);
INSERT INTO Adresse VALUES (44,1,'rue de la Gare','','','8',13.7);
INSERT INTO Adresse VALUES (45,1,'rue du Général de Gaulle','','','9',14);
INSERT INTO Adresse VALUES (46,1,'rue Charles Gounod','','','10',14.3);
INSERT INTO Adresse VALUES (47,1,'Cour du Grand Duc','','','11',14.6);
INSERT INTO Adresse VALUES (48,1,'rue du Gravier','','','12',14.9);
INSERT INTO Adresse VALUES (49,1,'rue du Griffon','','','1',15.2);
INSERT INTO Adresse VALUES (50,1,'Cour de la Guifette','','','2',15.5);
INSERT INTO Adresse VALUES (51,1,'rue du Haut-Barr','','','3',15.8);
INSERT INTO Adresse VALUES (52,1,'rue des Hêtres','','','4',16.1);
INSERT INTO Adresse VALUES (53,1,'rue Hohl','','','5',16.4);
INSERT INTO Adresse VALUES (54,1,'rue du Hohneck','','','6',16.7);
INSERT INTO Adresse VALUES (55,1,'rue du Hohwald','','','7',17);
INSERT INTO Adresse VALUES (56,1,'rue Jean Holweg ','','','8',17.3);
INSERT INTO Adresse VALUES (57,1,'rue Victor Hugo','','','9',17.6);
INSERT INTO Adresse VALUES (58,1,'rue des Jardins','','','10',17.9);
INSERT INTO Adresse VALUES (59,1,'rue du Kronthal','','','11',18.2);
INSERT INTO Adresse VALUES (60,1,'rue La Fontaine','','','12',18.5);
INSERT INTO Adresse VALUES (61,1,'rue Lamartine','','','1',18.8);
INSERT INTO Adresse VALUES (62,1,'Route de Lampertheim','','','2',19.1);
INSERT INTO Adresse VALUES (63,1,'rue du Lavoir','','','3',19.4);
INSERT INTO Adresse VALUES (64,1,'rue Lavoisier','','','4',19.7);
INSERT INTO Adresse VALUES (65,1,'rue du Général Leclerc','','','5',20);
INSERT INTO Adresse VALUES (66,1,'rue Lignée','','','6',20.3);
INSERT INTO Adresse VALUES (67,1,'Place Longchamp','','','7',20.6);
INSERT INTO Adresse VALUES (68,1,'rue des Marguerites','','','8',20.9);
INSERT INTO Adresse VALUES (69,1,'rue de la Marseillaise','','','9',21.2);
INSERT INTO Adresse VALUES (70,1,'rue Matter','','','10',21.5);
INSERT INTO Adresse VALUES (71,1,'rue du Matterberg','','','11',21.8);
INSERT INTO Adresse VALUES (72,1,'rue Guy de Maupassant','','','12',22.1);
INSERT INTO Adresse VALUES (73,1,'rue des Merles','','','1',22.4);
INSERT INTO Adresse VALUES (74,1,'rue des Mésanges','','','2',22.7);
INSERT INTO Adresse VALUES (75,1,'rue du Moulin','','','3',23);
INSERT INTO Adresse VALUES (76,1,'Place Molière','','','4',23.3);
INSERT INTO Adresse VALUES (77,1,'rue Molière','','','5',23.6);
INSERT INTO Adresse VALUES (78,1,'rue Mozart','','','6',23.9);
INSERT INTO Adresse VALUES (79,1,'rue Neuve','','','7',24.2);
INSERT INTO Adresse VALUES (80,1,'rue du Nideck','','','8',24.5);
INSERT INTO Adresse VALUES (81,1,'rue des Noyers','','','9',24.8);
INSERT INTO Adresse VALUES (82,1,'rue Oberlin','','','10',25.1);
INSERT INTO Adresse VALUES (83,1,'Place Ste.Odile','','','11',25.4);
INSERT INTO Adresse VALUES (84,1,'rue Blaise Pascal','','','12',25.7);
INSERT INTO Adresse VALUES (85,1,'rue Pasteur','','','1',26);
INSERT INTO Adresse VALUES (86,1,'rue des Perdrix','','','2',26.3);
INSERT INTO Adresse VALUES (87,1,'rue des Peupliers','','','3',26.6);
INSERT INTO Adresse VALUES (88,1,'rue de la Pierre-Polie','','','4',26.9);
INSERT INTO Adresse VALUES (89,1,'rue des Platanes','','','5',27.2);
INSERT INTO Adresse VALUES (90,1,'Impasse du Plateau','','','6',27.5);
INSERT INTO Adresse VALUES (91,1,'rue Racine','','','7',27.8);
INSERT INTO Adresse VALUES (92,1,'rue de la Rampe','','','8',28.1);
INSERT INTO Adresse VALUES (93,1,'rue de Reichstett','','','9',28.4);
INSERT INTO Adresse VALUES (94,1,'rue au Rempart','','','10',28.7);
INSERT INTO Adresse VALUES (95,1,'Cour du Rossignol','','','11',29);
INSERT INTO Adresse VALUES (96,1,'rue Jean-Jacques Rousseau','','','12',29.3);
INSERT INTO Adresse VALUES (97,1,'Chemin du Ruisseau','','','1',29.6);
INSERT INTO Adresse VALUES (98,1,'rue Georges Sand','','','2',29.9);
INSERT INTO Adresse VALUES (99,1,'rue Albert Schweitzer','','','3',30.2);
INSERT INTO Adresse VALUES (100,1,'rue du Serin','','','4',30.5);
INSERT INTO Adresse VALUES (101,1,'rue des Sorbiers','','','5',30.8);
INSERT INTO Adresse VALUES (102,1,'rue Stendhal','','','6',31.1);
INSERT INTO Adresse VALUES (103,1,'Route de Strasbourg','','','7',31.4);
INSERT INTO Adresse VALUES (104,1,'rue Strintz','','','8',31.7);
INSERT INTO Adresse VALUES (105,1,'rue du Tanet','','','9',32);
INSERT INTO Adresse VALUES (106,1,'rue du Temple','','','10',32.3);
INSERT INTO Adresse VALUES (107,1,'rue du Vallon','','','11',32.6);
INSERT INTO Adresse VALUES (108,1,'Cour du Vanneau','','','12',32.9);
INSERT INTO Adresse VALUES (109,1,'rue Paul Verlaine','','','1',33.2);
INSERT INTO Adresse VALUES (110,1,'rue du Versant','','','2',33.5);
INSERT INTO Adresse VALUES (111,1,'rue du Vignoble','','','3',33.8);
INSERT INTO Adresse VALUES (112,1,'rue Voltaire','','','4',34.1);
INSERT INTO Adresse VALUES (113,1,'rue du Général Wurmser','','','5',34.4);
INSERT INTO Adresse VALUES (114,1,'Rue d''Annanelle','','','6',34.7);
INSERT INTO Adresse VALUES (115,1,'Rue de la Balance','','','7',35);
INSERT INTO Adresse VALUES (116,1,'Rue de la Banasterie','','','8',35.3);
INSERT INTO Adresse VALUES (117,1,'Rue Bancasse','','','9',35.6);
INSERT INTO Adresse VALUES (118,1,'Rue Bonneterie','','','10',35.9);
INSERT INTO Adresse VALUES (119,1,'Rue de la Bouquerie','','','11',36.2);
INSERT INTO Adresse VALUES (120,1,'Rue Carreterie','','','12',36.5);
INSERT INTO Adresse VALUES (121,1,'Rue Chauffard','','','1',36.8);
INSERT INTO Adresse VALUES (122,1,'Rue du Pape-Clément-VI','','','2',37.1);
INSERT INTO Adresse VALUES (123,1,'Rue de la Grande-Fusterie','','','3',37.4);
INSERT INTO Adresse VALUES (124,1,'Rue de la Moyenne-Fusterie','','','4',37.7);
INSERT INTO Adresse VALUES (125,1,'Rue de la Petite-Fusterie','','','5',38);
INSERT INTO Adresse VALUES (126,1,'Rue Guillaume Puy','','','6',38.3);
INSERT INTO Adresse VALUES (127,1,'Rue Henri Fabre','','','7',38.6);
INSERT INTO Adresse VALUES (128,1,'Rue Joseph-Vernet','','','8',38.9);
INSERT INTO Adresse VALUES (129,1,'Rue des Lices','','','9',39.2);
INSERT INTO Adresse VALUES (130,1,'Rue de la Peyrolerie','','','10',39.5);
INSERT INTO Adresse VALUES (131,1,'Rue Philonarde','','','11',39.8);
INSERT INTO Adresse VALUES (132,1,'Rue de la République','','','12',40.1);
INSERT INTO Adresse VALUES (133,1,'Rue du Roi-René','','','1',40.4);
INSERT INTO Adresse VALUES (134,1,'Rue Saint-Agricol','','','2',40.7);
INSERT INTO Adresse VALUES (135,1,'Rue des Teinturiers','','','3',41);
INSERT INTO Adresse VALUES (136,1,'Rue Thiers','','','4',41.3);
INSERT INTO Adresse VALUES (137,1,'Rue du Vieux-Sextier','','','5',41.6);
INSERT INTO Adresse VALUES (138,1,'rue du Matterberg','','','6',41.9);
INSERT INTO Adresse VALUES (139,1,'rue Guy de Maupassant','','','7',42.2);
INSERT INTO Adresse VALUES (140,1,'rue des Merles','','','8',42.5);
INSERT INTO Adresse VALUES (141,1,'rue des Mésanges','','','9',42.8);
INSERT INTO Adresse VALUES (142,1,'rue du Moulin','','','10',43.1);
INSERT INTO Adresse VALUES (143,1,'Place Molière','','','11',43.4);
INSERT INTO Adresse VALUES (144,1,'rue Molière','','','12',43.7);
INSERT INTO Adresse VALUES (145,1,'rue Mozart','','','1',44);
INSERT INTO Adresse VALUES (146,1,'rue Neuve','','','2',44.3);
INSERT INTO Adresse VALUES (147,1,'rue du Nideck','','','3',44.6);
INSERT INTO Adresse VALUES (148,1,'rue des Noyers','','','4',44.9);
INSERT INTO Adresse VALUES (149,1,'rue Oberlin','','','5',45.2);
INSERT INTO Adresse VALUES (150,1,'Cour du Bouvreuil','','','6',45.5);
INSERT INTO Adresse VALUES (151,1,'rue Brandt','','','7',45.8);
INSERT INTO Adresse VALUES (152,1,'route de Brumath','','','8',46.1);
INSERT INTO Adresse VALUES (153,1,'Impasse des Cailles','','','9',46.4);
INSERT INTO Adresse VALUES (154,1,'rue du Canal','','','10',46.7);
INSERT INTO Adresse VALUES (155,1,'rue des Champs','','','11',47);
INSERT INTO Adresse VALUES (156,1,'rue du Champ du Feu','','','12',47.3);
INSERT INTO Adresse VALUES (157,1,'Impasse des Charmes','','','1',47.6);
INSERT INTO Adresse VALUES (158,1,'rue des Châtaigniers','','','2',47.9);
INSERT INTO Adresse VALUES (159,1,'rue Chateaubriand','','','3',48.2);
INSERT INTO Adresse VALUES (160,1,'rue du Château d''Eau','','','4',48.5);
INSERT INTO Adresse VALUES (161,1,'rue du Cottage','','','5',48.8);
INSERT INTO Adresse VALUES (162,1,'rue de la Couronne','','','6',49.1);
INSERT INTO Adresse VALUES (163,1,'rue du Dabo','','','7',49.4);
INSERT INTO Adresse VALUES (164,1,'rue Diderot','','','8',49.7);
INSERT INTO Adresse VALUES (165,1,'rue du Donon','','','9',50);
INSERT INTO Adresse VALUES (166,1,'rue des Faisans','','','10',50.3);
INSERT INTO Adresse VALUES (167,1,'Cour de la Fauvette','','','11',50.6);
INSERT INTO Adresse VALUES (168,1,'rue des Fleurs','','','12',50.9);
INSERT INTO Adresse VALUES (169,1,'rue de la Forêt','','','1',51.2);
INSERT INTO Adresse VALUES (170,1,'rue de la Gare','','','2',51.5);
INSERT INTO Adresse VALUES (171,1,'rue du Général de Gaulle','','','3',51.8);
INSERT INTO Adresse VALUES (172,1,'rue Charles Gounod','','','4',52.1);
INSERT INTO Adresse VALUES (173,1,'Cour du Grand Duc','','','5',52.4);
INSERT INTO Adresse VALUES (174,1,'rue Hohl','','','6',52.7);
INSERT INTO Adresse VALUES (175,1,'rue du Hohneck','','','7',53);
INSERT INTO Adresse VALUES (176,1,'rue du Hohwald','','','8',53.3);
INSERT INTO Adresse VALUES (177,1,'rue Jean Holweg ','','','9',53.6);
INSERT INTO Adresse VALUES (178,1,'rue Victor Hugo','','','10',53.9);
INSERT INTO Adresse VALUES (179,1,'rue des Jardins','','','11',54.2);
INSERT INTO Adresse VALUES (180,1,'rue du Kronthal','','','12',54.5);
INSERT INTO Adresse VALUES (181,1,'rue La Fontaine','','','1',54.8);
INSERT INTO Adresse VALUES (182,1,'rue Lamartine','','','2',55.1);
INSERT INTO Adresse VALUES (183,1,'Route de Lampertheim','','','3',55.4);
INSERT INTO Adresse VALUES (184,1,'rue du Lavoir','','','4',55.7);
INSERT INTO Adresse VALUES (185,1,'rue Lavoisier','','','5',56);
INSERT INTO Adresse VALUES (186,1,'rue du Général Leclerc','','','6',56.3);
INSERT INTO Adresse VALUES (187,1,'rue Lignée','','','7',56.6);
INSERT INTO Adresse VALUES (188,1,'Place Longchamp','','','8',56.9);
INSERT INTO Adresse VALUES (189,1,'rue des Marguerites','','','9',57.2);
INSERT INTO Adresse VALUES (190,1,'rue de la Marseillaise','','','10',57.5);
INSERT INTO Adresse VALUES (191,1,'rue Matter','','','11',57.8);
INSERT INTO Adresse VALUES (192,1,'rue du Matterberg','','','12',58.1);
INSERT INTO Adresse VALUES (193,1,'rue Guy de Maupassant','','','1',58.4);
INSERT INTO Adresse VALUES (194,1,'rue des Merles','','','2',58.7);
INSERT INTO Adresse VALUES (195,1,'rue des Mésanges','','','3',59);
INSERT INTO Adresse VALUES (196,1,'Impasse des Alouettes','','','4',59.3);
INSERT INTO Adresse VALUES (197,1,'rue Jeanne d''Arc','','','5',59.6);
INSERT INTO Adresse VALUES (198,1,'rue des Artisans','','','6',59.9);
INSERT INTO Adresse VALUES (199,1,'rue Basse','','','7',60.2);
INSERT INTO Adresse VALUES (200,1,'rue des Bateliers','','','8',60.5);
INSERT INTO Adresse VALUES (201,1,'rue Beethoven','','','9',60.8);
INSERT INTO Adresse VALUES (202,1,'rue des Bergers','','','10',61.1);
INSERT INTO Adresse VALUES (203,1,'rue Berlioz','','','11',61.4);
INSERT INTO Adresse VALUES (204,1,'route de Berstett','','','12',61.7);
INSERT INTO Adresse VALUES (205,1,'Place de la Bique','','','1',62);
INSERT INTO Adresse VALUES (206,1,'rue de la Bique','','','2',62.3);
INSERT INTO Adresse VALUES (207,1,'rue des Bleuets','','','3',62.6);
INSERT INTO Adresse VALUES (208,1,'Cour du Bouvreuil','','','4',62.9);
INSERT INTO Adresse VALUES (209,1,'rue Brandt','','','5',63.2);
INSERT INTO Adresse VALUES (210,1,'route de Brumath','','','6',63.5);
INSERT INTO Adresse VALUES (211,1,'Impasse des Cailles','','','7',63.8);
INSERT INTO Adresse VALUES (212,1,'rue du Canal','','','8',64.1);
INSERT INTO Adresse VALUES (213,1,'rue des Champs','','','9',64.4);
INSERT INTO Adresse VALUES (214,1,'rue du Champ du Feu','','','10',64.7);
INSERT INTO Adresse VALUES (215,1,'Impasse des Charmes','','','11',65);
INSERT INTO Adresse VALUES (216,1,'Rue Thiers','','','12',65.3);
INSERT INTO Adresse VALUES (217,1,'Rue du Vieux-Sextier','','','1',65.6);
INSERT INTO Adresse VALUES (218,1,'rue du Matterberg','','','2',65.9);
INSERT INTO Adresse VALUES (219,1,'rue Guy de Maupassant','','','3',66.2);
INSERT INTO Adresse VALUES (220,1,'rue des Merles','','','4',66.5);

GO


-- Table Contrat
--No INTEGER NOT NULL,Date DATE NOT NULL,Statut VARCHAR(50) NOT NULL,DateStatut DATE,SortieNo INTEGER NOT NULL,PPEntiteNo INTEGER NOT NULL
INSERT INTO Contrat VALUES(1,'2001-01-02','signé','2001-01-06',1,1);
INSERT INTO Contrat VALUES(2,'2001-01-21','signé','2001-01-25',2,2);
INSERT INTO Contrat VALUES(3,'2001-02-09','signé','2001-02-13',3,2);
INSERT INTO Contrat VALUES(4,'2001-02-28','signé','2001-03-04',4,3);
INSERT INTO Contrat VALUES(5,'2001-04-07','signé','2001-04-11',6,6);
INSERT INTO Contrat VALUES(6,'2001-04-26','signé','2001-04-30',7,7);
INSERT INTO Contrat VALUES(7,'2001-05-15','signé','2001-05-19',8,7);
INSERT INTO Contrat VALUES(8,'2001-06-03','signé','2001-06-07',9,8);
INSERT INTO Contrat VALUES(9,'2001-07-11','signé','2001-07-15',11,11);
INSERT INTO Contrat VALUES(10,'2001-07-30','signé','2001-08-03',12,12);
INSERT INTO Contrat VALUES(11,'2001-08-18','signé','2001-08-22',13,12);
INSERT INTO Contrat VALUES(12,'2001-09-06','signé','2001-09-10',14,13);
INSERT INTO Contrat VALUES(13,'2001-10-14','signé','2001-10-18',16,16);
INSERT INTO Contrat VALUES(14,'2001-11-02','signé','2001-11-06',17,17);
INSERT INTO Contrat VALUES(15,'2001-11-21','signé','2001-11-25',18,17);
INSERT INTO Contrat VALUES(16,'2001-12-10','signé','2001-12-14',19,18);
INSERT INTO Contrat VALUES(17,'2002-01-17','signé','2002-01-21',21,21);
INSERT INTO Contrat VALUES(18,'2002-02-05','signé','2002-02-09',22,22);
INSERT INTO Contrat VALUES(19,'2002-02-24','signé','2002-02-28',23,22);
INSERT INTO Contrat VALUES(20,'2002-03-15','signé','2002-03-19',24,23);
INSERT INTO Contrat VALUES(21,'2002-04-22','signé','2002-04-26',26,26);
INSERT INTO Contrat VALUES(22,'2002-05-11','signé','2002-05-15',27,27);
INSERT INTO Contrat VALUES(23,'2002-05-30','signé','2002-06-03',28,27);
INSERT INTO Contrat VALUES(24,'2002-06-18','signé','2002-06-22',29,28);
INSERT INTO Contrat VALUES(25,'2002-07-26','signé','2002-07-30',31,31);
INSERT INTO Contrat VALUES(26,'2002-08-14','signé','2002-08-18',32,32);
INSERT INTO Contrat VALUES(27,'2002-09-02','signé','2002-09-06',33,32);
INSERT INTO Contrat VALUES(28,'2002-09-21','signé','2002-09-25',34,33);
INSERT INTO Contrat VALUES(29,'2002-10-29','signé','2002-11-02',36,36);
INSERT INTO Contrat VALUES(30,'2002-11-17','signé','2002-11-21',37,37);
INSERT INTO Contrat VALUES(31,'2002-12-06','signé','2002-12-10',38,37);
INSERT INTO Contrat VALUES(32,'2002-12-25','signé','2002-12-29',39,38);
INSERT INTO Contrat VALUES(33,'2003-02-01','signé','2003-02-05',41,41);
INSERT INTO Contrat VALUES(34,'2003-02-20','signé','2003-02-24',42,42);
INSERT INTO Contrat VALUES(35,'2003-03-11','signé','2003-03-15',43,42);
INSERT INTO Contrat VALUES(36,'2003-03-30','signé','2003-04-03',44,43);
INSERT INTO Contrat VALUES(37,'2003-05-07','signé','2003-05-11',46,46);
INSERT INTO Contrat VALUES(38,'2003-05-26','signé','2003-05-30',47,47);
INSERT INTO Contrat VALUES(39,'2003-06-14','signé','2003-06-18',48,47);
INSERT INTO Contrat VALUES(40,'2003-07-03','signé','2003-07-07',49,48);
INSERT INTO Contrat VALUES(41,'2003-08-10','signé','2003-08-14',51,51);
INSERT INTO Contrat VALUES(42,'2003-08-29','signé','2003-09-02',52,52);
INSERT INTO Contrat VALUES(43,'2003-09-17','signé','2003-09-21',53,52);
INSERT INTO Contrat VALUES(44,'2003-10-06','signé','2003-10-10',54,53);
INSERT INTO Contrat VALUES(45,'2003-11-13','signé','2003-11-17',56,56);
INSERT INTO Contrat VALUES(46,'2003-12-02','signé','2003-12-06',57,57);
INSERT INTO Contrat VALUES(47,'2003-12-21','signé','2003-12-25',58,57);
INSERT INTO Contrat VALUES(48,'2004-01-09','signé','2004-01-13',59,58);
INSERT INTO Contrat VALUES(49,'2004-02-16','signé','2004-02-20',61,61);
INSERT INTO Contrat VALUES(50,'2004-03-06','signé','2004-03-10',62,62);
INSERT INTO Contrat VALUES(51,'2004-03-25','signé','2004-03-29',63,62);
INSERT INTO Contrat VALUES(52,'2004-04-13','signé','2004-04-17',64,63);
INSERT INTO Contrat VALUES(53,'2004-05-21','signé','2004-05-25',66,66);
INSERT INTO Contrat VALUES(54,'2004-06-09','signé','2004-06-13',67,67);
INSERT INTO Contrat VALUES(55,'2004-06-28','signé','2004-07-02',68,67);
INSERT INTO Contrat VALUES(56,'2004-07-17','signé','2004-07-21',69,68);
INSERT INTO Contrat VALUES(57,'2004-08-24','signé','2004-08-28',71,71);
INSERT INTO Contrat VALUES(58,'2004-09-12','signé','2004-09-16',72,72);
INSERT INTO Contrat VALUES(59,'2004-10-01','signé','2004-10-05',73,72);
INSERT INTO Contrat VALUES(60,'2004-10-20','signé','2004-10-24',74,73);
INSERT INTO Contrat VALUES(61,'2004-11-27','signé','2004-12-01',76,76);
INSERT INTO Contrat VALUES(62,'2004-12-16','signé','2004-12-20',77,77);
INSERT INTO Contrat VALUES(63,'2005-01-04','signé','2005-01-08',78,77);
INSERT INTO Contrat VALUES(64,'2005-01-23','signé','2005-01-27',79,78);
INSERT INTO Contrat VALUES(65,'2005-03-02','signé','2005-03-06',81,81);
INSERT INTO Contrat VALUES(66,'2005-03-21','signé','2005-03-25',82,82);
INSERT INTO Contrat VALUES(67,'2005-04-09','signé','2005-04-13',83,82);
INSERT INTO Contrat VALUES(68,'2005-04-28','signé','2005-05-02',84,83);
INSERT INTO Contrat VALUES(69,'2005-06-05','signé','2005-06-09',86,86);
INSERT INTO Contrat VALUES(70,'2005-06-24','signé','2005-06-28',87,87);
INSERT INTO Contrat VALUES(71,'2005-07-13','signé','2005-07-17',88,87);
INSERT INTO Contrat VALUES(72,'2005-08-01','signé','2005-08-05',89,88);
INSERT INTO Contrat VALUES(73,'2005-09-08','signé','2005-09-12',91,91);
INSERT INTO Contrat VALUES(74,'2005-09-27','signé','2005-10-01',92,92);
INSERT INTO Contrat VALUES(75,'2005-10-16','signé','2005-10-20',93,92);
INSERT INTO Contrat VALUES(76,'2005-11-04','signé','2005-11-08',94,93);
INSERT INTO Contrat VALUES(77,'2005-12-12','signé','2005-12-16',96,96);
INSERT INTO Contrat VALUES(78,'2005-12-31','signé','2006-01-04',97,97);
INSERT INTO Contrat VALUES(79,'2006-01-19','signé','2006-01-23',98,97);
INSERT INTO Contrat VALUES(80,'2006-02-07','signé','2006-02-11',99,98);
INSERT INTO Contrat VALUES(81,'2006-03-17','signé','2006-03-21',101,101);
INSERT INTO Contrat VALUES(82,'2006-04-05','signé','2006-04-09',102,102);
INSERT INTO Contrat VALUES(83,'2006-04-24','signé','2006-04-28',103,102);
INSERT INTO Contrat VALUES(84,'2006-05-13','signé','2006-05-17',104,103);
INSERT INTO Contrat VALUES(85,'2006-06-20','signé','2006-06-24',106,106);
INSERT INTO Contrat VALUES(86,'2006-07-09','signé','2006-07-13',107,107);
INSERT INTO Contrat VALUES(87,'2006-07-28','signé','2006-08-01',108,107);
INSERT INTO Contrat VALUES(88,'2006-08-16','signé','2006-08-20',109,108);
INSERT INTO Contrat VALUES(89,'2006-09-23','signé','2006-09-27',111,111);
INSERT INTO Contrat VALUES(90,'2006-10-12','signé','2006-10-16',112,112);
INSERT INTO Contrat VALUES(91,'2006-10-31','signé','2006-11-04',113,112);
INSERT INTO Contrat VALUES(92,'2006-11-19','signé','2006-11-23',114,113);
INSERT INTO Contrat VALUES(93,'2006-12-27','signé','2006-12-31',116,116);
INSERT INTO Contrat VALUES(94,'2007-01-15','signé','2007-01-19',117,117);
INSERT INTO Contrat VALUES(95,'2007-02-03','signé','2007-02-07',118,117);
INSERT INTO Contrat VALUES(96,'2007-02-22','signé','2007-02-26',119,118);
INSERT INTO Contrat VALUES(97,'2007-04-01','signé','2007-04-05',121,121);
INSERT INTO Contrat VALUES(98,'2007-04-20','signé','2007-04-24',122,122);
INSERT INTO Contrat VALUES(99,'2007-05-09','signé','2007-05-13',123,122);
INSERT INTO Contrat VALUES(100,'2007-05-28','signé','2007-06-01',124,123);
INSERT INTO Contrat VALUES(101,'2007-07-05','signé','2007-07-09',126,126);
INSERT INTO Contrat VALUES(102,'2007-07-24','signé','2007-07-28',127,127);
INSERT INTO Contrat VALUES(103,'2007-08-12','signé','2007-08-16',128,127);
INSERT INTO Contrat VALUES(104,'2007-08-31','signé','2007-09-04',129,128);
INSERT INTO Contrat VALUES(105,'2007-10-08','signé','2007-10-12',131,131);
INSERT INTO Contrat VALUES(106,'2007-10-27','signé','2007-10-31',132,132);
INSERT INTO Contrat VALUES(107,'2007-11-15','signé','2007-11-19',133,132);
INSERT INTO Contrat VALUES(108,'2007-12-04','signé','2007-12-08',134,133);
INSERT INTO Contrat VALUES(109,'2008-01-11','signé','2008-01-15',136,136);
INSERT INTO Contrat VALUES(110,'2008-01-30','signé','2008-02-03',137,137);
INSERT INTO Contrat VALUES(111,'2008-02-18','signé','2008-02-22',138,137);
INSERT INTO Contrat VALUES(112,'2008-03-08','signé','2008-03-12',139,138);
INSERT INTO Contrat VALUES(113,'2008-04-15','signé','2008-04-19',141,141);
INSERT INTO Contrat VALUES(114,'2008-05-04','signé','2008-05-08',142,142);
INSERT INTO Contrat VALUES(115,'2008-05-23','signé','2008-05-27',143,142);
INSERT INTO Contrat VALUES(116,'2008-06-11','signé','2008-06-15',144,143);
INSERT INTO Contrat VALUES(117,'2008-07-19','signé','2008-07-23',146,146);
INSERT INTO Contrat VALUES(118,'2008-08-07','signé','2008-08-11',147,147);
INSERT INTO Contrat VALUES(119,'2008-08-26','signé','2008-08-30',148,147);
INSERT INTO Contrat VALUES(120,'2008-09-14','signé','2008-09-18',149,148);
INSERT INTO Contrat VALUES(121,'2008-10-22','signé','2008-10-26',151,151);
INSERT INTO Contrat VALUES(122,'2008-11-10','signé','2008-11-14',152,152);
INSERT INTO Contrat VALUES(123,'2008-11-29','signé','2008-12-03',153,152);
INSERT INTO Contrat VALUES(124,'2008-12-18','signé','2008-12-22',154,153);
INSERT INTO Contrat VALUES(125,'2009-01-25','signé','2009-01-29',156,156);
INSERT INTO Contrat VALUES(126,'2009-02-13','signé','2009-02-17',157,157);
INSERT INTO Contrat VALUES(127,'2009-03-04','signé','2009-03-08',158,157);
INSERT INTO Contrat VALUES(128,'2009-03-23','signé','2009-03-27',159,158);
INSERT INTO Contrat VALUES(129,'2009-04-30','signé','2009-05-04',161,161);
INSERT INTO Contrat VALUES(130,'2009-05-19','signé','2009-05-23',162,162);
INSERT INTO Contrat VALUES(131,'2009-06-07','signé','2009-06-11',163,162);
INSERT INTO Contrat VALUES(132,'2009-06-26','signé','2009-06-30',164,163);
INSERT INTO Contrat VALUES(133,'2009-08-03','signé','2009-08-07',166,166);
INSERT INTO Contrat VALUES(134,'2009-08-22','signé','2009-08-26',167,167);
INSERT INTO Contrat VALUES(135,'2009-09-10','signé','2009-09-14',168,167);
INSERT INTO Contrat VALUES(136,'2009-09-29','signé','2009-10-03',169,168);
INSERT INTO Contrat VALUES(137,'2009-11-06','signé','2009-11-10',171,171);
INSERT INTO Contrat VALUES(138,'2009-11-25','signé','2009-11-29',172,172);
INSERT INTO Contrat VALUES(139,'2009-12-14','signé','2009-12-18',173,172);
INSERT INTO Contrat VALUES(140,'2010-01-02','signé','2010-01-06',174,173);
INSERT INTO Contrat VALUES(141,'2010-02-09','signé','2010-02-13',176,176);
INSERT INTO Contrat VALUES(142,'2010-02-28','signé','2010-03-04',177,177);
INSERT INTO Contrat VALUES(143,'2010-03-19','signé','2010-03-23',178,177);
INSERT INTO Contrat VALUES(144,'2010-04-07','signé','2010-04-11',179,178);
INSERT INTO Contrat VALUES(145,'2010-05-15','signé','2010-05-19',181,181);
INSERT INTO Contrat VALUES(146,'2010-06-03','signé','2010-06-07',182,182);
INSERT INTO Contrat VALUES(147,'2010-06-22','signé','2010-06-26',183,182);

INSERT INTO Contrat VALUES(152,'2010-10-14','signé','2010-10-18',189,188);
INSERT INTO Contrat VALUES(153,'2010-11-21','signé','2010-11-25',191,191);
INSERT INTO Contrat VALUES(154,'2010-12-10','signé','2010-12-14',192,192);
INSERT INTO Contrat VALUES(155,'2010-12-29','signé','2011-01-02',193,192);
INSERT INTO Contrat VALUES(156,'2011-01-17','signé','2011-01-21',194,193);
INSERT INTO Contrat VALUES(157,'2011-02-24','signé','2011-02-28',196,196);
INSERT INTO Contrat VALUES(158,'2011-03-15','signé','2011-03-19',197,197);
INSERT INTO Contrat VALUES(159,'2011-04-03','signé','2011-04-07',198,197);
INSERT INTO Contrat VALUES(160,'2011-04-22','signé','2011-04-26',199,198);
INSERT INTO Contrat VALUES(161,'2011-05-30','signé','2011-06-03',201,201);
INSERT INTO Contrat VALUES(162,'2011-06-18','signé','2011-06-22',202,202);
INSERT INTO Contrat VALUES(163,'2011-07-07','signé','2011-07-11',203,202);
INSERT INTO Contrat VALUES(164,'2011-07-26','signé','2011-07-30',204,203);
INSERT INTO Contrat VALUES(165,'2011-09-02','signé','2011-09-06',206,206);
INSERT INTO Contrat VALUES(166,'2011-09-21','signé','2011-09-25',207,207);
INSERT INTO Contrat VALUES(167,'2011-10-10','signé','2011-10-14',208,207);
INSERT INTO Contrat VALUES(168,'2011-10-29','signé','2011-11-02',209,208);
INSERT INTO Contrat VALUES(169,'2011-12-06','signé','2011-12-10',211,211);
INSERT INTO Contrat VALUES(170,'2011-12-25','signé','2011-12-29',212,212);
INSERT INTO Contrat VALUES(171,'2012-01-13','envoyé','2012-01-17',213,212);
INSERT INTO Contrat VALUES(172,'2012-02-01','signé','2012-02-05',214,213);
INSERT INTO Contrat VALUES(173,'2012-03-10','envoyé','2012-03-14',216,216);
INSERT INTO Contrat VALUES(174,'2012-03-29','envoyé','2012-04-02',217,217);
INSERT INTO Contrat VALUES(175,'2012-04-17','envoyé','2012-04-21',218,217);
INSERT INTO Contrat VALUES(176,'2012-05-06','envoyé','2012-05-10',219,218);
--Suppression des lignes suivantes pour contrainte d'integrite 3
--INSERT INTO Contrat VALUES(148,'2010-07-11','signé','2010-07-15',184,183);
--INSERT INTO Contrat VALUES(149,'2010-08-18','signé','2010-08-22',186,186);
--INSERT INTO Contrat VALUES(150,'2010-09-06','signé','2010-09-10',187,187);
--INSERT INTO Contrat VALUES(151,'2010-09-25','signé','2010-09-29',188,187);

GO

-- Table Contact
--EntrepriseEntiteNo INTEGER NOT NULL, PPEntiteNo INTEGER NOT NULL
INSERT INTO Contact VALUES(5,6);
INSERT INTO Contact VALUES(10,11);
INSERT INTO Contact VALUES(15,16);
INSERT INTO Contact VALUES(20,21);
INSERT INTO Contact VALUES(25,26);
INSERT INTO Contact VALUES(30,31);
INSERT INTO Contact VALUES(35,36);
INSERT INTO Contact VALUES(40,41);
INSERT INTO Contact VALUES(45,46);
INSERT INTO Contact VALUES(50,51);
INSERT INTO Contact VALUES(55,56);
INSERT INTO Contact VALUES(60,61);
INSERT INTO Contact VALUES(65,66);
INSERT INTO Contact VALUES(70,71);
INSERT INTO Contact VALUES(75,76);
INSERT INTO Contact VALUES(80,81);
INSERT INTO Contact VALUES(85,86);
INSERT INTO Contact VALUES(90,91);
INSERT INTO Contact VALUES(95,96);
INSERT INTO Contact VALUES(100,101);
INSERT INTO Contact VALUES(105,106);
INSERT INTO Contact VALUES(110,111);
INSERT INTO Contact VALUES(115,116);
INSERT INTO Contact VALUES(120,121);
INSERT INTO Contact VALUES(125,126);
INSERT INTO Contact VALUES(130,131);
INSERT INTO Contact VALUES(135,136);
INSERT INTO Contact VALUES(140,141);
INSERT INTO Contact VALUES(145,146);
INSERT INTO Contact VALUES(150,151);
INSERT INTO Contact VALUES(155,156);
INSERT INTO Contact VALUES(160,161);
INSERT INTO Contact VALUES(165,166);
INSERT INTO Contact VALUES(170,171);
INSERT INTO Contact VALUES(175,176);
INSERT INTO Contact VALUES(180,181);
INSERT INTO Contact VALUES(185,186);
INSERT INTO Contact VALUES(190,191);
INSERT INTO Contact VALUES(195,196);
INSERT INTO Contact VALUES(200,201);
INSERT INTO Contact VALUES(205,206);
INSERT INTO Contact VALUES(210,211);

INSERT INTO Contact VALUES(10,12);

GO

-- Table Reservation
--EntiteNo INTEGER NOT NULL,--SortieNo INTEGER NOT NULL,--Date     DATE NOT NULL
INSERT INTO Reservation VALUES(1,1,'2001-01-02');
INSERT INTO Reservation VALUES(2,2,'2001-01-21');
INSERT INTO Reservation VALUES(2,3,'2001-02-09');
INSERT INTO Reservation VALUES(3,4,'2001-02-28');
INSERT INTO Reservation VALUES(5,6,'2001-04-07');
INSERT INTO Reservation VALUES(7,7,'2001-04-26');
INSERT INTO Reservation VALUES(7,8,'2001-05-15');
INSERT INTO Reservation VALUES(8,9,'2001-06-03');
INSERT INTO Reservation VALUES(10,11,'2001-07-11');
INSERT INTO Reservation VALUES(12,12,'2001-07-30');
INSERT INTO Reservation VALUES(12,13,'2001-08-18');
INSERT INTO Reservation VALUES(13,14,'2001-09-06');
INSERT INTO Reservation VALUES(15,16,'2001-10-14');
INSERT INTO Reservation VALUES(17,17,'2001-11-02');
INSERT INTO Reservation VALUES(17,18,'2001-11-21');
INSERT INTO Reservation VALUES(18,19,'2001-12-10');
INSERT INTO Reservation VALUES(20,21,'2002-01-17');
INSERT INTO Reservation VALUES(22,22,'2002-02-05');
INSERT INTO Reservation VALUES(22,23,'2002-02-24');
INSERT INTO Reservation VALUES(23,24,'2002-03-15');
INSERT INTO Reservation VALUES(25,26,'2002-04-22');
INSERT INTO Reservation VALUES(27,27,'2002-05-11');
INSERT INTO Reservation VALUES(27,28,'2002-05-30');
INSERT INTO Reservation VALUES(28,29,'2002-06-18');
INSERT INTO Reservation VALUES(30,31,'2002-07-26');
INSERT INTO Reservation VALUES(32,32,'2002-08-14');
INSERT INTO Reservation VALUES(32,33,'2002-09-02');
INSERT INTO Reservation VALUES(33,34,'2002-09-21');
INSERT INTO Reservation VALUES(35,36,'2002-10-29');
INSERT INTO Reservation VALUES(37,37,'2002-11-17');
INSERT INTO Reservation VALUES(37,38,'2002-12-06');
INSERT INTO Reservation VALUES(38,39,'2002-12-25');
INSERT INTO Reservation VALUES(40,41,'2003-02-01');
INSERT INTO Reservation VALUES(42,42,'2003-02-20');
INSERT INTO Reservation VALUES(42,43,'2003-03-11');
INSERT INTO Reservation VALUES(43,44,'2003-03-30');
INSERT INTO Reservation VALUES(45,46,'2003-05-07');
INSERT INTO Reservation VALUES(47,47,'2003-05-26');
INSERT INTO Reservation VALUES(47,48,'2003-06-14');
INSERT INTO Reservation VALUES(48,49,'2003-07-03');
INSERT INTO Reservation VALUES(50,51,'2003-08-10');
INSERT INTO Reservation VALUES(52,52,'2003-08-29');
INSERT INTO Reservation VALUES(52,53,'2003-09-17');
INSERT INTO Reservation VALUES(53,54,'2003-10-06');
INSERT INTO Reservation VALUES(55,56,'2003-11-13');
INSERT INTO Reservation VALUES(57,57,'2003-12-02');
INSERT INTO Reservation VALUES(57,58,'2003-12-21');
INSERT INTO Reservation VALUES(58,59,'2004-01-09');
INSERT INTO Reservation VALUES(60,61,'2004-02-16');
INSERT INTO Reservation VALUES(62,62,'2004-03-06');
INSERT INTO Reservation VALUES(62,63,'2004-03-25');
INSERT INTO Reservation VALUES(63,64,'2004-04-13');
INSERT INTO Reservation VALUES(65,66,'2004-05-21');
INSERT INTO Reservation VALUES(67,67,'2004-06-09');
INSERT INTO Reservation VALUES(67,68,'2004-06-28');
INSERT INTO Reservation VALUES(68,69,'2004-07-17');
INSERT INTO Reservation VALUES(70,71,'2004-08-24');
INSERT INTO Reservation VALUES(72,72,'2004-09-12');
INSERT INTO Reservation VALUES(72,73,'2004-10-01');
INSERT INTO Reservation VALUES(73,74,'2004-10-20');
INSERT INTO Reservation VALUES(75,76,'2004-11-27');
INSERT INTO Reservation VALUES(77,77,'2004-12-16');
INSERT INTO Reservation VALUES(77,78,'2005-01-04');
INSERT INTO Reservation VALUES(78,79,'2005-01-23');
INSERT INTO Reservation VALUES(80,81,'2005-03-02');
INSERT INTO Reservation VALUES(82,82,'2005-03-21');
INSERT INTO Reservation VALUES(82,83,'2005-04-09');
INSERT INTO Reservation VALUES(83,84,'2005-04-28');
INSERT INTO Reservation VALUES(85,86,'2005-06-05');
INSERT INTO Reservation VALUES(87,87,'2005-06-24');
INSERT INTO Reservation VALUES(87,88,'2005-07-13');
INSERT INTO Reservation VALUES(88,89,'2005-08-01');
INSERT INTO Reservation VALUES(90,91,'2005-09-08');
INSERT INTO Reservation VALUES(92,92,'2005-09-27');
INSERT INTO Reservation VALUES(92,93,'2005-10-16');
INSERT INTO Reservation VALUES(93,94,'2005-11-04');
INSERT INTO Reservation VALUES(95,96,'2005-12-12');
INSERT INTO Reservation VALUES(97,97,'2005-12-31');
INSERT INTO Reservation VALUES(97,98,'2006-01-19');
INSERT INTO Reservation VALUES(98,99,'2006-02-07');
INSERT INTO Reservation VALUES(100,101,'2006-03-17');
INSERT INTO Reservation VALUES(102,102,'2006-04-05');
INSERT INTO Reservation VALUES(102,103,'2006-04-24');
INSERT INTO Reservation VALUES(103,104,'2006-05-13');
INSERT INTO Reservation VALUES(105,106,'2006-06-20');
INSERT INTO Reservation VALUES(107,107,'2006-07-09');
INSERT INTO Reservation VALUES(107,108,'2006-07-28');
INSERT INTO Reservation VALUES(108,109,'2006-08-16');
INSERT INTO Reservation VALUES(110,111,'2006-09-23');
INSERT INTO Reservation VALUES(112,112,'2006-10-12');
INSERT INTO Reservation VALUES(112,113,'2006-10-31');
INSERT INTO Reservation VALUES(113,114,'2006-11-19');
INSERT INTO Reservation VALUES(115,116,'2006-12-27');
INSERT INTO Reservation VALUES(117,117,'2007-01-15');
INSERT INTO Reservation VALUES(117,118,'2007-02-03');
INSERT INTO Reservation VALUES(118,119,'2007-02-22');
INSERT INTO Reservation VALUES(120,121,'2007-04-01');
INSERT INTO Reservation VALUES(122,122,'2007-04-20');
INSERT INTO Reservation VALUES(122,123,'2007-05-09');
INSERT INTO Reservation VALUES(123,124,'2007-05-28');
INSERT INTO Reservation VALUES(125,126,'2007-07-05');
INSERT INTO Reservation VALUES(127,127,'2007-07-24');
INSERT INTO Reservation VALUES(127,128,'2007-08-12');
INSERT INTO Reservation VALUES(128,129,'2007-08-31');
INSERT INTO Reservation VALUES(130,131,'2007-10-08');
INSERT INTO Reservation VALUES(132,132,'2007-10-27');
INSERT INTO Reservation VALUES(132,133,'2007-11-15');
INSERT INTO Reservation VALUES(133,134,'2007-12-04');
INSERT INTO Reservation VALUES(135,136,'2008-01-11');
INSERT INTO Reservation VALUES(137,137,'2008-01-30');
INSERT INTO Reservation VALUES(137,138,'2008-02-18');
INSERT INTO Reservation VALUES(138,139,'2008-03-08');
INSERT INTO Reservation VALUES(140,141,'2008-04-15');
INSERT INTO Reservation VALUES(142,142,'2008-05-04');
INSERT INTO Reservation VALUES(142,143,'2008-05-23');
INSERT INTO Reservation VALUES(143,144,'2008-06-11');
INSERT INTO Reservation VALUES(145,146,'2008-07-19');
INSERT INTO Reservation VALUES(147,147,'2008-08-07');
INSERT INTO Reservation VALUES(147,148,'2008-08-26');
INSERT INTO Reservation VALUES(148,149,'2008-09-14');
INSERT INTO Reservation VALUES(150,151,'2008-10-22');
INSERT INTO Reservation VALUES(152,152,'2008-11-10');
INSERT INTO Reservation VALUES(152,153,'2008-11-29');
INSERT INTO Reservation VALUES(153,154,'2008-12-18');
INSERT INTO Reservation VALUES(155,156,'2009-01-25');
INSERT INTO Reservation VALUES(157,157,'2009-02-13');
INSERT INTO Reservation VALUES(157,158,'2009-03-04');
INSERT INTO Reservation VALUES(158,159,'2009-03-23');
INSERT INTO Reservation VALUES(160,161,'2009-04-30');
INSERT INTO Reservation VALUES(162,162,'2009-05-19');
INSERT INTO Reservation VALUES(162,163,'2009-06-07');
INSERT INTO Reservation VALUES(163,164,'2009-06-26');
INSERT INTO Reservation VALUES(165,166,'2009-08-03');
INSERT INTO Reservation VALUES(167,167,'2009-08-22');
INSERT INTO Reservation VALUES(167,168,'2009-09-10');
INSERT INTO Reservation VALUES(168,169,'2009-09-29');
INSERT INTO Reservation VALUES(170,171,'2009-11-06');
INSERT INTO Reservation VALUES(172,172,'2009-11-25');
INSERT INTO Reservation VALUES(172,173,'2009-12-14');
INSERT INTO Reservation VALUES(173,174,'2010-01-02');
INSERT INTO Reservation VALUES(175,176,'2010-02-09');
INSERT INTO Reservation VALUES(177,177,'2010-02-28');
INSERT INTO Reservation VALUES(177,178,'2010-03-19');
INSERT INTO Reservation VALUES(178,179,'2010-04-07');
INSERT INTO Reservation VALUES(180,181,'2010-05-15');
INSERT INTO Reservation VALUES(182,182,'2010-06-03');
INSERT INTO Reservation VALUES(182,183,'2010-06-22');
INSERT INTO Reservation VALUES(183,184,'2010-07-11');
INSERT INTO Reservation VALUES(185,186,'2010-08-18');
INSERT INTO Reservation VALUES(187,187,'2010-09-06');
INSERT INTO Reservation VALUES(187,188,'2010-09-25');
INSERT INTO Reservation VALUES(188,189,'2010-10-14');
INSERT INTO Reservation VALUES(190,191,'2010-11-21');
INSERT INTO Reservation VALUES(192,192,'2010-12-10');
INSERT INTO Reservation VALUES(192,193,'2010-12-29');
INSERT INTO Reservation VALUES(193,194,'2011-01-17');
INSERT INTO Reservation VALUES(195,196,'2011-02-24');
INSERT INTO Reservation VALUES(197,197,'2011-03-15');
INSERT INTO Reservation VALUES(197,198,'2011-04-03');
INSERT INTO Reservation VALUES(198,199,'2011-04-22');
INSERT INTO Reservation VALUES(200,201,'2011-05-30');
INSERT INTO Reservation VALUES(202,202,'2011-06-18');
INSERT INTO Reservation VALUES(202,203,'2011-07-07');
INSERT INTO Reservation VALUES(203,204,'2011-07-26');
INSERT INTO Reservation VALUES(205,206,'2011-09-02');
INSERT INTO Reservation VALUES(207,207,'2011-09-21');
INSERT INTO Reservation VALUES(207,208,'2011-10-10');
INSERT INTO Reservation VALUES(208,209,'2011-10-29');
INSERT INTO Reservation VALUES(210,211,'2011-12-06');
INSERT INTO Reservation VALUES(212,212,'2011-12-25');
INSERT INTO Reservation VALUES(212,213,'2012-01-13');
INSERT INTO Reservation VALUES(213,214,'2012-02-01');
INSERT INTO Reservation VALUES(215,216,'2012-03-10');
INSERT INTO Reservation VALUES(217,217,'2012-03-29');
INSERT INTO Reservation VALUES(217,218,'2012-04-17');
INSERT INTO Reservation VALUES(218,219,'2012-05-06');

GO
