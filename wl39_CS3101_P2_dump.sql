-- MySQL dump 10.19  Distrib 10.3.28-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: wl39_CS3101_P2_dump
-- ------------------------------------------------------
-- Server version	10.3.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `court`
--

DROP TABLE IF EXISTS `court`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `court` (
  `number` int(10) unsigned NOT NULL,
  `venue_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `surface` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`number`,`venue_name`),
  KEY `court_FK` (`venue_name`),
  CONSTRAINT `court_FK` FOREIGN KEY (`venue_name`) REFERENCES `venue` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `court`
--

LOCK TABLES `court` WRITE;
/*!40000 ALTER TABLE `court` DISABLE KEYS */;
INSERT INTO `court` VALUES (1,'East Sands Leisure Centre','hardcourt'),(1,'Forthill Lawn Tennis Club','clay'),(1,'University Sports Centre','hardcourt'),(1,'Waterstone Crook Sports Centre','grass'),(2,'East Sands Leisure Centre','hardcourt'),(2,'Forthill Lawn Tennis Club','clay'),(2,'University Sports Centre','hardcourt'),(2,'Waterstone Crook Sports Centre','grass'),(3,'East Sands Leisure Centre','grass'),(3,'Forthill Lawn Tennis Club','grass'),(3,'University Sports Centre','hardcourt'),(3,'Waterstone Crook Sports Centre','hardcourt'),(4,'East Sands Leisure Centre','grass'),(4,'Forthill Lawn Tennis Club','grass'),(4,'University Sports Centre','grass'),(4,'Waterstone Crook Sports Centre','hardcourt'),(5,'East Sands Leisure Centre','grass'),(5,'Forthill Lawn Tennis Club','hardcourt'),(5,'University Sports Centre','grass'),(6,'East Sands Leisure Centre','clay'),(6,'Forthill Lawn Tennis Club','hardcourt'),(6,'University Sports Centre','clay'),(7,'University Sports Centre','clay');
/*!40000 ALTER TABLE `court` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wl39`@`%`*/ /*!50003 TRIGGER `court_BINS` BEFORE INSERT ON `court` FOR EACH ROW
BEGIN
	IF `new`.`surface` NOT IN ('grass', 'clay', 'hardcourt') THEN 
		SIGNAL SQLSTATE '45001' SET message_text='Bad surface value.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `played_match`
--

DROP TABLE IF EXISTS `played_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `played_match` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p1_email` varchar(100) COLLATE utf8_bin NOT NULL,
  `p2_email` varchar(100) COLLATE utf8_bin NOT NULL,
  `date_played` date NOT NULL,
  `court_number` int(10) unsigned NOT NULL,
  `venue_name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `played_match_FK` (`p1_email`),
  KEY `played_match_FK_1` (`p2_email`),
  KEY `played_match_FK_2` (`venue_name`),
  KEY `played_match_FK_3` (`court_number`,`venue_name`),
  CONSTRAINT `played_match_FK` FOREIGN KEY (`p1_email`) REFERENCES `player` (`email`),
  CONSTRAINT `played_match_FK_1` FOREIGN KEY (`p2_email`) REFERENCES `player` (`email`),
  CONSTRAINT `played_match_FK_2` FOREIGN KEY (`venue_name`) REFERENCES `venue` (`name`),
  CONSTRAINT `played_match_FK_3` FOREIGN KEY (`court_number`, `venue_name`) REFERENCES `court` (`number`, `venue_name`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `played_match`
--

LOCK TABLES `played_match` WRITE;
/*!40000 ALTER TABLE `played_match` DISABLE KEYS */;
INSERT INTO `played_match` VALUES (2,'lmt@st-andrews.ac.uk','moham@gmail.com','2022-04-08',2,'University Sports Centre'),(3,'rfj@st-andrews.ac.uk','hs223@st-andrews.ac.uk','2022-03-20',2,'Waterstone Crook Sports Centre'),(4,'hs223@st-andrews.ac.uk','lmt@st-andrews.ac.uk','2022-04-11',1,'East Sands Leisure Centre'),(5,'hs223@st-andrews.ac.uk','lmt@st-andrews.ac.uk','2022-04-11',1,'East Sands Leisure Centre'),(6,'hs223@st-andrews.ac.uk','lmt@st-andrews.ac.uk','2022-04-11',1,'East Sands Leisure Centre'),(7,'hs223@st-andrews.ac.uk','lmt@st-andrews.ac.uk','2022-04-11',1,'East Sands Leisure Centre'),(8,'hs223@st-andrews.ac.uk','lmt@st-andrews.ac.uk','2022-04-11',1,'East Sands Leisure Centre'),(13,'hs223@st-andrews.ac.uk','iwg6852@gmail.com','2022-04-20',1,'East Sands Leisure Centre'),(14,'moham@gmail.com','iwg6852@gmail.com','2022-04-20',4,'Waterstone Crook Sports Centre'),(22,'jwh@hotmail.com','tabitha.stacey@gmail.com','2018-04-05',1,'University Sports Centre'),(23,'louis.payne@gmail.com','final_fantasy_freak1993@hotmail.com','2018-04-11',3,'University Sports Centre'),(24,'jwh@hotmail.com','sylvia.hathaway@gmail.com','2018-04-17',1,'University Sports Centre'),(25,'louis.payne@gmail.com','jwh@hotmail.com','2018-05-07',3,'University Sports Centre'),(26,'tabitha.stacey@gmail.com','final_fantasy_freak1993@hotmail.com','2018-05-23',2,'Forthill Lawn Tennis Club'),(27,'sylvia.hathaway@gmail.com','tabitha.stacey@gmail.com','2018-05-25',2,'Waterstone Crook Sports Centre'),(28,'louis.payne@gmail.com','tabitha.stacey@gmail.com','2018-05-28',1,'University Sports Centre'),(29,'final_fantasy_freak1993@hotmail.com','sylvia.hathaway@gmail.com','2018-06-13',1,'University Sports Centre'),(30,'jwh@hotmail.com','final_fantasy_freak1993@hotmail.com','2018-06-21',1,'University Sports Centre'),(31,'sylvia.hathaway@gmail.com','louis.payne@gmail.com','2018-07-09',3,'University Sports Centre'),(32,'srrogers@yahoo.co.uk','tasha.marsden@gmail.com','2018-09-30',1,'Waterstone Crook Sports Centre'),(33,'gary_the_man@yahoo.co.uk','u_marsden@gmail.com','2018-10-28',2,'Forthill Lawn Tennis Club'),(34,'srrogers@yahoo.co.uk','u_marsden@gmail.com','2018-11-02',1,'Waterstone Crook Sports Centre'),(35,'gary_the_man@yahoo.co.uk','tasha.marsden@gmail.com','2018-11-04',4,'Waterstone Crook Sports Centre'),(36,'tasha.marsden@gmail.com','u_marsden@gmail.com','2018-11-06',2,'Forthill Lawn Tennis Club'),(37,'gary_the_man@yahoo.co.uk','srrogers@yahoo.co.uk','2018-11-09',2,'Waterstone Crook Sports Centre'),(38,'tabitha.stacey@gmail.com','butch@xyz.club','2019-04-11',1,'University Sports Centre'),(39,'butch@xyz.club','final_fantasy_freak1993@hotmail.com','2019-04-12',1,'University Sports Centre'),(40,'sylvia.hathaway@gmail.com','butch@xyz.club','2019-04-16',3,'University Sports Centre'),(41,'gary_the_man@yahoo.co.uk','tabitha.stacey@gmail.com','2019-04-19',1,'University Sports Centre'),(42,'jwh@hotmail.com','sylvia.hathaway@gmail.com','2019-04-24',2,'Waterstone Crook Sports Centre'),(43,'gary_the_man@yahoo.co.uk','final_fantasy_freak1993@hotmail.com','2019-04-30',2,'Waterstone Crook Sports Centre'),(44,'sylvia.hathaway@gmail.com','final_fantasy_freak1993@hotmail.com','2019-05-03',4,'Waterstone Crook Sports Centre'),(45,'tabitha.stacey@gmail.com','final_fantasy_freak1993@hotmail.com','2019-05-13',3,'University Sports Centre'),(46,'jwh@hotmail.com','final_fantasy_freak1993@hotmail.com','2019-05-21',3,'University Sports Centre'),(47,'gary_the_man@yahoo.co.uk','sylvia.hathaway@gmail.com','2019-06-06',4,'Waterstone Crook Sports Centre'),(48,'tabitha.stacey@gmail.com','sylvia.hathaway@gmail.com','2019-06-28',1,'University Sports Centre'),(49,'jwh@hotmail.com','tabitha.stacey@gmail.com','2019-07-15',2,'Waterstone Crook Sports Centre'),(50,'jwh@hotmail.com','gary_the_man@yahoo.co.uk','2019-07-17',1,'University Sports Centre'),(51,'jwh@hotmail.com','butch@xyz.club','2019-07-22',1,'University Sports Centre'),(52,'gary_the_man@yahoo.co.uk','butch@xyz.club','2019-07-26',1,'University Sports Centre'),(53,'tasha.marsden@gmail.com','u_marsden@gmail.com','2019-09-27',2,'Waterstone Crook Sports Centre'),(54,'srrogers@yahoo.co.uk','u_marsden@gmail.com','2019-09-29',2,'Waterstone Crook Sports Centre'),(55,'gary_the_man@yahoo.co.uk','tasha.marsden@gmail.com','2019-09-29',4,'Waterstone Crook Sports Centre'),(56,'srrogers@yahoo.co.uk','tasha.marsden@gmail.com','2019-10-02',1,'Forthill Lawn Tennis Club'),(57,'gary_the_man@yahoo.co.uk','srrogers@yahoo.co.uk','2019-10-09',1,'Waterstone Crook Sports Centre'),(58,'gary_the_man@yahoo.co.uk','u_marsden@gmail.com','2019-10-30',3,'University Sports Centre'),(59,'tabitha.stacey@gmail.com','butch@xyz.club','2020-05-05',1,'Waterstone Crook Sports Centre'),(60,'butch@xyz.club','sylvia.hathaway@gmail.com','2020-05-15',2,'Waterstone Crook Sports Centre'),(61,'gary_the_man@yahoo.co.uk','sylvia.hathaway@gmail.com','2020-05-26',1,'East Sands Leisure Centre'),(62,'tabitha.stacey@gmail.com','sylvia.hathaway@gmail.com','2020-05-28',1,'East Sands Leisure Centre'),(63,'tabitha.stacey@gmail.com','gary_the_man@yahoo.co.uk','2020-07-03',2,'East Sands Leisure Centre'),(64,'butch@xyz.club','gary_the_man@yahoo.co.uk','2020-07-06',3,'University Sports Centre'),(65,'tasha.marsden@gmail.com','u_marsden@gmail.com','2020-10-02',1,'Waterstone Crook Sports Centre'),(66,'gary_the_man@yahoo.co.uk','tasha.marsden@gmail.com','2020-10-09',2,'Waterstone Crook Sports Centre'),(67,'gary_the_man@yahoo.co.uk','u_marsden@gmail.com','2020-11-05',1,'Forthill Lawn Tennis Club');
/*!40000 ALTER TABLE `played_match` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wl39`@`%`*/ /*!50003 TRIGGER `match_BINS` BEFORE INSERT ON `played_match` FOR EACH ROW
BEGIN
	IF TIMESTAMPDIFF(DAY, CURDATE(), `new`.`date_played`) > 0 THEN 
		SIGNAL SQLSTATE '45001' SET message_text='Bad date of birth.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `played_set`
--

DROP TABLE IF EXISTS `played_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `played_set` (
  `match_id` int(10) unsigned NOT NULL,
  `set_number` int(10) unsigned NOT NULL,
  `p1_games_won` int(10) unsigned NOT NULL,
  `p2_games_won` int(10) unsigned NOT NULL,
  PRIMARY KEY (`match_id`,`set_number`),
  CONSTRAINT `played_set_FK` FOREIGN KEY (`match_id`) REFERENCES `played_match` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `played_set`
--

LOCK TABLES `played_set` WRITE;
/*!40000 ALTER TABLE `played_set` DISABLE KEYS */;
INSERT INTO `played_set` VALUES (2,1,5,7),(2,2,7,3),(2,3,1,7),(3,1,7,2),(3,2,6,7),(3,3,5,7),(4,1,7,5),(5,1,7,5),(6,1,7,5),(7,1,7,5),(7,2,5,7),(7,3,5,7),(8,1,7,5),(8,2,5,7),(8,3,5,7),(13,1,7,5),(13,2,5,7),(13,3,7,5),(14,1,7,5),(14,2,5,7),(14,3,7,6),(22,1,7,6),(22,2,1,6),(22,3,6,3),(23,1,6,4),(23,2,6,0),(24,1,2,6),(24,2,7,6),(24,3,6,0),(25,1,0,6),(25,2,6,7),(26,1,6,4),(26,2,3,6),(26,3,3,6),(27,1,3,6),(27,2,1,6),(28,1,6,4),(28,2,2,6),(28,3,5,7),(29,1,5,7),(29,2,0,6),(30,1,6,0),(30,2,6,3),(31,1,6,0),(31,2,5,7),(31,3,6,7),(32,1,6,7),(32,2,2,6),(33,1,0,6),(33,2,6,3),(33,3,3,6),(34,1,7,5),(34,2,6,3),(35,1,6,4),(35,2,6,7),(35,3,6,2),(36,1,3,6),(36,2,0,6),(37,1,0,6),(37,2,6,1),(37,3,3,6),(38,1,4,6),(38,2,6,3),(38,3,4,6),(39,1,6,7),(39,2,6,4),(39,3,6,1),(40,1,0,6),(40,2,0,6),(41,1,7,5),(41,2,6,4),(42,1,0,6),(42,2,1,6),(43,1,5,7),(43,2,6,0),(43,3,6,2),(44,1,5,7),(44,2,7,5),(44,3,7,5),(45,1,6,7),(45,2,6,1),(45,3,4,6),(46,1,6,7),(46,2,0,6),(47,1,6,4),(47,2,3,6),(47,3,6,3),(48,1,4,6),(48,2,3,6),(49,1,2,6),(49,2,4,6),(50,1,6,3),(50,2,3,6),(50,3,6,4),(51,1,6,3),(51,2,2,6),(51,3,6,7),(52,1,3,6),(52,2,2,6),(53,1,6,2),(53,2,6,4),(54,1,6,4),(54,2,5,7),(54,3,0,6),(55,1,4,6),(55,2,6,3),(55,3,5,7),(56,1,6,0),(56,2,0,6),(56,3,4,6),(57,1,6,0),(57,2,1,6),(57,3,7,6),(58,1,6,4),(58,2,6,2),(59,1,4,6),(59,2,2,6),(60,1,6,4),(60,2,5,7),(60,3,6,7),(61,1,6,0),(61,2,6,3),(62,1,6,4),(62,2,6,4),(63,1,3,6),(63,2,7,6),(63,3,6,0),(64,1,7,6),(64,2,6,7),(64,3,4,6),(65,1,6,2),(65,2,6,7),(65,3,4,6),(66,1,7,6),(66,2,7,6),(67,1,6,4),(67,2,6,7),(67,3,6,3);
/*!40000 ALTER TABLE `played_set` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wl39`@`%`*/ /*!50003 TRIGGER `set_BINS` BEFORE INSERT ON `played_set` FOR EACH ROW
BEGIN
	IF (`new`.`set_number` < 1 OR `new`.`set_number` > 3 ) THEN 
		SIGNAL SQLSTATE '45001' SET message_text='Bad set number.';
	END IF;

	IF (`new`.`p1_games_won` = `new`.`p2_games_won`)  THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad set score';
	END IF;

	IF (`new`.`p1_games_won` > 7 OR `new`.`p1_games_won` < 0)  THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad player 1 score Should less than 7';
	END IF;

	IF (`new`.`p2_games_won` > 7 OR `new`.`p2_games_won` < 0)  THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad player 2 score Should less than 7';
	END IF;

	IF  (`new`.`p1_games_won` = 7 AND `new`.`p2_games_won` < 5 )  THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad player score.';
	END IF;

	IF  (`new`.`p2_games_won` = 7 AND `new`.`p1_games_won` < 5 )  THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad player score';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `email` varchar(100) COLLATE utf8_bin NOT NULL,
  `forename` varchar(100) COLLATE utf8_bin NOT NULL,
  `middlenames` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `surname` varchar(100) COLLATE utf8_bin NOT NULL,
  `date_of_birth` date NOT NULL,
  `elo` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES ('butch@xyz.club','Jamie','Eugene,Korey','Butcher','1985-09-21',1115),('final_fantasy_freak1993@hotmail.com','Kirsten','Aileen,Louise','Jackman','1993-10-28',937),('gary_the_man@yahoo.co.uk','Gary','Carl','Marsden','1985-10-12',1060),('hs223@st-andrews.ac.uk','Hanbee','Holly','Seo','2001-03-20',1000),('iwg6852@gmail.com','Wankyu','','Lim','1996-04-20',1000),('jwh@hotmail.com','Jeremy','Wardell','Huddleston','1991-02-13',1114),('leighton.buzzard@gmail.com','Leighton','Alan','Buzzard','1980-05-17',1000),('lmt@st-andrews.ac.uk','Torpey','Mirka','Louis','1982-05-16',1000),('louis.payne@gmail.com','Louis','Kennard','Payne','2000-05-31',996),('mad_maddy@gmail.com','Madeleine','','Daubney','1991-03-08',1000),('moham@gmail.com','Zayed','Abdulla,King','Mohamed','1997-12-19',1000),('rfj@st-andrews.ac.uk','Roger','Fedra','Jeremy','1981-08-08',1000),('srrogers@yahoo.co.uk','Sue','Rosemary','Rogers','1965-07-30',964),('sylvia.hathaway@gmail.com','Sylvia','Loraine','Hathaway','2004-01-02',932),('tabitha.stacey@gmail.com','Tabitha','','Stacey','2005-09-10',922),('tasha.marsden@gmail.com','Natasha','Joy,Bernardette,Louise','Marsden','1960-04-28',1010),('u_marsden@gmail.com','Ulysses','','Marsden','1977-05-07',1000);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wl39`@`%`*/ /*!50003 TRIGGER `player_BINS` BEFORE INSERT ON `player` FOR EACH ROW
BEGIN
	IF TIMESTAMPDIFF(DAY, CURDATE(), `new`.`date_of_birth`) > 0 THEN 
		SIGNAL SQLSTATE '45001' SET message_text='Bad date of birth.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player_phone`
--

DROP TABLE IF EXISTS `player_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_phone` (
  `email` varchar(100) COLLATE utf8_bin NOT NULL,
  `phone_number` varchar(100) COLLATE utf8_bin NOT NULL,
  `phone_type` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  KEY `player_phone_FK` (`email`),
  CONSTRAINT `player_phone_FK` FOREIGN KEY (`email`) REFERENCES `player` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_phone`
--

LOCK TABLES `player_phone` WRITE;
/*!40000 ALTER TABLE `player_phone` DISABLE KEYS */;
INSERT INTO `player_phone` VALUES ('rfj@st-andrews.ac.uk','07494684968','mobile'),('rfj@st-andrews.ac.uk','07575694752','mobile'),('moham@gmail.com','07648653178','home'),('hs223@st-andrews.ac.uk','07783183430','home'),('rfj@st-andrews.ac.uk','08319874583','home'),('lmt@st-andrews.ac.uk','07840233645','home'),('iwg6852@gmail.com','07840233645','mobile'),('iwg6852@gmail.com','07742587597','work'),('jwh@hotmail.com','01314960470','home'),('tabitha.stacey@gmail.com','07837585417','mobile'),('srrogers@yahoo.co.uk','07700900949','mobile'),('final_fantasy_freak1993@hotmail.com','07700900909','mobile'),('sylvia.hathaway@gmail.com','07700900939','mobile'),('louis.payne@gmail.com','07700900654','mobile'),('u_marsden@gmail.com','01314960745','home'),('gary_the_man@yahoo.co.uk','01514960777','home'),('butch@xyz.club','07969438448','mobile'),('leighton.buzzard@gmail.com','01174960714','home'),('leighton.buzzard@gmail.com','01314960962','work'),('mad_maddy@gmail.com','02079460501','home'),('mad_maddy@gmail.com','01154960961','work'),('tasha.marsden@gmail.com','07889344229','mobile');
/*!40000 ALTER TABLE `player_phone` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wl39`@`%`*/ /*!50003 TRIGGER `phone_number_BINS` BEFORE INSERT ON `player_phone` FOR EACH ROW
BEGIN
	IF `new`.`phone_type` NOT IN ('mobile', 'work', 'home') THEN 
		SIGNAL SQLSTATE '45002' SET message_text='Bad phone type.';
	END IF;
	IF (`new`.`phone_number` REGEXP '^[0-9]{11}$') = 0 THEN 
		SIGNAL SQLSTATE '45001' SET message_text='Bad phone number.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venue` (
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `address` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES ('East Sands Leisure Centre','2 St Mary St, St Andrews KY16 8LH'),('Forthill Lawn Tennis Club','20 Forthill Road, Broughty Ferry, Dundee DD5 3SR'),('Old Course Sports Centre','KY16 9SS'),('University Sports Centre','9 St Leonard’s Rd, St Andrews KY16 9DY'),('Waterstone Crook Sports Centre','69 Kirk Rd, Newport-on-Tay DD6 8HY');
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_contact_details`
--

DROP TABLE IF EXISTS `view_contact_details`;
/*!50001 DROP VIEW IF EXISTS `view_contact_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_contact_details` (
  `full_name` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `phone_numbers` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_grass_courts`
--

DROP TABLE IF EXISTS `view_grass_courts`;
/*!50001 DROP VIEW IF EXISTS `view_grass_courts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_grass_courts` (
  `number` tinyint NOT NULL,
  `venue_name` tinyint NOT NULL,
  `address` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_match_with_winner`
--

DROP TABLE IF EXISTS `view_match_with_winner`;
/*!50001 DROP VIEW IF EXISTS `view_match_with_winner`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_match_with_winner` (
  `id` tinyint NOT NULL,
  `p1_email` tinyint NOT NULL,
  `p2_email` tinyint NOT NULL,
  `date_played` tinyint NOT NULL,
  `court_number` tinyint NOT NULL,
  `venue_name` tinyint NOT NULL,
  `GET_WIN_OF_MATCH(id)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_match_with_winner_surface`
--

DROP TABLE IF EXISTS `view_match_with_winner_surface`;
/*!50001 DROP VIEW IF EXISTS `view_match_with_winner_surface`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_match_with_winner_surface` (
  `id` tinyint NOT NULL,
  `p1_email` tinyint NOT NULL,
  `p2_email` tinyint NOT NULL,
  `date_played` tinyint NOT NULL,
  `court_number` tinyint NOT NULL,
  `venue_name` tinyint NOT NULL,
  `surface` tinyint NOT NULL,
  `GET_WIN_OF_MATCH(id)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_player_details`
--

DROP TABLE IF EXISTS `view_player_details`;
/*!50001 DROP VIEW IF EXISTS `view_player_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_player_details` (
  `full_name` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `date_of_birth` tinyint NOT NULL,
  `elo` tinyint NOT NULL,
  `phone_numbers` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_win_count`
--

DROP TABLE IF EXISTS `view_win_count`;
/*!50001 DROP VIEW IF EXISTS `view_win_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_win_count` (
  `email` tinyint NOT NULL,
  `elo` tinyint NOT NULL,
  `win_count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'wl39_CS3101_P2_dump'
--
/*!50003 DROP FUNCTION IF EXISTS `GET_FULL_NAME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wl39`@`%` FUNCTION `GET_FULL_NAME`(EMAIL VARCHAR(100)) RETURNS varchar(100) CHARSET utf8 COLLATE utf8_bin
BEGIN
	DECLARE USER_SURNAME VARCHAR(100);
	DECLARE USER_MIDDLENAMES VARCHAR(100);
	DECLARE USER_FORENAME VARCHAR(100);

	DECLARE USER_FULLNAME VARCHAR(100);

	SELECT surname, middlenames, forename INTO USER_SURNAME, USER_MIDDLENAMES, USER_FORENAME FROM wl39_CS3101_P2_dump.player p WHERE p.email = EMAIL;

	SET USER_MIDDLENAMES = REPLACE(USER_MIDDLENAMES, ',', ' ');

	SET USER_FULLNAME = CONCAT_WS(' ', USER_FORENAME, USER_MIDDLENAMES, USER_SURNAME) ;

	RETURN USER_FULLNAME;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GET_PHONE_NUMBERS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wl39`@`%` FUNCTION `GET_PHONE_NUMBERS`(EMAIL VARCHAR(100)) RETURNS varchar(100) CHARSET utf8 COLLATE utf8_bin
BEGIN
	DECLARE USER_PHONE_NUMBERS VARCHAR(100);
	DECLARE INT_PHONE_NUMBERS INT;
	SELECT phone_number INTO USER_PHONE_NUMBERS FROM wl39_CS3101_P2_dump.player_phone pp WHERE pp.email = EMAIL;


	RETURN USER_PHONE_NUMBERS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GET_WIN_OF_MATCH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wl39`@`%` FUNCTION `GET_WIN_OF_MATCH`(USER_MATCH_ID INT(10) UNSIGNED) RETURNS varchar(100) CHARSET utf8 COLLATE utf8_bin
BEGIN
	DECLARE P1_SCORE INT(10);
	DECLARE P2_SCORE INT(10);
	DECLARE USER_P1_EMAIL VARCHAR(100);
	DECLARE USER_P2_EMAIL VARCHAR(100);

	SELECT p1_email, p2_email INTO USER_P1_EMAIL, USER_P2_EMAIL FROM wl39_CS3101_P2_dump.played_match pm WHERE pm.id = USER_MATCH_ID;

	SELECT COUNT(*) INTO P1_SCORE FROM wl39_CS3101_P2_dump.played_match pm INNER JOIN wl39_CS3101_P2_dump.played_set ps ON id = match_id WHERE id = USER_MATCH_ID AND ps.p1_games_won > ps.p2_games_won ;
	SELECT COUNT(*) INTO P2_SCORE FROM wl39_CS3101_P2_dump.played_match pm INNER JOIN wl39_CS3101_P2_dump.played_set ps ON id = match_id WHERE id = USER_MATCH_ID AND ps.p2_games_won > ps.p1_games_won ;

	IF P1_SCORE > P2_SCORE THEN
		RETURN USER_P1_EMAIL;
	ELSE
		RETURN USER_P2_EMAIL;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `WIN_COUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wl39`@`%` FUNCTION `WIN_COUNT`(EMAIL VARCHAR(100)) RETURNS int(10)
BEGIN
	
	DECLARE WIN_COUNT INT(10);
	
	SELECT COUNT(*) INTO WIN_COUNT FROM played_match pm WHERE EMAIL = GET_WIN_OF_MATCH(id);

	RETURN WIN_COUNT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_add_match` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wl39`@`%` PROCEDURE `proc_add_match`(EMAIL_1 VARCHAR(100), EMAIL_2 VARCHAR(100), MATCH_DATE VARCHAR(100), USER_VENUE_NAME VARCHAR(100), USER_COURT_NUMBER INT(10) UNSIGNED, SET_NUMBER_1 INT(10) UNSIGNED, SET1_P1_SCORE INT(10) UNSIGNED, SET1_P2_SCORE INT(10) UNSIGNED, SET_NUMBER_2 INT(10) UNSIGNED, SET2_P1_SCORE INT(10) UNSIGNED, SET2_P2_SCORE INT(10) UNSIGNED, SET_NUMBER_3 INT(10) UNSIGNED, SET3_P1_SCORE INT(10) UNSIGNED, SET3_P2_SCORE INT(10) UNSIGNED )
BEGIN
	DECLARE P1_SCORE, P2_SCORE INT(10) UNSIGNED DEFAULT 0;
	DECLARE P1_ELO INT(10) DEFAULT 0;
	DECLARE P2_ELO INT(10) DEFAULT 0;
	DECLARE MATCH_ID INT(10) UNSIGNED DEFAULT 0;

	IF EMAIL_1 = EMAIL_2 THEN
		SIGNAL SQLSTATE '45005' SET message_text='Player 1 and Player 2 have to be different.';
	END IF;

	IF SET1_P1_SCORE = SET1_P2_SCORE THEN 
		SIGNAL SQLSTATE '45004' SET message_text='Scores cannot be same 1';
	END IF;

	IF SET1_P1_SCORE > SET1_P2_SCORE THEN
		SET P1_SCORE = P1_SCORE + 1;
	ELSE
		SET P2_SCORE = P2_SCORE + 1;
	END IF;

	IF SET_NUMBER_2 IS NOT NULL THEN
		IF SET2_P1_SCORE = SET2_P2_SCORE THEN 
			SIGNAL SQLSTATE '45004' SET message_text='Scores cannot be same 2';
		END IF;
		IF SET2_P1_SCORE > SET2_P2_SCORE THEN
			SET P1_SCORE = P1_SCORE + 1;
		ELSE
			SET P2_SCORE = P2_SCORE + 1;
		END IF;
	
	END IF;

	IF SET_NUMBER_3 IS NOT NULL THEN
		IF SET3_P1_SCORE = SET3_P2_SCORE THEN 
			SIGNAL SQLSTATE '45004' SET message_text='Scores cannot be same 3';
		END IF;
	
		IF SET3_P1_SCORE > SET3_P2_SCORE THEN
			SET P1_SCORE = P1_SCORE + 1;
		ELSE
			SET P2_SCORE = P2_SCORE + 1;
		END IF;
	
	END IF;

	IF P1_SCORE = P2_SCORE THEN
		SIGNAL SQLSTATE '45001' SET message_text='Bad match sets.';
	END IF;

	INSERT INTO wl39_CS3101_P2_dump.played_match (p1_email, p2_email, date_played, venue_name , court_number) VALUES (EMAIL_1, EMAIL_2, MATCH_DATE, USER_VENUE_NAME, USER_COURT_NUMBER);

	SELECT id INTO MATCH_ID FROM wl39_CS3101_P2_dump.played_match pm ORDER BY pm.id DESC LIMIT 1;

	INSERT INTO wl39_CS3101_P2_dump.played_set (match_id, set_number, p1_games_won, p2_games_won) VALUES (MATCH_ID, SET_NUMBER_1, SET1_P1_SCORE, SET1_P2_SCORE);

	IF SET_NUMBER_2 IS NOT NULL THEN
		INSERT INTO wl39_CS3101_P2_dump.played_set (match_id, set_number, p1_games_won, p2_games_won) VALUES (MATCH_ID, SET_NUMBER_2, SET2_P1_SCORE, SET2_P2_SCORE);
	END IF;

	IF SET_NUMBER_3 IS NOT NULL THEN
		INSERT INTO wl39_CS3101_P2_dump.played_set (match_id, set_number, p1_games_won, p2_games_won) VALUES (MATCH_ID, SET_NUMBER_3, SET3_P1_SCORE, SET3_P2_SCORE);
	END IF;


	SELECT elo INTO P1_ELO FROM wl39_CS3101_P2_dump.player p WHERE p.email = EMAIL_1;
	SELECT elo INTO P2_ELO FROM wl39_CS3101_P2_dump.player p WHERE p.email = EMAIL_2;

	IF P1_SCORE > P2_SCORE THEN
		SET P1_ELO = P1_ELO + ROUND(40 * (1 - 1/(1+POW(10, ((P2_ELO - P1_ELO) / 400)))));
		SET P2_ELO = P2_ELO - ROUND(40 * (1 - 1/(1+POW(10, ((P2_ELO - P1_ELO) / 400)))));
	ELSE
		SET P1_ELO = P1_ELO - ROUND(40 * (1 - 1/(1+POW(10, ((P2_ELO - P1_ELO) / 400)))));
		SET P2_ELO = P2_ELO + ROUND(40 * (1 - 1/(1+POW(10, ((P2_ELO - P1_ELO) / 400)))));
	END IF;

	UPDATE wl39_CS3101_P2_dump.player SET elo = P1_ELO WHERE email = EMAIL_1;
	UPDATE wl39_CS3101_P2_dump.player SET elo = P2_ELO WHERE email = EMAIL_2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_contact_details`
--

/*!50001 DROP TABLE IF EXISTS `view_contact_details`*/;
/*!50001 DROP VIEW IF EXISTS `view_contact_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_contact_details` AS select `wl39_CS3101_P2_dump`.`GET_FULL_NAME`(`p`.`email`) AS `full_name`,`p`.`email` AS `email`,group_concat(`pp`.`phone_number` separator ',') AS `phone_numbers` from (`player` `p` join `player_phone` `pp` on(`p`.`email` = `pp`.`email`)) group by `p`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_grass_courts`
--

/*!50001 DROP TABLE IF EXISTS `view_grass_courts`*/;
/*!50001 DROP VIEW IF EXISTS `view_grass_courts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_grass_courts` AS select `c`.`number` AS `number`,`c`.`venue_name` AS `venue_name`,`v`.`address` AS `address` from (`court` `c` join `venue` `v` on(`c`.`venue_name` = `v`.`name`)) where `c`.`surface` = 'grass' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_match_with_winner`
--

/*!50001 DROP TABLE IF EXISTS `view_match_with_winner`*/;
/*!50001 DROP VIEW IF EXISTS `view_match_with_winner`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_match_with_winner` AS select `played_match`.`id` AS `id`,`played_match`.`p1_email` AS `p1_email`,`played_match`.`p2_email` AS `p2_email`,`played_match`.`date_played` AS `date_played`,`played_match`.`court_number` AS `court_number`,`played_match`.`venue_name` AS `venue_name`,`GET_WIN_OF_MATCH`(`played_match`.`id`) AS `GET_WIN_OF_MATCH(id)` from `played_match` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_match_with_winner_surface`
--

/*!50001 DROP TABLE IF EXISTS `view_match_with_winner_surface`*/;
/*!50001 DROP VIEW IF EXISTS `view_match_with_winner_surface`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_match_with_winner_surface` AS select `pm`.`id` AS `id`,`pm`.`p1_email` AS `p1_email`,`pm`.`p2_email` AS `p2_email`,`pm`.`date_played` AS `date_played`,`pm`.`court_number` AS `court_number`,`c`.`venue_name` AS `venue_name`,`c`.`surface` AS `surface`,`wl39_CS3101_P2_dump`.`GET_WIN_OF_MATCH`(`pm`.`id`) AS `GET_WIN_OF_MATCH(id)` from (`played_match` `pm` join `court` `c` on(`pm`.`court_number` = `c`.`number` and `pm`.`venue_name` = `c`.`venue_name`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_player_details`
--

/*!50001 DROP TABLE IF EXISTS `view_player_details`*/;
/*!50001 DROP VIEW IF EXISTS `view_player_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_player_details` AS select `wl39_CS3101_P2_dump`.`GET_FULL_NAME`(`p`.`email`) AS `full_name`,`p`.`email` AS `email`,`p`.`date_of_birth` AS `date_of_birth`,`p`.`elo` AS `elo`,group_concat(`pp`.`phone_number` separator ',') AS `phone_numbers` from (`player` `p` join `player_phone` `pp` on(`p`.`email` = `pp`.`email`)) group by `p`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_win_count`
--

/*!50001 DROP TABLE IF EXISTS `view_win_count`*/;
/*!50001 DROP VIEW IF EXISTS `view_win_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_bin */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`wl39`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_win_count` AS select `p`.`email` AS `email`,`p`.`elo` AS `elo`,`wl39_CS3101_P2_dump`.`WIN_COUNT`(`p`.`email`) AS `win_count` from `player` `p` order by `p`.`elo` desc,`p`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-14  4:07:56
