<?php

include_once('./Classe/Data/DB_Ligue.php');
include_once('./Classe/Technique/Script.php');
include_once('Sport.php');
include_once('Personne.php');

Class Ligue{

	//attributs
	private $id;
	private $libelle;
	private $description;
	private $Sport;
	private $Admin;
	private $ListePersonnel = array();

	//constructeur
	function __construct(){
		$this->Sport = new Sport();
		$this->Admin = new Personne();
	}

	function getListePersonnel(){
		return $this->ListePersonnel;
	}

	function setListePersonnel($Liste){
		$this->ListePersonnel = $Liste;
	}

	function setId($id){
		$this->id = $id;
	}

	function getId(){
		return $this->id;
	}

	function setLibelle($Libelle){
		$this->Libelle = $Libelle;
	}

	function getLibelle(){
		return $this->Libelle;
	}

	function setDescription($Description){
		$this->description = $Description;
	}

	function getDescription(){
		return $this->description;
	}

	function setSportId($sport_id){
		$this->Sport->setId($sport_id);
	}

	function getSportID(){
		return $this->Sport->getId();
	}

	function setSportLibelle($sport_libelle){
		$this->Sport->setLibelle($sport_Libelle);
	}

	function getSportLibelle(){
		return $this->Sport->getLibelle();
	}

	function setAdminId($id){
		$this->Admin->setId($id);
	}

	function getAdminId(){
		return $this->Admin->getId();
	}

	function setAdminNom($nom){
		$this->Admin->setNom($nom);
	}

	function getAdminNom(){
		return $this->Admin->getNom();
	}

	function getTableauAttributs(){
		$retour = array();

		$retour[] = "Id";
		$retour[] = "Libelle";
		$retour[] = "Description";
		$retour[] = "SportLibelle";
		$retour[] = "Admin";

		return $retour;
	}

	function getListePersonnel(){
		$data = new DB_Ligue();

		return $data->getPersonnelLigue($id);
	}

	//renvoi un tableau de ligue
	function getAllLigue(){
		$data = new DB_Ligue();

		return $data->getAllLigue();
	}

	function getLigue($id){
		$data = new DB_Ligue();

		return $data->getLigue($id);
	}
}

?>