<?php 

include_once("DB.php");
include_once("./Classe/Metier/Ligue.php");

Class DB_Ligue extends DB{

	function getPersonnelLigue($pId){
		 
	}

	//renvoi un objet ligue
	function getLigue($id){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getLigue(:id)";

		//on envoie la requête
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(":id",$id);
		
		if ($stmt->execute()){
			if (count($resultat = $stmt->fetch(PDO::FETCH_ASSOC)) != 0){

				$Ligue = new Ligue();
				
				$Ligue->setID($resultat["lig_id"]);
				$Ligue->setLibelle($resultat["lig_libelle"]);
				$Ligue->setDescription($resultat["lig_description"]);
				$Ligue->setLibelle($resultat["lig_libelle"]);
				$Ligue->setLibelle($resultat["lig_libelle"]);
				$Ligue->setLibelle($resultat["lig_libelle"]);
			}else{
				echo("Requete vide");
				return false;
			}
		}else{
			echo("Erreur dans la requête");
			return false;
		}
	}

	//renvoi un tableau d'objet Ligue
	function getAllLigue(){
		$tableauRetour = array();

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getAllLigues()";

		//on envoie la requête
		$stmt = $dbh->prepare($sql);
		
		if ($stmt->execute()){
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){

				$Ligue = new Ligue();

				$Ligue->setId($row["lig_id"]);
				$Ligue->setLibelle($row["lig_libelle"]);
				$Ligue->setDescription($row["lig_description"]);

				$tableauRetour[] = $Ligue;
			}
		}else{
			echo("Erreur lors de l'éxecution de la requête");
			return false;
		}
		return $tableauRetour;
	}
}
?>