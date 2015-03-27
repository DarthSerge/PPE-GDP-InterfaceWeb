<?php

include('DB.php');
include('Script.php');

Class Ligue{

	//attributs
	private $lig_id;
	private $lig_libelle;
	private $lig_description;
	private $lig_administrateur_id;

	private $ListePersonnel = array();

	//constructeur
	function __construct(){
	}
}

?>