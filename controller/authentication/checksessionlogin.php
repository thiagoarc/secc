<?php 
	
	if( isset($_SESSION['ang_secc_uid']) && isset($_SESSION['ang_secc_email']) && isset($_SESSION['ang_secc_profile']) ){
		print 'authentified';
	}else{
		print 'notauthentified';
	}
		

?>