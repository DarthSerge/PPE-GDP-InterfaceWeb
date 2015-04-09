<?php 
    session_start();
    $pers = new Personne();
    $lig = new Ligue();
    $Lig->getLigue($_SESSION["lig_id"]);
?>
<!DOCTYPE html>
    <html>
            <head>
                    <title>Accueil</title>
                    <meta charset="utf-8" />
                        <p>Connecté en tant que : <?php $_SESSION["nom"]." ".$_SESSION["prenom"] ?></p>
                        <p>Gestion de la ligue :  <?php $Lig->getLibelle() ?>  </p>

             </head>

             <body>
                <a href="add_personnel.php">Ajouter une personne à la ligue</a>
                <?php

                $Personne = $pers->getTableauAttributs();
                $PersonneLigue = $Lig->getListePersonnel();

                echo("<table>");
                    for($i=0;$i<count($PersonneLigue);$i++){
                        echo("<tr>");
                        for($j=0;$j<count($Personne)+2;$j++){
                            echo("<td>");
                                if ($i==0){
                                    echo($Personne[j]);
                                }else{
                                    echo($PersonneLigue[i]->getIndiceAttributs(j));
                                }
                            echo("</td>");
                        }
                        echo("</tr>");
                    }
                echo("</table>");
                ?>
             </body>
     </html>