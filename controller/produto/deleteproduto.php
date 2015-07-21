<?php 
	
include_once('../../conn/config.php');
$oConexao = Conexao::getInstance();

$id = $_GET['id'];

try{

	if( $id > 0){
		$stmt = $oConexao->prepare("DELETE FROM produto WHERE idproduto = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		$oConexao = null;
		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Produto deletado com sucesso.';
    	echo json_encode($msg);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>