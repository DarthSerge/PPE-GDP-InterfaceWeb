<?php

function head($Titre){
	echo("<!DOCTYPE html>\n");
	echo("<html>\n");
	echo("<head>\n");
	echo("<title>".$Titre."</title>\n");  
	echo("<meta charset=\"utf-8\"/>\n");
	echo("<script type=\"text/javascript\" src=\"jquery-2.1.3.min.js\"></script>\n");
	echo("</head>\n");
	echo("<body>\n");
}

function footer(){
	echo("</body>\n");
	echo("</html>");
}

function messageOK($message){
	?>
		<script>
			$(document).ready(function() {
				$("#msgresultat").html(<?php echo("<font color=\"#96CA2D\">".$message."</font>");?>);
			});
		</script>
	<?php
}

function messageNOK($message){
	?>
		<script>
			$(document).ready(function() {
				$("#msgresultat").html(<?php echo("<font color=\"#B9121B\">".$message."</font>");?>);
			});
		</script>
	<?php
}

?>