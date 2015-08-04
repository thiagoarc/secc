<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

	if( $params->email != '' ){

		$stmt = $oConexao->prepare("SELECT email, senha, perfil FROM usuario WHERE upper(email) = upper(:email) AND upper(senha) = upper(:senha)");  
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('senha', sha1( $params->password ) );
		$stmt->execute();
		$usuario = $stmt->fetchObject();
		$oConexao = null;

		if( $usuario ){
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