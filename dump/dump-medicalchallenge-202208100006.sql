-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: medicalchallenge
-- ------------------------------------------------------
-- Server version	5.5.5-10.8.3-MariaDB

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
-- Table structure for table `agendamentos`
--

DROP TABLE IF EXISTS `agendamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) DEFAULT NULL,
  `id_profissional` int(11) NOT NULL,
  `dh_inicio` datetime NOT NULL,
  `dh_fim` datetime NOT NULL,
  `id_convenio` int(11) DEFAULT NULL,
  `id_procedimento` int(11) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agendamento_id_convenio_idx` (`id_convenio`),
  KEY `agendamento_id_procedimento_idx` (`id_procedimento`),
  KEY `agendamento_id_profissional_idx` (`id_profissional`),
  KEY `agendamento_id_paciente_idx` (`id_paciente`),
  CONSTRAINT `agendamento_id_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_procedimento` FOREIGN KEY (`id_procedimento`) REFERENCES `procedimentos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `agendamento_id_profissional` FOREIGN KEY (`id_profissional`) REFERENCES `profissionais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos`
--

LOCK TABLES `agendamentos` WRITE;
/*!40000 ALTER TABLE `agendamentos` DISABLE KEYS */;
INSERT INTO `agendamentos` VALUES (1,1,1,'2021-02-01 08:30:00','2021-02-01 08:45:00',1,1,'primeira consulta do paciente'),(2,5,2,'2021-02-01 08:30:00','2021-02-01 09:00:00',2,1,'100'),(3,2,1,'2021-02-01 14:00:00','2021-02-01 14:30:00',3,1,'não cobrar'),(4,7,1,'2021-02-03 17:15:00','2021-02-03 18:00:00',3,1,''),(5,6,2,'2021-02-04 13:30:00','2021-02-04 13:50:00',1,1,'paciente com dores fortes'),(6,8,2,'2021-02-12 14:20:00','2021-02-12 15:00:00',1,1,'parente do Dr. Lucas'),(7,2,1,'2021-02-12 14:25:00','2021-02-12 14:45:00',3,1,'xxx'),(8,3,2,'2021-03-07 15:00:00','2021-03-07 15:30:00',1,1,''),(9,5,1,'2021-03-08 10:15:00','2021-03-08 11:00:00',2,2,''),(10,7,2,'2021-03-21 09:10:00','2021-03-21 10:30:00',3,1,''),(11,1,2,'2021-03-22 11:00:00','2021-03-22 11:30:00',1,2,''),(12,3,1,'2021-03-22 11:10:00','2021-03-22 11:50:00',1,1,'paciente indicado pela filha do dr.'),(13,5,1,'2021-06-04 09:00:00','2021-06-04 09:45:00',2,1,''),(14,4,2,'2021-06-05 17:00:00','2021-06-05 17:25:00',2,1,'…'),(15,4,1,'2021-06-15 17:15:00','2021-06-15 18:00:00',2,3,''),(16,6,1,'2021-06-28 11:00:00','2021-06-28 11:30:00',1,2,'X-x-x-x'),(17,9,1,'2021-08-06 08:30:00','2021-08-06 08:45:00',2,1,''),(18,1,2,'2021-08-16 10:15:00','2021-08-16 11:00:00',1,3,'dores de cabeça muito fortes'),(19,8,2,'2021-08-19 08:30:00','2021-08-19 09:00:00',1,1,'queixa de dor na coluna');
/*!40000 ALTER TABLE `agendamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convenios`
--

DROP TABLE IF EXISTS `convenios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convenios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convenios`
--

LOCK TABLES `convenios` WRITE;
/*!40000 ALTER TABLE `convenios` DISABLE KEYS */;
INSERT INTO `convenios` VALUES (1,'Hospital',NULL),(2,'Migração',NULL),(3,'Particular',NULL);
/*!40000 ALTER TABLE `convenios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `sexo` enum('Masculino','Feminino') NOT NULL,
  `nascimento` date NOT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `id_convenio` int(11) DEFAULT NULL,
  `cod_referencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paciente_id_convenio_idx` (`id_convenio`),
  CONSTRAINT `paciente_id_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'Rúben Rebelo César','Masculino','1990-05-02','908.394.690-80','27.046.463-3',1,'10268'),(2,'Lázaro Goulart Camarinho','Masculino','1983-06-04','095.805.480-05','25.903.805-2',3,'10269'),(3,'Gabrielly Sesimbra Candeias','Feminino','1967-12-12','207.182.310-90','41.845.430-9',1,'10270'),(4,'Hernâni Fidalgo Brito','Masculino','1975-10-14','307.522.380-86','42.896.829-6',2,'10271'),(5,'Isaac Severiano Nunes','Masculino','1966-04-15','007.217.650-41','49.040.121-1',2,'10272'),(6,'Amélie Azenha Fontoura','Feminino','1982-02-17','610.800.760-50','26.659.290-9',1,'10274'),(7,'Joel Medina Covilhã','Masculino','1956-10-22','468.052.020-51','13.060.699-6',3,'10275'),(8,'Lorenzo Milheirão Remígio','Masculino','1972-09-29','247.294.840-96','45.056.413-7',1,'10276'),(9,'Gabriella Fialho Feijó','Feminino','1988-07-16','454.421.590-00','42.395.070-8',2,'10277');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedimentos`
--

DROP TABLE IF EXISTS `procedimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedimentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedimentos`
--

LOCK TABLES `procedimentos` WRITE;
/*!40000 ALTER TABLE `procedimentos` DISABLE KEYS */;
INSERT INTO `procedimentos` VALUES (1,'Consulta',NULL),(2,'Retorno',NULL),(3,'Acompanhamento',NULL);
/*!40000 ALTER TABLE `procedimentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profissionais`
--

DROP TABLE IF EXISTS `profissionais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profissionais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `crm` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profissionais`
--

LOCK TABLES `profissionais` WRITE;
/*!40000 ALTER TABLE `profissionais` DISABLE KEYS */;
INSERT INTO `profissionais` VALUES (1,'Pietro',NULL),(2,'Dr. Lucas',NULL);
/*!40000 ALTER TABLE `profissionais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'medicalchallenge'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-10  0:06:20
