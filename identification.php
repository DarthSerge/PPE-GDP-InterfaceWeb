<?php 
    session_start();
    include_once("./classe/Metier/Personne.php");
?>
<!DOCTYPE html>
    <html>
            <head>
                    <title>Connection</title>
                    <meta charset="utf-8" />
             </head>

             <body>
                    <?php
                        if (isset($_POST["login"]) && isset($_POST["mdp"])){
                            $pers = new Personne();

                            if (!$pers->createSession($_POST["login"],$_POST["mdp"])){
                               echo("Erreur dans les identifiants");
                            }else{
                                $_SESSION["id"] = $pers->getId();
                                $_SESSION["statut_code"] = $pers->getStatutId();
                                $_SESSION["nom"] = $pers->getNom();
                                $_SESSION["prenom"] = $pers->getPrenom();
                                $_SESSION["lig_id"] = $pers->getLigueId();

                                header('location : PPE-GDP-InterfaceWeb/index.php');
                                die();                       
                            }
                        }
                    ?>
                    <form action="identification.php" method="post">
                         <p> Login : <input type="text" name="login" /></p>
                         <p> Mot de passe : <input type="password" name="mdp" /></p>
                         <p><input type="submit" value="Connection"></p>
                    </form>
             </body>
     </html>