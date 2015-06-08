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
-- Base de données :  `ppe_gdp`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLigue`(IN `ligue_id` INT)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DELETE FROM personnel WHERE pers_id IN (
        SELECT pers_id FROM personnel WHERE lig_id = ligue_id 			AND pt_id <> 1
        									);
    DELETE FROM ligue WHERE lig_id = ligue_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUtilisateur`(IN `id` INT)
    DETERMINISTIC
BEGIN
	DELETE FROM personnel WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAdmin`(IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT pers_id, pers_nom, pers_prenom, pers_email, pers_password 
    FROM personnel 
    WHERE pers_id = 
    	(SELECT lig_administrateur_id 
         FROM ligue 
         WHERE lig_id = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllLigues`()
    SQL SECURITY INVOKER
BEGIN
	SELECT l.lig_id, lig_libelle, pers_prenom, pers_nom, sp_libelle, (
        SELECT COUNT(pers_id) 
        FROM personnel 
        WHERE lig_id=l.lig_id) as effectif 
    FROM ligue l
    INNER JOIN personnel p ON p.pers_id = l.lig_administrateur_id
    INNER JOIN sport s ON s.sp_id = l.lig_sp_id 
    ORDER BY l.lig_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllSports`()
    SQL SECURITY INVOKER
BEGIN
	SELECT sp_id, sp_libelle
    FROM sport;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmploye`(IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT pers_nom, pers_prenom, pers_email, pers_password, lig_id 
    FROM personnel 
    WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmployesLigue`(IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT pers_id, pers_nom, pers_prenom, pers_email, pers_password, pt_id 
    FROM personnel 
    WHERE lig_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLigue`(IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT lig_libelle, lig_description, sp_id, sp_libelle 
    FROM ligue 
    INNER JOIN sport ON sp_id = lig_sp_id 
    WHERE lig_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getNombreLigues`()
    NO SQL
BEGIN
	SELECT COUNT(lig_id) as nb 
    FROM ligue;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoot`()
    SQL SECURITY INVOKER
BEGIN
	SELECT pers_id, pers_nom, pers_prenom, pers_email, pers_password 
    FROM personnel 
    WHERE pt_id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUtilisateurLigue`(IN `id_Ligue` INT UNSIGNED)
    SQL SECURITY INVOKER
    COMMENT 'Renvoi la liste des personnes appartenant à une ligue'
BEGIN 

SET @id = id_Ligue;

SELECT pers_id,pers_nom,pers_prenom FROM personnel WHERE lig_id = @id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLigue`(IN `libelle` VARCHAR(100), IN `description` TEXT)
    SQL SECURITY INVOKER
BEGIN
    
	INSERT INTO personnel(pers_nom,pers_prenom,pers_email,pt_id,pers_password,lig_id) 
    VALUES(nom,prenom,mail,statut,epassword,ligue_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUtilisateur`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `epassword` VARCHAR(75), IN `ligue_id` INT, IN `statut` INT, IN `mail` VARCHAR(250))
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUtilisateur`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `mail` VARCHAR(250), IN `pass` VARCHAR(75), IN `id` INT)
    SQL SECURITY INVOKER
BEGIN
	UPDATE personnel
    SET pers_nom = nom,
    	pers_prenom = prenom,
        pers_email = mail,
        pers_password = pass 
    WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verifLigueExiste`(IN `id` INT, IN `libelle` VARCHAR(100))
    SQL SECURITY INVOKER
BEGIN
	SELECT COUNT(lig_id) as existe 
    FROM ligue 
    WHERE lig_libelle = libelle 
    AND lig_id <> id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verifMailExiste`(IN `id` INT, IN `mail` VARCHAR(250))
    SQL SECURITY INVOKER
BEGIN
	SELECT COUNT(pers_id) as existe 
    FROM personnel 
    WHERE pers_email = mail
    AND pers_id <> id;
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

CREATE DEFINER=`root`@`localhost` FUNCTION `checkId`(`Login` VARCHAR(250), `mdp` VARCHAR(75)) RETURNS int(1) unsigned
    SQL SECURITY INVOKER
BEGIN 

SET @Login = Login;
SET @mdp = mdp;

SET @id = (SELECT pers_id FROM personnel WHERE pers_email = @Login AND pers_password = @mdp);

RETURN @id;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Contenu de la table `ligue`
--

INSERT INTO `ligue` (`lig_id`, `lig_libelle`, `lig_description`, `lig_administrateur_id`, `lig_sp_id`) VALUES
(21, 'BasketBar', 'Ligue de Basketball de Bar-le-Duc', 26, 5),
(22, 'Metz Soccer Club', 'Club de football de Metz pour les jeunes de 9 à 17ans.', 3, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Contenu de la table `personnel`
--

INSERT INTO `personnel` (`pers_id`, `pers_nom`, `pers_prenom`, `pers_email`, `pers_password`, `pt_id`, `lig_id`) VALUES
(3, 'Popolovich', 'Sergei', 'serge@mail.com', 'e14a57595c0a7c90fc4484f4eb8b926e', 1, NULL),
(26, 'Capitolin', 'Terry', 't.cap@mail.com', 'c81b633ca076b69d890761e14e90b1dd', 2, 21),
(27, 'Priso', 'Francis', 'f.pri@mail.com', '0af1951231dc6076574b630f08fed3ee', 3, 21);

-- --------------------------------------------------------

--
-- Structure de la table `personnel_type`
--

CREATE TABLE IF NOT EXISTS `personnel_type` (
  `pt_id` int(11) NOT NULL AUTO_INCREMENT,
  `pt_libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

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
  ADD CONSTRAINT `FK_personnel_lig_id` FOREIGN KEY (`lig_id`) REFERENCES `ligue` (`lig_id`),
  ADD CONSTRAINT `FK_personnel_pt_id` FOREIGN KEY (`pt_id`) REFERENCES `personnel_type` (`pt_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
