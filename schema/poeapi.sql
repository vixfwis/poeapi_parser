-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: poeapi
-- ------------------------------------------------------
-- Server version	10.4.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_UN` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=744 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_discord`
--

DROP TABLE IF EXISTS `char_discord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_discord` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` bigint(20) unsigned DEFAULT NULL,
  `discord_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `char_discord_UN` (`char_id`,`discord_id`),
  KEY `char_discord_FK_1` (`discord_id`),
  CONSTRAINT `char_discord_FK` FOREIGN KEY (`char_id`) REFERENCES `chars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `char_discord_FK_1` FOREIGN KEY (`discord_id`) REFERENCES `discord` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_discord`
--

LOCK TABLES `char_discord` WRITE;
/*!40000 ALTER TABLE `char_discord` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_discord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chars`
--

DROP TABLE IF EXISTS `chars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chars_UN` (`name`),
  KEY `chars_FK` (`account_id`),
  CONSTRAINT `chars_FK` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=742 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chars`
--

LOCK TABLES `chars` WRITE;
/*!40000 ALTER TABLE `chars` DISABLE KEYS */;
/*!40000 ALTER TABLE `chars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_UN` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'chaos'),(2,'ex'),(3,'mir');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discord`
--

DROP TABLE IF EXISTS `discord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discord` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vouch` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discord`
--

LOCK TABLES `discord` WRITE;
/*!40000 ALTER TABLE `discord` DISABLE KEYS */;
/*!40000 ALTER TABLE `discord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hcraft_names`
--

DROP TABLE IF EXISTS `hcraft_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hcraft_names` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hcraft_names_UN` (`name`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hcraft_names`
--

LOCK TABLES `hcraft_names` WRITE;
/*!40000 ALTER TABLE `hcraft_names` DISABLE KEYS */;
INSERT INTO `hcraft_names` VALUES (1,'<white>{Augment} an item with a new <white>{Attack} modifier'),(2,'<white>{Augment} an item with a new <white>{Lightning} modifier'),(3,'<white>{Remove} a random <white>{Chaos} modifier from an item'),(4,'<white>{Sacrifice} up to half a stack of <white>{Divination Cards} to receive between 0 and twice that amount of the same Card'),(5,'<white>{Augment} an item with a new <white>{Chaos} modifier'),(6,'<white>{Remove} a random <white>{non-Caster} modifier from an item and <white>{add} a new <white>{Caster} modifier'),(7,'<white>{Augment} a Magic or Rare item with a new <white>{Caster} modifier'),(8,'<white>{Remove} a random <white>{non-Attack} modifier from an item and <white>{add} a new <white>{Attack} modifier'),(9,'<white>{Remove} a random <white>{non-Cold} modifier from an item and <white>{add} a new <white>{Cold} modifier'),(10,'<white>{Remove} a random <white>{non-Life} modifier from an item and <white>{add} a new <white>{Life} modifier'),(11,'<white>{Change} a modifier that grants <white>{Cold} Resistance into a similar-tier modifier that grants <white>{Fire} Resistance'),(12,'<white>{Augment} a Magic or Rare item with a new <white>{Caster} modifier with Lucky values'),(13,'<white>{Remove} a random <white>{non-Lightning} modifier from an item and <white>{add} a new <white>{Lightning} modifier'),(14,'<white>{Remove} a random <white>{non-Defence} modifier from an item and <white>{add} a new <white>{Defence} modifier'),(15,'<white>{Remove} a random <white>{Cold} modifier from an item'),(16,'<white>{Augment} an item with a new <white>{Cold} modifier with Lucky values'),(17,'<white>{Remove} a random <white>{Fire} modifier from an item and <white>{add} a new <white>{Fire} modifier'),(18,'<white>{Reforge} a Rare item, keeping all <white>{Suffixes}'),(19,'<white>{Change} a modifier that grants <white>{Lightning} Resistance into a similar-tier modifier that grants <white>{Fire} Resistance'),(20,'<white>{Change} an <white>{Elder Fragment} into another random Elder Fragment of that type'),(21,'<white>{Remove} a random <white>{Caster} modifier from an item'),(22,'<white>{Augment} a Magic or Rare item with a new <white>{Fire} modifier with Lucky values'),(23,'<white>{Augment} an item with a new <white>{Attack} modifier with Lucky values'),(24,'<white>{Randomise} the numeric values of the random <white>{Speed} modifiers on a Magic or Rare item'),(25,'<white>{Remove} a random <white>{non-Critical} modifier from an item and <white>{add} a new <white>{Critical} modifier'),(26,'<white>{Remove} a random <white>{Influence} modifier from an item'),(27,'<white>{Augment} an item with a new <white>{Critical} modifier with lucky values'),(28,'<white>{Change} a modifier that grants <white>{Fire} Resistance into a similar-tier modifier that grants <white>{Cold} Resistance'),(29,'<white>{Change} a modifier that grants <white>{Fire} Resistance into a similar-tier modifier that grants <white>{Lightning} Resistance'),(30,'<white>{Change} a modifier that grants <white>{Lightning} Resistance into a similar-tier modifier that grants <white>{Cold} Resistance'),(31,'<white>{Randomise} the numeric values of the random <white>{Life} modifiers on a Magic or Rare item'),(32,'<white>{Augment} an item with a new <white>{Defence} modifier'),(33,'<white>{Remove} a random <white>{Cold} modifier from an item and <white>{add} a new <white>{Cold} modifier'),(34,'<white>{Remove} a random <white>{Attack} modifier from an item'),(35,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Critical} modifier. <white>{Critical} modifiers are more common'),(36,'<white>{Remove} a random <white>{non-Chaos} modifier from an item and <white>{add} a new <white>{Chaos} modifier'),(37,'<white>{Randomise} the numeric values of the random <white>{Lightning} modifiers on a Magic or Rare item'),(38,'<white>{Remove} a random <white>{non-Physical} modifier from an item and <white>{add} a new <white>{Physical} modifier'),(39,'<white>{Randomise} the numeric values of the random <white>{Attack} modifiers on a Magic or Rare item'),(40,'<white>{Randomise} the numeric values of the random <white>{Physical} modifiers on a Magic or Rare item'),(41,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Critical} modifier'),(42,'<white>{Change} a modifier that grants <white>{Cold} Resistance into a similar-tier modifier that grants <white>{Lightning} Resistance'),(43,'<white>{Reforge} the colour of a <white>{non-Green} socket on an item, turning it <white>{Green}'),(44,'<white>{Reforge} a Rare item, being much <white>{less likely} to receive the same modifier types'),(45,'<white>{Remove} a random <white>{non-Fire} modifier from an item and <white>{add} a new <white>{Fire} modifier'),(46,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants +1 Maximum Mana per 2% quality'),(47,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants +1 Maximum Life per 2% quality'),(48,'Add a random <white>{Influence} to Normal, Magic or Rare <white>{Armour} that isn\'t influenced'),(49,'<white>{Augment} an item with a new <white>{Critical} modifier'),(50,'<white>{Remove} a random <white>{Critical} modifier from an item'),(51,'<white>{Reforge} a Rare item, being much <white>{more likely} to receive the same modifier types'),(52,'<white>{Augment} a Rare item with a new modifier, with Lucky modifier values'),(53,'<white>{Remove} a random <white>{Attack} modifier from an item and <white>{add} a new <white>{Attack} modifier'),(54,'<white>{Reforge} the colour of a <white>{non-Blue} socket on an item, turning it <white>{Blue}'),(55,'Add a random <white>{Influence} to a Normal, Magic or Rare <white>{Weapon} that isn\'t influenced'),(56,'<white>{Enchant} a <white>{Weapon}. Quality does not increase its Physical Damage, grants 1% increased Accuracy per 2% Quality'),(57,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Speed} modifier'),(58,'<white>{Remove} a random <white>{Life} modifier from an item and <white>{add} a new <white>{Life} modifier'),(59,'<white>{Augment} an item with a new <white>{Life} modifier'),(60,'<white>{Remove} a random <white>{Life} modifier from an item'),(61,'<white>{Augment} an item with a new <white>{Speed} modifier'),(62,'<white>{Change} a <white>{Unique Bestiary} item or item with an Aspect into Lures of the same beast family'),(63,'<white>{Reforge} a Rare item with Lucky modifier values, keeping all <white>{Suffixes}'),(64,'<white>{Randomise} the numeric values of the random <white>{Critical} modifiers on a Magic or Rare item'),(65,'Set a new <white>{Implicit} modifier on a <white>{Cobalt, Crimson, Viridian} or <white>{Prismatic Jewel}'),(66,'Set a new <white>{Implicit} modifier on an <white>{Abyss Jewel} or <white>{Timeless Jewel}'),(67,'<white>{Synthesise} an item, giving random Synthesised implicits. Cannot be used on Unique, Influenced, Synthesised or Fractured items'),(68,'<white>{Exchange} a <white>{Resonator} for a Fossil or vice versa. Rare outcomes are more likely with rare inputs'),(69,'<white>{Reforge} the colour of a <white>{non-Red} socket on an item, turning it <white>{Red}'),(70,'<white>{Remove} a random <white>{Physical} modifier from an item and <white>{add} a new <white>{Physical} modifier'),(71,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants +1 Intelligence per 2% quality'),(72,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants 1% Fire Resistance per 2% quality'),(73,'<white>{Enchant} a <white>{Melee Weapon}. Quality does not increase its Physical Damage, has +1 Weapon Range per 10% Quality'),(74,'<white>{Augment} an item with a new <white>{Life} modifier with Lucky values'),(75,'<white>{Augment} an item with a new <white>{Cold} modifier'),(76,'<white>{Change} a stack of <white>{Fossils} into a different type of Fossil'),(77,'<white>{Augment} an item with a new <white>{Defence} modifier with Lucky values'),(78,'<white>{Remove} a random <white>{Caster} modifier from an item and <white>{add} a new <white>{Caster} modifier'),(79,'<white>{Remove} a random <white>{Physical} modifier from an item'),(80,'<white>{Remove} a random <white>{Fire} modifier from an item'),(81,'<white>{Remove} a random <white>{Lightning} modifier from an item and <white>{add} a new <white>{Lightning} modifier'),(82,'<white>{Remove} a random <white>{Lightning} modifier from an item'),(83,'<white>{Augment} an item with a new <white>{Lightning} modifier with Lucky values'),(84,'<white>{Reforge} a Rare item with Lucky modifier values, keeping all <white>{Prefixes}'),(85,'<white>{Reroll} the values of Prefix, Suffix and Implicit modifiers on a Rare item, with Lucky modifier values'),(86,'<white>{Change} a stack of <white>{Timeless Splinters} or a <white>{Timeless Emblem} into Splinters or an Emblem of another type'),(87,'<white>{Reforge} a Rare item, keeping all <white>{Prefixes}'),(88,'<white>{Remove} a random <white>{Defence} modifier from an item and <white>{add} a new <white>{Defence} modifier'),(89,'<white>{Remove} a random <white>{Defence} modifier from an item'),(90,'<white>{Remove} a random <white>{Chaos} modifier from an item and <white>{add} a new <white>{Chaos} modifier'),(91,'<white>{Change} a <white>{Sacrifice} or <white>{Mortal Fragment} into another random Fragment of that type'),(92,'<white>{Change} a <white>{Unique Armour} into another Unique Armour of that type'),(93,'<white>{Remove} a random <white>{Critical} modifier from an item and <white>{add} a new <white>{Critical} modifier'),(94,'<white>{Augment} an item with a new <white>{Chaos} modifier with Lucky values'),(95,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants +1 Strength per 2% quality'),(96,'<white>{Fracture} a random <white>{Suffix} on an item with least 3 Suffixes. This can\'t be used on Influenced, Synthesised, or Fractured items'),(97,'<white>{Enchant} a <white>{Weapon}. Quality does not increase its Physical Damage, grants 1% increased Area of Effect per 4% Quality'),(98,'<white>{Change} a stack of <white>{Delirium Orbs} into a different type of Delirium Orb'),(99,'<white>{Reroll} the values of <white>{Prefix} modifiers on a Magic or Rare item, with Lucky modifier values'),(100,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 40% of the gem\'s total experience stored as a Facetor\'s Lens'),(101,'<white>{Enchant} a <white>{Flask} with a modifier that increases its Effect. The magnitude of this effect decreases with each use'),(102,'<white>{Enchant} a <white>{Flask} with a modifier that increases its Maximum Charges. The magnitude of this effect decreases with each use'),(103,'<white>{Enchant} a <white>{Flask} with a modifier that reduces its Charges used. The magnitude of this effect decreases with each use'),(104,'<white>{Augment} a Magic or Rare item with a new <white>{Physical} modifier'),(105,'<white>{Change} a <white>{Harbinger Unique} or <white>{Unique Piece} into a random Beachhead Map'),(106,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 20% of the gem\'s total experience stored as a Facetor\'s Lens'),(107,'<white>{Fracture} a random modifier on an item with at least 5 modifiers, locking it in place. This can\'t be used on Influenced, Synthesised, or Fractured items'),(108,'<white>{Augment} an item with a new <white>{Influence} modifier'),(109,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Life} modifier'),(110,'<white>{Augment} an item with a new <white>{Influence} modifier with Lucky values'),(111,'<white>{Enchant} a non-Unique <white>{Map} with \"Map boss is surrounded by Tormented Spirits\"'),(112,'<white>{Reforge} a <white>{Normal} or <white>{Magic} item as a Rare item with random modifiers, including a <white>{Speed} modifier'),(113,'<white>{Randomise} the numeric values of the random <white>{Defence} modifiers on a Magic or Rare item'),(114,'<white>{Enchant} a non-Unique <white>{Map} with \"Map has a Vaal Side Area\"'),(115,'<white>{Upgrade} the tier of an <white>{Essence}'),(116,'<white>{Enchant} a non-Unique <white>{Map} with \"Has an additional modifier from Zana\'s crafting bench at random\"'),(117,'<white>{Enchant} a <white>{Weapon}. Quality does not increase its Physical Damage, has 1% increased Attack Speed per 8% Quality'),(118,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{two} random <white>{high-tier} modifiers'),(119,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{four} random <white>{high-tier} modifiers'),(120,'<white>{Upgrade} a <white>{Normal item} to a Magic item, adding <white>{two} random <white>{high-tier} modifiers'),(121,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{three} random <white>{high-tier} modifiers'),(122,'<white>{Enchant} a <white>{Weapon}. Quality does not increase its Physical Damage, grants 1% increased Elemental Damage per 2% Quality'),(123,'<white>{Sacrifice} a <white>{Weapon} or <white>{Armour} to create a <white>{Belt} with similar modifiers'),(124,'<white>{Sacrifice} a <white>{Weapon} or <white>{Armour} to create a <white>{Ring} with similar modifiers'),(125,'<white>{Sacrifice} a <white>{Weapon} or <white>{Armour} to create an <white>{Amulet} with similar modifiers'),(126,'<white>{Upgrade} a <white>{Normal item} to a Magic item, adding <white>{one} random <white>{high-tier} modifier'),(127,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{three} random modifiers'),(128,'<white>{Change} a <white>{Divination Card} into another random Divination Card'),(129,'Add a random <white>{Influence} to Normal, Magic or Rare <white>{Jewellery} that isn\'t influenced'),(130,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Defence} modifier'),(131,'<white>{Remove} a random <white>{Influence} modifier from an item and <white>{add} a new <white>{Influence} modifier'),(132,'<white>{Reforge} a Rare item with new random modifiers, including an <white>{Influence} modifier. <white>{Influence} modifiers are more common'),(133,'<white>{Enchant} a non-Unique <white>{Map} with \"Map doesn\'t consume Sextant charges\"'),(134,'Improves the <white>{Quality} of a <white>{Gem} by at least 10%. The maximum quality is 20%'),(135,'<white>{Upgrades} a Normal Item to a <white>{random rarity} 10 times, using the outcome with the highest rarity'),(136,'<white>{Reroll} the values of <white>{Suffix} modifiers on a Magic or Rare item, with Lucky modifier values'),(137,'<white>{Augment} a Magic or Rare item with a new <white>{Fire} modifier'),(138,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{four} random modifiers'),(139,'Set a new <white>{Implicit} modifier on a <white>{Cluster Jewel}'),(140,'<white>{Remove} a random <white>{non-Influence} modifier from an item and <white>{add} a new <white>{Influence} modifier'),(141,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Speed} modifier. <white>{Speed} modifiers are more common'),(142,'<white>{Augment} a Magic or Rare item with a new <white>{Physical} modifier with Lucky values'),(143,'Set an item to <white>{five sockets}'),(144,'<white>{Reforge} the links between sockets on an item, linking <white>{five sockets}'),(145,'<white>{Randomise} the numeric values of the random <white>{Caster} modifiers on a Magic or Rare item'),(146,'<white>{Enchant} a <white>{Weapon}. Quality does not increase its Physical Damage, has 1% increased Critical Strike Chance per 4% Quality'),(147,'<white>{Randomise} the numeric values of the random <white>{Chaos} modifiers on a Magic or Rare item'),(148,'<white>{Sacrifice} a <white>{Weapon} or <white>{Armour} to create a <white>{Jewel} with similar modifiers'),(149,'<white>{Randomise} the numeric values of the random <white>{Fire} modifiers on a Magic or Rare item'),(150,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants +1 Dexterity per 2% quality'),(151,'<white>{Change} a <white>{Shaper Fragment} into another random Shaper Fragment'),(152,'<white>{Remove} a random <white>{Speed} modifier from an item and <white>{add} a new <white>{Speed} modifier'),(153,'<white>{Remove} a random <white>{non-Speed} modifier from an item and <white>{add} a new <white>{Speed} modifier'),(154,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 50% of the gem\'s total experience stored as a Facetor\'s Lens'),(155,'<white>{Change} an <white>{Offering to the Goddess} into a Dedication to the Goddess'),(156,'<white>{Change} a stack of <white>{Essences} into a different type of the same tier'),(157,'<white>{Randomise} the numeric values of the random <white>{Cold} modifiers on a Magic or Rare item'),(158,'<white>{Change} a <white>{Unique} item into another random Unique item'),(159,'<white>{Change} a <white>{Unique Item} into Perandus Coins. Rarer Unique Items are worth more Perandus Coins'),(160,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 30% of the gem\'s quality as Gemcutter\'s Prisms'),(161,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 50% of the gem\'s quality as Gemcutter\'s Prisms'),(162,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 30% of the gem\'s total experience stored as a Facetor\'s Lens'),(163,'<white>{Change} a stack of <white>{Catalysts} into a different type of Catalyst'),(164,'<white>{Change} a <white>{Gem} into another Gem, carrying over experience and quality if possible'),(165,'<white>{Reforge} the links between sockets on an item, linking <white>{six sockets}'),(166,'<white>{Reforge} a Rare item with new <white>{random modifiers} 10 times, using the outcome with the highest average modifier level'),(167,'<white>{Augment} an item with a new <white>{Speed} modifier with Lucky values'),(168,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants 1% Cold Resistance per 2% quality'),(169,'<white>{Enchant Body Armour}. Quality does not increase its Defences, grants 1% Lightning Resistance per 2% quality'),(170,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 40% of the gem\'s quality as Gemcutter\'s Prisms'),(171,'<white>{Sacrifice} a <white>{Corrupted Map}. Create a new Corrupted Map of the same tier and rarity.'),(172,'<white>{Remove} a random <white>{Speed} modifier from an item'),(173,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Lightning} modifier. <white>{Lightning} modifiers are more common'),(174,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including an <white>{Attack} modifier. <white>{Attack} modifiers are more common'),(175,'Attempt to <white>{upgrade} a <white>{Scarab}, with a chance for it to become Winged'),(176,'<white>{Upgrade} a <white>{Magic item} to a Rare item, adding <white>{two} random modifiers'),(177,'<white>{Change} a stack of <white>{Breach Splinters} or a <white>{Breachstone} into Splinters or a Breachstone of another type'),(178,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Physical} modifier'),(179,'<white>{Change} a <white>{Pale Court Key} into another random Pale Court Key'),(180,'<white>{Change} a <white>{Map} into another of the same tier, prioritising Maps that you have not yet completed'),(181,'<white>{Sacrifice} a <white>{Corrupted Gem} to gain 20% of the gem\'s quality as Gemcutter\'s Prisms'),(182,'<white>{Reforge} the <white>{links between sockets} on an item 10 times, using the outcome with the greatest number of linked sockets'),(183,'<white>{Change} a <white>{Unique Jewel} into another Unique Jewel'),(184,'<white>{Fracture} a random <white>{Prefix} on an item with at least 3 Prefixes. This can\'t be used on Influenced, Synthesised, or Fractured items.'),(185,'Improves the <white>{Quality} of a <white>{Flask} by at least 10%. Has greater effect on lower rarity flasks. The maximum quality is 20%'),(186,'Set an item to <white>{six sockets}'),(187,'<white>{Change} a stack of <white>{Oils} into a different colour of Oil'),(188,'<white>{Change} a <white>{Unique} into a random Unique Weapon'),(189,'<white>{Change} a <white>{Unique} into a random Unique Ring, Amulet or Belt'),(190,'<white>{Exchange} 3 <white>{Cartographer\'s Chisels} for 3 Vaal Orbs'),(191,'<white>{Reforge} the <white>{colours of sockets} on an item 10 times, using the outcome with the greatest number of less-common socket colours'),(192,'<white>{Reforge} the <white>{number of sockets} on an item 10 times, using the outcome with the greatest number of sockets'),(193,'<white>{Split} a <white>{Scarab} into two Scarabs of lower rarity'),(194,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Cold} modifier. <white>{Cold} modifiers are more common'),(195,'<white>{Reforge} a rare item with new random modifiers, including a <white>{Defence} modifier. <white>{Defence} modifiers are more common'),(196,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Physical} modifier. <white>{Physical} modifiers are more common'),(197,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Fire} modifier. <white>{Fire} modifiers are more common'),(198,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Caster} modifier. <white>{Caster} modifiers are more common'),(199,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Life} modifier. <white>{Life} modifiers are more common'),(200,'<white>{Reforge} the colour of a random <white>{socket} on an item, turning it <white>{White}'),(201,'<white>{Sacrifice} a <white>{Red Map} to create random Map Fragments based on its tier'),(202,'<white>{Exchange} 3 <white>{Orbs of Alteration} for 3 Chaos Orbs'),(203,'Attempt to <white>{Awaken} a <white>{level 20 Support Gem} that can be Awakened with a 5% chance. If it does not Awaken, it is destroyed.'),(204,'<white>{Sacrifice} a stack of <white>{Divination Cards} for that many different Divination Cards'),(205,'<white>{Reforge} the colour of <white>{two random} sockets on an item, turning them <white>{Red and Blue}'),(206,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Fire} modifier'),(207,'<white>{Change} an <white>{Offering to the Goddess} into a Gift to the Goddess'),(208,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Chaos} modifier'),(209,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including an <white>{Attack} modifier'),(210,'<white>{Change} a <white>{Unique Weapon} into another Unique Weapon of that weapon type'),(211,'<white>{Enchant} a <white>{Flask} with a modifier that increases its Duration. The magnitude of this effect decreases with each use'),(212,'<white>{Reforge} a <white>{Normal} or <white>{Magic} item as a Rare item with random modifiers, including a <white>{Physical} modifier'),(213,'<white>{Change} a <white>{Scarab} to another Scarab of the same rarity'),(214,'<white>{Upgrade} an <white>{Oil} into an Oil one tier higher'),(215,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Lightning} modifier'),(216,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Chaos} modifier. <white>{Chaos} modifiers are more common'),(217,'<white>{Reforge} a <white>{Rare} item with new random modifiers, including a <white>{Cold} modifier'),(218,'<white>{Sacrifice} a <white>{Map} to gain 3 Niko Atlas Missions based on its colour');
/*!40000 ALTER TABLE `hcraft_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hcrafts`
--

DROP TABLE IF EXISTS `hcrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hcrafts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned DEFAULT NULL,
  `craft_id` bigint(20) unsigned DEFAULT NULL,
  `price` float NOT NULL,
  `currency_id` bigint(20) unsigned DEFAULT NULL,
  `ilvl` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hcrafts_FK` (`item_id`),
  KEY `hcrafts_FK_1` (`currency_id`),
  KEY `hcrafts_FK_2` (`craft_id`),
  CONSTRAINT `hcrafts_FK` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hcrafts_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `hcrafts_FK_2` FOREIGN KEY (`craft_id`) REFERENCES `hcraft_names` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19749 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hcrafts`
--

LOCK TABLES `hcrafts` WRITE;
/*!40000 ALTER TABLE `hcrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `hcrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `verified` tinyint(3) unsigned DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp(),
  `stash_id` bigint(20) unsigned DEFAULT NULL,
  `item_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `items_UN` (`item_hash`),
  KEY `items_FK` (`stash_id`),
  CONSTRAINT `items_FK` FOREIGN KEY (`stash_id`) REFERENCES `stashes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10965 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leagues`
--

DROP TABLE IF EXISTS `leagues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leagues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leagues_UN` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=744 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagues`
--

LOCK TABLES `leagues` WRITE;
/*!40000 ALTER TABLE `leagues` DISABLE KEYS */;
INSERT INTO `leagues` VALUES (1,'Harvest');
/*!40000 ALTER TABLE `leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxies`
--

DROP TABLE IF EXISTS `proxies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `protocol` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxies`
--

LOCK TABLES `proxies` WRITE;
/*!40000 ALTER TABLE `proxies` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stashes`
--

DROP TABLE IF EXISTS `stashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stashes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `stash_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `league_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stashes_UN` (`stash_hash`),
  KEY `stashes_FK` (`account_id`),
  KEY `stashes_FK_1` (`league_id`),
  CONSTRAINT `stashes_FK` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stashes_FK_1` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stashes`
--

LOCK TABLES `stashes` WRITE;
/*!40000 ALTER TABLE `stashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-15 20:24:07
