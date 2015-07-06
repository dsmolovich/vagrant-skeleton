<div style="background-color: #ffcccc; border: dashed 2px #ff8888; padding: 1em; margin: 1em;">
	<p>Here's the contents of <b><?php echo $_SERVER["SCRIPT_FILENAME"]?></b> in the VM <?=$_SERVER["HTTP_HOST"]?>
	that is mapped to <b>src/example.com.src/public/index.php</b> on host machine.</p>
</div>

<?php
phpinfo();
