<?php

include_once("DB.php");

class DB_Sport extends DB{

	function getSport($pId){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getSportLibelle(:id)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':id',$pId);
		
		$resultat = $stmt->fetch(PDO::FETCH_ASSOC);

			if (count($resultat) != 0){
				return $resultat["sp_libelle"];
			}else{
				echo("Erreur dans la requete");
				return false;
	}

	function getAllSport(){

		$tableauRetour;

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getAllSports()";

		//on envoie la requête 
		$stmt = $dbh->prepare($sql);
		
		$resultat = $stmt->fetch(PDO::FETCH_ASSOC);

			if (count($resultat) != 0){
				while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$Sport = new Sport();

				$Sport.setId($resulat["sp_id"]);
				$Sport.setLibelle($resulat["sp_libelle"]);

				$tableauRetour[] = $Sport;
				}

				return $tableauRetour;
			}else{
				echo("Erreur dans la requete");
				return false;
	}
	}
}