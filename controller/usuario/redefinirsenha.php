<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idusuario != '' ){

		$stmt = $oConexao->prepare("UPDATE usuario SET senha = :senha WHERE idusuario = :idusuario");  
		$stmt->bindParam('senha', sha1( $params->senha ) );
		$stmt->bindParam('idusuario', $params->idusuario);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Senha redefinida com sucesso.';
    	echo json_encode($msg);

	}

}catch (PDOException $e){
    $oConexao->rollBack();
   	$msg['msg']         = 'error';
    $msg['msg_error'] 	= $e->getMessage()." - Por favor entre em contato com o adimistrador do sistema e informe o erro.";
	die();
}

?>