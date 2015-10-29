<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

$idusuario = $_SESSION['ang_secc_uid'];

try{
	$oConexao->beginTransaction(); 
//print_r($params);

	$stmt = $oConexao->prepare("INSERT INTO solicitacao (datasolicitacao, idusuario) VALUES 
		(now(), :idusuario)");  
		$stmt->bindParam('idusuario', $idusuario);
		$stmt->execute();
		//$oConexao = null;



	$idsolicitacao = $oConexao->lastInsertId();

	for($i = 0; $i < count($params); $i++){

		$stmt = $oConexao->prepare("INSERT INTO solicitacao_produto (idsolicitacao, idproduto, qtd) VALUES (:idsolicitacao, :idproduto, :qtd)");  
		$stmt->bindParam('idsolicitacao', $idsolicitacao);
		$stmt->bindParam('idproduto', $params[$i]->id);
		$stmt->bindParam('qtd', $params[$i]->qtd);
		$stmt->execute();
	}

	$oConexao->commit();

	$msg['msg']         = 'success';
    $msg['msg_success'] = 'Cadastro realizado com sucesso.';
    echo json_encode($msg);

}catch (PDOException $e){
	echo $e->errorInfo[0]."   ".$e->getMessage();
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar salvar.';
    echo json_encode($msg);
}

?>