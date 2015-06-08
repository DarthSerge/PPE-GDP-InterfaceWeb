<?php
	session_start();
    include_once("./Procedure/functionAffiche.php");
    include_once("./Classe/Metier/Personne.php");
    include_once("./Procedure/structure.php");

     if (isset($_GET["id"]))
        head("Modification d'une personne");
    else
        head("Ajout d'une personne");

    $lig  = new Ligue();
    $pers = new Personne();

    if(isset($_GET["id"])){

        $resultat = $pers->getInfos($_GET["id"]);

        $nom    = $resultat["pers_nom"];
        $prenom = $resultat["pers_prenom"];
        $email  = $resultat["pers_email"];
        $id     = $_GET["id"];
    } else {
        $nom    = "";
        $prenom = "";
        $email  = "";
        $id     = 0;
    }

    if (isset($_POST["id_personne"])){

        $Erreur = ""; 

        if ($_POST["nom"] == ""){
            $Erreur = "Le nom est obligatoire"; 
        } else if ($_POST["prenom"] == ""){
             $Erreur = "Le prenom est obligatoire"; 
        } else if ($_POST["mdp"] == ""){
             $Erreur = "Le mot de passe est obligatoire"; 
        } else if ($_POST["mdp2"] == ""){
             $Erreur = "La répétition du mot de passe est obligatoire"; 
        } else if (!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)){
             $Erreur = "Email incorrect";
        } else if ($_POST["mdp"] != $_POST["mdp2"]){
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
    
    echo("<div id=\"bloc\">\n<form action=\"gestion_personne.php\" method=\"post\">\n");

    if(isset($_GET["id"]))
        echo("<h1>Modification d'un employé</h1>");
    else
        echo("<h1>Ajout d'un employé</h1>");

    echo("<p>Formulaire</p>");
    echo("<div><label>Nom : </label><input type=\"text\" name=\"nom\" value=\"".$nom."\" /></div>\n");
    echo("<div><label>Prénom : </label><input type=\"text\" name=\"prenom\" value=\"".$prenom."\" /></div>\n");
    echo("<div><label>Email : </label><input type=\"email\" name=\"email\" value=\"".$email."\" /></div>\n");
    echo("<div><label>Mot de passe : </label><input type=\"password\" name=\"mdp\" /></div>\n");
    echo("<div><label>Encore : </label><input type=\"password\" name=\"mdp2\" /></div>\n");
    echo("<input type=\"hidden\" name=\"id_personne\" value=\"".$id."\" />\n");
    echo("<a href=\"indexAdmin.php\"><input type=\"button\" value=\"Retour\" id=\"boutonRetour\"/></a>\n");
    echo("<input type=\"submit\" value=\"Valider\" id=\"boutonValider\"/>\n");
    echo("</form>\n</div>\n");
    echo("<div id=\"msgresultat\"></div>\n");
   
    footer();
?>