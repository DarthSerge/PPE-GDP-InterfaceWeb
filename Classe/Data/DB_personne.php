<?php
include_once("./Classe/Metier/Type.php");
include_once("./Classe/Technique/Script.php");
include_once("Salt.php");

Class DB_Personne extends DB{

	//test de connection
	function checkId($login,$mdp){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL checkId(:login,:mdp)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':login',$login);
		$stmt->BindValue(':mdp',md5(saltPassword($mdp)));

		//renvoi l'id si les identifiants sont corrects ou faux si erreur SQL ou identifiants incorrects
		if ($stmt->execute()){

			$resultat = $stmt->fetch(PDO::FETCH_ASSOC);

			if (count($resultat) != 0){
				return $resultat["pers_id"];
			}else{
				echo("Mauvais password");
				return false;
			}		
		}
		else{
			/*scriptAlert("Erreur dans la requête");*/
			return false;
		}
	}

	function getInfos($pId){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getPersonne(:id)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':id',$pId);
		
		//renvoi 
		if ($stmt->execute()){
			return $stmt->fetch(PDO::FETCH_ASSOC);
		}
		else{
			scriptAlert("Erreur dans la requête");
			return false;
		}
	}

	//renvoi un tableau contenant tout les types de personne
	function getTypePersonne(){

		$retour = array();

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL getTypePersonne()";

		//on envoie la requête
		$stmt = $dbh->prepare($sql);

		if($stmt->execute()){
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){

			$type = new Type();
			$type->setId($row["pt_id"]);
			$type->setLibelle($row["pt_libelle"]);

			$retour[] = $type;
			}
		return $retour;
		}else{
			echo("Erreur dans la requête");
			return false;
		}
	}

	//Ajoute une personne en base 
	function addPersonne($nom,$prenom,$mdp,$ligue_id,$statut_id,$mail){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL insertPersonne(:nom,:prenom,:mdp,:ligue_id,:statut_id,:mail)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':nom',$nom);
		$stmt->BindValue(':prenom',$prenom);
		$stmt->BindValue(':mdp',md5(saltPassword($mdp)));
		$stmt->BindValue(':ligue_id',$ligue_id);
		$stmt->BindValue(':statut_id',$statut_id);
		$stmt->BindValue(':mail',$mail);
		
		//renvoi 
		return $stmt->execute();
	}

	function deletePersonne($id){

		//connection a la base
		$dbh = $this->connect();
		$sql = "CALL deletePersonne(:id)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':id',$id);
		
		//renvoi 
		return $stmt->execute();
	}
}

?>