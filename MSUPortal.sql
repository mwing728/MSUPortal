-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: MSUPortal
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

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
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Login` (
  `Email` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `EmpType` varchar(1) DEFAULT NULL,
  KEY `Email` (`Email`),
  CONSTRAINT `Email` FOREIGN KEY (`Email`) REFERENCES `Registration` (`Email`) ON DELETE CASCADE,
  CONSTRAINT `Login_ibfk_1` FOREIGN KEY (`Email`) REFERENCES `Registration` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES ('testAdmin@gmail.com','$5$rounds=535000$Guy3sVdLO.klQn3Q$TkXlwsoSZlIxXfY4.NroECYEAKkAmzVtHart0..EEr8','A'),('testUser@gmail.com','$5$rounds=535000$n2jpio8baoARo0Fa$VuztFcnjhohTg9XsjxW6siNxPvL7z3rE.B8ozShH469','C');
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Questions` (
  `question` varchar(255) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Date` date NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email` (`Email`),
  CONSTRAINT `Questions_ibfk_1` FOREIGN KEY (`Email`) REFERENCES `Registration` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questions`
--

LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` VALUES ('How are you doing','testAdmin@gmail.com','2019-06-04',13,'I am well'),('Whats your name','testAdmin@gmail.com','2019-06-04',14,'The name is Matt');
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registration`
--

DROP TABLE IF EXISTS `Registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registration` (
  `FirstName` varchar(25) NOT NULL,
  `LastName` varchar(25) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `EmpType` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registration`
--

LOCK TABLES `Registration` WRITE;
/*!40000 ALTER TABLE `Registration` DISABLE KEYS */;
INSERT INTO `Registration` VALUES ('testAdmin','Admin','testAdmin@gmail.com','$5$rounds=535000$Guy3sVdLO.klQn3Q$TkXlwsoSZlIxXfY4.NroECYEAKkAmzVtHart0..EEr8','A'),('testUser','User','testUser@gmail.com','$5$rounds=535000$n2jpio8baoARo0Fa$VuztFcnjhohTg9XsjxW6siNxPvL7z3rE.B8ozShH469','C');
/*!40000 ALTER TABLE `Registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teachers`
--

DROP TABLE IF EXISTS `Teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teachers` (
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(8000) DEFAULT NULL,
  `msupages` varchar(8000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teachers`
--

LOCK TABLES `Teachers` WRITE;
/*!40000 ALTER TABLE `Teachers` DISABLE KEYS */;
INSERT INTO `Teachers` VALUES ('James Benham','benhamj@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/319/user/benham_0001.jpg.0.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=benhamj'),('George Antoniou','antonioug@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/318/user/me_new_0001.jpg.0.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=antonioug'),('Boxiang Dong','dongb@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/8953/user/dongb2.jpeg.1.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=dongb'),('Anna Feldman','feldmana@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/1279/user/af.png.1.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=feldmana'),('Christopher Leberknight','leberknightc@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/5712/user/2eb9dc3bc75046f393d6bf6132d278a6.png.1.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=leberknightc'),('Dawei Li','lida@montclair.edu','https://www.montclair.edu/responsive-media/cache/profilepages/media/8826/user/photome3forlinkedin.png.1.1x.generic.jpg','https://www.montclair.edu/profilepages/view_profile.php?username=lida');
/*!40000 ALTER TABLE `Teachers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-06 20:43:48
