<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

		$stmt = $oConexao->prepare("UPDATE solicitacao SET status = 2 WHERE idsolicitacao = :idsolicitacao");  
		$stmt->bindParam('idsolicitacao', $params->id);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Solicitação cancelada com sucesso.';
    	echo json_encode($msg);

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar cancelar.';
    echo json_encode($msg);
}

?>