<?php 
	
include_once('../../conn/config.php');
$oConexao = Conexao::getInstance();

$id = $_GET['id'];

try{

		$stmt = $oConexao->prepare("DELETE FROM empenho_aditivo WHERE idempenho_aditivo = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		$oConexao = null;
		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Registro deletado com sucesso.';
    	echo json_encode($msg);

}catch (PDOException $e){
	echo $e->errorInfo[0]."   ".$e->getMessage();
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>