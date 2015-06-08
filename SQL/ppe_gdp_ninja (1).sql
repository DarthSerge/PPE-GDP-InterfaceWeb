-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 08 Juin 2015 à 16:16
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `ppe_gdp_ninja`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkId`(IN `Login` VARCHAR(250), IN `mdp` VARCHAR(75))
    SQL SECURITY INVOKER
BEGIN 

SELECT pers_id FROM personnel WHERE pers_email = Login AND pers_password = mdp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRoot`(IN `password` VARCHAR(75))
    SQL SECURITY INVOKER
BEGIN
	SET @passRoot = (SELECT pers_password FROM personnel WHERE pt_id = 1);
	SELECT @passRoot = MD5(password) as test;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLigue`(IN `ligue_id` INT)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DELETE FROM personnel WHERE pers_id IN (
        SELECT pers_id FROM personnel WHERE lig_id = ligue_id 			AND pt_id <> 1
        									);
    DELETE FROM ligue WHERE lig_id = ligue_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePersonne`(IN `id` INT)
    DETERMINISTIC
BEGIN
	DELETE FROM personnel WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllLigues`()
    SQL SECURITY INVOKER
BEGIN
	SELECT l.lig_id, lig_libelle, pers_prenom, pers_nom, sp_libelle,l.lig_description, (
        SELECT COUNT(pers_id) 
        FROM personnel 
        WHERE lig_id=l.lig_id) as effectif 
    FROM ligue l
    INNER JOIN personnel p ON p.pers_id = l.lig_administrateur_id
    INNER JOIN sport s ON s.sp_id = l.lig_sp_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllSports`()
    SQL SECURITY INVOKER
BEGIN
	SELECT sp_id, sp_libelle
    FROM sport;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLigue`(IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT 				
    	l.lig_id,
        l.lig_description,
        l.lig_libelle,                                    					s.sp_libelle,
        s.sp_id,
        p.pers_id,
        p.pers_nom,
        p.pers_prenom,
        p.pt_id
    FROM
    	ligue l 
    	LEFT JOIN sport s ON s.sp_id = l.lig_sp_id
        LEFT JOIN personnel p ON p.pers_id = l.lig_administrateur_id
    WHERE
    	l.lig_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getNombreLigues`()
    NO SQL
BEGIN
	SELECT COUNT(lig_id) as nb 
    FROM ligue;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonne`(IN `id` INT)
    SQL SECURITY INVOKER
    COMMENT 'Renvoi les informations d''une personne'
BEGIN 
	SELECT pers_nom,pers_prenom,pers_email,pt_id,lig_id
    FROM personnel
    WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonneLigue`(IN `id` INT UNSIGNED)
    SQL SECURITY INVOKER
    COMMENT 'Renvoi la liste des personnes appartenant à une ligue'
BEGIN 
SELECT pers_id,pers_nom,pers_prenom,pers_email FROM personnel WHERE lig_id = id ORDER BY pt_id,pers_nom,pers_prenom;
END$$

CREATE DEFINER=`root`@`locahost` PROCEDURE `getSportLibelle`(IN `id` INT)
    SQL SECURITY INVOKER
    COMMENT 'renvoi le libélle du sport passé en paramètre'
BEGIN
	SELECT sp_libelle FROM sport WHERE sp_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTypePersonne`()
    SQL SECURITY INVOKER
BEGIN
	SELECT pt_id,pt_libelle FROM personnel_type;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLigue`(IN `libelle` VARCHAR(100), IN `description` TEXT)
    SQL SECURITY INVOKER
