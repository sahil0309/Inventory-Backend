CREATE DATABASE  IF NOT EXISTS `testing` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `testing`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: testing
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bill` (
  `billId` int(11) NOT NULL AUTO_INCREMENT,
  `dealerId` int(11) NOT NULL,
  `timeStamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amountPaid` decimal(10,4) NOT NULL,
  `labourCharges` decimal(10,4) DEFAULT NULL,
  `vehicleNumber` varchar(255) DEFAULT NULL,
  `amount` decimal(10,4) NOT NULL,
  `netGst` decimal(10,4) DEFAULT NULL,
  `totalAmount` decimal(10,4) NOT NULL,
  `balance` decimal(10,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`billId`),
  KEY `Bill_User_FK_idx` (`dealerId`),
  CONSTRAINT `BIll_Dealer_FK` FOREIGN KEY (`dealerId`) REFERENCES `dealer` (`dealerId`),
  CONSTRAINT `Bill_User_FK` FOREIGN KEY (`dealerId`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_product_detail`
--

DROP TABLE IF EXISTS `bill_product_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bill_product_detail` (
  `billProductId` int(11) NOT NULL AUTO_INCREMENT,
  `billId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `totalCostPrice` decimal(15,2) NOT NULL,
  `totalSellingPrice` decimal(15,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cgst` decimal(10,4) DEFAULT NULL,
  `sgst` decimal(10,4) DEFAULT NULL,
  `igst` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`billProductId`),
  KEY `BillProduct_Bill_FK_idx` (`billId`),
  KEY `BillProduct_Product_FK_idx` (`productId`),
  CONSTRAINT `BillProduct_Bill_FK` FOREIGN KEY (`billId`) REFERENCES `bill` (`billId`),
  CONSTRAINT `BillProduct_Product_FK` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_product_detail`
--

LOCK TABLES `bill_product_detail` WRITE;
/*!40000 ALTER TABLE `bill_product_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_product_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) NOT NULL,
  `createdBy` int(11) NOT NULL DEFAULT '1',
  `createdOn` timestamp(2) NULL DEFAULT CURRENT_TIMESTAMP(2),
  `updatedBy` int(11) DEFAULT NULL,
  `updatedOn` timestamp(2) NULL DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryId`),
  UNIQUE KEY `CategoryName_UNIQUE` (`categoryName`),
  KEY `CategoryCreated_User_idx` (`createdBy`),
  KEY `CategoryUpdated_User_idx` (`updatedBy`),
  CONSTRAINT `CategoryCreated_User` FOREIGN KEY (`createdBy`) REFERENCES `user` (`userId`),
  CONSTRAINT `CategoryUpdated_User` FOREIGN KEY (`updatedBy`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Mobile',1,'2019-02-16 14:55:07.36',1,'2019-02-16 17:10:55.66','Not Required',1),(3,'Laptop',1,'2019-02-16 15:18:54.37',NULL,NULL,NULL,0),(8,'Televison',1,'2019-02-16 15:32:33.51',1,'2019-02-16 17:14:48.90','Not Required',0),(18,'Cement',1,'2019-02-16 17:15:22.99',NULL,NULL,NULL,1),(19,'Color',1,'2019-02-16 17:16:13.40',NULL,NULL,NULL,1),(20,'Pipes',1,'2019-02-16 17:16:37.35',NULL,NULL,NULL,1),(21,'Grocery',1,'2019-02-16 19:22:00.62',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `customerId` int(11) NOT NULL AUTO_INCREMENT,
  `customerUserName` varchar(255) NOT NULL,
  `customerFirstName` varchar(100) NOT NULL,
  `customerLastName` varchar(100) NOT NULL,
  `customerEmail` varchar(100) NOT NULL,
  `customerMobileNumber` varchar(255) NOT NULL,
  `customerBalance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `createdBy` int(11) NOT NULL DEFAULT '1',
  `createdOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedOn` timestamp(2) NULL DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`customerId`),
  UNIQUE KEY `UserEmail_UNIQUE` (`customerEmail`),
  UNIQUE KEY `customerUserName_UNIQUE` (`customerUserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'sahila','Sahil','Arora','arora.sahil8@gmail.com','7696435771',0.00,1,'2019-02-23 12:29:37',NULL,NULL,1),(2,'yashm','Yash','Mamidwar','mamidwaryash@gmail.com','879913216',0.00,1,'2019-02-23 12:31:17',NULL,NULL,1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dealer`
--

DROP TABLE IF EXISTS `dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `dealer` (
  `dealerId` int(11) NOT NULL AUTO_INCREMENT,
  `dealerContactPerson` varchar(100) NOT NULL,
  `dealerAddress` varchar(255) NOT NULL,
  `dealerPhoneNumber` varchar(255) DEFAULT NULL,
  `dealerCity` varchar(45) NOT NULL,
  `dealerEmail` varchar(100) NOT NULL,
  `dealerType` varchar(255) NOT NULL,
  `dealerUserName` varchar(45) NOT NULL,
  `dealerAgencyName` varchar(255) DEFAULT NULL,
  `dealerMobileNumber` varchar(255) NOT NULL,
  `dealerPinCode` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL DEFAULT '1',
  `createdOn` timestamp(2) NULL DEFAULT CURRENT_TIMESTAMP(2),
  `updatedBy` int(11) DEFAULT NULL,
  `updatedOn` timestamp(2) NULL DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dealerId`),
  UNIQUE KEY `DealerEmail_UNIQUE` (`dealerEmail`),
  UNIQUE KEY `DealerUserName_UNIQUE` (`dealerUserName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dealer`
--

LOCK TABLES `dealer` WRITE;
/*!40000 ALTER TABLE `dealer` DISABLE KEYS */;
INSERT INTO `dealer` VALUES (1,'Sahil','Sector 6 kaypee heritage Koparkhirane','8755079382','Mumbai','arora.sahil83@gmail.com','','sahila33','arora mithai vale','8793199461',431602,1,'2019-02-21 11:14:10.60',1,'2019-02-23 09:10:48.73',NULL,1),(2,'Sahil','KoparKiarane','123','Mumbai','arora.sahil9@gmail.com','','sahila1','Sahil Associates','12345',151101,1,'2019-02-21 14:26:32.32',NULL,NULL,NULL,1),(3,'Yash','koparkhairne','112e33','Mumbai','mamidwaryash@gmail.com','','yashm','Yash Agency','11323',151001,1,'2019-02-22 18:19:47.50',NULL,NULL,NULL,1),(5,'Anmol','Kopkhairne','879319921','Mumbai','anmol.rastogi@gmail.com','','Anmolr1','anmol agency','87893199461',411098,1,'2019-02-23 07:32:22.03',NULL,NULL,NULL,1),(6,'Vyas','112','','Mumbai','arora.sahil8@gmail.com','Dealer','Vyas','Indore Namkeen Store','',151001,1,'2019-03-29 10:06:10.07',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `dealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outstanding`
--

DROP TABLE IF EXISTS `outstanding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `outstanding` (
  `outstandingId` int(11) NOT NULL AUTO_INCREMENT,
  `dealerId` int(11) NOT NULL,
  `outstandingAmount` decimal(10,4) DEFAULT '0.0000',
  PRIMARY KEY (`outstandingId`),
  KEY `Outstanding_DealerId_idx` (`dealerId`),
  CONSTRAINT `Outstanding_DealerId` FOREIGN KEY (`dealerId`) REFERENCES `dealer` (`dealerId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outstanding`
--

LOCK TABLES `outstanding` WRITE;
/*!40000 ALTER TABLE `outstanding` DISABLE KEYS */;
INSERT INTO `outstanding` VALUES (1,6,-2800.0000);
/*!40000 ALTER TABLE `outstanding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `variant` varchar(100) NOT NULL,
  `unitOfMeasure` varchar(100) NOT NULL,
  `cgstPercentage` decimal(10,4) DEFAULT NULL,
  `sgstPercentage` decimal(10,4) DEFAULT NULL,
  `igstPercentage` decimal(10,4) unsigned DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdBy` int(11) NOT NULL DEFAULT '1',
  `createdOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedOn` timestamp(2) NULL DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`productId`),
  UNIQUE KEY `ProductName_UNIQUE` (`productName`),
  KEY `Product_Category_FK_idx` (`categoryId`),
  KEY `ProductCreated_User_FK_idx` (`createdBy`),
  KEY `ProductUpdated_user_FK_idx` (`updatedBy`),
  CONSTRAINT `ProductCreated_User_FK` FOREIGN KEY (`createdBy`) REFERENCES `user` (`userId`),
  CONSTRAINT `ProductUpdated_user_FK` FOREIGN KEY (`updatedBy`) REFERENCES `user` (`userId`),
  CONSTRAINT `Product_Category_FK` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,'Mi Note 5','','',NULL,NULL,NULL,0,1,NULL,NULL,NULL,NULL),(6,1,'Demo2','','',NULL,NULL,NULL,1,1,'2019-02-17 08:30:24',1,'2019-02-17 09:40:29.94',NULL),(7,1,'Iphone x','','',NULL,NULL,NULL,0,1,'2019-02-17 08:30:33',1,'2019-02-17 09:46:18.36','Not Required'),(8,18,'Ambuja Cement','','',NULL,NULL,NULL,1,1,'2019-02-18 16:54:32',NULL,NULL,NULL),(9,18,'Ultra Tech Cement','','',NULL,NULL,NULL,1,1,'2019-02-18 16:54:48',NULL,NULL,NULL),(10,20,'Monitor','','',NULL,NULL,NULL,1,1,'2019-02-19 07:56:05',NULL,NULL,NULL),(15,1,'Note 7','4GB','unit',2.5000,2.5000,0.0000,1,1,'2019-03-16 16:49:06',NULL,NULL,NULL),(16,1,'Iphone 8','64 gb','L',5.0000,5.0000,5.0000,1,1,'2019-03-29 14:48:07',NULL,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_history`
--

DROP TABLE IF EXISTS `purchase_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `purchase_history` (
  `purchaseId` int(11) NOT NULL AUTO_INCREMENT,
  `dealerId` int(11) NOT NULL,
  `timeStamp` timestamp NULL DEFAULT NULL,
  `vehicleNumber` varchar(255) DEFAULT NULL,
  `labourCharges` decimal(10,4) DEFAULT NULL,
  `amount` decimal(10,4) NOT NULL,
  `netGst` decimal(10,4) DEFAULT NULL,
  `totalAmount` decimal(10,4) NOT NULL,
  `amountPaid` decimal(10,4) NOT NULL,
  `balance` decimal(10,4) NOT NULL,
  PRIMARY KEY (`purchaseId`),
  KEY `Purchase_Dealer_FK_idx` (`dealerId`),
  CONSTRAINT `Purchase_Dealer_FK` FOREIGN KEY (`dealerId`) REFERENCES `dealer` (`dealerId`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_history`
--

LOCK TABLES `purchase_history` WRITE;
/*!40000 ALTER TABLE `purchase_history` DISABLE KEYS */;
INSERT INTO `purchase_history` VALUES (1,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(4,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(5,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(6,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(7,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(8,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(9,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(10,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(11,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(12,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(13,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(14,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(15,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(16,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(17,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(18,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(19,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(20,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(21,2,NULL,'MH 01 AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(22,1,NULL,'MH 01AB 1234',1000.0000,1000.0000,1000.0000,2000.0000,100.0000,1900.0000),(23,1,NULL,'MH 01AB 1234',1000.0000,1000.0000,1000.0000,2000.0000,100.0000,1900.0000),(24,1,NULL,'MH 01AB 1234',1000.0000,1000.0000,1000.0000,2000.0000,100.0000,1900.0000),(25,1,NULL,'MH 01AB 1234',1000.0000,1000.0000,1000.0000,2000.0000,100.0000,1900.0000),(26,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(27,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(28,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(29,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(30,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(31,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(32,1,NULL,'MH 01 AB 1234',1000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(33,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(34,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(35,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(36,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(37,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(38,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(39,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(40,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(41,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(42,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(43,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(44,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(45,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(46,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(47,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(48,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(49,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(50,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(51,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(52,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(53,1,NULL,'MH 01AB 1234',1000.0000,2000.0000,1000.0000,3000.0000,100.0000,2900.0000),(54,6,NULL,'MH 01 AB 1234',2000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(55,6,NULL,'MH 01 AB 1234',2000.0000,3000.0000,1000.0000,4000.0000,100.0000,3900.0000),(56,6,NULL,'MH 01 AB 1234',1000.0000,1000.0000,1000.0000,2000.0000,100.0000,1900.0000),(57,6,NULL,'MH 01 AB 1234',120.0000,1000.0000,100.0000,1100.0000,500.0000,600.0000),(58,6,NULL,'MH 01 AB 1234',1000.0000,1000.0000,100.0000,1100.0000,500.0000,600.0000),(59,6,NULL,'MH 01 AB 1234',1000.0000,2000.0000,100.0000,2100.0000,500.0000,1600.0000);
/*!40000 ALTER TABLE `purchase_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_product`
--

DROP TABLE IF EXISTS `purchase_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `purchase_product` (
  `purchase_productId` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantityPurchased` int(11) NOT NULL,
  `rate` decimal(10,4) DEFAULT NULL,
  `availability` int(11) NOT NULL,
  `cgst` decimal(10,4) DEFAULT NULL,
  `sgst` decimal(10,4) DEFAULT NULL,
  `igst` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`purchase_productId`),
  KEY `Product_Purchase_FK_idx` (`productId`),
  KEY `PurchaseProduct_Product_FK_idx` (`purchaseId`),
  CONSTRAINT `Purchase_Product_FK` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_product`
--

LOCK TABLES `purchase_product` WRITE;
/*!40000 ALTER TABLE `purchase_product` DISABLE KEYS */;
INSERT INTO `purchase_product` VALUES (49,44,6,1,1000.0000,1,100.0000,100.0000,100.0000),(50,44,9,1,1000.0000,1,100.0000,100.0000,100.0000),(51,45,6,1,1000.0000,1,100.0000,100.0000,100.0000),(52,45,9,1,1000.0000,1,100.0000,100.0000,100.0000),(53,46,6,1,1000.0000,1,100.0000,100.0000,100.0000),(54,46,9,1,1000.0000,1,100.0000,100.0000,100.0000),(55,47,6,1,1000.0000,1,100.0000,100.0000,100.0000),(56,47,9,1,1000.0000,1,100.0000,100.0000,100.0000),(57,48,6,1,1000.0000,1,100.0000,100.0000,100.0000),(58,48,9,1,1000.0000,1,100.0000,100.0000,100.0000),(59,49,6,1,1000.0000,1,100.0000,100.0000,100.0000),(60,49,9,1,1000.0000,1,100.0000,100.0000,100.0000),(61,50,6,1,1000.0000,1,100.0000,100.0000,100.0000),(62,50,9,1,1000.0000,1,100.0000,100.0000,100.0000),(63,51,6,1,1000.0000,1,100.0000,100.0000,100.0000),(64,51,9,1,1000.0000,1,100.0000,100.0000,100.0000),(65,52,6,1,1000.0000,1,100.0000,100.0000,100.0000),(66,52,9,1,1000.0000,1,100.0000,100.0000,100.0000),(67,53,6,1,1000.0000,1,100.0000,100.0000,100.0000),(68,53,9,1,1000.0000,1,100.0000,100.0000,100.0000),(69,54,6,1,1000.0000,1,100.0000,100.0000,100.0000),(70,54,15,1,2000.0000,1,100.0000,100.0000,100.0000),(71,55,6,1,1000.0000,1,100.0000,100.0000,100.0000),(72,55,15,1,2000.0000,1,100.0000,100.0000,100.0000),(73,56,16,1,1000.0000,1,100.0000,100.0000,100.0000),(74,57,16,1,1000.0000,1,100.0000,100.0000,100.0000),(75,58,16,1,1000.0000,1,100.0000,100.0000,100.0000),(76,59,16,2,1000.0000,2,100.0000,100.0000,100.0000);
/*!40000 ALTER TABLE `purchase_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stock` (
  `stockId` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `quantity` int(11) DEFAULT '0',
  `quantityBlack` int(11) DEFAULT '0',
  PRIMARY KEY (`stockId`),
  KEY `Stock_Product_FK_idx` (`productId`),
  CONSTRAINT `Stock_Product_FK` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,6,11,0),(2,9,9,0),(3,15,6,0),(4,16,4,0);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `transactionId` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseId` int(11) DEFAULT NULL,
  `billId` int(11) DEFAULT NULL,
  `dealerId` int(11) DEFAULT NULL,
  `amountPay` decimal(10,4) DEFAULT NULL,
  `modeOfPayment` varchar(255) DEFAULT NULL,
  `transactionType` varchar(255) NOT NULL,
  `timeStamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transactionId`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,14,NULL,2,100.0000,'Cash','Purchase',NULL),(2,15,NULL,2,100.0000,'Cash','Purchase',NULL),(3,12,NULL,2,100.0000,'Cash','Purchase',NULL),(4,12,NULL,2,100.0000,'Cash','Purchase',NULL),(5,12,NULL,2,100.0000,'Cash','Purchase',NULL),(6,12,NULL,2,100.0000,'Cash','Purchase',NULL),(7,12,NULL,2,100.0000,'Cash','Purchase',NULL),(8,12,NULL,2,100.0000,'Cash','Purchase',NULL),(9,12,NULL,1,100.0000,'Cash','Purchase',NULL),(10,12,NULL,1,100.0000,'Cash','Purchase',NULL),(11,12,NULL,1,100.0000,'Cash','Purchase',NULL),(12,12,NULL,1,100.0000,'Cash','Purchase',NULL),(13,12,NULL,1,100.0000,'Cash','Purchase',NULL),(14,12,NULL,1,100.0000,'Cash','Purchase',NULL),(15,12,NULL,1,100.0000,'Cash','Purchase',NULL),(16,12,NULL,1,100.0000,'Cash','Purchase',NULL),(17,12,NULL,1,100.0000,'Cash','Purchase',NULL),(18,12,NULL,1,100.0000,'Cash','Purchase',NULL),(19,12,NULL,1,100.0000,'Cash','Purchase',NULL),(20,38,NULL,1,100.0000,'Cash','Purchase',NULL),(21,39,NULL,1,100.0000,'Cash','Purchase',NULL),(22,40,NULL,1,100.0000,'Cash','Purchase',NULL),(23,41,NULL,1,100.0000,'Cash','Purchase',NULL),(24,42,NULL,1,100.0000,'Cash','Purchase',NULL),(25,43,NULL,1,100.0000,'Cash','Purchase',NULL),(26,44,NULL,1,100.0000,'Cash','Purchase',NULL),(27,45,NULL,1,100.0000,'Cash','Purchase',NULL),(28,46,NULL,1,100.0000,'Cash','Purchase',NULL),(29,47,NULL,1,100.0000,'Cash','Purchase',NULL),(30,48,NULL,1,100.0000,'Cash','Purchase',NULL),(31,49,NULL,1,100.0000,'Cash','Purchase',NULL),(32,50,NULL,1,100.0000,'Cash','Purchase',NULL),(33,51,NULL,1,100.0000,'Cash','Purchase',NULL),(34,52,NULL,1,100.0000,'Cash','Purchase',NULL),(35,53,NULL,1,100.0000,'Cash','Purchase',NULL),(36,54,NULL,6,100.0000,'Cash','Purchase',NULL),(37,55,NULL,6,100.0000,'Cash','Purchase',NULL),(38,56,NULL,6,100.0000,'Cash','Purchase',NULL),(39,57,NULL,6,500.0000,'Cash','Purchase',NULL),(40,58,NULL,6,500.0000,'Cash','Purchase',NULL),(41,59,NULL,6,500.0000,'Cash','Purchase',NULL);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) NOT NULL,
  `userFirstName` varchar(100) NOT NULL,
  `userLastName` varchar(100) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName_UNIQUE` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','Yash','Mamidwar');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'testing'
--

--
-- Dumping routines for database 'testing'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddBill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBill`(
In _dealerID int(11),
In _vehicleNumber varchar(255),
In _labourCharges decimal(10,4),
In _amount decimal(10,4),
In _netGst decimal(10,4),
In _totalAmount decimal(10,4),
In _amountPaid decimal(10,4) )
BEGIN
declare	_billId int(11);
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Stock Addition Failed' as message;
insert into bill(
dealerID,
vehicleNumber,
labourCharges,
amount,
netGst,
totalAmount,
amountPaid,
balance
) 
values(
_dealerID,
_vehicleNumber,
_labourCharges,
_amount,
_netGst,
_totalAmount,
_amountPaid,
_totalAmount - _amountPaid
);
set _billId = last_insert_id();
SELECT 'success' AS status, 'Stock Added Succesfully' AS message,_billId as billId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddBillProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBillProduct`(
In _billId int(11),In _productId int(11),
In _quantity int(11),
In _totalCostPrice decimal(10,4),
In _totalSellingPrice decimal(10,4),
In _cgst decimal(10,4),
In _sgst decimal(10,4),
In _igst decimal(10,4)
)
BEGIN
insert into bill_product_detail(
billId,
productId,
quantity,
totalCostPrice,
totalSellingPrice,
cgst,
sgst,
igst
) values(
_billId,
_productId,
_quantity,
_totalCostPrice,
_totalSellingPrice,
_cgst,
_sgst,
_igst
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCategory`(In _categoryName varchar(100),In _createdBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Category Insertion Failed' as message;
if  exists(select categoryId from `category` where categoryName=_categoryName && isActive=1)
then
 SELECT 'error' as status,'Category Already Exist' as message;
elseif exists(select categoryId from `category` where categoryName=_categoryName && isActive=0)
then 
update category set isActive=1 where categoryName=_categoryName;
SELECT 'success' AS status, 'Category Added Succesfully' AS message;
else
INSERT INTO `category`
(
`categoryName`,
`createdBy`)
VALUES
(_categoryName,_createdBy);
SELECT 'success' AS status, 'Category Added Succesfully' AS message;
END if;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomer`(In _customerUserName varchar(255),In _customerFirstName varchar(100),
_customerLastName varchar(100),_customerEmail varchar(100),_customerMobileNumber varchar(100),_createdBy int(11))
BEGIN
/*DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Add Dealer' as message;*/
if  exists(select customerUserName from customer where customerUserName=_customerUserName)
then
 SELECT 'error' as status,'UserName already taken' as message;
elseif exists(select  customerEmail from  customer where  customerEmail = _customerEmail)
then  SELECT 'error' as status,'Email Id Already Exists' as message;
else
insert into  customer(
customerUserName,
customerFirstName,
customerLastName,
customerEmail,
customerMobileNumber,
createdBy
)
values(
_customerUserName,
_customerFirstName,
_customerLastName,
_customerEmail,
_customerMobileNumber,
_createdBy
);
SELECT 'success' AS status, 'Customer Added Succesfully' AS message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddDealer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDealer`(In _dealerUserName varchar(45),In _dealerContactPerson
varchar(100),In _dealerType
varchar(100),In _dealerAgencyName varchar(255),In _dealerAddress varchar(255),In _dealerCity varchar(255),
In _dealerPinCode int(11),
In _dealerEmail varchar(100),In _dealerMobileNumber varchar(255),In _dealerPhoneNumber 
varchar(100),In _createdBy int(11)
)
BEGIN
declare _dealerId int;
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Add Dealer' as message;
if  exists(select dealerUserName from dealer where dealerUserName=_dealerUserName)
then
 SELECT 'error' as status,'UserName already taken' as message;
elseif exists(select dealerEmail from dealer where dealerEmail = _dealerEmail)
then  SELECT 'error' as status,'Email Id Already Exists' as message;
else
insert into dealer(
dealerUserName,
dealerContactPerson,
dealerType,
dealerAgencyName,
dealerAddress,
dealerCity,
dealerPinCode,
dealerEmail,
dealerMobileNumber,
dealerPhoneNumber,
createdBy
) values (
_dealerUserName,
_dealerContactPerson,
_dealerType,
_dealerAgencyName,
_dealerAddress,
_dealerCity,
_dealerPinCode,
_dealerEmail,
_dealerMobileNumber,
_dealerPhoneNumber,
_createdBy
);
set _dealerId= LAST_INSERT_ID();
insert into outstanding(dealerId) values(_dealerID);
SELECT 'success' AS status, 'Dealer Added Succesfully' AS message;
END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduct`(In _productName varchar(100),In _categoryId int(11),
In _variant varchar(100),
In _unitOfMeasure varchar(100),
In _cgstPercentage decimal(10,4),
In _sgstPercentage decimal(10,4),
In _igstPercentage decimal(10,4),
In _createdBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Product Insertion Failed' as message;
if  exists(select productId from `product` where productName=_productName && isActive=1)
then
 SELECT 'error' as status,'Product Already Exist' as message;
elseif exists(select productId from `product` where productName=_productName && isActive=0)
then 
update product set isActive=1 where productName=_productName;
SELECT 'success' AS status, 'Product Added Succesfully' AS message;
else
INSERT INTO `product`
(
`productName`,
`categoryId`,
 variant,
 unitOfMeasure,
 cgstPercentage,
 sgstPercentage,
 igstPercentage,
`createdBy`)
VALUES
(_productName,_categoryId, _variant,
 _unitOfMeasure,
 _cgstPercentage,
 _sgstPercentage,
 _igstPercentage,_createdBy);
 insert into stock(productId) values(last_insert_id());
SELECT 'success' AS status, 'Product Added Succesfully' AS message;
END if;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPurchase`(In _dealerID int(11),
In _vehicleNumber varchar(255),
In _labourCharges decimal(10,4),
In _amount decimal(10,4),
In _netGst decimal(10,4),
In _totalAmount decimal(10,4),
In _amountPaid decimal(10,4)
)
BEGIN
declare	_purchaseId int(11);
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Stock Addition Failed' as message;
insert into purchase_history(
dealerID,
vehicleNumber,
labourCharges,
amount,
netGst,
totalAmount,
amountPaid,
balance
) 
values(
_dealerID,
_vehicleNumber,
_labourCharges,
_amount,
_netGst,
_totalAmount,
_amountPaid,
_totalAmount - _amountPaid
);
set _purchaseId = last_insert_id();
SELECT 'success' AS status, 'Stock Added Succesfully' AS message,_purchaseId as purchaseID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddPurchaseProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPurchaseProduct`(In _purchaseId int(11),In _productId int(11),
In _quantityPurchased int(11),
In _rate decimal(10,4),
In _cgst decimal(10,4),
In _sgst decimal(10,4),
In _igst decimal(10,4)
)
BEGIN
/*DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Add Purchase Product' as message;*/
insert into purchase_product(
purchaseId,
productId,
quantityPurchased,
availability,
rate,
cgst,
sgst,
igst
) values(
_purchaseId,
_productId,
_quantityPurchased,
_quantityPurchased,
_rate,
_cgst,
_sgst,
_igst
);
/*
if exists(select * from stock where productId=_productId) then
if(_cgst=null && _sgst=null && _igst=null) then 
update stock set  quantityBlack = quantityBlack + _quantityPurchased where productId=_productId;
else
update stock set  quantity = quantity + _quantityPurchased where productId=_productId;
end if;
else 
if(_cgst=null && _sgst=null && _igst=null) then 
insert into stock(productId,quantityBlack) values(_productId, _quantityPurchased);
else
insert into stock(productId,quantity) values(_productId, _quantityPurchased);
end if;
END if;
*/
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStock`(In _productId int(11),
In _costPrice decimal(15,2),
In _purchaseTimeStamp timestamp,
In _quantityAvailable int(11),In _dealerId int(11),In _createdBy int(11))
BEGIN
declare _StockId int;
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Stock Addition Failed' as message;
insert into stock(productId,costPrice,purchaseTimeStamp,quantityAvailable,dealerId,createdBy) values(
_productId,_costPrice,_purchaseTimeStamp,_quantityAvailable,_dealerId,_createdBy);
 SET _stockId = LAST_INSERT_ID();
 insert into purchase_history(stockId,quantity) values(_stockId,_quantityAvailable);
SELECT 'success' AS status, 'Stock Added Succesfully' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategory`(In _categoryId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Category Deletion Failed' as message;
if  exists(select categoryId from `category` where categoryId=_categoryId && isActive=1)
then
UPDATE `category`
SET
`isActive` = 0,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `categoryId` = _categoryID;
SELECT 
    'success' AS status,
    'Category Deleted Successfully' AS message;
else 
SELECT 'error' as status,'Category Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCustomer`(In _customerId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
update customer set 
isActive=0,
reason=_reason,
updatedBy=_updatedBy
where customerId=_customerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDealer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDealer`(In _dealerId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
update dealer set isActive=0,reason=_reason,updatedBy=_updatedBy where dealerId=_dealerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProduct`(In _productId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Product Deletion Failed' as message;
if  exists(select productId from `product` where productId=_productId && isActive=1)
then
UPDATE `product`
SET
`isActive` = 0,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `productId` = _productID;
SELECT 
    'success' AS status,
    'Product Deleted Successfully' AS message;
else 
SELECT 'error' as status,'Product Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeletePurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePurchase`(In _purchaseId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
Declare _productId int(11);
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Product Deletion Failed' as message;
if  exists(select purchaseId from purchase_history where purchaseId=_purchaseId && isActive=1)
then
UPDATE purchase_history
SET
`isActive` = 0,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `purchaseId` = purchaseId;
set _productId= (select productId from purchase_history where purrchaseId=_purcahseId ); 
update stock set quantityAvailable=quantityAvailable - quantityPurchased where productId=_productId;
SELECT 
    'success' AS status,
    'Purchase Deleted Successfully' AS message;
else 
SELECT 'error' as status,'Stock Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeletePurchaseProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePurchaseProducts`(_purchaseId int(11))
BEGIN
delete from purchase_product where purchaseId=_purchaseId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteStock`(In _stockId int(11),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Product Deletion Failed' as message;
if  exists(select stockId from stock where stockId=_stockId && isActive=1)
then
UPDATE stock
SET
`isActive` = 0,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `stockId` = _stockId;
SELECT 
    'success' AS status,
    'Stock Deleted Successfully' AS message;
else 
SELECT 'error' as status,'Stock Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditCategory`(In _categoryId int(11),In _categoryName varchar(100),In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Category Updation Failed' as message;
if  exists(select categoryId from `category` where categoryId=_categoryId && isActive=1)
then
 UPDATE `category`
SET
`categoryName` = _categoryName,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `categoryId` = _categoryID;
SELECT 
    'success' AS status,
    'Category Updated Successfully' AS message;
else 
SELECT 'error' as status,'Category Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditCustomer`(In _customerId int(11),In _customerUserName varchar(255),In _customerFirstName varchar(100),
_customerLastName varchar(100),_customerEmail varchar(100),_customerMobileNumber varchar(100),_updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Add Dealer' as message;
if  exists(select customerUserName from customer where customerUserName=_customerUserName && customerId!=_customerId)
then
 SELECT 'error' as status,'UserName already taken' as message;
elseif exists(select  customerEmail from  customer where  customerEmail = _customerEmail && customerId!=_customerId)
then  SELECT 'error' as status,'Email Id Already Exists' as message;
else
update customer set 
customerUserName=_customerUserName,
customerFirstName=_customerFirstName,
customerLastName=_customerLastName,
customerEmail=_customerEmail,
customerMobileNumber=_customerMobileNumber,
updatedBy=_updatedBy,
updatedOn =current_timestamp
where customerId=_customerId;
SELECT 'success' AS status, 'Customer Updated Succesfully' AS message;
End if;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditDealer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditDealer`(In _dealerId int(11),
In _dealerUserName varchar(45),In _dealerContactPerson varchar(100),
In _dealerType varchar(100),
In _dealerAgencyName varchar(255),
In _dealerAddress varchar(255),In _dealerCity varchar(255),
In _dealerPinCode int(11),
In _dealerEmail varchar(100),In _dealerMobileNumber varchar(255),In _dealerPhoneNumber 
varchar(100),In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Update Dealer Details' as message;
if  exists(select dealerUserName from dealer where dealerUserName=_dealerUserName 
&& dealerId != _dealerId)
then
 SELECT 'error' as status,'UserName already taken' as message;
elseif exists(select dealerEmail from dealer where dealerEmail = _dealerEmail
&& dealerId != _dealerId)
then  SELECT 'error' as status,'Email Id Already Exists' as message;
else
update dealer set
dealerUserName=_dealerUserName,
dealerContactPerson=_dealerContactPerson,
dealerType = _dealerType,
dealerAgencyName=_dealerAgencyName,
dealerAddress=_dealerAddress,
dealerCity=_dealerCity,
dealerPinCode=_dealerPinCode,
dealerEmail=_dealerEmail,
dealerMobileNumber=_dealerMobileNumber,
dealerPhoneNumber=_dealerPhoneNumber,
updatedBy=_updatedBy,
updatedOn =current_timestamp(2)
where dealerId=_dealerId;
SELECT 'success' AS status, 'Dealer Updated Succesfully' AS message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditProduct`(In _productId int(11),In _productName varchar(100),In _categoryId int(11),
In _variant varchar(100),
In _unitOfMeasure varchar(100),
In _cgstPercentage decimal(10,4),
In _sgstPercentage decimal(10,4),
In _igstPercentage decimal(10,4),
In _reason varchar(200) ,In _updatedBy int(11))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Product Updation Failed' as message;
if  exists(select productId from `product` where productId=_productId && isActive=1)
then
 UPDATE `product`
SET
`productName` = _productName,
`categoryId`=_categoryId,
variant = _variant,
unitOfMeasure = _unitOfMeasure,
cgstPercentage = _cgstPercentage,
sgstPercentage = _sgstPercentage,
igstPercentage = _igstPercentage,
`updatedBy` = _updatedBy,
`updatedOn` = current_timestamp(2),
`reason` = _reason
WHERE `productId` = _productId;
SELECT 
    'success' AS status,
    'Product Updated Successfully' AS message;
else 
SELECT 'error' as status,'Product Id Does not Exist' as message;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditPurchase`(In _purchaseId int(11),
In _dealerID int(11),
In _vehicleNumber varchar(255),
In _labourCharges decimal(10,4),
In _amount decimal(10,4),
In _netGst decimal(10,4),
In _totalAmount decimal(10,4),
In _amountPaid decimal(10,4))
BEGIN
declare	_purchaseId int(11);
declare _outstanding decimal(10,4);
declare _prevDealerId int(11);
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Purchase Updation Failed' as message;
select dealerId into _prevDealerId from purchase_history where purchaseId=_purchaseId;
select balance into _outstanding from purchase_history where purchaseId=_purchaseId;
call ManageOutstandings(_prevDealerId,_outstanding,'Recieve');
update purchase_history set
dealerID = _dealerID,
vehicleNumber=_vehicleNumber,
labourCharges=_labourCharges,
amount=_amount,
netGst=_netGst,
totalAmount=_totalAmount,
amountPaid=_amountPaid,
balance=_totalAmount - _amountPaid
where purchaseId=_purchaseId;
SELECT 'success' AS status, 'Purchase Updated Succesfully' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditStock`(
In _stockId int(11),In _productId int(11),In _costPrice decimal(15,2),
In _quantityPurchased int(11),
In _purchaseTimeStamp timestamp,
In _dealerId int(11),
In _updatedBy int(11)
)
BEGIN
/*DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Stock Updation Failed' as message;*/
UPDATE stock 
SET 
    productId = _productId,
    costPrice = _costPrice,
    purchaseTimeStamp = _purchaseTimeStamp,
    quantityAvailable = _quantityPurchased,
    updatedBy = _updatedBy,
    updatedOn = CURRENT_TIMESTAMP(2),
    dealerId = _dealerID
WHERE
    stockId = _stockId;
UPDATE purchase_history 
SET 
    quantity = _quantityPurchased,
    updatedBy = _updatedBy,
    updatedOn = CURRENT_TIMESTAMP(2)
WHERE
    stockId = _stockId;
SELECT 'success' AS status, 'Stock Updated Successfully' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCategories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCategories`()
BEGIN
select * from category where isActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCategoryById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCategoryById`(In _categoryId int(11))
BEGIN
select * from category where categoryId=_categoryId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomer`()
BEGIN
select c.*, concat(c.customerFirstName,' ',c.customerLastName) as customerName from customer c where isActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerById`(In _customerId int(11))
BEGIN
select *,concat(customer.customerFirstName,' ',customer.customerLastName) as customerName from customer 
where customerId=_customerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDealer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDealer`()
BEGIN
select * from dealer where isActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDealerById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDealerById`(In _dealerId int(11))
BEGIN
select * from dealer where  dealerId=_dealerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GETGST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GETGST`(In _productId int(11),In _price decimal(10,4), _quantity int(11),Out _cgst decimal(10,4),Out _sgst decimal(10,4),
Out _igst decimal(10,4))
BEGIN
declare _cgstPercentage decimal(10,4);
declare _sgstPercentage decimal(10,4);
declare _igstPercentage decimal(10,4);
declare _netPrice decimal(10.4);
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Get GST' as message;
set _netPrice = _quantity * _price;
select  cgstPercentage into _cgstPercentage from product where productId = _productId;
select  sgstPercentage into _sgstPercentage  from product where productId = _productId;
select  igstPercentage into _igstPercentage  from product where productId = _productId;
set _cgst =  _netPrice * _cgstPercentage * 0.01;
set _sgst = _netPrice * _sgstPercentage * 0.01;
set _igst = _netPrice * _igstPercentage * 0.01;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductById`(In _productId int(11))
BEGIN
select * from product where productId=_productId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProducts`()
BEGIN
select * from product where isActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductsPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductsPurchase`(_purchaseId int(11))
BEGIN
select pp.*,p.cgstPercentage,p.sgstPercentage,p.igstPercentage 
from purchase_product pp  join product p 
on pp.productId = p.productId
where purchaseId=_purchaseId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPurchase`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Unable To Find Purchases' as message;
select * from purchase_history;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPurchaseAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPurchaseAvailability`(In _productId int(11),In _type varchar(255))
BEGIN
if(_type='Normal') then
select * from purchase_product p where productId=_productId and availability>0 and 
(cgst is not null || sgst is not null || igst is not null)
order by  purchaseId;
else
select * from purchase_product p where productId=_productId and availability>0 and 
(cgst is  null && sgst is not null && igst is not null)
order by  purchaseId;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPurchaseById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPurchaseById`(In _purchaseId int(11))
BEGIN
select * from 
purchase_history
where purchaseId = _purchaseId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStock`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Unable To Find Stocks' as message;
select * from stock;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStockById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStockById`(In _stockId int(11))
BEGIN
select * from stock where stockId=_stockId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStockReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStockReport`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Unable To Find Stock Details' as message;
select sobj.productId,pobj.productName,cobj.categoryName,
sobj.quantityAvailable as quantityAvailable,
max(phistoryobj.purchaseTimeStamp) as lastPurchased,
sum(phistoryobj.quantityPurchased) as quantityPurchased
from stock  sobj 
join product pobj on sobj.productId = pobj.productId
join category cobj on pobj.categoryId= cobj.categoryId 
join purchase_history phistoryobj on sobj.productId = phistoryobj.productId
where sobj.isActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageOutstandings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageOutstandings`(In _dealerId int(11),In _outstandingAmount int(11),In _transcationType varchar(255))
BEGIN
/*DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Cannot Manage Outstandings' as message;*/
if(_transcationType='Recieve') then
update outstanding set outstandingAmount = outstandingAmount + _outstandingAmount where
dealerId=_dealerId;
else
update outstanding set outstandingAmount = outstandingAmount - _outstandingAmount where
dealerId=_dealerId;
end if;
SELECT 'success' AS status, 'Outstandings Updated Succesfully' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManagePurchaseAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManagePurchaseAvailability`(In _purchaseProductId int(11),
In _quantity int(11),In _operation int(11)
)
BEGIN
if(_operation='Subtract') then 
update purchase_product set availability = availability - _qunatity 
where purchase_productId = _purchaseProductId;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageStock`(_productId int (11),_quantity int(11),
_type varchar(255),_transactionType varchar(255))
BEGIN
if(_transactionType='Add') then
if(_type='Black') then
update  stock set quantityBlack=quantityBlack + _quantity;
else
update stock set quantity=quantity + _quantity;
end if;
else
if(_type='Black') then
update  stock set quantityBlack=quantityBlack - _quantity;
else
update stock set quantity=quantity - _quantity;
end if;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageTransaction`(In _recordId int(11),In _dealerId int(11),In _amountPay decimal(10.4) ,
In _modeOfPayment varchar(255),In _transactionType varchar(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error' as status,'Transaction Failed' as message;
if(_transactionType='Purchase') then 
insert into transaction(purchaseId,dealerId,amountPay,modeOfPayment,transactionType) values(_recordId,_dealerId,
_amountPay,_modeOfPayment,_transactionType);
elseif(_transactionType='Sell') then 
insert into transaction(billId,dealerId,amountPay,modeOfPayment,transactionType) values(_recordId,_dealerId,
_amountPay,_modeOfPayment,_transactionType);
else
insert into transaction(dealerId,amountPay,modeOfPayment,transactionType) values( _dealerId,
_amountPay,_modeOfPayment,_transactionType);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-01 19:14:09
