<?php 

if( isset($_SESSION['ang_secc_uid']) && isset($_SESSION['ang_secc_email']) && isset($_SESSION['ang_secc_profile']) ){
	session_unset($_SESSION['ang_secc_uid']);
	session_unset($_SESSION['ang_secc_email']);
	session_unset($_SESSION['ang_secc_profile']);
	print 'notauthentified';
}else{
	print 'authentified';
}

?>