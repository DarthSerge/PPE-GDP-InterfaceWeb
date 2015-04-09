<?php
	session_start();
    include_once("./Procédure/functionAffiche.php")
?>
<!DOCTYPE html>
    <html>
            <head>
                    <title>Gestion des ligues </title>
                    <meta charset="utf-8" />
             </head>
             <body>
                    <?php
                        //cas du superadministrateur
                        if ($_SESSION["Statut_code"] = 1){

                                $tableauLigue = 
                                echo("<table>");
                                for($i=0;$i<count($pTableauData)+1;$i++){
                                    echo("<tr>");
                                    for($j=0;$j<count($pTableauEntete);$j++){
                                        echo("<td>");
                                            if ($i==0){
                                                echo($pTableauEntete[j]);
                                            }else{
                                                echo($pTableauData[i].);
                                            }
                                        echo("</td>");
                                    }
                                    echo("</tr>");
                                }
                                echo("</table>");
                        }
                    ?>
             </body>
     </html>