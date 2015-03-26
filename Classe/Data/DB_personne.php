<?php

include("DB.php");
include("./Classe/Technique/Script.php");
include("Salt.php");

Class Db_Personne extends DB{

	//test de connection
	function checkId($login,$mdp){

		//connection a la base
		$dbh = $this->connect();
		$sql = "SELECT checkId(:login,:mdp)";

		//on envoie la requête et on bind les arguments
		$stmt = $dbh->prepare($sql);
		$stmt->BindValue(':login',$login);
		$stmt->BindValue(':mdp',md5(saltPassword($mdp)));
		
		//renvoi vrai si les identifiants sont corrects ou faux si erreur SQL ou identifiants incorrects
		if ($stmt->execute()){
			return ($stmt->fetch() != null);
		}
		else{
			scriptAlert("Erreur dans la requête");
			return false;
		}
	}
}

?>