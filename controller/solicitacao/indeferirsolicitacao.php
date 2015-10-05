<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;

try{
	$oConexao->beginTransaction(); 


		//faz o update com a nova qtd
		$sql = "UPDATE solicitacao_produto SET status = 2, motivo = :motivo WHERE idsolicitacao = :idsolicitacao AND idproduto = :idproduto";
		$stmt3 = $oConexao->prepare($sql);  
		$stmt3->bindParam('idsolicitacao', $params->idsolicitacao);
		$stmt3->bindParam('motivo', $params->motivo);
		$stmt3->bindParam('idproduto', $params->idproduto);
		$stmt3->execute();

		$oConexao->commit();

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Solicitação do produto foi indeferida com sucesso.';
    	echo json_encode($msg);


}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar indeferir a solicitação.';
    echo json_encode($msg);
}
?>