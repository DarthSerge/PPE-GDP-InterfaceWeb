<?php
	session_start();
    include_once("./Procedure/functionAffiche.php");
    include_once("./Classe/Metier/Personne.php");
    include_once("./Procedure/structure.php");

    head("Ajout d'une personne");

    $lig  = new Ligue();
    $pers = new Personne();

    if(isset($_GET["id"])){

        $resultat = $pers->getInfos($_GET["id"]);

        $nom    = $resultat["pers_nom"];
        $prenom = $resultat["pers_prenom"];
        $email  = $resultat["pers_email"];
        $id     = $_GET["id"];
    }else{
        $nom    = "";
        $prenom = "";
        $email  = "";
        $id     = 0;
    }

    if (isset($_POST["id_personne"])){

        $Erreur = ""; 

        if($_POST["nom"] == ""){
            $Erreur = "Le nom est obligatoire"; 
        }elseif($_POST["prenom"] == ""){
            $Erreur = "Le prenom est obligatoire"; 
        }elseif($_POST["mdp"] == ""){
            $Erreur = "Le mot de passe est obligatoire"; 
        }elseif($_POST["mdp2"] == ""){
            $Erreur = "La répétition du mot de passe est obligatoire"; 
        }elseif(!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)){
            $Erreur = "Email incorrect";
        }elseif($_POST["mdp"] != $_POST["mdp2"]){
            $Erreur = "Les mots de passe doivent être identiques";
        }

        if ($Erreur == ""){

            $pers->setNom($_POST["nom"]);
            $pers->setPrenom($_POST["prenom"]);
            $pers->setMotDePasse($_POST["mdp"]);
            $pers->setEmail($_POST["email"]);
            $pers->setLigueId($_SESSION["lig_id"]);
            $pers->setStatutId(3);

            if ($_POST["id_personne"] == 0){
                if ($pers->addPersonne()){
                    header("Location:indexAdmin.php");
                }else{
                    messageNOK("Erreur lors de l'ajout !");
                }
            }else{
                if ($pers->updatePersonne($_POST["id_personne"])){
                    header("Location:indexAdmin.php");
                }else{
                    messageNOK("Erreur lors de la modification !");
                }
            } 
        }else{
            messageNOK($Erreur);
        }
    }
    
    echo("<form action=\"gestion_personne.php\" method=\"post\">\n");
    echo("<p> Nom : <input type=\"text\" name=\"nom\" value=\"".$nom."\" /></p>\n");
    echo("<p> Prénom : <input type=\"text\" name=\"prenom\" value=\"".$prenom."\" /></p>\n");
    echo("<p> Mail : <input type=\"email\" name=\"email\" value=\"".$email."\" /></p>\n");
    echo("<p> Mot de passe : <input type=\"password\" name=\"mdp\" /></p>\n");
    echo("<p> Répétez le mot de passe : <input type=\"password\" name=\"mdp2\" /></p>\n");
    echo("<p> <input type=\"submit\" value=\"Valider\" /></p>\n");
    echo("<input type=\"hidden\" name=\"id_personne\" value=\"".$id."\" />\n");
    echo("</form>\n");
    echo("<div id=\"msgresultat\"></div>\n");

    echo("<a href=\"indexAdmin.php\">Retour</a>\n");
   
    footer();
?>