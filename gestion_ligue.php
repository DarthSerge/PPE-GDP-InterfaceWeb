<?php
	session_start();

?>
<!DOCTYPE html>
    <html>
         
            <head>
                    <title>Gestion de la ligue : <?php echo(); ?> </title>
                    <meta charset="utf-8" />
             </head>

             <body>
                    <?php
                        
                    ?>
                    <form action="identification.php" method="post">
                         <p> Login : <input type="text" name="login" /></p>
                         <p> Mot de passe : <input type="password" name="mdp" /></p>
                         <p><input type="submit" value="Connection"></p>
                    </form>
                
             </body>
     </html>