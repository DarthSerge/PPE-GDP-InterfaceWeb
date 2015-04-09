<?php
	//construit automatiquement un tableau HTLM avec les données d'un tableau d'objet
	function buildTableau($pTableauEntete){

		echo("<table>");
		for($i=0;$i<count($pTableauData)+1;$i++){
			echo("<tr>");
			for($j=0;$j<count($pTableauEntete);$j++){
				echo("<td>");
					if ($i==0){
						echo($pTableauEntete[j]);
					}else{
						echo($pTableauData[i]);
					}
				echo("</td>");
			}
			echo("</tr>");
		}
		echo("</table>");
	}

	function buildArrayObject($tableauObjet){
		$tableau = array();

		foreach($tableauObjet as $tableauIntermediaire){
			$tableau[] = $tableauIntermediaire;
		}
	}

	//Affiche un selecteur avec la liste des sports
	function getSelectSport($ListeSport){

		echo("<select name=\"Sports\">");
		echo("<option value=\"\"> ----- Choisir ----- </option>");

		for ($i=0;$i<count($ListeSport);$i++){
			echo("<option value=".$ListeSport[i]->getId().">".$ListeSport[i]->getLibelle()." </option>");
		}

		echo("</select>");	
	}

	//Affiche un selecteur avec la liste des Ligues
	function getSelectLigue($ListeLigue){

		echo("<select name=\"ligue\">");
		echo("<option value=\"\"> ----- Choisir ----- </option>");

		for($i=0;$i<count($ListeLigue);$i++){
			echo("salade de bite");
			echo("<option value=".$ListeLigue[$i]->getId().">".$ListeLigue[$i]->getLibelle()." </option>");
		}
		echo("</select>");	
	}

	//Affiche un selecteur avec la liste des types de personne
	function getSelectType($ListeType){

		echo("<select name=\"type\">");
		echo("<option value=\"\"> ----- Choisir ----- </option>");

		for($i=0;$i<count($ListeType);$i++){
			echo("<option value=".$ListeType[$i]->getId().">".$ListeType[$i]->getLibelle()." </option>");
		}
		echo("</select>");	
	}
?>