-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 27 Mars 2015 à 15:17
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
        SELECT pers_id FROM personnel WHERE lig_id = ligue_id       AND pt_id <> 1
                          );
    DELETE FROM ligue WHERE lig_id = ligue_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUtilisateur`(IN `id` INT)
    DETERMINISTIC
BEGIN
  DELETE FROM personnel WHERE pers_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllLigue`()
    SQL SECURITY INVOKER
BEGIN
  SELECT * FROM ligue;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUtilisateur`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `mail` VARCHAR(250), IN `pass` VARCHAR(75), IN `statut` INT, IN `ligue_id` INT)
BEGIN
  UPDATE personnel
    SET pers_nom = nom,
      pers_prenom = prenom,
        pers_email = mail,
        pt_id = statut,
        pers_password = pass,
        lig_id = ligue_id;
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
  PRIMARY KEY (`lig_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `ligue`
--

INSERT INTO `ligue` (`lig_id`, `lig_libelle`, `lig_description`, `lig_administrateur_id`) VALUES
(1, 'Ligue Jill Officielle', 'Ceci est un test', 1),
(2, 'Ligue ALl Star FAP', 'Ceci est un encore un test', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `personnel`
--

INSERT INTO `personnel` (`pers_id`, `pers_nom`, `pers_prenom`, `pers_email`, `pers_password`, `pt_id`, `lig_id`) VALUES
(1, 'Popolov', 'Serge', 'serge@mail.com', '5a2204e9473c526b4c0993159d652a4e', 1, 1),
(2, 'pipou', 'poup', 'poupipou@mail.com', 'poupi', 3, 2);

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

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `FK_personnel_lig_id` FOREIGN KEY (`lig_id`) REFERENCES `ligue` (`lig_id`),
  ADD CONSTRAINT `FK_personnel_pt_id` FOREIGN KEY (`pt_id`) REFERENCES `personnel_type` (`pt_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
