<?php 

Class DB_Ligue extends DB{

	function getPersonnelLigue($pId){

		 
	}

	//renvoi un tableau d'objet Ligue
	function getAllLigue(){
		$tableauRetour = array();

		//connection a la base
		$dbh = $this->connect();
		$sql = "SELECT getAllLigue()";

		//on envoie la requête
		$stmt = $dbh->prepare($sql);
		
		if ($stmt->execute()){
			while($row = $stmt->fetch()){
				$Ligue = new Ligue();
				$tableauRetour[] = $Ligue;
			}
		}

		return $tableauRetour;
	}

}

?>