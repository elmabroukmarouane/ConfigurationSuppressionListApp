-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: exactarget
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `clickers`
--

DROP TABLE IF EXISTS `clickers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clickers` (
  `id_Click` int(11) NOT NULL AUTO_INCREMENT,
  `id_Send_Click` int(11) DEFAULT NULL,
  `id_Email_Click` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Click`)
) ENGINE=MyISAM AUTO_INCREMENT=512051 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clickers`
--

LOCK TABLES `clickers` WRITE;
/*!40000 ALTER TABLE `clickers` DISABLE KEYS */;
/*!40000 ALTER TABLE `clickers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id_Country` int(11) NOT NULL AUTO_INCREMENT,
  `name_Country` varchar(250) DEFAULT NULL,
  `flag_Country` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_Country`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'USA','USA.jpg'),(2,'UK','UK.jpg'),(3,'AU','Australia.png');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creatives`
--

DROP TABLE IF EXISTS `creatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creatives` (
  `id_Creative` int(11) NOT NULL AUTO_INCREMENT,
  `name_Creative` varchar(250) DEFAULT NULL,
  `id_Offer_Creative` int(11) DEFAULT NULL,
  `isUnsub_Creativ` tinyint(1) NOT NULL,
  `cptClick_Creative` int(11) DEFAULT NULL,
  `cptLead_Creative` int(11) DEFAULT NULL,
  `cptUnsub_Creative` int(11) DEFAULT '0',
  PRIMARY KEY (`id_Creative`),
  KEY `fk_offer` (`id_Offer_Creative`)
) ENGINE=MyISAM AUTO_INCREMENT=1271 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creatives`
--

LOCK TABLES `creatives` WRITE;
/*!40000 ALTER TABLE `creatives` DISABLE KEYS */;
INSERT INTO `creatives` VALUES (1268,'yRVVc.',554,0,0,0,0),(1269,'5Pkzv.',555,0,0,0,0),(1270,'ST5lV.',556,0,0,0,0);
/*!40000 ALTER TABLE `creatives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `id_Domain` int(11) NOT NULL AUTO_INCREMENT,
  `name_Domain` varchar(250) DEFAULT NULL,
  `saleDate_Domaine` date DEFAULT NULL,
  `expirationDate_Domain` date DEFAULT NULL,
  `id_Domain_Provider_Domain` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Domain`),
  KEY `fk_domain` (`id_Domain_Provider_Domain`)
) ENGINE=MyISAM AUTO_INCREMENT=1547 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES (1542,'bakinajo.us','2018-07-03','2019-07-03',3),(1543,'sub1.bakinajo.us','2018-07-03','2013-07-03',3),(1544,'sub2.bakinajo.us','2018-07-03','2019-07-03',3),(1545,'sub3.bakinajo.us','2018-07-03','2019-07-03',3),(1546,'sub4.bakinajo.us','2018-07-03','2019-07-03',3);
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domainprovider`
--

DROP TABLE IF EXISTS `domainprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domainprovider` (
  `id_DomainProvider` int(11) NOT NULL AUTO_INCREMENT,
  `name_DomainProvider` varchar(250) DEFAULT NULL,
  `note_DomainProvider` varchar(500) DEFAULT NULL,
  `website_DomainProvider` varchar(250) DEFAULT NULL,
  `logo_DomainProvider` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_DomainProvider`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domainprovider`
--

LOCK TABLES `domainprovider` WRITE;
/*!40000 ALTER TABLE `domainprovider` DISABLE KEYS */;
INSERT INTO `domainprovider` VALUES (3,'Domain Provider 1','Domain Provider','www.domain.com','Domain Provider 1.');
/*!40000 ALTER TABLE `domainprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `id_Email` int(11) NOT NULL AUTO_INCREMENT,
  `email_Email` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName_Email` varchar(250) DEFAULT NULL,
  `lastName_Email` varchar(250) DEFAULT NULL,
  `dob_Email` varchar(250) DEFAULT NULL,
  `state_Email` varchar(250) DEFAULT NULL,
  `id_List_Email` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Email`),
  UNIQUE KEY `email_Email` (`email_Email`),
  KEY `fk_emailList` (`id_List_Email`),
  KEY `email_Email_2` (`email_Email`),
  KEY `email_Email_3` (`email_Email`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
INSERT INTO `email` VALUES (1,'badrelomari40a@gmail.com',NULL,NULL,NULL,NULL,2),(2,'lisha.sperry824@gmail.com',NULL,NULL,NULL,NULL,2),(3,'marcolimas339@gmail.com',NULL,NULL,NULL,NULL,2),(4,'omarbren.37@gmail.com',NULL,NULL,NULL,NULL,2),(5,'khalidben444@gmail.com',NULL,NULL,NULL,NULL,2),(6,'bedmor470@gmail.com',NULL,NULL,NULL,NULL,2),(7,'kyleeara715@gmail.com',NULL,NULL,NULL,NULL,2),(8,'chanellebok839@gmail.com',NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_list_warmup`
--

DROP TABLE IF EXISTS `email_list_warmup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_list_warmup` (
  `id_employer` int(11) NOT NULL,
  `id_email` int(11) NOT NULL,
  `password_email` varchar(1500) NOT NULL,
  PRIMARY KEY (`id_employer`,`id_email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_list_warmup`
--

LOCK TABLES `email_list_warmup` WRITE;
/*!40000 ALTER TABLE `email_list_warmup` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_list_warmup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer`
--

DROP TABLE IF EXISTS `employer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employer` (
  `id_Employer` int(11) NOT NULL AUTO_INCREMENT,
  `firstName_Employer` varchar(250) DEFAULT NULL,
  `lastName_Employer` varchar(250) DEFAULT NULL,
  `dob_Employer` date DEFAULT NULL,
  `dateIn_Employer` date DEFAULT NULL,
  `dateOut_Employer` date DEFAULT NULL,
  `salaire_Employer` double DEFAULT NULL,
  `id_type_Employer_Employer` int(11) DEFAULT NULL,
  `password_Employer` varchar(250) DEFAULT NULL,
  `id_Isp_Employer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Employer`),
  KEY `fk_type` (`id_type_Employer_Employer`),
  KEY `fk_ispEmployer` (`id_Isp_Employer`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer`
--

LOCK TABLES `employer` WRITE;
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer` VALUES (51,NULL,NULL,'2017-04-24','2017-04-24','2017-04-24',NULL,NULL,NULL,NULL),(53,'baderB','baderB','2018-06-19','2018-06-19','2018-06-19',0,1,'baderB',37);
/*!40000 ALTER TABLE `employer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experience`
--

DROP TABLE IF EXISTS `experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experience` (
  `id_Experience` int(11) NOT NULL AUTO_INCREMENT,
  `id_Employer_Experience` int(11) DEFAULT NULL,
  `dateBegin_Experience` date DEFAULT NULL,
  `dateEnd_Experience` date DEFAULT NULL,
  `id_Type_Employer_Experience` int(11) DEFAULT NULL,
  `id_Isp_Experience` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Experience`),
  KEY `fk_ispExper` (`id_Isp_Experience`),
  KEY `fk_employer` (`id_Employer_Experience`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

LOCK TABLES `experience` WRITE;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` VALUES (47,51,'2017-04-24',NULL,NULL,NULL),(48,52,'2017-04-24',NULL,1,37),(49,53,'2018-06-19',NULL,1,37);
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `froms`
--

DROP TABLE IF EXISTS `froms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `froms` (
  `id_From` int(11) NOT NULL AUTO_INCREMENT,
  `text_From` varchar(250) DEFAULT NULL,
  `id_Offer_From` int(11) DEFAULT NULL,
  `cptOpen_From` int(11) DEFAULT NULL,
  `cptClick_From` int(11) DEFAULT NULL,
  `cptLead_From` int(11) DEFAULT NULL,
  `cptUnsub_From` int(11) DEFAULT '0',
  PRIMARY KEY (`id_From`),
  KEY `fk_offer` (`id_Offer_From`)
) ENGINE=MyISAM AUTO_INCREMENT=6890 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `froms`
--

LOCK TABLES `froms` WRITE;
/*!40000 ALTER TABLE `froms` DISABLE KEYS */;
INSERT INTO `froms` VALUES (6887,'from',554,0,0,0,0),(6888,'fdsfdsfds',555,0,0,0,0),(6889,'LoveSwans',556,0,0,0,0);
/*!40000 ALTER TABLE `froms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip`
--

DROP TABLE IF EXISTS `ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip` (
  `id_IP` int(11) NOT NULL AUTO_INCREMENT,
  `IP_IP` varchar(250) DEFAULT NULL,
  `id_Domain_IP` int(11) DEFAULT NULL,
  `id_Server_IP` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_IP`),
  KEY `fk_server` (`id_Server_IP`)
) ENGINE=MyISAM AUTO_INCREMENT=1469 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip`
--

LOCK TABLES `ip` WRITE;
/*!40000 ALTER TABLE `ip` DISABLE KEYS */;
INSERT INTO `ip` VALUES (1464,'50.116.4.206',1542,283);
/*!40000 ALTER TABLE `ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `isp`
--

DROP TABLE IF EXISTS `isp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isp` (
  `id_Isp` int(11) NOT NULL AUTO_INCREMENT,
  `name_isp` varchar(250) DEFAULT NULL,
  `logo_isp` varchar(250) DEFAULT NULL,
  `is_free_isp` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_Isp`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `isp`
--

LOCK TABLES `isp` WRITE;
/*!40000 ALTER TABLE `isp` DISABLE KEYS */;
INSERT INTO `isp` VALUES (1,'gmail','gmail.jpg',1),(2,'aol','aol.png',1),(3,'warm up','warm up.png',1),(5,'hotmail','hotmail.jpg',1),(6,'comcast','comcast.jpg',1),(7,'cox','cox.png',1),(8,'icloud','iCloud.jpg',1),(9,'att','att.jpg',1),(10,'yahoo','Yahoo.jpg',1),(11,'gmx','gmx.png',1),(12,'juno','juno.png',1),(13,'netzero','netzero.png',1),(14,'verizon','virizon.png',1),(15,'bellsouth','bellsouth.gif',1),(16,'sbcglobal','sbcglobal.gif',1),(17,'btinternet','btinternet.gif',1),(18,'virgin','virgin.png',1),(19,'teee','te.jpg',0),(20,'roadrunner','roadrunner.gif',1),(21,'talktalk','talktalk.jpg',0),(36,'Publisher','',0),(37,'All','',0),(38,'Samples','',0);
/*!40000 ALTER TABLE `isp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list` (
  `id_List` int(11) NOT NULL AUTO_INCREMENT,
  `name_List` varchar(250) DEFAULT NULL,
  `id_Country_List` int(11) DEFAULT NULL,
  `isActive_List` tinyint(1) DEFAULT NULL,
  `id_Type_List` int(11) DEFAULT NULL,
  `id_ISP_List` int(11) DEFAULT NULL,
  `isOptIN_List` tinyint(1) DEFAULT NULL,
  `fields_List` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_List`),
  KEY `fk_countryList` (`id_Country_List`),
  KEY `fk_typeList` (`id_Type_List`),
  KEY `fk_ISP` (`id_ISP_List`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (1,'gmail tracking test',1,1,1,1,0,''),(2,'gmail tracking test',1,1,2,1,0,''),(3,'gmail tracking test',1,1,3,1,0,''),(4,'gmail tracking test',1,1,4,1,0,''),(5,'gmail tracking test',1,1,5,1,0,'');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `negative`
--

DROP TABLE IF EXISTS `negative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `negative` (
  `id_negative` int(11) NOT NULL AUTO_INCREMENT,
  `name_negative` varchar(250) DEFAULT NULL,
  `file_negative` varchar(250) DEFAULT NULL,
  `id_mailer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_negative`)
) ENGINE=MyISAM AUTO_INCREMENT=476 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negative`
--

LOCK TABLES `negative` WRITE;
/*!40000 ALTER TABLE `negative` DISABLE KEYS */;
/*!40000 ALTER TABLE `negative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id_Notification` int(11) NOT NULL AUTO_INCREMENT,
  `text_Notification` text,
  PRIMARY KEY (`id_Notification`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_mailer`
--

DROP TABLE IF EXISTS `notification_mailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_mailer` (
  `id_notification_mailer` int(11) NOT NULL AUTO_INCREMENT,
  `id_notification` int(11) DEFAULT NULL,
  `id_mailer` int(11) DEFAULT NULL,
  `is_Readed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_notification_mailer`)
) ENGINE=MyISAM AUTO_INCREMENT=185 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_mailer`
--

LOCK TABLES `notification_mailer` WRITE;
/*!40000 ALTER TABLE `notification_mailer` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_mailer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer` (
  `id_offer` int(11) NOT NULL AUTO_INCREMENT,
  `name_Offer` varchar(250) DEFAULT NULL,
  `id_Sponsor_Offer` int(11) DEFAULT NULL,
  `id_Country_Offer` varchar(250) DEFAULT NULL,
  `isActive_Offer` tinyint(1) DEFAULT NULL,
  `isSensitive_Offer` tinyint(1) DEFAULT NULL,
  `link_Offer` varchar(250) DEFAULT NULL,
  `unsub_Offer` varchar(250) DEFAULT NULL,
  `suppressionFile_Offer` varchar(250) DEFAULT NULL,
  `notWorkingDays_Offer` varchar(250) DEFAULT NULL,
  `id_Vertical_Offer` int(11) NOT NULL,
  `TypeSuppressionFile_Offer` varchar(250) DEFAULT NULL,
  `sid_Offer` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_offer`),
  KEY `fk_sponsor` (`id_Sponsor_Offer`),
  KEY `fk_vertical` (`id_Vertical_Offer`)
) ENGINE=MyISAM AUTO_INCREMENT=557 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer`
--

LOCK TABLES `offer` WRITE;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
INSERT INTO `offer` VALUES (554,'Offer 1',12,'1',1,1,'www.google.com','www.google.com','sp12-554-84984-MD5.txt','',1,'MD5',84984),(555,'154 | bader  offer',12,'1',1,0,'http://206.189.199.100/exactarget/Offer/IU_Offer.php','http://206.189.199.100/exactarget/Offer/IU_Offer.php','sp12-555-154-MD5.txt','',7,'MD5',154),(556,'9599 -  LoveSwans',13,'1',1,0,'http://waybitz.com/199071ea81da211800/','http://waybitz.com/u199071ea81da211800/','sp13-556-9599-MD5.txt','',27,'MD5',9599);
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openers`
--

DROP TABLE IF EXISTS `openers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `openers` (
  `id_Open` int(11) NOT NULL AUTO_INCREMENT,
  `id_Send_Open` int(11) DEFAULT NULL,
  `id_Email_Open` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Open`)
) ENGINE=MyISAM AUTO_INCREMENT=8716329 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openers`
--

LOCK TABLES `openers` WRITE;
/*!40000 ALTER TABLE `openers` DISABLE KEYS */;
/*!40000 ALTER TABLE `openers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `os`
--

DROP TABLE IF EXISTS `os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `os` (
  `id_OS` int(11) NOT NULL AUTO_INCREMENT,
  `name_OS` varchar(250) DEFAULT NULL,
  `bit_OS` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_OS`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os`
--

LOCK TABLES `os` WRITE;
/*!40000 ALTER TABLE `os` DISABLE KEYS */;
INSERT INTO `os` VALUES (1,'Centos 6',64),(2,'test',80);
/*!40000 ALTER TABLE `os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plateform`
--

DROP TABLE IF EXISTS `plateform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plateform` (
  `id_plateform` int(11) NOT NULL AUTO_INCREMENT,
  `name_plateform` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id_plateform`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plateform`
--

LOCK TABLES `plateform` WRITE;
/*!40000 ALTER TABLE `plateform` DISABLE KEYS */;
INSERT INTO `plateform` VALUES (1,'HitPath'),(2,'Cake');
/*!40000 ALTER TABLE `plateform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seedadmin`
--

DROP TABLE IF EXISTS `seedadmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seedadmin` (
  `id_seedadmin` int(11) NOT NULL AUTO_INCREMENT,
  `id_isp` int(11) DEFAULT NULL,
  `email` text,
  PRIMARY KEY (`id_seedadmin`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seedadmin`
--

LOCK TABLES `seedadmin` WRITE;
/*!40000 ALTER TABLE `seedadmin` DISABLE KEYS */;
/*!40000 ALTER TABLE `seedadmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send`
--

DROP TABLE IF EXISTS `send`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `send` (
  `id_Send` int(11) NOT NULL AUTO_INCREMENT,
  `id_Offer_Send` int(11) NOT NULL,
  `id_ISP_Send` int(11) DEFAULT NULL,
  `id_Employer_Send` int(11) DEFAULT NULL,
  `header_Send` text,
  `body_Send` text,
  `emailTest_Send` text,
  `returnPath_Send` varchar(250) DEFAULT NULL,
  `IPS_Send` text,
  `id_From_Send` int(11) DEFAULT NULL,
  `id_Subject_Send` int(11) DEFAULT NULL,
  `id_Creative_Send` int(11) DEFAULT NULL,
  `startFrom_Send` int(11) NOT NULL DEFAULT '0',
  `cptReceived` int(11) DEFAULT '0',
  `cptDelivered` int(11) DEFAULT '0',
  `cptHardBounce` int(11) DEFAULT '0',
  `cptSoftBounce` int(11) DEFAULT '0',
  `isAR` tinyint(1) DEFAULT '0',
  `ARList` text,
  `is_Sender` tinyint(1) NOT NULL DEFAULT '0',
  `track_Sender` int(11) NOT NULL DEFAULT '0',
  `id_negative` int(11) DEFAULT NULL,
  `extra` text,
  `dateCreation` datetime DEFAULT NULL,
  PRIMARY KEY (`id_Send`)
) ENGINE=MyISAM AUTO_INCREMENT=4823 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send`
--

LOCK TABLES `send` WRITE;
/*!40000 ALTER TABLE `send` DISABLE KEYS */;
INSERT INTO `send` VALUES (4814,556,1,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1270,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-09 22:48:45'),(4815,556,1,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1270,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-09 22:54:14'),(4816,554,10,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/yRVVc.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1268,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-12 20:29:05'),(4817,555,10,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/5Pkzv.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1269,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-12 20:29:53'),(4818,556,1,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1270,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-15 18:40:03'),(4819,554,1,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/yRVVc.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,1268,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-15 18:40:46'),(4820,-1,1,53,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','','return@[domain]',NULL,-1,-1,0,0,0,0,0,0,0,'',0,0,0,NULL,'2018-07-15 18:47:04'),(4821,556,1,53,'fromName:dsd\r\nfromEmail: <contact@[domain]>\r\nsubject:tgf\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"https://i.imgur.com/Br2aUzf.png\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"https://i.imgur.com/ViMyjuW.jpg\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','omarbren.37@gmail.com','return@[domain]','212.71.233.71',6889,22033,1270,8,80,80,0,0,0,'',0,0,0,NULL,'2018-07-15 18:47:25'),(4822,556,1,53,'fromName:dsd\r\nfromEmail: <contact@[domain]>\r\nsubject:tgf\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"https://i.imgur.com/Br2aUzf.png\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"https://i.imgur.com/ViMyjuW.jpg\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>','omarbren.37@gmail.com','return@[domain]','212.71.233.71',6889,22033,1270,7,70,70,0,0,0,'',0,0,0,NULL,'2018-07-15 18:53:37');
/*!40000 ALTER TABLE `send` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send_history`
--

DROP TABLE IF EXISTS `send_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `send_history` (
  `id_Send` int(11) DEFAULT NULL,
  `header` text,
  `body` text,
  `id_send_history` int(11) NOT NULL AUTO_INCREMENT,
  `dateUpdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id_send_history`)
) ENGINE=MyISAM AUTO_INCREMENT=13919 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send_history`
--

LOCK TABLES `send_history` WRITE;
/*!40000 ALTER TABLE `send_history` DISABLE KEYS */;
INSERT INTO `send_history` VALUES (4814,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13910,'2018-07-09 22:48:45'),(4815,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13911,'2018-07-09 22:54:14'),(4816,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/yRVVc.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13912,'2018-07-12 20:29:05'),(4817,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/5Pkzv.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13913,'2018-07-12 20:29:53'),(4818,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13914,'2018-07-15 18:40:03'),(4819,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/yRVVc.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13915,'2018-07-15 18:40:46'),(4820,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13916,'2018-07-15 18:47:04'),(4821,'fromName:--\r\nfromEmail: <contact@[domain]>\r\nsubject:--\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"http://[domain]/ST5lV.\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"http://[domain]/\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13917,'2018-07-15 18:47:25'),(4821,'fromName:dsd\r\nfromEmail: <contact@[domain]>\r\nsubject:tgf\r\ndate:[date]\r\nto:[to]\r\nreply-to:<reply@[domain]>\r\ncontent-type:text/html;','<center>\r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]rr\">\r\n<img src=\"https://i.imgur.com/Br2aUzf.png\"/>\r\n</a>\r\n</center>\r\n	  \r\n\r\n<center>	  \r\n<a href=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idCreative][RandomC/2][idIP]uu\">\r\n<img src=\"https://i.imgur.com/ViMyjuW.jpg\"/>\r\n</a>\r\n</center>\r\n<br/><br/>\r\n<center>	  \r\n	  <img style=\"width:0px;height:0px;display:none;\" src=\"http://[domain]/[idSend][RandomC/2][idEmail][RandomC/2][idFrom][RandomC/2][idSubject][RandomC/2][idIP]=[sender]\"/>\r\n</center>',13918,'2018-07-15 18:50:28');
/*!40000 ALTER TABLE `send_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sender`
--

DROP TABLE IF EXISTS `sender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sender` (
  `id_Email` int(11) DEFAULT NULL,
  `sender` varchar(250) DEFAULT NULL,
  `id_ISP` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sender`
--

LOCK TABLES `sender` WRITE;
/*!40000 ALTER TABLE `sender` DISABLE KEYS */;
/*!40000 ALTER TABLE `sender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sendlist`
--

DROP TABLE IF EXISTS `sendlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sendlist` (
  `id_sendlist` int(11) NOT NULL AUTO_INCREMENT,
  `id_Send` int(11) DEFAULT NULL,
  `id_List` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sendlist`)
) ENGINE=MyISAM AUTO_INCREMENT=38161 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sendlist`
--

LOCK TABLES `sendlist` WRITE;
/*!40000 ALTER TABLE `sendlist` DISABLE KEYS */;
INSERT INTO `sendlist` VALUES (38152,4814,906),(38153,4815,911),(38154,4816,921),(38155,4817,921),(38156,4818,1),(38157,4819,1),(38158,4820,1),(38159,4821,1),(38160,4822,1);
/*!40000 ALTER TABLE `sendlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sendprocess`
--

DROP TABLE IF EXISTS `sendprocess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sendprocess` (
  `id_SendProcess` int(11) NOT NULL AUTO_INCREMENT,
  `id_Send` int(11) DEFAULT NULL,
  `host` varchar(250) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_SendProcess`)
) ENGINE=MyISAM AUTO_INCREMENT=112341 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sendprocess`
--

LOCK TABLES `sendprocess` WRITE;
/*!40000 ALTER TABLE `sendprocess` DISABLE KEYS */;
INSERT INTO `sendprocess` VALUES (112337,4821,'206.189.199.100',0),(112338,4821,'212.71.233.71',0),(112339,4822,'206.189.199.100',0),(112340,4822,'212.71.233.71',0);
/*!40000 ALTER TABLE `sendprocess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `id_Server` int(11) NOT NULL AUTO_INCREMENT,
  `alias_Server` varchar(250) DEFAULT NULL,
  `id_Server_Provider_Server` int(11) DEFAULT NULL,
  `username_Server` varchar(250) DEFAULT NULL,
  `password_Server` varchar(250) DEFAULT NULL,
  `saleDate_Server` date DEFAULT NULL,
  `expirationDate_Server` date DEFAULT NULL,
  `id_OS_Server` int(11) DEFAULT NULL,
  `id_IP_Server` int(11) DEFAULT NULL,
  `isActive_Server` tinyint(1) DEFAULT NULL,
  `isp_Server` varchar(500) DEFAULT NULL,
  `mailerYes_Server` varchar(500) DEFAULT NULL,
  `mailerNo_Server` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_Server`),
  KEY `fk_sprovider` (`id_Server_Provider_Server`),
  KEY `fk_os` (`id_OS_Server`)
) ENGINE=MyISAM AUTO_INCREMENT=284 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` VALUES (283,'Server 1 SMALL',30,'root','bader55!!','2018-07-03','2018-07-31',1,1464,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serverisp`
--

DROP TABLE IF EXISTS `serverisp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serverisp` (
  `id_Serverisp` int(11) NOT NULL AUTO_INCREMENT,
  `id_Server` int(11) DEFAULT NULL,
  `id_Isp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Serverisp`)
) ENGINE=MyISAM AUTO_INCREMENT=2799 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serverisp`
--

LOCK TABLES `serverisp` WRITE;
/*!40000 ALTER TABLE `serverisp` DISABLE KEYS */;
INSERT INTO `serverisp` VALUES (2795,283,1),(2796,283,2),(2797,283,18),(2798,283,37);
/*!40000 ALTER TABLE `serverisp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servermailer`
--

DROP TABLE IF EXISTS `servermailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servermailer` (
  `id_Servermailer` int(11) NOT NULL AUTO_INCREMENT,
  `id_Server` int(11) DEFAULT NULL,
  `id_Mailer` int(11) DEFAULT NULL,
  `is_Autorised` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_Servermailer`)
) ENGINE=MyISAM AUTO_INCREMENT=27309 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servermailer`
--

LOCK TABLES `servermailer` WRITE;
/*!40000 ALTER TABLE `servermailer` DISABLE KEYS */;
INSERT INTO `servermailer` VALUES (27308,283,53,1);
/*!40000 ALTER TABLE `servermailer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serverprovider`
--

DROP TABLE IF EXISTS `serverprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serverprovider` (
  `id_ServerProvider` int(11) NOT NULL AUTO_INCREMENT,
  `name_ServerProvider` varchar(250) DEFAULT NULL,
  `note_ServerProvider` varchar(500) DEFAULT NULL,
  `website_ServerProvider` varchar(250) DEFAULT NULL,
  `logo_ServerProvider` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_ServerProvider`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serverprovider`
--

LOCK TABLES `serverprovider` WRITE;
/*!40000 ALTER TABLE `serverprovider` DISABLE KEYS */;
INSERT INTO `serverprovider` VALUES (30,'Server Provider 1','Server Provider','www.server.com','Server Provider 1.');
/*!40000 ALTER TABLE `serverprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor` (
  `id_Sponsor` int(11) NOT NULL AUTO_INCREMENT,
  `name_Sponsor` varchar(250) DEFAULT NULL,
  `logo_Sponsor` varchar(250) DEFAULT NULL,
  `isActive_Sponsor` tinyint(1) DEFAULT NULL,
  `login_sponsor` varchar(255) DEFAULT NULL,
  `password_sponsor` varchar(255) DEFAULT NULL,
  `url_login_page_sponsor` varchar(255) DEFAULT NULL,
  `id_plateform_sponsor` int(11) NOT NULL,
  `api_access_key_sponsor` varchar(255) DEFAULT NULL,
  `api_host_url` varchar(3000) DEFAULT NULL,
  `affiliate_id_sponsor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Sponsor`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (12,'Sponsor 1','Sponsor 1.',1,'login','pass','www.google.com',1,'4984cqsd4v9sd45498v4sd98vs','www.google.com','123'),(13,'LoadSmooth','LoadSmooth.',1,'N/A','N/A','https://affiliate.loadsmooth.com',1,'6d94a1762ec9fcc63b8db6a8b8619bebc35b7fe77764fff472186346d6d52766','http://api.loadsmooth.com/pubapi.php','471576');
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor_employee`
--

DROP TABLE IF EXISTS `sponsor_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor_employee` (
  `id_sponsor` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  PRIMARY KEY (`id_sponsor`,`id_employee`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor_employee`
--

LOCK TABLES `sponsor_employee` WRITE;
/*!40000 ALTER TABLE `sponsor_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsor_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor_login_history`
--

DROP TABLE IF EXISTS `sponsor_login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor_login_history` (
  `id_sponsor_login_history` int(11) NOT NULL AUTO_INCREMENT,
  `id_sponsor` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  `date_login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_login` varchar(1500) NOT NULL,
  PRIMARY KEY (`id_sponsor_login_history`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor_login_history`
--

LOCK TABLES `sponsor_login_history` WRITE;
/*!40000 ALTER TABLE `sponsor_login_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsor_login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id_Subject` int(11) NOT NULL AUTO_INCREMENT,
  `text_Subject` varchar(250) DEFAULT NULL,
  `id_Offer_Subject` int(11) DEFAULT NULL,
  `cptOpen_Subject` int(11) DEFAULT NULL,
  `cptClick_Subject` int(11) DEFAULT NULL,
  `cptLead_Subject` int(11) DEFAULT NULL,
  `cptUnsub_Subject` int(11) DEFAULT '0',
  PRIMARY KEY (`id_Subject`),
  KEY `fk_offer` (`id_Offer_Subject`)
) ENGINE=MyISAM AUTO_INCREMENT=22050 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (22031,'subject',554,0,0,0,0),(22032,'sfddfsdfs',555,0,0,0,0),(22033,'Your search for a girl has ended',556,0,0,0,0),(22034,'The Search For Your Girl is Over!',556,0,0,0,0),(22035,'The Long Search For Love is Over!',556,0,0,0,0),(22036,'Looking For Love in All The Right Places',556,0,0,0,0),(22037,'Gorgeous Women Are Waiting to Meet You',556,0,0,0,0),(22038,'The Only Site With The Girl For You',556,0,0,0,0),(22039,'Ready to Meet Your Dream Girl?',556,0,0,0,0),(22040,'Beautiful Women Looking For Connections',556,0,0,0,0),(22041,'Beautiful Women Waiting to Connect',556,0,0,0,0),(22042,'Beautiful Women Looking For Connections',556,0,0,0,0),(22043,'Fed up with Fake Dating? Try this',556,0,0,0,0),(22044,'Tired of fake dating? Try this!',556,0,0,0,0),(22045,'Looking for a gorgeous woman?',556,0,0,0,0),(22046,'The Only Dating Site You Need',556,0,0,0,0),(22047,'The only site that gets you a girl',556,0,0,0,0),(22048,'The Search for Your Girl is Over',556,0,0,0,0),(22049,'You Don\'t Have to be Alone',556,0,0,0,0);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `subject_ticket` varchar(2500) NOT NULL,
  `id_ticket_status` int(11) NOT NULL,
  `id_user_ticket` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ticket`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (36,'welcome ',1,0),(37,'dddd',1,0),(38,'vzevzevz',1,0),(39,'',1,0);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_details`
--

DROP TABLE IF EXISTS `ticket_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_details` (
  `id_ticket_details` int(11) NOT NULL AUTO_INCREMENT,
  `id_ticket` int(11) NOT NULL,
  `date_ticket_details` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message_ticket_details` text NOT NULL,
  `is_support_answer` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_ticket_details`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_details`
--

LOCK TABLES `ticket_details` WRITE;
/*!40000 ALTER TABLE `ticket_details` DISABLE KEYS */;
INSERT INTO `ticket_details` VALUES (59,36,'2017-04-25 11:02:45','Hello, \r\n\r\nmalik mzaghab \r\n\r\nRegards.\r\n',1),(60,37,'2018-06-24 15:47:14','dddd',1),(61,38,'2018-06-24 15:47:27','vzevzevze',1),(62,39,'2018-07-03 14:12:23','',1);
/*!40000 ALTER TABLE `ticket_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_status`
--

DROP TABLE IF EXISTS `ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_status` (
  `id_ticket_status` int(11) NOT NULL AUTO_INCREMENT,
  `name_ticket_status` varchar(255) NOT NULL,
  PRIMARY KEY (`id_ticket_status`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_status`
--

LOCK TABLES `ticket_status` WRITE;
/*!40000 ALTER TABLE `ticket_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_employer`
--

DROP TABLE IF EXISTS `type_employer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_employer` (
  `id_type_Employer` int(11) NOT NULL AUTO_INCREMENT,
  `name_type_Employer` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_type_Employer`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_employer`
--

LOCK TABLES `type_employer` WRITE;
/*!40000 ALTER TABLE `type_employer` DISABLE KEYS */;
INSERT INTO `type_employer` VALUES (1,'Mailer'),(2,'Domains Manager'),(3,'Offer Manager');
/*!40000 ALTER TABLE `type_employer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typelist`
--

DROP TABLE IF EXISTS `typelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typelist` (
  `id_TypeList` int(11) NOT NULL AUTO_INCREMENT,
  `name_TypeList` varchar(250) DEFAULT NULL,
  `abr_TypeList` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_TypeList`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typelist`
--

LOCK TABLES `typelist` WRITE;
/*!40000 ALTER TABLE `typelist` DISABLE KEYS */;
INSERT INTO `typelist` VALUES (1,'Fresh','FRSH'),(2,'Delivered','DL'),(3,'Openers','OPNS'),(4,'Clickers','CLK'),(5,'Unsubcribers','UNSUB');
/*!40000 ALTER TABLE `typelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unsuboffer`
--

DROP TABLE IF EXISTS `unsuboffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unsuboffer` (
  `id_Email` int(11) NOT NULL DEFAULT '0',
  `id_Offer` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_Email`,`id_Offer`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unsuboffer`
--

LOCK TABLES `unsuboffer` WRITE;
/*!40000 ALTER TABLE `unsuboffer` DISABLE KEYS */;
/*!40000 ALTER TABLE `unsuboffer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unsubscribers`
--

DROP TABLE IF EXISTS `unsubscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unsubscribers` (
  `id_Unsub` int(11) NOT NULL AUTO_INCREMENT,
  `id_Send_Unsub` int(11) DEFAULT NULL,
  `id_Email_Unsub` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Unsub`)
) ENGINE=MyISAM AUTO_INCREMENT=2036467 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unsubscribers`
--

LOCK TABLES `unsubscribers` WRITE;
/*!40000 ALTER TABLE `unsubscribers` DISABLE KEYS */;
/*!40000 ALTER TABLE `unsubscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vertical`
--

DROP TABLE IF EXISTS `vertical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vertical` (
  `id_Vertical` int(11) NOT NULL AUTO_INCREMENT,
  `name_Vertical` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_Vertical`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vertical`
--

LOCK TABLES `vertical` WRITE;
/*!40000 ALTER TABLE `vertical` DISABLE KEYS */;
INSERT INTO `vertical` VALUES (1,'Diet/Weightloss'),(3,'Health/Beauty'),(4,'Promotional - US'),(5,'Surveys'),(7,'Mortgage/Refinance'),(8,'Miscellaneous'),(9,'Credit Report'),(10,'Biz Opp/MLM'),(12,'Auto Warranty'),(13,'Travel'),(14,'Cash Advance/PayDay Loan'),(15,'Debt/Personal Finance'),(16,'Health Insurance'),(17,'Education'),(18,'Home/Home Improvement'),(19,'Psychological'),(20,'Diabetes'),(21,'Advertorial'),(22,'TV/Entertainment'),(23,'Auto Financing'),(25,'Adult'),(26,'Email submit'),(27,'Dating'),(28,'International'),(29,'UK'),(31,'Seasonal'),(32,'One Time Purchase'),(34,'Automotive');
/*!40000 ALTER TABLE `vertical` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vl_clickers`
--

DROP TABLE IF EXISTS `vl_clickers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vl_clickers` (
  `id_Email` int(11) NOT NULL DEFAULT '0',
  `id_Isp` int(11) NOT NULL DEFAULT '0',
  `id_Vertical` int(11) NOT NULL DEFAULT '0',
  KEY `fk_i` (`id_Isp`),
  KEY `fk_v` (`id_Vertical`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vl_clickers`
--

LOCK TABLES `vl_clickers` WRITE;
/*!40000 ALTER TABLE `vl_clickers` DISABLE KEYS */;
/*!40000 ALTER TABLE `vl_clickers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vl_openers`
--

DROP TABLE IF EXISTS `vl_openers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vl_openers` (
  `id_Email` int(11) NOT NULL DEFAULT '0',
  `id_Isp` int(11) NOT NULL DEFAULT '0',
  `id_Vertical` int(11) NOT NULL DEFAULT '0',
  KEY `fk_i` (`id_Isp`),
  KEY `fk_v` (`id_Vertical`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vl_openers`
--

LOCK TABLES `vl_openers` WRITE;
/*!40000 ALTER TABLE `vl_openers` DISABLE KEYS */;
/*!40000 ALTER TABLE `vl_openers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vmta`
--

DROP TABLE IF EXISTS `vmta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmta` (
  `id_VMTA` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(250) DEFAULT NULL,
  `domain` varchar(500) DEFAULT NULL,
  `id_Mailer` int(11) DEFAULT NULL,
  `id_Server` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_VMTA`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vmta`
--

LOCK TABLES `vmta` WRITE;
/*!40000 ALTER TABLE `vmta` DISABLE KEYS */;
/*!40000 ALTER TABLE `vmta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-22 10:48:59
