CREATE DATABASE  IF NOT EXISTS `buyme` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buyme`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: buyme
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alert_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `message` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`alert_id`,`username`),
  KEY `alert_username_fk_idx` (`username`),
  CONSTRAINT `alert_username_fk` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auction_id` int NOT NULL AUTO_INCREMENT,
  `manufacture_id` int NOT NULL,
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` datetime NOT NULL,
  `current_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `seller_username` varchar(50) DEFAULT NULL,
  `buyer_username` varchar(50) DEFAULT NULL,
  `hidden_minimum_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `minimum_bid_increment` decimal(10,2) NOT NULL DEFAULT '0.01',
  PRIMARY KEY (`auction_id`),
  KEY `buyer_username_fk_idx` (`buyer_username`),
  KEY `seller_username_fk_idx` (`seller_username`),
  KEY `manufacture_id_fk_idx` (`manufacture_id`),
  CONSTRAINT `buyer_username_fk` FOREIGN KEY (`buyer_username`) REFERENCES `users` (`username`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `manufacture_id_fk` FOREIGN KEY (`manufacture_id`) REFERENCES `clothes` (`manufacture_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `seller_username_fk` FOREIGN KEY (`seller_username`) REFERENCES `users` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES (2,1,'2023-08-05 17:38:44','2023-08-14 17:38:00',29.00,'matt',NULL,20.00,5.00),(3,3,'2023-08-05 17:51:05','2023-09-05 17:51:00',53.00,'matt',NULL,60.00,1.00),(4,2,'2023-08-05 17:51:21','2023-08-29 17:51:00',64.00,'matt',NULL,50.00,2.00),(5,1,'2023-08-07 13:03:44','2023-08-03 19:09:00',10.00,'matt','test6',7.00,1.00),(6,1,'2023-08-07 16:59:15','2023-08-23 20:59:00',14.00,'test5',NULL,6.00,1.00),(7,4,'2023-08-12 22:06:49','2023-08-13 12:06:00',40.00,'test6',NULL,20.00,5.00),(8,5,'2023-08-12 22:10:02','2023-08-13 10:09:00',65.00,'test6','test1@rut',35.00,10.00),(9,6,'2023-08-12 22:22:40','2023-08-13 08:22:00',61.00,'test1@rut',NULL,50.00,2.00),(10,7,'2023-08-12 22:35:00','2023-08-13 13:50:00',33.00,'test1@rut',NULL,22.00,1.00),(11,8,'2023-08-12 22:36:18','2023-08-16 22:36:00',35.00,'test1@rut',NULL,20.00,3.00),(12,9,'2023-08-12 22:38:54','2023-08-16 22:38:00',50.00,'test1@rut',NULL,40.00,1.00),(13,10,'2023-08-12 22:40:28','2023-08-13 13:15:00',52.00,'test1@rut',NULL,40.00,2.00),(14,11,'2023-08-12 22:43:29','2023-08-13 13:20:00',33.00,'test1@rut',NULL,20.00,3.00),(15,12,'2023-08-12 22:44:09','2023-08-14 22:44:00',43.00,'test1@rut',NULL,30.00,3.00),(16,13,'2023-08-13 11:37:12','2023-08-14 11:37:00',85.00,'test5',NULL,90.00,5.00),(17,14,'2023-08-13 12:58:28','2023-08-13 13:02:00',40.00,'test5',NULL,20.00,1.00);
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `bid_id` int NOT NULL,
  `auction_id` int NOT NULL,
  `bidder_username` varchar(50) NOT NULL DEFAULT 'root',
  `amount` decimal(10,2) DEFAULT '0.01',
  `bid_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bid_id`,`auction_id`,`bidder_username`),
  KEY `suction_id_fk_idx` (`auction_id`),
  KEY `bidder_username_fk_idx` (`bidder_username`),
  CONSTRAINT `auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bidder_username_fk` FOREIGN KEY (`bidder_username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,2,'test6',16.00,'2023-08-12 22:11:45'),(1,3,'test6',52.00,'2023-08-12 22:10:49'),(1,4,'test6',60.00,'2023-08-12 22:19:24'),(1,6,'matt',12.00,'2023-08-07 19:19:29'),(1,7,'test1@rut',35.00,'2023-08-12 22:29:30'),(1,8,'test1@rut',55.00,'2023-08-12 22:22:59'),(1,9,'matt',61.00,'2023-08-12 22:46:09'),(1,10,'matt',31.00,'2023-08-12 22:46:59'),(1,13,'matt',50.00,'2023-08-12 22:47:25'),(1,14,'matt',33.00,'2023-08-12 22:45:19'),(1,15,'test5',43.00,'2023-08-13 09:54:43'),(1,16,'matt',55.00,'2023-08-13 12:12:47'),(2,2,'test1@rut',23.00,'2023-08-12 22:25:23'),(2,3,'test1@rut',53.00,'2023-08-12 22:28:58'),(2,4,'test1@rut',62.00,'2023-08-12 22:32:51'),(2,6,'matt',13.00,'2023-08-07 19:20:46'),(2,7,'test1@rut',40.00,'2023-08-12 22:33:21'),(2,8,'test1@rut',65.00,'2023-08-12 22:24:44'),(2,10,'matt',33.00,'2023-08-12 22:47:12'),(2,13,'test5',52.00,'2023-08-13 12:48:48'),(2,16,'test1@rut',65.00,'2023-08-13 12:33:32'),(3,2,'test5',29.00,'2023-08-13 12:46:51'),(3,4,'test5',64.00,'2023-08-13 09:50:06'),(3,6,'test1@rut',14.00,'2023-08-12 22:28:19'),(3,16,'matt',70.00,'2023-08-13 12:43:58'),(4,16,'test1@rut',80.00,'2023-08-13 12:43:58'),(5,16,'matt',85.00,'2023-08-13 12:43:58');
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidsetting`
--

DROP TABLE IF EXISTS `bidsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidsetting` (
  `auction_id` int NOT NULL,
  `bidder_username` varchar(50) NOT NULL,
  `anonymousORnot` tinyint NOT NULL DEFAULT '0',
  `autobiddingORnot` tinyint NOT NULL DEFAULT '0',
  `autobid_upper_limit` decimal(10,2) NOT NULL DEFAULT '0.01',
  `autobid_increment` decimal(10,2) NOT NULL DEFAULT '0.01',
  PRIMARY KEY (`auction_id`,`bidder_username`),
  KEY `bidder_username_fk2_idx` (`bidder_username`),
  CONSTRAINT `auction_id_fk2` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bidder_username_fk2` FOREIGN KEY (`bidder_username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsetting`
--

LOCK TABLES `bidsetting` WRITE;
/*!40000 ALTER TABLE `bidsetting` DISABLE KEYS */;
INSERT INTO `bidsetting` VALUES (2,'test5',0,1,35.00,6.00),(13,'test5',0,1,54.00,2.00),(16,'matt',0,1,100.00,5.00),(16,'test1@rut',0,1,90.00,10.00);
/*!40000 ALTER TABLE `bidsetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bottoms`
--

DROP TABLE IF EXISTS `bottoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bottoms` (
  `manufacture_id` int NOT NULL,
  `type` enum('Activewear','Sweatpants','Jeans') NOT NULL,
  `waist_length` enum('XS','S','M','L','XL') NOT NULL,
  `rise_type` enum('High','Mid','Low') NOT NULL,
  PRIMARY KEY (`manufacture_id`),
  CONSTRAINT `manufacture_id_bottoms_fk` FOREIGN KEY (`manufacture_id`) REFERENCES `clothes` (`manufacture_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bottoms`
--

LOCK TABLES `bottoms` WRITE;
/*!40000 ALTER TABLE `bottoms` DISABLE KEYS */;
INSERT INTO `bottoms` VALUES (2,'Activewear','XS','High'),(6,'Sweatpants','L','Mid'),(7,'Jeans','M','High'),(9,'Jeans','M','High'),(12,'Jeans','M','Mid'),(13,'Activewear','XS','High');
/*!40000 ALTER TABLE `bottoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothes`
--

DROP TABLE IF EXISTS `clothes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clothes` (
  `manufacture_id` int NOT NULL AUTO_INCREMENT,
  `brand` enum('Adidas','Calvin Klein','Nike','Levis','Barbour','Birkenstock','Boden') NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `age` enum('Infants','Kids','Teenagers','Young Adults','30-50','60+') NOT NULL,
  PRIMARY KEY (`manufacture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothes`
--

LOCK TABLES `clothes` WRITE;
/*!40000 ALTER TABLE `clothes` DISABLE KEYS */;
INSERT INTO `clothes` VALUES (1,'Adidas','M','Infants'),(2,'Adidas','M','30-50'),(3,'Adidas','M','Infants'),(4,'Levis','F','Young Adults'),(5,'Birkenstock','M','Kids'),(6,'Barbour','M','Teenagers'),(7,'Calvin Klein','F','Teenagers'),(8,'Nike','M','Young Adults'),(9,'Boden','F','30-50'),(10,'Nike','M','Kids'),(11,'Birkenstock','F','Teenagers'),(12,'Levis','M','Young Adults'),(13,'Adidas','M','Infants'),(14,'Calvin Klein','M','Young Adults');
/*!40000 ALTER TABLE `clothes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `answer` varchar(100) DEFAULT NULL,
  `question` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `qid` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`qid`),
  KEY `username_fk_idx` (`username`),
  CONSTRAINT `username_fk` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES ('Yes','Do you sell this?','test1@rut',1),('No','Can I find this in red?','test5',2),('We accept Visa, Mastercard, Discover, and Amex','What payment methods do you accept?','matt',3),('We offer a 30 day money back guarantee','What is your return policy?','test1@rut',4);
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `footwear`
--

DROP TABLE IF EXISTS `footwear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `footwear` (
  `manufacture_id` int NOT NULL,
  `type_of_footwear` enum('Athletic shoes','Boots','Sneakers','Flats') NOT NULL,
  `size` enum('1','2','3','4','5','6','7','8','9','10','11') NOT NULL,
  `lace_color` enum('Black','Blue','Brown','Beige','Green','Red') NOT NULL,
  PRIMARY KEY (`manufacture_id`),
  CONSTRAINT `manufacture_id_footwear_fk` FOREIGN KEY (`manufacture_id`) REFERENCES `clothes` (`manufacture_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `footwear`
--

LOCK TABLES `footwear` WRITE;
/*!40000 ALTER TABLE `footwear` DISABLE KEYS */;
INSERT INTO `footwear` VALUES (3,'Athletic shoes','1','Black'),(5,'Flats','5','Beige'),(10,'Athletic shoes','1','Black'),(14,'Athletic shoes','1','Black');
/*!40000 ALTER TABLE `footwear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top`
--

DROP TABLE IF EXISTS `top`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `top` (
  `manufacture_id` int NOT NULL,
  `Neck_type` enum('High','Boat','Collared') NOT NULL,
  `size` enum('XS','S','M','L','XL') NOT NULL,
  `sleeve_length` enum('none','short','long','3/4') NOT NULL,
  PRIMARY KEY (`manufacture_id`),
  CONSTRAINT `manufacture_id_top_fk` FOREIGN KEY (`manufacture_id`) REFERENCES `clothes` (`manufacture_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top`
--

LOCK TABLES `top` WRITE;
/*!40000 ALTER TABLE `top` DISABLE KEYS */;
INSERT INTO `top` VALUES (1,'High','XS','none'),(4,'High','M','short'),(8,'Boat','L','short'),(11,'Boat','S','3/4');
/*!40000 ALTER TABLE `top` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_type` enum('END','CR','ADMIN') NOT NULL,
  `username` varchar(50) NOT NULL DEFAULT 'root',
  `password` varchar(50) NOT NULL DEFAULT 'root',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ADMIN','admin@cs','password123'),('END','matt','password999'),('END','test1@rut','password567'),('CR','test2@rut','password000'),('CR','test3@rut','password999'),('END','test5','password123'),('END','test6','password333');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-13 13:38:20
