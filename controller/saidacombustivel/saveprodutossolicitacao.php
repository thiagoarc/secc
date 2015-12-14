<?php
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));
//print_r($params);

try{

	$stmt = $oConexao->prepare("INSERT INTO solicitacao_produto (idsolicitacao, idproduto, qtd) VALUES (:idsolicitacao, :idproduto, :qtd)");  
	$stmt->bindParam('idsolicitacao', $params->idsolicitacao);
	$stmt->bindParam('idproduto', $params->idproduto);
	$stmt->bindParam('qtd', $params->qtd);
	$stmt->execute();

	$msg['msg']         = 'success';
    $msg['msg_success'] = 'Cadastro realizado com sucesso.';
    echo json_encode($msg);

}catch (PDOException $e){
	//echo $e->errorInfo[0]."   ".$e->getMessage();
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar salvar.';
    echo json_encode($msg);
}
?>