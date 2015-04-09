<?php 

class Sport{

	private $id;
	private $libelle;

	//constructeur
	function __construct(){

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
}

?>