<?php 

class Type{

	private $id;
	private $libelle;

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