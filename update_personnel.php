<?php
	session_start();
?>
<!DOCTYPE html>
    <html>
            <head>
                    <title>Modifier une personne</title>
                    <meta charset="utf-8" />
             </head>
             <body>
                   <?php
                        if (isset($_POST["nom"]) && isset($_POST["prenom"]) && isset($_POST["email"]) && isset($_POST["mdp"]) && isset($_POST["mdp2"])){

                            $Erreur = ""; 

                            //on test le mail
                            if(!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)){
                                $Erreur = "Email incorrect";
                            }

                            //on test les mots de passe
                            if ($_POST["mdp"] != $_POST["mdp2"]){
                                $Erreur = "Les mots de passe doivent être identiques";
                            }

                             //on test la sélection d'une Ligue
                            if ($_POST["ligue"] == ""){
                                $Erreur = "Le choix de la ligue est obligatoire";
                            }

                            //on crée la personne s'il n'y a pas d'erreur
                            if ($Erreur == ""){
                                $pers = new Personne();

                                $pers->setNom($_POST["nom"]);
                                $pers->setPrenom($_POST["prenom"]);
                                $pers->setMotDePasse($_POST["mdp"]);
                                $pers->setEmail($_POST["email"]);
                                $pers->setNom($_POST["ligue"]);

                                if (!$pers->addPersonne()){
                                    echo("Erreur lors de la création");
                                }else{
                                    echo("Personne bien créée");
                                    header('location : http://localhost/ppe-gdp-interfaceweb/gestion_ligue.php');
                                }
                            }else{
                                echo($Erreur);
                            }
                        }
                    ?>
                    <form action="add_personnel.php" method="post">
                         <p> Nom :          <input type="text" name="nom" /></p>
                         <p> Prénom :       <input type="text" name="prenom" /></p>
                         <p> Mail :         <input type="email" name="email" /></p>
                         <p> Mot de passe :   <input type="password" name="mdp" /></p>
                         <p> Répétez le mot de passe :   <input type="password" name="mdp2" /></p>
                         <p> <?php getSelectLigue($lig->getAllLigue()); ?> </p>
                         <p>                <input type="submit" value="Valider"></p>
                    </form>
             </body>
     </html>