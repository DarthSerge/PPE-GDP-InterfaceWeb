<?php

include_once('Ligue.php');
include_once('./Classe/Data/DB_Personne.php');

Class Personne{

	//attributs
	private $nom;
	private $prenom;
	private $email;
	private $mdp;
	private $id;
	private $statut_id;
	private $ligue_id;

	//constructeur
	function __construct(){
	}

	//getters et setter
	function setNom($nom){
		$this->nom = $nom;
	}

	function getNom(){
		return $this->nom;
	}

	function setPrenom($prenom){
		$this->prenom = $prenom;
	}

	function getPrenom(){
		return $this->prenom;
	}

	function setEmail($mail){
		$this->email = $mail;
	}
 
	function getEmail(){
		return $this->email;
	}

	function setMotDePasse($mdp){
		$this->mdp = $mdp;
	}

	function getMotDePasse(){
		return $this->mdp;
	}

	function setId($id){
		$this->id = $id;
	}

	function getId(){
		return $this->id;
	}

	function setStatutID($statut_id){
		$this->statut_id = $statut_id;
	}

	function getStatutID(){
		return $this->statut_id;
	}

	function setLigueId($ligId){
		$this->ligue_id = $ligId;
	}

	function getLigueId(){
		return $this->ligue_id;
	}

	//test les identifiants et créer l'entité si les informations de saisie sont correctes
	function createSession($login,$mdp){

		$data = new DB_Personne();

		//On test les identifiants de connexion
		$id = $data->checkId($login,$mdp);

		if ($id != 0){
			//On récupère les informations de compte
			$info = $data->getInfos($id);

			if ($info["pers_nom"] == ""){
				return false;
			}else{
				$this->nom 			= $info["pers_nom"];
				$this->prenom 		= $info["pers_prenom"];
				$this->id 			= $id;
				$this->statut_id 	= $info["pt_id"];
				$this->ligue_id		= $info["lig_id"];

				return true;
			}
		}
		return false;
	}

	function getTableauAttributs(){
		$retour = array();

		$retour[] = "Id";
		$retour[] = "Nom";
		$retour[] = "Prenom";
		$retour[] = "Mail";

		return $retour;
	}

	function getIndiceAttributs($indice){
		switch ($indice){
			case 0 : return $this->getId(); 
			case 1 : return $this->getNom(); 
			case 2 : return $this->getPrenom();
			case 3 : return $this->getEmail(); 
		}
	}

	function getTypePersonne(){
		$data = new DB_Personne();

		return $data->getTypePersonne();
	}

	function addPersonne(){
		$data = new DB_Personne();

		return $data->addPersonne($this->nom,$this->prenom,$this->mdp,$this->ligue_id,$this->statut_id,$this->email);
	}

	function updatePersonne($id){
		$data = new DB_Personne();

		return $data->updatePersonne($this->nom, $this->prenom, $this->email, $this->password, $id);
	}

	function deletePersonne($id){
		$data = new DB_Personne();

		return $data->deletePersonne($id);
	}

	function getInfos($id){
		$data = new DB_Personne();

		return $data->getInfos($id);
	}
}

?>