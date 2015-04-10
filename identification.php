<?php 
    session_start();
    include_once("./classe/Metier/Personne.php");
    include_once("./Procedure/structure.php");

    head("Connexion");

    if (isset($_POST["login"]) && isset($_POST["mdp"])){
        $pers = new Personne();

        if (!$pers->createSession($_POST["login"],$_POST["mdp"])){
           messageNOK("Erreur dans les identifiants");
        }else{
            $_SESSION["id"] = $pers->getId();
            $_SESSION["statut_code"] = $pers->getStatutId();
            $_SESSION["nom"] = $pers->getNom();
            $_SESSION["prenom"] = $pers->getPrenom();
            $_SESSION["lig_id"] = $pers->getLigueId();

            header("Location:indexAdmin.php");                      
        }
    }else{
?>
<form action="identification.php" method="post">
     <p> Login : <input type="text" name="login" /></p>
     <p> Mot de passe : <input type="password" name="mdp" /></p>
     <p><input type="submit" value="Connection"></p>
</form>
<div id="msgresultat"></div>
<?php 
}
    footer();
?>
