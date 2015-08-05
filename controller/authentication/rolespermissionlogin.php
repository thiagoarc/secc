<?php 

session_start();
$oConexao = Conexao::getInstance();

try{

	if( isset($_SESSION['ang_secc_uid']) ){

		$usuario = $_SESSION['ang_secc_uid'];

		$stmt = $oConexao->prepare("SELECT roles FROM usuario_permissao WHERE idusuario = :usuario");  
		$stmt->bindParam('usuario', $usuario);
		$stmt->execute();
		$rolespermission = $stmt->fetchAll(PDO::FETCH_OBJ);
		$oConexao = null;

		if( $rolespermission ){
			echo json_encode($rolespermission);
		}else{
			echo '{ "roles": "null" }';
		}

	}else{
		echo '{ "roles": "null" }';
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>