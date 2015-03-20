<?php

include('DB.php');
include('Script.php');

Class Ligue{

	//attributs
	private $id;
	private $libelle;
	private $id_admin;
	private $ListePersonnel = array();

	//constructeur
	function __construct($id){

		$db = new Connection();
		$Formation = new Formation();

		$this->id = $id;
		
	}

	//renvoi toutes les formations suivi par l'utilisateur
	function getFormationUser(){

		$db = new Connection();

		$this->ListeFormation = $db.getFormationUser($this->id);
	}
}

?>