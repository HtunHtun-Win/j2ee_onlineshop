-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: ecommercial_sys
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `isdeleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (11,'Clothes',0,'2025-08-25 23:42:49'),(12,'Pants',0,'2025-08-25 23:43:03'),(13,'Shoes',0,'2025-08-25 23:43:24'),(15,'Bags',0,'2025-08-25 23:44:23'),(16,'Accessories',0,'2025-08-25 23:44:43');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `message` text,
  `user_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (6,'EasyBying','This syste is so smooth and it can hep us to save our valuable time.',13,'2025-08-28 10:51:24'),(7,'UI','UI is simple and easy to use',2,'2025-08-28 10:59:32'),(8,'Feedback','This is the good web',3,'2025-08-28 12:28:19'),(11,'kkfkl','cn',2,'2025-08-31 10:31:29');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `isdeleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_no` (`order_no`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`),
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (102,'ORD1756562466194',42,1,399999,0,'2025-08-30 20:31:06'),(103,'ORD1756562466194',74,2,40000,0,'2025-08-30 20:31:06'),(104,'ORD1756562466194',29,1,80000,0,'2025-08-30 20:31:06'),(105,'ORD1756562466194',68,2,86000,0,'2025-08-30 20:31:06'),(106,'ORD1756563209745',42,1,399999,0,'2025-08-30 20:43:29'),(107,'ORD1756563337700',68,1,86000,0,'2025-07-30 20:45:37'),(108,'ORD1756564076198',51,2,50000,1,'2025-08-30 20:57:56'),(109,'ORD1756564076198',72,3,20000,1,'2025-08-30 20:57:56'),(110,'ORD1756612859780',42,1,399999,1,'2025-08-31 10:30:59'),(111,'ORD1756619013534',30,1,300000,1,'2025-08-31 12:13:33'),(112,'ORD1756619238689',30,1,300000,1,'2025-08-31 12:17:18'),(113,'ORD1756619346127',30,1,300000,1,'2025-08-31 12:19:06'),(114,'ORD1756619461384',30,1,300000,1,'2025-08-31 12:21:01'),(115,'ORD1756620420173',28,1,260000,1,'2025-08-31 12:37:00'),(116,'ORD1756620577032',68,1,86000,1,'2025-08-31 12:39:37'),(117,'ORD1756620613519',42,1,399999,1,'2025-08-31 12:40:13'),(118,'ORD1756621014694',34,1,96500,1,'2025-08-31 12:46:54'),(119,'ORD1756621038595',34,1,96500,1,'2025-08-31 12:47:18'),(120,'ORD1756621129494',51,1,50000,1,'2025-08-31 12:48:49'),(121,'ORD1756621384685',68,1,86000,1,'2025-08-31 12:53:04'),(122,'ORD1756621627189',51,1,50000,1,'2025-08-31 12:57:07'),(123,'ORD1756621646169',51,1,50000,1,'2025-08-31 12:57:26'),(124,'ORD1756621798149',74,1,40000,1,'2025-08-31 12:59:58'),(125,'ORD1756621832743',68,1,86000,1,'2025-08-31 13:00:32'),(126,'ORD1756621986379',68,1,86000,1,'2025-08-31 13:03:06'),(127,'ORD1756622108057',68,1,86000,1,'2025-08-31 13:05:08'),(128,'ORD1756622122783',68,2,86000,1,'2025-08-31 13:05:22'),(129,'ORD1756622649468',68,1,86000,1,'2025-08-31 13:14:09'),(130,'ORD1756622706622',68,1,86000,1,'2025-08-31 13:15:06'),(131,'ORD1756622741713',68,1,86000,1,'2025-08-31 13:15:41'),(132,'ORD1756622885190',68,1,86000,1,'2025-08-31 13:18:05'),(133,'ORD1756622960187',68,1,86000,1,'2025-08-31 13:19:20'),(134,'ORD1756622998883',68,1,86000,1,'2025-08-31 13:19:58'),(135,'ORD1756623024598',68,1,86000,1,'2025-08-31 13:20:24'),(136,'ORD1756623060073',68,1,86000,1,'2025-08-31 13:21:00'),(137,'ORD1756623108280',68,1,86000,1,'2025-08-31 13:21:48'),(138,'ORD1756623510494',68,1,86000,1,'2025-08-31 13:28:30'),(139,'ORD1756623973037',68,1,86000,1,'2025-08-31 13:36:13'),(140,'ORD1756624252639',68,1,86000,1,'2025-08-31 13:40:52'),(141,'ORD1756624291736',68,1,86000,1,'2025-08-31 13:41:31'),(142,'ORD1756624404057',68,1,86000,1,'2025-08-31 13:43:24'),(143,'ORD1756624763982',68,1,86000,1,'2025-08-31 13:49:24'),(144,'ORD1756624928911',68,1,86000,1,'2025-08-31 13:52:08'),(145,'ORD1756625304162',68,1,86000,1,'2025-08-31 13:58:24'),(146,'ORD1756625367350',42,1,399999,1,'2025-08-31 13:59:27'),(147,'ORD1756953240360',42,1,399999,0,'2025-09-04 09:04:00'),(148,'ORD1757515829288',42,1,399999,0,'2025-09-10 21:20:29'),(149,'ORD1757515829288',74,3,40000,0,'2025-09-10 21:20:29'),(150,'ORD1757515829288',68,1,86000,0,'2025-09-10 21:20:29'),(151,'ORD1757515847232',28,1,260000,0,'2025-09-10 21:20:47');
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_no` varchar(255) NOT NULL,
  `user_id` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT 'pending',
  `payment` varchar(255) DEFAULT NULL,
  `isdeleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_no`),
  UNIQUE KEY `order_no` (`order_no`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('ORD1756562466194',2,731999,0,731999,'ygn','confirm','photo_2025-08-30_20-28-14.jpg',0,'2025-08-30 20:31:06'),('ORD1756563209745',1,399999,0,399999,'Yangon','confirm','photo_2025-08-30_20-28-22.jpg',0,'2025-08-30 20:43:29'),('ORD1756563337700',1,86000,0,86000,'Yangon','pending','photo_2025-08-30_20-28-20.jpg',0,'2025-07-30 20:45:37'),('ORD1756564076198',2,160000,0,160000,'ygn','confirm',NULL,1,'2025-08-30 20:57:56'),('ORD1756612859780',2,399999,0,399999,'Mandalay','confirm','photo_2025-08-30_20-28-08.jpg',1,'2025-08-31 10:30:59'),('ORD1756619013534',1,300000,0,300000,'Yangon','pending',NULL,1,'2025-08-31 12:13:33'),('ORD1756619238689',1,300000,0,300000,'Yangon','pending',NULL,1,'2025-08-31 12:17:18'),('ORD1756619346127',1,300000,0,300000,'Yangon','pending',NULL,1,'2025-08-31 12:19:06'),('ORD1756619461384',1,300000,0,300000,'Yangon','pending',NULL,1,'2025-08-31 12:21:01'),('ORD1756620420173',2,260000,0,260000,'Mandalay','pending',NULL,1,'2025-08-31 12:37:00'),('ORD1756620577032',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 12:39:37'),('ORD1756620613519',2,399999,0,399999,'Mandalay','pending',NULL,1,'2025-08-31 12:40:13'),('ORD1756621014694',2,96500,0,96500,'Mandalay','pending',NULL,1,'2025-08-31 12:46:54'),('ORD1756621038595',2,96500,0,96500,'Mandalay','pending',NULL,1,'2025-08-31 12:47:18'),('ORD1756621129494',2,50000,0,50000,'Mandalay','pending',NULL,1,'2025-08-31 12:48:49'),('ORD1756621384685',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 12:53:04'),('ORD1756621627189',2,50000,0,50000,'Mandalay','pending',NULL,1,'2025-08-31 12:57:07'),('ORD1756621646169',2,50000,0,50000,'Mandalay','pending',NULL,1,'2025-08-31 12:57:26'),('ORD1756621798149',2,40000,0,40000,'Mandalay','pending',NULL,1,'2025-08-31 12:59:58'),('ORD1756621832743',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:00:32'),('ORD1756621986379',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:03:06'),('ORD1756622108057',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:05:08'),('ORD1756622122783',2,172000,0,172000,'Mandalay','pending',NULL,1,'2025-08-31 13:05:22'),('ORD1756622649468',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:14:09'),('ORD1756622706622',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:15:06'),('ORD1756622741713',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:15:41'),('ORD1756622885190',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:18:05'),('ORD1756622960187',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:19:20'),('ORD1756622998883',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:19:58'),('ORD1756623024598',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:20:24'),('ORD1756623060073',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:21:00'),('ORD1756623108280',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:21:48'),('ORD1756623510494',1,86000,0,86000,'Yangon','pending',NULL,1,'2025-08-31 13:28:30'),('ORD1756623973037',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:36:13'),('ORD1756624252639',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:40:52'),('ORD1756624291736',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:41:31'),('ORD1756624404057',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:43:24'),('ORD1756624763982',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:49:23'),('ORD1756624928911',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:52:08'),('ORD1756625304162',2,86000,0,86000,'Mandalay','pending',NULL,1,'2025-08-31 13:58:24'),('ORD1756625367350',2,399999,0,399999,'Mandalay','pending',NULL,1,'2025-08-31 13:59:27'),('ORD1756953240360',2,399999,0,399999,'Mandalay','confirm',NULL,0,'2025-09-04 09:04:00'),('ORD1757515829288',1,605999,0,605999,'Yangon','pending','photo_2025-08-30_20-28-08.jpg',0,'2025-09-10 21:20:29'),('ORD1757515847232',1,260000,0,260000,'Yangon','pending',NULL,0,'2025-09-10 21:20:47');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_logs`
--

DROP TABLE IF EXISTS `product_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `note` varchar(20) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_logs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_logs`
--

LOCK TABLES `product_logs` WRITE;
/*!40000 ALTER TABLE `product_logs` DISABLE KEYS */;
INSERT INTO `product_logs` VALUES (142,30,'restore',1,'2025-08-31 12:17:11'),(143,30,'restore',1,'2025-08-31 12:21:26'),(144,30,'restore',1,'2025-08-31 12:21:28'),(145,30,'restore',1,'2025-08-31 12:21:32'),(146,42,'restore',1,'2025-08-31 12:40:32'),(147,68,'restore',1,'2025-08-31 12:40:36'),(148,28,'restore',1,'2025-08-31 12:40:39'),(149,34,'restore',1,'2025-08-31 12:48:35'),(150,34,'restore',1,'2025-08-31 12:48:38'),(151,51,'restore',1,'2025-08-31 12:52:35'),(152,68,'restore',1,'2025-08-31 12:53:28'),(153,51,'restore',1,'2025-08-31 12:57:37'),(154,51,'restore',1,'2025-08-31 12:57:40'),(155,74,'restore',1,'2025-08-31 13:00:25'),(156,68,'restore',1,'2025-08-31 13:02:40'),(157,68,'restore',1,'2025-08-31 13:04:53'),(158,68,'restore',2,'2025-08-31 13:13:08'),(159,68,'restore',1,'2025-08-31 13:13:10'),(160,68,'restore',1,'2025-08-31 13:15:30'),(161,68,'restore',1,'2025-08-31 13:15:32'),(162,68,'restore',1,'2025-08-31 13:17:47'),(163,68,'restore',1,'2025-08-31 13:19:10'),(164,68,'restore',1,'2025-08-31 13:19:50'),(165,68,'restore',1,'2025-08-31 13:20:16'),(166,68,'restore',1,'2025-08-31 13:20:51'),(167,68,'restore',1,'2025-08-31 13:21:41'),(168,68,'restore',1,'2025-08-31 13:35:50'),(169,68,'restore',1,'2025-08-31 13:35:52'),(170,68,'restore',1,'2025-08-31 13:39:39'),(171,68,'restore',1,'2025-08-31 13:41:25'),(172,68,'restore',1,'2025-08-31 13:42:54'),(173,68,'restore',1,'2025-08-31 13:47:45'),(174,68,'restore',1,'2025-08-31 13:49:40'),(175,68,'restore',1,'2025-08-31 13:52:22'),(176,68,'restore',1,'2025-08-31 13:58:38'),(177,42,'restore',1,'2025-08-31 13:59:31'),(178,42,'restore',1,'2025-08-31 13:59:39'),(179,51,'restore',2,'2025-08-31 14:07:45'),(180,72,'restore',3,'2025-08-31 14:07:45');
/*!40000 ALTER TABLE `product_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text,
  `price` double(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `isdeleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (26,'I Wish You Were Here','10001','1756146796007_photo_2025-08-26_00-47-47.jpg','NFC RUBBER TAG SWEATSHIRT SXLAD & CYAN EDITION',350000.00,10,11,0,'2025-08-26 00:01:15'),(27,'COCO Original Hoodie','10002','1756147015053_photo_2025-08-26_00-47-39.jpg','The CoCo Hoodie, crafted with a boxy pattern, brings a perfect blend of comfort and style.',68000.00,10,11,0,'2025-08-26 00:11:15'),(28,'Shoes','0011','1756146821795_photo_2025-08-26_00-42-13.jpg','New Balance 9060 trainers in grey multi',260000.00,9,13,0,'2025-08-26 00:23:02'),(29,'High Cultured (Classic Oxford shirt)','10003','1756147727714_photo_2025-08-26_00-49-23.jpg','High Cultured(Classic Oxford shirt)',80000.00,9,11,0,'2025-08-26 00:23:21'),(30,'Trainers in black','0012','1756146837153_photo_2025-08-26_00-42-05.jpg','94% of customers recommend this product',300000.00,5,13,0,'2025-08-26 00:25:27'),(31,'Sneakers in black','0013','1756146857391_photo_2025-08-26_00-42-18.jpg','Awesome looking shoe that doesn’t make me feel guilty about the price. Super breathable and true to size. Second pair.',330000.00,6,13,0,'2025-08-26 00:27:17'),(32,'SISBURMA RABBIT TEE','10004','1756147430921_photo_2025-08-26_00-47-24.jpg','RVST COLLECTION PREMIUM AIR LAYER',58000.00,20,11,0,'2025-08-26 00:27:43'),(33,'Puma Palermo','0014','1756146873845_photo_2025-08-26_00-42-23.jpg','100% of customers recommend this product',580000.00,5,13,0,'2025-08-26 00:29:38'),(34,'RESTYLE JACKET','10005','1756147486161_photo_2025-08-26_00-47-15.jpg','Evenfall Ember Jacket',96500.00,10,11,0,'2025-08-26 00:31:10'),(35,'RESTYLE SHIRT','10006','1756147532843_photo_2025-08-26_00-47-19.jpg','Lime Soda Shirt',53500.00,10,11,0,'2025-08-26 00:33:07'),(36,'RESTYLE JACKET','10007','1756147570034_photo_2025-08-26_00-47-28.jpg','Brownie Grid Retro Jacket',96500.00,5,11,0,'2025-08-26 00:34:30'),(37,'SISBURMA HOODIE','10008','1756147606589_photo_2025-08-26_00-47-31.jpg','NPLH Double-Layer Reversible Rectangle Hoodie',62000.00,10,11,0,'2025-08-26 00:37:49'),(38,'MINUSX T-SHIRT','10009','1756147805925_photo_2025-08-26_01-19-44.jpg','MINUSX VANTA T-SHIRT',54000.00,10,11,0,'2025-08-26 00:40:45'),(39,'MINUSX SHIRT','10010','1756147877050_photo_2025-08-26_00-47-35.jpg','MINUSX SHORT-SLEEVE SHIRT',54000.00,10,11,0,'2025-08-26 00:42:07'),(40,'Casual Leather Shoes','0015','1756145745742_111.jpg','We are engaged in offering Men Casual Leather Shoes to\r\nour clients. Our range of all products is widely appreciated\r\nby our clients.',390000.00,7,13,0,'2025-08-26 00:45:45'),(41,'JOYBEAN','0016','1756145875912_photo_2025-08-26_00-42-28.jpg','The Marvelous Slip-on features a Joynit upper for\r\na snug yet breathable fit. Its soft, flexible Phylon\r\nsole with an anti-skid rubber base ensures\r\nstability and durability. The bouncy YoYo footbed\r\nprovides exceptional comfort, keeping your feet\r\nfeeling fresh all day.',400000.00,8,13,0,'2025-08-26 00:47:55'),(42,'Fashion Shoes','0017','1756148279739_photo_2025-08-26_01-26-42.jpg','The bouncy YoYo footbed provides exceptional comfort, keeping your feet feeling fresh all day.',399999.00,0,13,0,'2025-08-26 00:49:38'),(43,'D Van Snaker','0018','1756148245856_photo_2025-08-26_01-22-46.jpg','Good looking and high quility shoes',195000.00,10,13,0,'2025-08-26 00:52:52'),(44,'ROMAND','10011','1756148297023_photo_2025-08-26_01-27-34.jpg','Lipstick',24000.00,20,16,0,'2025-08-26 00:54:19'),(46,'Labubu','10012','1756148358210_photo_2025-08-26_01-27-38.jpg','Toy',42000.00,24,16,0,'2025-08-26 00:56:59'),(47,'REMAX Earbuds','10013','1756148413078_photo_2025-08-26_01-27-24.jpg','CozyPods W30N ANC+ENC Noise Reduction',95000.00,20,16,0,'2025-08-26 01:00:45'),(48,'Jisulife Life 9 Fan','10014','1756148433528_photo_2025-08-26_01-27-31.jpg','Jisulife Handheld Fan Life9',110000.00,10,16,0,'2025-08-26 01:02:33'),(49,'Stylish','0019','1756146793136_photo_2025-08-26_01-02-24.jpg','100% good quility.',450000.00,8,13,0,'2025-08-26 01:03:13'),(50,'REMAX SMARTWATCH','10015','1756148464133_photo_2025-08-26_01-27-27.jpg','WATCH 25 SMARTWATCH',175000.00,10,16,0,'2025-08-26 01:05:47'),(51,'Fashions','0021','1756147036195_b6.jpg','Very Conformable',50000.00,11,15,0,'2025-08-26 01:07:16'),(52,'GUCCI','0022','1756147147850_b10.jpg','Looking good and The bouncy YoYo footbed provides exceptional comfort, keeping your feet feeling fresh all day.',340000.00,2,15,0,'2025-08-26 01:09:07'),(53,'Fashions Style','0023','1756147232666_b2.jpg','The bouncy YoYo provides exceptional comfort, keeping your feet feeling fresh all day.',50000.00,16,15,0,'2025-08-26 01:10:32'),(54,'StyleSecret','0024','1756147305494_b1.jpg','provides exceptional comfort.',30000.00,7,15,0,'2025-08-26 01:11:45'),(62,'Black Colour','0025','1756147466713_b5.jpg','provides exceptional comfort,',46000.00,6,15,0,'2025-08-26 01:14:26'),(63,'Adidas','0020','1756147573987_photo_2025-08-26_01-02-29.jpg','provides exceptional comfort,',508000.00,5,13,0,'2025-08-26 01:16:13'),(64,'Hand Bag','0026','1756148386010_b9.jpg','provides exceptional comfort,',34000.00,23,15,0,'2025-08-26 01:29:46'),(65,'Black Bag','0027','1756148505312_b7.jpg','provides exceptional comfort,',37500.00,9,15,0,'2025-08-26 01:31:45'),(66,'Block Color','0028','1756148691778_b8.jpg','provides exceptional comfort,',30000.00,12,15,0,'2025-08-26 01:34:51'),(67,'MYST','10016','1756149892015_photo_2025-08-26_01-51-23.jpg','MYST INSPIRED PERFUME',38000.00,10,16,0,'2025-08-26 01:36:02'),(68,'Laptop Bag','0029','1756148809515_photo_2025-08-26_01-35-51.jpg','provides exceptional comfort,very easy.',86000.00,12,15,0,'2025-08-26 01:36:34'),(69,'Easy Bag','0030','1756148904973_b3.jpg','Very Easy to use.',18000.00,21,15,0,'2025-08-26 01:38:24'),(70,'ALEXANDRE CHRISTIE WATCH','10017','1756149734838_photo_2025-08-26_01-51-34.jpg','MODLE NO:AC9205MCLBBA',700100.00,2,16,0,'2025-08-26 01:39:32'),(71,'DENNIS MARTIN WATCH','10018','1756149759245_photo_2025-08-26_01-51-30.jpg','MODEL NO:DM9494G3LPGNGN',244500.00,2,16,0,'2025-08-26 01:41:41'),(72,'HIGH CULTURED BUCKET HAT','10019','1756149794635_photo_2025-08-26_01-51-19.jpg','These fabulous bucket hats are stylish.',20000.00,3,16,0,'2025-08-26 01:45:13'),(73,'Vaseline Body Lotion','10020','1756149874401_photo_2025-08-26_01-51-27.jpg','Vaseline Body Lotion Fresh & Bright Cooling',25000.00,20,16,0,'2025-08-26 01:48:12'),(74,'Style Pant','0031','1756149503036_photo_2025-08-26_01-46-30.jpg','100% good quality.',40000.00,16,12,0,'2025-08-26 01:48:23'),(75,'Black Pant','0032','1756149581790_photo_2025-08-26_01-45-28.jpg','100% good quality.',42000.00,8,12,0,'2025-08-26 01:49:41'),(76,'Long pant','0032','1756149666377_photo_2025-08-26_01-45-33.jpg','100% good quality.',38000.00,7,12,0,'2025-08-26 01:51:06'),(77,'FILSON','0034','1756149749578_photo_2025-08-26_01-45-38.jpg','100% good quality.',35000.00,25,12,0,'2025-08-26 01:52:29'),(78,'FILSON','0034','1756149759090_photo_2025-08-26_01-45-38.jpg','100% good quality.',35000.00,25,12,1,'2025-08-26 01:52:39'),(79,'Jean','0035','1756149823503_photo_2025-08-26_01-46-04.jpg','100% good quality.',60000.00,32,12,0,'2025-08-26 01:53:43'),(80,'Fashion star','0036','1756149892424_photo_2025-08-26_01-46-13.jpg','100% good quality.',26000.00,6,12,0,'2025-08-26 01:54:52'),(81,'Pant','0037','1756149975072_photo_2025-08-26_01-46-17.jpg','100% good quality.',48000.00,9,12,0,'2025-08-26 01:56:15'),(82,'Fashion','0038','1756150074616_photo_2025-08-26_01-46-22.jpg','100% good quality.',56000.00,24,12,0,'2025-08-26 01:57:54'),(83,'Black pant','0039','1756150111152_photo_2025-08-26_01-46-36.jpg','100% good quality.',30000.00,34,12,0,'2025-08-26 01:58:31'),(84,'Blue Style pant','0040','1756150187829_photo_2025-08-26_01-46-42.jpg','100% good quality.',38000.00,23,12,0,'2025-08-26 01:59:21');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,46,1,5,'ss','2025-08-28 16:57:09'),(2,46,1,5,'hi','2025-08-28 17:03:12'),(3,46,2,5,'haha','2025-08-28 17:03:54'),(4,46,2,2,'dd','2025-08-28 17:04:23'),(5,26,2,3,'nice','2025-08-28 17:28:41'),(6,29,2,5,'very good','2025-08-30 20:30:00'),(7,51,2,4,'not bad','2025-08-30 20:56:01'),(8,68,2,5,'good','2025-08-30 20:56:18'),(9,42,2,5,'i like it \r\n','2025-08-30 20:56:38');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  `isdeleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','0977777779','Yangon','admin@gmail.com','21232f297a57a5a743894a0e4a801fc3','admin',0,'2025-03-01 00:00:00'),(2,'MgMg','932342333','Mandalay','mgmg@gmail.com','b59c67bf196a4758191e42f76670ceba','customer',0,'2025-03-01 00:00:00'),(3,'AungAung','0932423432','Ayeyarwady','aa@gmail.com','934b535800b1cba8f96a5d72f72f1611','customer',0,'2025-03-01 00:00:00'),(4,'Tun Tun','09589125632','Bago','htun@gmail.com','2be9bd7a3434f7038ca27d1918de58bd','customer',0,'2025-03-01 00:00:00'),(5,'ThetHtar','09111111111','Yangon','htar@gmail.com','dbc4d84bfcfe2284ba11beffb853a8c4','customer',0,'2025-08-03 08:49:19'),(13,'moe moe','09234234233','Nay Pyi Taw','mm@gmail.com','c5fe25896e49ddfe996db7508cf00534','customer',0,'2025-08-28 11:00:52');
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

-- Dump completed on 2025-09-10 21:59:08
