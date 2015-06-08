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
  SELECT        
      l.lig_id,
        l.lig_description,
        l.lig_libelle,                                              s.sp_libelle,
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
    SQL SECURITY INVOKER
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePersonne`(IN `id` INT)
    DETERMINISTIC
BEGIN
  DELETE FROM personnel WHERE pers_id = id;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPersonne`(IN `nom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `epassword` VARCHAR(75), IN `ligue_id` INT, IN `statut` INT, IN `mail` VARCHAR(250))
    SQL SECURITY INVOKER
BEGIN
    
  INSERT INTO personnel(pers_nom,pers_prenom,pers_email,pt_id,pers_password,lig_id) 
    VALUES(nom,prenom,mail,statut,epassword,ligue_id);
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

CREATE DEFINER=`root`@`localhost` FUNCTION `checkId`(`Login` VARCHAR(250), `mdp` VARCHAR(75)) RETURNS int(1) unsigned
    SQL SECURITY INVOKER
BEGIN 

SET @Login = Login;
SET @mdp = mdp;

SET @id = (SELECT pers_id FROM personnel WHERE pers_email = @Login AND pers_password = @mdp);

RETURN @id;

END$$

DELIMITER ;