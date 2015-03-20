<?php 

define("PRESALT","ValarMorgulis");
define("SUFSALT","sergeestunbongars");

//Ajoute le salt au password
function saltPassword($Password){
	return(PRESALT.$Password.SUFSALT);
}

?>