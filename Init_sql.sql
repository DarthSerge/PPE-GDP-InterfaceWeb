-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 20 Mars 2015 à 17:35
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
-- Fonctions
--
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
  `lig_administrateur_id` int(11) NOT NULL,
  PRIMARY KEY (`lig_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `ligue`
--

INSERT INTO `ligue` (`lig_id`, `lig_libelle`, `lig_administrateur_id`) VALUES
(1, 'Ligue Jill Officielle', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `personnel`
--

INSERT INTO `personnel` (`pers_id`, `pers_nom`, `pers_prenom`, `pers_email`, `pers_password`, `pt_id`, `lig_id`) VALUES
(1, 'Popolov', 'Serge', 'serge@mail.com', 'serge', 1, 1);

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
