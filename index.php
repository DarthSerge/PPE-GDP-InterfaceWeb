<?php 
    session_start();
?>
<!DOCTYPE html>
    <html>
            <head>
                    <title>Accueil</title>
                    <meta charset="utf-8" />
                    Connecté en tant que : <?php $_SESSION["nom"]." ".$_SESSION["prenom"] ?>
             </head>

             <body>
                <a href="add_personnel.php">Ajouter une personne</a>
                <a href="update_personnel.php">Modifier une personne</a>
                <a href="add_personnel.php">Supprimer une personne</a>
             </body>
     </html>