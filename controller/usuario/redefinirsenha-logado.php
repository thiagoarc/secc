<?php 

session_start();
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

$msg = array();
header('Content-type: application/json');

try{

	if( $_SESSION['ang_secc_uid'] ){

		$stmt = $oConexao->prepare("UPDATE usuario SET senha = :senha WHERE email = :email");  
		$stmt->bindParam('senha', sha1( $params->senha ) );
		$stmt->bindParam('email', $_SESSION['ang_secc_email'] );
		$usuario = $stmt->execute();
		$oConexao = null;

		if( $usuario ){
			$msg['message'] = 'success';
	        echo json_encode($msg);
		}else{
			$msg['message'] = 'error';
	        echo json_encode($msg);
		}

	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>