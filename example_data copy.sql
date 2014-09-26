# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.6.16)
# Database: blackjack
# Generation Time: 2014-09-11 22:38:56 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table casino_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `casino_log`;

CREATE TABLE `casino_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gambler_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `game` enum('BLACKJACK','CRAPS','POKER') DEFAULT NULL,
  `net_amount` decimal(10,2) DEFAULT NULL,
  `mood` enum('ANGRY','OK','HAPPY') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `casino_log` WRITE;
/*!40000 ALTER TABLE `casino_log` DISABLE KEYS */;

INSERT INTO `casino_log` (`id`, `gambler_id`, `visit_date`, `game`, `net_amount`, `mood`)
VALUES
	(1,2,'2013-10-07','CRAPS',-34.00,'OK'),
	(2,2,'2013-11-16','BLACKJACK',-259.00,'OK'),
	(3,1,'2014-01-02','BLACKJACK',-197.00,'OK'),
	(4,4,'2014-03-02','POKER',205.00,'HAPPY'),
	(5,2,'2014-02-22','CRAPS',-437.00,'ANGRY'),
	(6,5,'2013-12-31','POKER',-568.00,'OK'),
	(7,5,'2014-01-27','CRAPS',527.00,'HAPPY'),
	(8,4,'2014-01-05','BLACKJACK',935.00,'HAPPY'),
	(9,5,'2014-06-21','CRAPS',-91.00,'OK'),
	(10,1,'2014-05-26','BLACKJACK',-652.00,'ANGRY'),
	(11,1,'2014-05-09','CRAPS',-987.00,'ANGRY'),
	(12,1,'2013-12-26','POKER',-981.00,'ANGRY'),
	(13,1,'2013-09-22','CRAPS',-941.00,'ANGRY'),
	(14,3,'2013-09-19','BLACKJACK',-762.00,'ANGRY'),
	(15,4,'2014-04-14','POKER',-987.00,'ANGRY'),
	(16,2,'2013-09-29','BLACKJACK',-648.00,'OK'),
	(17,3,'2014-03-16','BLACKJACK',278.00,'HAPPY'),
	(18,3,'2014-07-28','BLACKJACK',-449.00,'OK'),
	(19,1,'2014-06-03','POKER',-408.00,'OK'),
	(20,1,'2014-03-06','POKER',-694.00,'OK'),
	(21,1,'2013-12-09','BLACKJACK',-244.00,'OK'),
	(22,4,'2014-03-15','BLACKJACK',-141.00,'OK'),
	(23,4,'2014-03-28','BLACKJACK',-971.00,'ANGRY'),
	(24,2,'2014-02-01','POKER',-432.00,'ANGRY'),
	(25,5,'2013-12-16','BLACKJACK',247.00,'HAPPY'),
	(26,3,'2014-01-28','BLACKJACK',938.00,'HAPPY'),
	(27,1,'2013-11-09','BLACKJACK',-948.00,'ANGRY'),
	(28,5,'2014-07-22','BLACKJACK',-928.00,'ANGRY'),
	(29,4,'2014-07-02','BLACKJACK',-795.00,'OK'),
	(30,4,'2013-12-07','CRAPS',192.00,'HAPPY'),
	(31,3,'2014-03-05','BLACKJACK',573.00,'HAPPY'),
	(32,1,'2014-05-22','BLACKJACK',-290.00,'ANGRY'),
	(33,1,'2013-12-22','BLACKJACK',-729.00,'OK'),
	(34,1,'2014-06-03','POKER',776.00,'HAPPY'),
	(35,1,'2013-10-21','BLACKJACK',-695.00,'OK'),
	(36,5,'2014-05-01','BLACKJACK',-144.00,'OK'),
	(37,5,'2014-02-18','BLACKJACK',-638.00,'OK'),
	(38,5,'2014-03-03','CRAPS',-756.00,'ANGRY'),
	(39,4,'2014-06-02','BLACKJACK',-866.00,'ANGRY'),
	(40,1,'2014-01-24','BLACKJACK',-64.00,'OK'),
	(41,5,'2013-10-03','BLACKJACK',-720.00,'OK'),
	(42,4,'2013-10-27','POKER',410.00,'HAPPY'),
	(43,5,'2014-06-03','BLACKJACK',-889.00,'ANGRY'),
	(44,1,'2013-12-03','BLACKJACK',-216.00,'OK'),
	(45,4,'2013-09-20','POKER',-410.00,'ANGRY'),
	(46,3,'2014-04-22','BLACKJACK',-405.00,'ANGRY'),
	(47,1,'2014-02-22','BLACKJACK',-796.00,'ANGRY'),
	(48,5,'2014-01-20','BLACKJACK',-720.00,'OK');

/*!40000 ALTER TABLE `casino_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gamblers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gamblers`;

CREATE TABLE `gamblers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `gamblers` WRITE;
/*!40000 ALTER TABLE `gamblers` DISABLE KEYS */;

INSERT INTO `gamblers` (`id`, `first_name`, `last_name`, `gender`)
VALUES
	(1,'Darth','Vader','MALE'),
	(2,'James','Bond','MALE'),
	(3,'Mega','Mind','MALE'),
	(4,'Bat','Woman','FEMALE'),
	(5,'Princess','Leiah','FEMALE');

/*!40000 ALTER TABLE `gamblers` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
