<?php 
	$msg = array();
	if( isset($_SESSION['ang_secc_uid']) && isset($_SESSION['ang_secc_email']) && isset($_SESSION['ang_secc_profile']) ){
		$msg['profile'] = $_SESSION['ang_secc_profile'];
		echo json_encode($msg);
	}else{
		$msg['profile'] = null;
		echo json_encode($msg);
	}
		

?>