BEGIN
    
	INSERT INTO personnel(pers_nom,pers_prenom,pers_email,pt_id,pers_password,lig_id) 
    VALUES(nom,prenom,mail,statut,epassword,ligue_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPersonne`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `epassword` VARCHAR(75), IN `ligue_id` INT, IN `statut` INT, IN `mail` VARCHAR(250))
    SQL SECURITY INVOKER
BEGIN
    
	INSERT INTO personnel(pers_nom,pers_prenom,pers_email,pt_id,pers_password,lig_id) 
    VALUES(nom,prenom,mail,statut,epassword,ligue_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLigue`(IN `libelle` VARCHAR(100), IN `description` TEXT, IN `ligue_id` INT)
    SQL SECURITY INVOKER
BEGIN
	UPDATE ligue
    SET lig_libelle = libelle,
    	lig_description = description
    WHERE 
    	lig_id = ligue_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePersonne`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `mail` VARCHAR(250), IN `pass` VARCHAR(75), IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	UPDATE personnel
    SET pers_nom = nom,
    	pers_prenom = prenom,
        pers_email = mail,
        pers_password = pass
    WHERE pers_id = id;
END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `checkAdmin`(`id` INT) RETURNS tinyint(1)
    SQL SECURITY INVOKER
BEGIN
	SET @type = (SELECT pt_id FROM personnel WHERE pers_id = id);
    
    CASE
        WHEN @type = 2 OR @type = 1 THEN RETURN true;
        WHEN @type = 3 THEN RETURN false;
    END CASE;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `ligue`
--

CREATE TABLE IF NOT EXISTS `ligue` (
  `lig_id` int(11) NOT NULL AUTO_INCREMENT,
  `lig_libelle` varchar(100) DEFAULT NULL,
  `lig_description` text NOT NULL,
  `lig_administrateur_id` int(11) NOT NULL,
  `lig_sp_id` int(11) NOT NULL,
  PRIMARY KEY (`lig_id`),
  KEY `lig_sp_id` (`lig_sp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `ligue`
--

INSERT INTO `ligue` (`lig_id`, `lig_libelle`, `lig_description`, `lig_administrateur_id`, `lig_sp_id`) VALUES
(3, 'Basketball RPZ', 'Ligue de basketball !', 3, 2),
(4, 'Sussu Curling', 'Cucu !', 4, 4),
(5, 'Canada mgl', 'Hockeeeeeeeey !', 3, 7);

-- --------------------------------------------------------

--
-- Structure de la table `personnel`
--

CREATE TABLE IF NOT EXISTS `personnel` (
  `pers_id` int(11) NOT NULL AUTO_INCREMENT,
  `pers_nom` varchar(50) DEFAULT NULL,
  `pers_prenom` varchar(50) DEFAULT NULL,
  `pers_email` varchar(250) DEFAULT NULL,
  `pers_password` varchar(75) DEFAULT NULL,
  `pt_id` int(11) DEFAULT NULL,
  `lig_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pers_id`),
  KEY `FK_personnel_pt_id` (`pt_id`),
  KEY `FK_personnel_lig_id` (`lig_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Contenu de la table `personnel`
--

INSERT INTO `personnel` (`pers_id`, `pers_nom`, `pers_prenom`, `pers_email`, `pers_password`, `pt_id`, `lig_id`) VALUES
(3, 'Popolov', 'Serge', 'serge@mail.com', '5a2204e9473c526b4c0993159d652a4e', 1, NULL),
(4, 'Kiwi', 'Johnny', 'ninja@mail.com', '5a2204e9473c526b4c0993159d652a4e', 3, 4),
(15, 'poulet', 'basquez', 'poulet@mail.com', '5a2204e9473c526b4c0993159d652a4e', 2, 4);

-- --------------------------------------------------------

--
-- Structure de la table `personnel_type`
--

CREATE TABLE IF NOT EXISTS `personnel_type` (
  `pt_id` int(11) NOT NULL,
  `pt_libelle` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `personnel_type`
--

INSERT INTO `personnel_type` (`pt_id`, `pt_libelle`) VALUES
(1, 'Super-Administrateur'),
(2, 'Administrateur'),
(3, 'Employé');

-- --------------------------------------------------------

--
-- Structure de la table `sport`
--

CREATE TABLE IF NOT EXISTS `sport` (
  `sp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_libelle` varchar(50) NOT NULL,
  PRIMARY KEY (`sp_id`),
  UNIQUE KEY `sp_libelle` (`sp_libelle`),
  UNIQUE KEY `sp_libelle_2` (`sp_libelle`),
  KEY `sp_id` (`sp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `sport`
--

INSERT INTO `sport` (`sp_id`, `sp_libelle`) VALUES
(5, 'Baseball'),
(2, 'Basketball'),
(4, 'Curling'),
(1, 'Football'),
(3, 'Handball'),
(7, 'Hockey'),
(6, 'Voleyball');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `ligue`
--
ALTER TABLE `ligue`
  ADD CONSTRAINT `fk_sport_ligue` FOREIGN KEY (`lig_sp_id`) REFERENCES `sport` (`sp_id`);

--
-- Contraintes pour la table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `FK_personnel_lig_id` FOREIGN KEY (`lig_id`) REFERENCES `ligue` (`lig_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
