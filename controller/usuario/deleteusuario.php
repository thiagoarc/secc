<?php 
	
$oConexao = Conexao::getInstance();

$id = $_GET['id'];

try{

	if( $id > 0){
		$stmt = $oConexao->prepare("UPDATE usuario SET liberado = 0 WHERE idusuario = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		$oConexao = null;
		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Usuário deletado com sucesso.';
    	echo json_encode($msg);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_error'] 	= $e->getMessage()." - Por favor entre em contato com o adimistrador do sistema e informe o erro.";
    echo json_encode($msg);
	die();
}

?>