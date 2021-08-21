-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: twitter
-- ------------------------------------------------------
-- Server version	5.7.35-0ubuntu0.18.04.1

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comments_text` text NOT NULL,
  `attachment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (2,2,1,'2021-08-19 05:08:14','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto1.jpg'),(3,2,1,'2021-08-19 05:08:26','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto1.jpg'),(4,2,1,'2021-08-19 05:09:06','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto1.jpg'),(5,2,1,'2021-08-21 10:29:39','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto1.jpg'),(6,2,1,'2021-08-21 10:29:49','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto2.jpg'),(7,2,1,'2021-08-21 10:29:55','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto2.jpg'),(8,3,1,'2021-08-21 10:30:23','Visualize how I can enable #letsdothis? Whenever I can, I am going to finish it #generasigigih #frontend','resto2.jpg');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_hashtag`
--

DROP TABLE IF EXISTS `comments_hashtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments_hashtag` (
  `comment_id` int(11) NOT NULL,
  `hashtag_id` int(11) NOT NULL,
  KEY `comment_id` (`comment_id`),
  KEY `hashtag_id` (`hashtag_id`),
  CONSTRAINT `comments_hashtag_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_hashtag_ibfk_2` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_hashtag`
--

LOCK TABLES `comments_hashtag` WRITE;
/*!40000 ALTER TABLE `comments_hashtag` DISABLE KEYS */;
INSERT INTO `comments_hashtag` VALUES (4,4),(4,5),(4,6),(5,4),(5,5),(5,6),(6,4),(6,5),(6,6),(7,4),(7,5),(7,6),(8,4),(8,5),(8,6);
/*!40000 ALTER TABLE `comments_hashtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hashtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtags`
--

LOCK TABLES `hashtags` WRITE;
/*!40000 ALTER TABLE `hashtags` DISABLE KEYS */;
INSERT INTO `hashtags` VALUES (1,'kejo',0),(2,'japan',0),(3,'imagination',0),(4,'letsdothis',0),(5,'generasigigih',0),(6,'frontend',0),(7,'generasi',0),(8,'gigih',0),(9,'indonesia',0);
/*!40000 ALTER TABLE `hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_text` text NOT NULL,
  `attachment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'2021-08-19 04:51:25',' I can fly to the sky, with the help of my imagination #kejo, #hola','gigih.png'),(2,1,'2021-08-19 04:52:31',' I can fly to the sky #japan, #imagination','gigih.png'),(3,1,'2021-08-19 04:55:22',' I can fly to the sky #japan, #imagination','gigih.png'),(4,1,'2021-08-19 04:56:39',' I can fly to the sky #japan, #imagination','gigih.png'),(5,1,'2021-08-19 11:56:04',' I can fly to the sky #japan, #imagination','gigih.png'),(6,1,'2021-08-19 11:56:31',' I can fly to the sky #japan, #imagination','gigih.png'),(7,1,'2021-08-19 12:02:25',' I can fly to the sky #japan, #imagination','gigih.png'),(8,1,'2021-08-19 12:03:02',' I can fly to the sky #japan, #imagination','gigih.png'),(9,1,'2021-08-20 08:49:44',' I can fly to the sky #japan, #imagination','SteamedBuns.jpg'),(10,2,'2021-08-20 08:51:08',' I can fly to the sky #japan, #imagination','SteamedBuns.jpg'),(11,3,'2021-08-20 08:56:05',' I can fly to the sky #japan, #imagination','SteamedBuns.jpg'),(12,3,'2021-08-21 10:13:51','halo dunia #generasi #gigih','gigih.png'),(13,2,'2021-08-21 10:14:34','halo semangat #generasi #gigih #indonesia','gigih.png');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_hashtag`
--

DROP TABLE IF EXISTS `posts_hashtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_hashtag` (
  `post_id` int(11) NOT NULL,
  `hashtag_id` int(11) NOT NULL,
  KEY `post_id` (`post_id`),
  KEY `hashtag_id` (`hashtag_id`),
  CONSTRAINT `posts_hashtag_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `posts_hashtag_ibfk_2` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_hashtag`
--

LOCK TABLES `posts_hashtag` WRITE;
/*!40000 ALTER TABLE `posts_hashtag` DISABLE KEYS */;
INSERT INTO `posts_hashtag` VALUES (2,2),(2,3),(3,2),(3,3),(4,2),(4,3),(6,2),(6,3),(7,2),(7,3),(8,2),(8,3),(9,2),(9,3),(10,2),(10,3),(11,2),(11,3),(12,7),(12,8),(13,7),(13,8),(13,9);
/*!40000 ALTER TABLE `posts_hashtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `bio` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jordan','jordan@gmail.com','saya anak indonesia dan sehat'),(2,'kejo','kejo@gmail.com','saya anak sehat'),(3,'marcell','marcell@gmail.com','saya anak sehat'),(4,'marcell','marcell@gmail.com','saya anak sehat'),(5,'marcell','marcell@gmail.com','saya anak indo');
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

-- Dump completed on 2021-08-21 18:06:24
