<?php 
    session_start();
    include_once("./Classe/Metier/Personne.php");
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
    }
?>
<div id="bloc">
<form action="identification.php" method="post">
    <h1>Gestion du personnel</h1>
    <p>Authentification</p>
    <div><label> Email : <span>saisir une adresse valide</span></label><input type="text" name="login" /></div>
    <div><label> Mot de passe : </label><input type="password" name="mdp" /></div>
    <input type="submit" value="Connexion" id="boutonConnexion">
</form>
</div>
<div id="msgresultat"></div>
<?php
    footer();
?>