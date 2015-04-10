<?php

include_once('./Classe/Data/DB_Ligue.php');
include_once('./Classe/Technique/Script.php');
include_once('sport.php');
include_once('Personne.php');

Class Ligue{

	//attributs
	private $id;
	private $libelle;
	private $description;
	private $sport;
	private $admin;
	private $ListePersonnel = array();

	//constructeur
	function __construct(){
		$this->sport = new sport();
		$this->admin = new Personne();
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

	function setLibelle($libelle){
		$this->libelle = $libelle;
	}

	function getLibelle(){
		return $this->libelle;
	}

	function setDescription($description){
		$this->description = $description;
	}

	function getDescription(){
		return $this->description;
	}

	function setSportId($sport_id){
		$this->sport->setId($sport_id);
	}

	function getSportId(){
		return $this->sport->getId();
	}

	function setSportlibelle($sport_libelle){
		$this->sport->setlibelle($sport_libelle);
	}

	function getSportlibelle(){
		return $this->sport->getlibelle();
	}

	function setAdminId($id){
		$this->admin->setId($id);
	}

	function getAdminId(){
		return $this->admin->getId();
	}

	function setAdminNom($nom){
		$this->admin->setNom($nom);
	}

	function getAdminNom(){
		return $this->admin->getNom();
	}

	function getTableauAttributs(){
		$retour = array();

		$retour[] = "Id";
		$retour[] = "libelle";
		$retour[] = "description";
		$retour[] = "sportlibelle";
		$retour[] = "admin";

		return $retour;
	}

	function getListePersonnelBase(){
		$data = new DB_Ligue();

		return $data->getPersonnelLigue($this->id);
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