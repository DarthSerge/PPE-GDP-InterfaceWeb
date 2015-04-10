<?php 
    session_start();
    include_once("./Classe/Metier/Personne.php");
    include_once("./Classe/Metier/Ligue.php");
    include_once("./Procedure/structure.php");

    head("Gestion du personnel");

     if(isset($_GET["deconnexion"])){
        session_destroy();
    }

    $pers = new Personne();
    $Lig  = new Ligue();

    if (isset($_SESSION["lig_id"])){
        $Lig = $Lig->getLigue($_SESSION["lig_id"]);
    }else{
        header("Location:identification.php");
    }

     if(isset($_GET["supprimer"]) && $_GET["supprimer"] != ""){
        if($pers->deletePersonne($_GET["supprimer"])){
            messageOK("Suppression réussie !");
        }else{
            messageNOK("Echec de la suppression !");
        }
    }
?>
<p>Connecté en tant que : <?php echo($_SESSION["prenom"]." ".$_SESSION["nom"]); ?></p>
<p>Gestion de la ligue :  <?php echo($Lig->getLibelle()); ?>  </p>

<a href="gestion_personne.php">Ajouter une personne à la ligue</a>

<?php

$Personne = $pers->getTableauAttributs();
$PersonneLigue = $Lig->getListePersonnelBase();

echo("<table border = \"1\">");
    for($i=0;$i<count($PersonneLigue)+1;$i++){
        echo("<tr>");
        for($j=0;$j<count($Personne)+2;$j++){
            echo("<td>");
                if ($i==0){
                    if ($j == count($Personne)){
                        echo("Modifier");
                    }elseif($j == count($Personne)+1){
                        echo("Supprimer");
                    }else{
                        echo($Personne[$j]);
                    }
                }else{
                    if ($j == count($Personne)){
                        echo("&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"gestion_personne.php?id=".$PersonneLigue[$i-1]->getIndiceAttributs(0)."\" ><img src=\"./Images/modif.png\" title=\"Modifier l'employé\"></a>");
                    }elseif($j == count($Personne)+1){
                        echo("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:if(confirm('Etes vous sûr(e) de vouloir supprimer cet employé(e) ?')){document.location.href='?supprimer=".$PersonneLigue[$i-1]->getIndiceAttributs(0)."';}\" ><img src=\"./Images/supprime.png\" title=\"Supprimer l'employé\"></a>");
                    }else{
                       echo($PersonneLigue[$i-1]->getIndiceAttributs($j));
                    }
                }
            echo("</td>");
        }
        echo("</tr>");
    }
echo("</table>");
?>
<a href="?deconnexion">Se déconnecter</a>
<div id="msgresultat"></div>
<?php
    footer();
?>