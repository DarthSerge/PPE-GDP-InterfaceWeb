<?php 
    session_start();
    include_once("./classe/Data/DB_Personne.php");
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
                            $db = new DB_Personne;

                            //on test les identifiants de connexion
                            if ($db->checkId($_POST["login"],$_POST["mdp"])){
                                $_SESSION["id"] = 
                            }
                            else{

                                echo("Identifiants incorrect !");
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