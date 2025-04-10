CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping` (
  `shipping_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `carrier` varchar(50) DEFAULT NULL,
  `shipping_date` timestamp NULL DEFAULT NULL,
  `estimated_delivery` timestamp NULL DEFAULT NULL,
  `delivery_date` timestamp NULL DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  PRIMARY KEY (`shipping_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
INSERT INTO `shipping` VALUES (1,3,'FEDEX789123456','FedEx','2023-01-14 08:15:00','2023-01-19 12:30:00',NULL,'In Transit'),(2,4,'UPS321654987','UPS','2023-01-16 05:50:00','2023-01-21 12:30:00',NULL,'Processing'),(3,1,'UPS123456780','UPS','2022-12-05 04:00:00','2022-12-10 12:30:00','2022-12-09 08:45:00','Delivered'),(4,1,'UPS123456781','UPS','2022-11-15 08:30:00','2022-11-20 12:30:00','2022-11-18 05:15:00','Delivered'),(5,2,'FEDEX987654320','FedEx','2022-12-12 10:50:00','2022-12-17 12:30:00','2022-12-20 06:00:00','Delivered'),(6,2,'FEDEX987654322','FedEx','2022-11-22 05:15:00','2022-11-27 12:30:00',NULL,'Lost'),(7,3,'DHL456789120','DHL','2022-10-10 02:45:00','2022-10-20 12:30:00','2022-10-18 10:50:00','Delivered'),(8,4,'USPS321654980','USPS','2022-09-05 08:00:00','2022-09-15 12:30:00','2022-09-14 03:40:00','Delivered'),(9,5,'FEDEX_EXP123456','FedEx Express','2022-08-15 11:30:00','2022-08-17 06:30:00','2022-08-17 06:00:00','Delivered'),(10,5,'UPS_NEXTDAY789','UPS Next Day Air','2022-07-20 10:15:00','2022-07-21 05:00:00','2022-07-21 03:45:00','Delivered'),(11,1,'UPS_RETURN123','UPS','2023-01-16 04:30:00','2023-01-20 12:30:00',NULL,'Return in Transit'),(12,2,'FEDEX_RETURN456','FedEx','2023-01-17 09:00:00','2023-01-22 12:30:00','2023-01-21 09:30:00','Return Received'),(13,4,'USPS_RETURN789','USPS','2023-01-18 05:45:00','2023-01-25 12:30:00',NULL,'Return Processing');
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-10 15:33:34
