<?php 

session_start();
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->email != '' ){

		$stmt = $oConexao->prepare("SELECT idusuario, email, perfil FROM usuario WHERE upper(email) = upper(:email) AND upper(senha) = upper(:senha)");  
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('senha', sha1( $params->password ) );
		$stmt->execute();
		$usuario = $stmt->fetchObject();
		$oConexao = null;

		if( $usuario ){
			//create session local browser
			$_SESSION['ang_secc_uid'] 		= $usuario->idusuario;
			$_SESSION['ang_secc_email'] 	= $usuario->email;
			$_SESSION['ang_secc_profile'] 	= $usuario->perfil;
			echo json_encode($usuario);
		}else{
			echo '{ "credentials": "null" }';
		}

	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>