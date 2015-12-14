<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

$idusuario = $_SESSION['ang_secc_uid'];



try{
	$oConexao->beginTransaction(); 
//print_r($params);


	for($i = 0; $i < count($params); $i++){

		$stmt = $oConexao->prepare("INSERT INTO saida (datasaida, idusuario, tipo, idsetor, idveiculo) VALUES 
		(now(), :idusuario, 3, :idsetor, :idveiculo)");  
		$stmt->bindParam('idusuario', $idusuario);
		$stmt->bindParam('idsetor', $params[$i]->idsetor);
		$stmt->bindParam('idveiculo', $params[$i]->idveiculo);
		$stmt->execute();
		//$oConexao = null;
		$idsaida = $oConexao->lastInsertId();

		$stmt = $oConexao->prepare("INSERT INTO saida_produto (saida_idsaida, produto_idproduto, qtd) VALUES (:idsaida, :idproduto, :qtd)");  
		$stmt->bindParam('idsaida', $idsaida);
		$stmt->bindParam('idproduto', $params[$i]->id);
		$stmt->bindParam('qtd', $params[$i]->qtd);
		$stmt->execute();

		$sql = "UPDATE produto SET qtdatual = (qtdatual - :qtd) WHERE idproduto = :idproduto";
		$stmt2 = $oConexao->prepare($sql);  
		$stmt2->bindParam('qtd', $params[$i]->qtd);
		$stmt2->bindParam('idproduto', $params[$i]->id);
		$stmt2->execute();
	}

	$oConexao->commit();

	$msg['msg']         = 'success';
    $msg['msg_success'] = 'Retirada de material realizada com sucesso.';
    echo json_encode($msg);

}catch (PDOException $e){
	echo $e->errorInfo[0]."   ".$e->getMessage();
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar retirar o material.';
    echo json_encode($msg);
}

?>